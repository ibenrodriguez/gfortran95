! Copyright (c) 2011-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program task_1a
    real :: oz1, oz2, oz3, oz4, oz5, oz6
    real :: avg

    write ( *, "( a )", advance = "no" ) 'oz1, oz2 = '
    read ( 5, * ) oz1, oz2

    ! oz1 = 324.0
    ! oz2 = 342.0
    oz3 = 443.0
    oz4 = 286.0
    oz5 = 401.1
    oz6 = 345.9

    avg = ( oz1 + oz2 + oz3 + oz4 + oz5 + oz6 ) / 6.0
    print *, 'avg =', avg

    stop
end
