#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")
latest_tag=$(git describe --abbrev=0 --tags 2>/dev/null || echo "none")

if [ "$latest_tag" != "none" ]; then
    commits=$(git log --oneline "$latest_tag"..)
else
    commits=$(git log --oneline)
fi

# Generate list of unique commit messages with URLs
commit_list=""
while IFS= read -r commit; do
    commit_hash=$(echo "$commit" | awk '{print $1}')
    commit_msg=$(echo "$commit" | sed 's/^[a-f0-9]\{7\} \(.*\)$/\1/')
    commit_msg=$(echo "$commit_msg" | sed -E 's|PR#([0-9]+)|[PR#\1](/'"${GITHUB_REPOSITORY}"'/pull/\1)|g')

    if ! grep -q "$commit_msg" <<< "$commit_list"; then
        commit_list+="* [$commit_hash](/${GITHUB_REPOSITORY}/commit/$commit_hash) $commit_msg"$'\n'
    fi
done <<< "$commits"

export version=${latest_tag}
export name=$(jq -r '.name' manifest.json)
export changes="$commit_list"

envsubst < "${script_dir}/templates/RELEASE_NOTES.md"
