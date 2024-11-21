#!/bin/bash

# Function to display usage instructions
show_usage() {
  echo "Usage: $0 file.pdf [-i <start_page>] [-e <end_page>]"
  echo "  -i <start_page>  Starting page (default: 1)."
  echo "  -e <end_page>    Ending page (default: total pages in the PDF)."
  exit 1
}

# Ensure at least one argument is provided
if [ "$#" -lt 1 ]; then
  show_usage
fi

# Initialize variables
file=""
start_page=1
end_page=""

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -i)
      start_page="$2"
      shift 2
      ;;
    -e)
      end_page="$2"
      shift 2
      ;;
    *)
      file="$1"
      shift
      ;;
  esac
done

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "The file $file does not exist."
  exit 1
fi

# Ensure pdftk is installed
if ! command -v pdftk &> /dev/null; then
  echo "Installing pdftk..."
  sudo apt update && sudo apt install pdftk -y
fi

# Get the total number of pages if the end page is not specified
if [ -z "$end_page" ]; then
  end_page=$(pdftk "$file" dump_data | grep NumberOfPages | awk '{print $2}')
fi

# Validate that the range is valid
if [ "$start_page" -gt "$end_page" ]; then
  echo "Invalid range: start_page ($start_page) must be less than or equal to end_page ($end_page)."
  exit 1
fi

# Create temporary files for intermediate steps
temp_section=$(mktemp --suffix=.pdf)
temp_odds=$(mktemp --suffix=.pdf)
temp_evens=$(mktemp --suffix=.pdf)
temp_evens_reversed=$(mktemp --suffix=.pdf)
output_pdf="ordered_${file%.pdf}_pages_${start_page}-${end_page}.pdf"

# Extract the selected page range
range="${start_page}-${end_page}"
echo "Extracting pages from range $range..."
pdftk "$file" cat "$range" output "$temp_section"

# Split the section into odd and even pages
echo "Splitting into odd pages..."
pdftk "$temp_section" cat odd output "$temp_odds"
echo "Splitting into even pages..."
pdftk "$temp_section" cat even output "$temp_evens"

# Reverse the order of the even pages
echo "Reversing even pages..."
pdftk "$temp_evens" cat end-1 output "$temp_evens_reversed"

# Combine the pages in the correct order for duplex printing
echo "Combining pages for duplex printing..."
pdftk A="$temp_odds" B="$temp_evens_reversed" shuffle A B output "$output_pdf"

# Clean up temporary files
rm -f "$temp_section" "$temp_odds" "$temp_evens" "$temp_evens_reversed"

echo "Combined file saved as $output_pdf."
echo "Print this file for perfect manual duplex printing."
exit 0
