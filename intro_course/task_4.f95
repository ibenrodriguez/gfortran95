! Copyright (c) 2011-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program task_4
    integer, parameter :: nsites = 5, nhours = 24
    integer :: site, hour, site_min, hour_min
    character( len = nsites ) :: abcde = 'ABCDE'
    real :: temp( nsites, nhours ), humi( nsites, nhours )
    real :: temp_avg, humi_avg

    ! read input data from two files
    open( unit = 22, file = "temp.txt" )
    open( unit = 33, file = "humi.txt" )
    do site = 1, nsites
        do hour = 1, nhours
            read( 22, * ) temp( site, hour )
            read( 33, * ) humi( site, hour )
        enddo
    enddo
    close( 22 )
    close( 33 )
    do hour = 1, nhours
         print *, ( temp( site, hour ), site = 1, nsites )
    enddo

    ! find where minimum humidity occurred
    site_min = 1
    hour_min = 1
    do site = 1, nsites
        do hour = 1, nhours
            if ( humi( site, hour ) < humi( site_min, hour_min ) ) then
                site_min = site
                hour_min = hour
            endif
        enddo
    enddo
    print *, 'min humidity:'
    print *, 'site = ', abcde( site_min : site_min )
    print *, 'hour =', hour_min
    print *, 'temp =', temp( site_min, hour_min )
    print *, 'humi =', humi( site_min, hour_min )

    ! tempi_avg over all sites at hour = 14
    temp_avg = 0.0
    do site = 1, nsites
        temp_avg = temp_avg + temp( site, 14 )
    enddo
    temp_avg = temp_avg / real( nsites )
    print *, '@ hour = 14, temp_avg =', temp_avg

    ! humi_avg at site C over 24 hours
    site = 3 ! site C
    temp_avg = 0.0
    do hour = 1, nhours
        humi_avg = humi_avg + humi( site, hour )
    enddo
    humi_avg = humi_avg / real( nhours )
    print *, '@ site = C, humi_avg =', humi_avg

    stop
end
