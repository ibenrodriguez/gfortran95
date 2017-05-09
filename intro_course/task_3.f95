! Copyright (c) 2011-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program task3
    logical, parameter :: check_laudness = .false.
    integer, parameter :: nseats = 30, nsecs = 720
    integer :: seat, seat_l, seat_q, time, sec
    real :: sound( nseats, nsecs )

    ! read data
    open( unit = 22, file = "sound.txt" )
    do seat = 1, nseats
            read( 22, * ) ( sound( seat, sec ), sec = 1, nsecs )
    enddo
    close( 22 )

    ! check laudness
    if ( check_laudness ) then
        do seat = 1, nseats
            do sec = 1, nsecs
                if ( sound( seat, sec ) > 90.0 ) then
                    print *, 'seat =', seat, ' sec =', sec, ' sound =', sound( seat, sec ), ' > 90 !'
                endif
                if ( sound( seat, sec ) < 10.0 ) then
                    print *, 'seat =', seat, ' sec =', sec, ' sound =', sound( seat, sec ), ' < 10 !'
                endif
            enddo
        enddo
    endif

    ! find laudest and quitest at 5min = 300sec
    seat_l = 1
    seat_q = 1
    time = 5 * 60
    do seat = 1, nseats
        if ( sound( seat, time ) > sound( seat_l, time ) ) then
            seat_l = seat
        endif
        if ( sound( seat, time ) < sound( seat_q, time ) ) then
            seat_q = seat
        endif
    enddo
    print *, '@ time = 5min'
    print *, ' laudest_seat =', seat_l, ' sound =', sound( seat_l, time )
    print *, 'quietest_seat =', seat_q, ' sound =', sound( seat_q, time )

    ! check laudness but now only print seat number once
    do seat = 1, nseats
        do sec = 1, nsecs
            if ( sound( seat, sec ) > 90.0 .or. sound( seat, sec ) < 10.0 ) then
                print "( a, i2 )", 'violation at seat = ', seat
                exit
            endif
        enddo
    enddo

    stop
end
