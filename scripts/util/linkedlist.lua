_G.LinkedList = Class(function(self)
    self._head = nil
    self._tail = nil
end)

function _G.LinkedList:Append(v)
    local elem = {data=v}
    if self._head == nil and self._tail == nil then
        self._head = elem
        self._tail = elem
    else
        elem._prev = self._tail
        self._tail._next = elem
        self._tail = elem
    end

    return v
end

function _G.LinkedList:Remove(v)
    local current = self._head
    while current ~= nil do
        if current.data == v then
            if current._prev ~= nil then
                current._prev._next = current._next
            else
                self._head = current._next
            end

            if current._next ~= nil then
                current._next._prev = current._prev
            else
                self._tail = current._prev
            end
            return true
        end

        current = current._next
    end

    return false
end

function _G.LinkedList:Head()
    return self._head and self._head.data or nil
end

function _G.LinkedList:Tail()
    return self._tail and self._tail.data or nil
end

function _G.LinkedList:Clear()
    self._head = nil
    self._tail = nil
end

function _G.LinkedList:Count()
    local count = 0
    local it = self:Iterator()
    while it:Next() ~= nil do
        count = count + 1
    end
    return count
end

function _G.LinkedList:Iterator()
    return {
        _list = self,
        _current = nil,
        Current = function(it)
            return it._current and it._current.data or nil
        end,
        RemoveCurrent = function(it)
            -- use to snip out the current element during iteration

            if it._current._prev == nil and it._current._next == nil then
                -- empty the list!
                it._list:Clear()
                return
            end

            local count = it._list:Count()

            if it._current._prev ~= nil then
                it._current._prev._next = it._current._next
            else
                assert(it._list._head == it._current)
                it._list._head = it._current._next
            end

            if it._current._next ~= nil then
                it._current._next._prev = it._current._prev
            else
                assert(it._list._tail == it._current)
                it._list._tail = it._current._prev
            end

            assert(count-1 == it._list:Count())

            -- NOTE! "current" is now not part of the list, but its _next and _prev still work for iterating off of it.
        end,
        Next = function(it)
            if it._current == nil then
                it._current = it._list._head
            else
                it._current = it._current._next
            end
            return it:Current()
        end,
    }
end
