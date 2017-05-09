! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program external_function
    interface
        function cube( x )
            real :: cube, x
        end function
    end interface

    real :: x = 4
    print "( f4.1, a, f4.1 )", x, "**3 = ", cube( x )

    stop
end program

real function cube( x )
    real :: x
    cube = x**3
    return
end function
