function delete(t)
    local j = 1
    n = #t
    for i = 1, n do
        if t[i].delete == 1 then
            t[i] = nil --delete an item
        else
            if (i ~= j) then
                t[j] = t[i]
                t[i] = nil
            end
            j = j + 1
        end
    end
end