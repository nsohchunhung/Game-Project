#!/bin/bash

# Professional Ebook Cleaner
# Removes emojis and improves formatting for professional presentation

INPUT_FILE="DevOps-Production-Deployment-Professional.md"
OUTPUT_FILE="DevOps-Production-Deployment-Professional-Clean.md"

echo "Cleaning ebook content for professional presentation..."

# Remove emojis and clean up formatting
sed -E '
# Remove common emojis
s/[🎯🚀📚🔧💡✅❌⚠️📊📁📝📖🌐📄🔍🧪🎉💻📋🔧🍎🐧🪟📦📈🎮🎭🚨🏗️📖🎪🎊📞🔥💪🌟⭐🎨🎬🎵🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿]/ /g

# Clean up multiple spaces
s/  +/ /g

# Remove empty lines with just spaces
s/^[[:space:]]*$//

# Clean up section headers
s/^#+ *[🎯🚀📚🔧💡✅❌⚠️📊📁📝📖🌐📄🔍🧪🎉💻📋🔧🍎🐧🪟📦📈🎮🎭🚨🏗️📖🎪🎊📞🔥💪🌟⭐🎨🎬🎵🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿] */# /g

# Clean up bullet points
s/^- *[🎯🚀📚🔧💡✅❌⚠️📊📁📝📖🌐📄🔍🧪🎉💻📋🔧🍎🐧🪟📦📈🎮🎭🚨🏗️📖🎪🎊📞🔥💪🌟⭐🎨🎬🎵🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿] /- /g

# Clean up numbered lists
s/^[0-9]+\. *[🎯🚀📚🔧💡✅❌⚠️📊📁📝📖🌐📄🔍🧪🎉💻📋🔧🍎🐧🪟📦📈🎮🎭🚨🏗️📖🎪🎊📞🔥💪🌟⭐🎨🎬🎵🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿] /1. /g

# Remove any remaining emoji characters
s/[^\x00-\x7F]//g

# Clean up multiple newlines
/^$/N;/\n$/N;s/\n\n\n+/\n\n/g
' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Professional ebook created: $OUTPUT_FILE"
echo "Content cleaned and formatted for professional presentation"
