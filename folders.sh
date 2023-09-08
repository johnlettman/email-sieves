#!/usr/bin/env bash
shopt -s globstar nullglob

declare -a folders
declare -a tags

for sieve in **/*.sieve; do
  mapfile -t sieve_folders < <(
    grep -oP 'fileinto\s+"\K[^"]+' "${sieve}" | sort -u)

  mapfile -t sieve_tags < <(
    grep -oP 'fileinto\s+"\K[^"]+(?="\s*;\s*#\s*tag)' "${sieve}" | sort -u)

  folders+=("${sieve_folders[@]}")
  tags+=("${sieve_tags[@]}")
done

# Clean up the lists for unique items
declare -A folder_set
declare -A tag_set

for folder in "${folders[@]}"; do
  folder_set["$folder"]=1
done

for tag in "${tags[@]}"; do
  tag_set["$tag"]=1
done

folders=("${!folder_set[@]}")
tags=("${!tag_set[@]}")

# shellcheck disable=SC2207
IFS=$'\n' folders=($(printf "%s\n" "${folders[@]}" | sort))

# shellcheck disable=SC2207
IFS=$'\n' tags=($(printf "%s\n" "${tags[@]}" | sort)) 

# Remove the tags from folders
for tag in "${tags[@]}"; do
  folders=("${folders[@]//${tag}}")
done

echo -e "\nFolders"
echo "======="
for folder in "${folders[@]}"; do
  if [ -n "${folder}" ]; then
    echo "- ${folder}"
  fi
done

echo -e "\nTags"
echo "===="
for tag in "${tags[@]}"; do
  if [ -n "${tag}" ]; then
    echo "- ${tag}"
  fi
done
