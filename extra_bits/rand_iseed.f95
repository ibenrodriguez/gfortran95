! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

! requires -fall-intrinsics compilation flag

program rand_iseed
    integer :: nseed = 3, nrand = 3
    integer :: iseed = 12345
    integer :: i, j
    real :: x

    do i = 1, nseed
        print "( a, i5 )", "iseed = ", iseed
        x = rand( iseed )
        do j = 1, nrand
            x = rand()
            print "( a, f6.4 )", "rand() = ", x
        enddo
    enddo

    stop
end
