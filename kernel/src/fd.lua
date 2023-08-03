--#skip 13
--[[
    Copyright (C) 2023 thegame4craft

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]--

k.printk(k.L_INFO, "fd")

k.fds = {}


--[[
    @param stream {read(), write(), seek(), close()}
    @param fd number or nil
]]
function k.create_fd(stream, fd)
    checkArg(1, stream, "table")
    checkArg(2, fd, "number", "nil")
    if fd then
        if k.fds[fd] then
            fd = nil
        end
    end
    if not fd then
        repeat
            fd = math.random(0, math.pow(2, 32)-1)
        until not k.fds[fd]
    end
    assert(not k.fds[fd], "Filedescriptor error")
    k.fds[fd] = {
        fd = fd,
        stream = stream
    }
    return fd
end

function k.close(fd)
    checkArg(1, fd, "number")
    if k.fds[fd] then
        k.fds[fd].stream.close(fd)
        k.fds[fd] = nil
    end
end

function k.write(fd, data)
    if k.fds[fd] then
        return k.fds[fd].stream.write(data) or data:len()
    end
    return 0
end

function k.isOpen(fd)
    return not not k.fds[fd]
end

function k.read(fd, c)
    if k.fds[fd] then
        return k.fds[fd].stream.read(c)
    end
    return ""
end

function k.seek(fd, off, whe)
    if k.fds[fd] then
        return k.fds[fd].stream.seek(off, whe)
    end
    return nil
end