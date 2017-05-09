! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program implicit_input_output
    integer :: i, j
    real :: a( 2, 3 )

    do i = 1, 2
        do j = 1, 3
            a( i , j ) = 10*i + j
        enddo
    enddo

    print *, ( ( a( i, j ), i = 1, 2 ), j = 1, 3 )
    print *,   ( a( 1, j ), j = 1, 3 )
    print *,   ( a( i, 1 ), i = 1, 2 )
    ! can also read:
    ! read( 22, * ) ( ( a( i, j ), i = 1, 2 ), j = 1, 3 )

    stop
end
