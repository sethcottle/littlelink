#!/bin/bash

# WCAG Minimum Contrast Ratio
MIN_CONTRAST=4.5

FAILED=0
ALL_RESOLVED=1
NEEDS_MANUAL_REVIEW=0

# Function to calculate luminance
get_luminance() {
    local color="$1"
    
    if [[ -z "$color" || "$color" == "#" ]]; then
        echo 0
        return
    fi
    
    color="${color#'#'}"
    
    if [[ ${#color} -ne 6 ]]; then
        echo 0
        return
    fi
    
    r=$(printf "%d" 0x${color:0:2} 2>/dev/null || echo 0)
    g=$(printf "%d" 0x${color:2:2} 2>/dev/null || echo 0)
    b=$(printf "%d" 0x${color:4:2} 2>/dev/null || echo 0)
    
    r=$(awk "BEGIN { print ($r/255 <= 0.03928) ? ($r/255)/12.92 : ((($r/255) + 0.055)/1.055) ^ 2.4 }")
    g=$(awk "BEGIN { print ($g/255 <= 0.03928) ? ($g/255)/12.92 : ((($g/255) + 0.055)/1.055) ^ 2.4 }")
    b=$(awk "BEGIN { print ($b/255 <= 0.03928) ? ($b/255)/12.92 : ((($b/255) + 0.055)/1.055) ^ 2.4 }")
    
    echo $(awk "BEGIN { print (0.2126 * $r) + (0.7152 * $g) + (0.0722 * $b) }")
}

# Function to calculate contrast ratio
get_contrast_ratio() {
    local lum1=$(get_luminance "$1")
    local lum2=$(get_luminance "$2")

    if [[ -z "$lum1" || -z "$lum2" ]]; then
        echo 0
        return
    fi

    if (( $(awk "BEGIN { print ($lum1 > $lum2) ? 1 : 0 }") )); then
        awk "BEGIN { printf \"%.5f\", ($lum1 + 0.05) / ($lum2 + 0.05) }"
    else
        awk "BEGIN { printf \"%.5f\", ($lum2 + 0.05) / ($lum1 + 0.05) }"
    fi
}

# Function to extract hex color from various CSS formats
extract_color() {
    local input="$1"
    local color=""
    
    # Try multiple extraction methods
    if [[ "$input" =~ "#[0-9a-fA-F]{6}" ]]; then
        # Direct hex color
        color=$(echo "$input" | grep -o "#[0-9a-fA-F]\{6\}")
    elif [[ "$input" =~ "1px solid #" ]]; then
        # Border format
        color=$(echo "$input" | sed -E 's/.*1px solid (#[0-9a-fA-F]{6}).*/\1/')
    elif [[ "$input" =~ "solid #" ]]; then
        # Alternative border format
        color=$(echo "$input" | sed -E 's/.*solid (#[0-9a-fA-F]{6}).*/\1/')
    elif [[ "$input" =~ "#" ]]; then
        # Fallback for any hex
        color=$(echo "$input" | grep -o "#[0-9a-fA-F]*" | head -1)
    fi
    
    echo "$color"
}

# Function to check contrast
check_contrast() {
    local text_color="$1"
    local background_color="$2"
    local context="$3"
    local border_color="$4"
    local recommend_stroke="$5"
    local is_background_check="$6"
    local button_name="$7"
    local check_failed=0
    
    if [[ -z "$text_color" || -z "$background_color" ]]; then
        return 0
    fi

    local contrast_ratio=$(get_contrast_ratio "$text_color" "$background_color")

    if [[ -z "$contrast_ratio" ]]; then
        contrast_ratio=0
    fi

    contrast_ratio=$(printf "%.2f" "$contrast_ratio")

    if (( $(awk "BEGIN { print ($contrast_ratio < $MIN_CONTRAST) ? 1 : 0 }") )); then
        # Check if we have the recommended border that compensates for the contrast issue
        if [[ -n "$border_color" && "$border_color" == "$recommend_stroke" && "$is_background_check" -eq 1 ]]; then
            echo "✅ [$context → $button_name] Contrast ratio $contrast_ratio fails WCAG but has a $recommend_stroke border → Treated as passing."
            echo "✅ [$context → $button_name] Issue resolved by stroke → Fully passing."
            check_failed=0
        else
            echo "❌ [$context → $button_name] Contrast ratio $contrast_ratio fails WCAG — Recommend adding a $recommend_stroke stroke."
            check_failed=1
        fi
    else
        echo "✅ [$context → $button_name] Contrast ratio $contrast_ratio passes WCAG"
        check_failed=0
    fi
    
    return $check_failed
}

# Function to process button CSS properties
process_button() {
    local button_name="$1"
    local text_color="$2"
    local background_color="$3"
    local border_color="$4"
    local has_gradient="$5"
    local button_failed=0
    
    # Handle gradient case first
    if [[ "$has_gradient" -eq 1 ]]; then
        echo "🚩 [./css/brands.css → $button_name] Detected gradient background → Flagging for manual review."
        NEEDS_MANUAL_REVIEW=1
        return
    fi
    
    # Run all contrast checks for this button
    if [[ -n "$text_color" && -n "$background_color" ]]; then
        check_contrast "$text_color" "$background_color" "TEXT vs BUTTON" "$border_color" "" 0 "$button_name"
        button_failed=$((button_failed | $?))
    fi

    if [[ -n "$background_color" ]]; then
        check_contrast "#ffffff" "$background_color" "BUTTON vs LIGHT THEME" "$border_color" "#000000" 1 "$button_name"
        button_failed=$((button_failed | $?))
        
        check_contrast "#121212" "$background_color" "BUTTON vs DARK THEME" "$border_color" "#ffffff" 1 "$button_name"
        button_failed=$((button_failed | $?))
    fi
    
    if [[ $button_failed -eq 1 ]]; then
        FAILED=1
        ALL_RESOLVED=0
    fi
}

# ---- FIXED GIT DIFF HANDLING ----
new_css=$(git diff origin/main --unified=0 -- css/brands.css | awk '/^\+.*(--button-text|--button-background|--button-border|background-image|\/\*|\.button-)/')

if [[ -z "$new_css" ]]; then
    echo "✅ No new CSS changes to check."
    exit 0
fi

echo "🔍 Auditing new CSS changes..."

# Variables for collecting button properties
BUTTON_NAME=""
TEXT_COLOR=""
BACKGROUND_COLOR=""
BORDER_COLOR=""
HAS_GRADIENT=0

# Process each line of CSS
while IFS= read -r line; do
    # Extract Button Name
    if [[ "$line" =~ /\* ]]; then
        # If we have a previous button to process, do it now
        if [[ -n "$BUTTON_NAME" && (-n "$TEXT_COLOR" || -n "$BACKGROUND_COLOR") ]]; then
            process_button "$BUTTON_NAME" "$TEXT_COLOR" "$BACKGROUND_COLOR" "$BORDER_COLOR" "$HAS_GRADIENT"
        fi
        
        # Start a new button
        BUTTON_NAME=$(echo "$line" | sed -E 's|\/\* *([^*]+) *\*\/|\1|' | xargs)
        TEXT_COLOR=""
        BACKGROUND_COLOR=""
        BORDER_COLOR=""
        HAS_GRADIENT=0
    fi

    if [[ "$line" =~ \.button- ]]; then
        BUTTON_NAME=$(echo "$line" | sed -E 's|.*\.button-([^ ]+).*|\1|' | tr -d '{')
    fi

    # Collect properties
    if [[ "$line" =~ --button-text ]]; then
        TEXT_COLOR=$(echo "$line" | awk -F '--button-text:' '{print $2}' | awk '{print $1}' | tr -d ';')
    fi
    
    if [[ "$line" =~ --button-background ]]; then
        BACKGROUND_COLOR=$(echo "$line" | awk -F '--button-background:' '{print $2}' | awk '{print $1}' | tr -d ';')
    fi
    
    # Extract border color
    if [[ "$line" =~ --button-border ]]; then
        BORDER_COLOR=$(extract_color "$line")
    fi
    
    # Check for gradient
    if [[ "$line" =~ background-image ]]; then
        HAS_GRADIENT=1
    fi
    
    # Process at end of button block
    if [[ "$line" =~ '}' && -n "$BUTTON_NAME" ]]; then
        process_button "$BUTTON_NAME" "$TEXT_COLOR" "$BACKGROUND_COLOR" "$BORDER_COLOR" "$HAS_GRADIENT"
        
        # Reset for next button
        BUTTON_NAME=""
        TEXT_COLOR=""
        BACKGROUND_COLOR=""
        BORDER_COLOR=""
        HAS_GRADIENT=0
    fi
done <<< "$new_css"

# Process any remaining button that wasn't ended with '}'
if [[ -n "$BUTTON_NAME" && (-n "$TEXT_COLOR" || -n "$BACKGROUND_COLOR") ]]; then
    process_button "$BUTTON_NAME" "$TEXT_COLOR" "$BACKGROUND_COLOR" "$BORDER_COLOR" "$HAS_GRADIENT"
fi

# ✅ Final report
if [[ "$NEEDS_MANUAL_REVIEW" -eq 1 ]]; then
    echo "⚠️ Manual review required for gradients!"
    exit 1
elif [[ "$ALL_RESOLVED" -eq 1 ]]; then
    echo "✅ All contrast checks passed!"
    exit 0
else
    echo "❌ Contrast issues found!"
    exit 1
fi