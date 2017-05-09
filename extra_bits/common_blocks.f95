! Copyright (c) 2012-2013 Bartosz Szczesny <bszcz@bszcz.org>
! This program is free software under the MIT license.

block data bd
    real :: x = 0.123
    common / c / x
end block data

program common_blocks
    interface
        function x_plus_y(y)
            real :: x_plus_y, y
        end function
    end interface

    real :: y = 0.654
    print "(a, f5.3)", "x_plus_y = ", x_plus_y(y)

    stop
end

real function x_plus_y(y)
    real :: x, y   ! don't need to pass 'x' as argument
    common / c / x ! 'x' is shared via common block 'c'
    x_plus_y = x + y
    return
end
