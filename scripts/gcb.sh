search=$1
set -f
if [[ -n $search ]]; then
        branches=$(git for-each-ref --format='%(refname:short)' refs/heads/|grep $search)
        array=(`echo $branches | sed 's/ /\n/g'`)
        if [[ -n $array ]]; then
                index=-1
                if [ "${#array[@]}" -gt 1 ]; then
                        for i in "${!array[@]}"; do
                                printf "%s\t%s\n" "$i" "${array[$i]}"
                        done

                        read -rsn1 index
                fi
                branch="${array[$index]}"
                git checkout $branch
        fi
fi

