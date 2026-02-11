#!/bin/bash

# Script to create the directory structure and files for a new feature in a Flutter project using Riverpod and MVC mvc_pattern.
# Run this script in the root directory of your Flutter project with this command:
#
# chmod +x mvc_pattern.sh && ./mvc_pattern.sh
#

# Colors for echo statements
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Welcome message
echo ""
echo -e "${YELLOW}Welcome to the Riverpod MVC mvc_pattern creation script!${NC}"
echo ""
echo "> Enter the name of your feature, and the script will create the required directories and files."
echo ""

# Prompt for feature name
while [[ -z "$feature_name" ]]; do
    read -p "Enter your feature name (in snake_case): " feature_name
    if [[ -z "$feature_name" ]]; then
        echo -e "${RED}Feature name cannot be empty. Please try again.${NC}"
    elif [[ ! "$feature_name" =~ ^[a-z]+(_[a-z]+)*$ ]]; then
        echo -e "${RED}Feature name must be in snake_case format. Please try again.${NC}"
        feature_name=""
    fi
done

# Ask if the user wants to write basic code structure
read -p "Would you like to write the basic code structure in each file? (Y/n): " write_code
write_code=${write_code:-y} # Default to 'y'

# Function to convert snake_case to PascalCase
to_pascal_case() {
    IFS='_' read -ra words <<< "$1"
    for i in "${!words[@]}"; do
        words[$i]=$(echo "${words[$i]:0:1}" | tr 'a-z' 'A-Z')${words[$i]:1}
    done
    echo "${words[*]}" | tr -d ' '
}

# Function to convert snake_case to camelCase
to_camel_case() {
    IFS='_' read -ra words <<< "$1"
    for i in "${!words[@]}"; do
        if [[ $i -eq 0 ]]; then
            words[$i]=$(echo "${words[$i]}" | tr 'A-Z' 'a-z')
        else
            words[$i]=$(echo "${words[$i]:0:1}" | tr 'a-z' 'A-Z')${words[$i]:1}
        fi
    done
    echo "${words[*]}" | tr -d ' '
}

# Convert feature name to PascalCase and camelCase
pascal_case_feature_name=$(to_pascal_case "$feature_name")
camel_case_feature_name=$(to_camel_case "$feature_name")

# Base directory for the feature
base_dir="lib/src/features/$feature_name"

# Check if the feature directory already exists
if [[ -d "$base_dir" ]]; then
    echo -e "${RED}Feature '$feature_name' already exists. Please choose a different name or delete the existing feature.${NC}"
    exit 1
fi

# Create directory structure
mkdir -p "$base_dir/controller"
mkdir -p "$base_dir/model/request"
mkdir -p "$base_dir/model/response"
mkdir -p "$base_dir/repository"
mkdir -p "$base_dir/views"
mkdir -p "$base_dir/views/components"


# File paths
file_paths=(
    "$base_dir/controller/${feature_name}.dart"
    "$base_dir/model/request/${feature_name}.dart"
    "$base_dir/model/response/${feature_name}.dart"
    "$base_dir/repository/${feature_name}.dart"
    "$base_dir/views/${feature_name}.dart"
    "$base_dir/views/components/.gitkeep"
)

# File contents
file_contents=(
    "import 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\n\ntypedef ${pascal_case_feature_name}Notifier = NotifierProvider<${pascal_case_feature_name}Provider, void>;\n\nfinal ${camel_case_feature_name}Provider = ${pascal_case_feature_name}Notifier(${pascal_case_feature_name}Provider.new);\n\nclass ${pascal_case_feature_name}Provider extends Notifier<void> {\n  @override\n  void build() {\n    debugPrint('${pascal_case_feature_name}Provider');\n  }\n}"
    "class ${pascal_case_feature_name}Params {}"
    "class ${pascal_case_feature_name}ResponseModel {}"
    "import '../../../core/network/api_client.dart';\n\nclass ${pascal_case_feature_name}Repository {\n  final ApiClient apiClient;\n\n  ${pascal_case_feature_name}Repository(this.apiClient);\n}"
    "import 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\n\nclass ${pascal_case_feature_name}View extends ConsumerWidget {\n  const ${pascal_case_feature_name}View({super.key});\n\n  @override\n  Widget build(BuildContext context, WidgetRef ref) {\n    return Scaffold(\n      appBar: AppBar(\n        title: const Text('${pascal_case_feature_name}'),\n      ),\n      body: Center(\n        child: Text('${pascal_case_feature_name}'),\n      ),\n    );\n  }\n}"
    ""
)

# Create files and write content based on user choice
for i in "${!file_paths[@]}"; do
    file_path="${file_paths[$i]}"
    file_content="${file_contents[$i]}"

    # Ensure directory exists
    mkdir -p "$(dirname "$file_path")"

    # Create file
    touch "$file_path"

    # Write content only if user chose "y"
    if [[ "$write_code" =~ ^[Yy]$ ]]; then
        echo -e "$file_content" > "$file_path"
    fi

    echo "Created: $file_path"
done

echo -e "${GREEN}Feature '$feature_name' directories and files created successfully!${NC}"
