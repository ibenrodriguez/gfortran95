! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program character_arrays
    character( len = 64 ) :: names( 3 )
    integer :: i

    do i = 1, 3
        write ( *, fmt = "( a, i1, a )", advance = 'no' ) "Enter name ", i, ": "
        read *, names( i )
    enddo

    do i = 1, 3
        print "( a, i1, a, a )", "names( ", i ," ) = ", names( i )
    enddo

    stop
end
