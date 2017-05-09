! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program data_at_compile_time
    integer :: i, j, array(3)
    real :: x, y

    ! this initialises the data at compilation
    data x, y / 0.1, 0.2 / array / 10, 20, 30 /

    print *,"x =", x
    print *,"y =", y
    print *,"array =", ( array( i ), i = 1, 3 )

    ! the code below is not an infinite loop
    ! "data j / 1 /" statement is done once
    do while ( j < 4 )
        data j / 1 /
        print *,"j =", j
        j = j + 1
    enddo
    print *, "quit the loop"

    stop
end
