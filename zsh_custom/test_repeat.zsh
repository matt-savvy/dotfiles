function test_repeat() {
    while true; do
        cat $1 | xargs mix test
        return_code=$?

        if [ $return_code -ne 0 ]; then
            break
        fi
    done
}
