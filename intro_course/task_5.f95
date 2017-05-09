! Copyright (c) 2011-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program task_5
    interface
        subroutine mean_std( xmax, ymax, inc, iwc, v, w, inc_mi, iwc_mi, v_mi, v_mo, &
                w_mi, w_mo, inc_si, iwc_si, v_si, v_so, w_si, w_so )
            integer :: xmax, ymax
            real :: inc( xmax, ymax ), iwc( xmax, ymax )
            real :: v( xmax, ymax ), w( xmax, ymax )
            real :: inc_mi, iwc_mi, v_mi, v_mo, w_mi, w_mo
            real :: inc_si, iwc_si, v_si, v_so, w_si, w_so
            integer :: x, y
            integer :: Ni, No ! numbers of points inside/outside of clouds
        end subroutine
        subroutine mx_mn( xmax, ymax, inc, iwc, v, w, inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, &
                w_mx_i, w_mx_o, inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o )
            integer :: xmax, ymax
            real :: inc( xmax, ymax ), iwc( xmax, ymax ), v( xmax, ymax ), w( xmax, ymax )
            real :: inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, w_mx_i, w_mx_o
            real :: inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o
            real :: T, H   ! tiny and huge
            real :: Ni, No ! numbers of points inside/outside of clouds
            integer :: x, y
        end subroutine
    end interface

    integer, parameter :: xmax = 100, ymax = 62
    real :: inc( xmax, ymax ), iwc( xmax, ymax ), v( xmax, ymax ), w( xmax, ymax ), z( ymax )
    real :: inc_mi, iwc_mi, v_mi, v_mo, w_mi, w_mo
    real :: inc_si, iwc_si, v_si, v_so, w_si, w_so
    real :: inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, w_mx_i, w_mx_o
    real :: inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o
    integer :: x, y

    open( unit = 11, file = "inc.txt" )
    open( unit = 22, file = "iwc.txt" )
    open( unit = 33, file = "v.txt" )
    open( unit = 44, file = "w.txt" )
    open( unit = 55, file = "z.txt" )

    do x = 1, xmax
        do y = 1, ymax
            read( 11, * ) inc( x, y )
            read( 22, * ) iwc( x, y )
            read( 33, * ) v( x, y )
            read( 44, * ) w( x, y )
        enddo
    enddo

    do y = 1, ymax      ! if put above it would be done xmax times
        read( 55, * ) z( y ) ! also the data file would end
    enddo

    close( 11 )
    close( 22 )
    close( 33 )
    close( 44 )
    close( 55 )

    call mean_std( xmax, ymax, inc, iwc, v, w, inc_mi, iwc_mi, v_mi, v_mo, &
        w_mi, w_mo, inc_si, iwc_si, v_si, v_so, w_si, w_so )
    call mx_mn( xmax, ymax, inc, iwc, v, w, inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, &
        w_mx_i, w_mx_o, inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o )

    print *, 'means'
    print 10, inc_mi, iwc_mi, v_mi, v_mo, w_mi, w_mo
    print *, 'stddevs'
    print 10, inc_si, iwc_si, v_si, v_so, w_si, w_so
    print *, 'max'
    print *, inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, w_mx_i, w_mx_o
    print *, 'min'
    print *, inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o
10  format ( 6E10.2 )

    stop
end

! subroutines begin

subroutine mean_std( xmax, ymax, inc, iwc, v, w, inc_mi, iwc_mi, v_mi, v_mo, &
        w_mi, w_mo, inc_si, iwc_si, v_si, v_so, w_si, w_so )
    integer :: xmax, ymax
    real :: inc( xmax, ymax ), iwc( xmax, ymax )
    real :: v( xmax, ymax ), w( xmax, ymax )
    real :: inc_mi, iwc_mi, v_mi, v_mo, w_mi, w_mo
    real :: inc_si, iwc_si, v_si, v_so, w_si, w_so
    integer :: x, y
    integer :: Ni, No ! numbers of points inside/outside of clouds

    inc_mi = 0.0; iwc_mi = 0.0; v_mi = 0.0; v_mo = 0.0; w_mi = 0.0; w_mo = 0.0
    inc_si = 0.0; iwc_si = 0.0; v_si = 0.0; v_so = 0.0; w_si = 0.0; w_so = 0.0
    Ni = 0; No = 0

    do x = 1, xmax
        do y = 1, ymax
            if ( iwc( x, y ) > 0.00001 ) then ! inside a cloud
                inc_mi = inc_mi + inc( x, y )
                iwc_mi = iwc_mi + iwc( x, y )
                v_mi = v_mi + v( x, y )
                w_mi = w_mi + w( x, y )
                Ni = Ni + 1
            else ! outside a cloud
                v_mo = v_mo + v( x, y )
                w_mo = w_mo + w( x, y )
                No = No + 1
            endif
        enddo
    enddo

    v_mi = v_mi / Ni; w_mi = w_mi / Ni; inc_mi = inc_mi / Ni; iwc_mi = iwc_mi / Ni
    v_mo = v_mo / No; w_mo = w_mo / No

    do x = 1, xmax
        do y = 1, ymax
            if ( iwc(x,y)>0.00001 ) then ! inside a cloud
                inc_si = inc_si + ( inc_mi-inc( x, y ) )**2
                iwc_si = iwc_si + ( iwc_mi-iwc( x, y ) )**2
                v_si = v_si + ( v_mi-v( x, y ) )**2
                w_si = w_si + ( w_mi-w( x, y ) )**2
            else ! outside a cloud
                v_so = v_so + ( v_mo-v( x, y ) )**2
                w_so = w_so + ( w_mo-w( x, y ) )**2
            endif
        enddo
    enddo

    Ni = Ni - 1; No = No - 1 ! need to divide by N-1 in stddev formula

    v_si = v_si / Ni; w_si = w_si / Ni; inc_si = inc_si / Ni; iwc_si = iwc_si / Ni
    v_so = v_so / No; w_so = w_so / No

    inc_si = sqrt( inc_si ); iwc_si = sqrt( iwc_si )
    v_si = sqrt( v_si ); w_si = sqrt( w_si )
    v_so = sqrt( v_so ); w_so = sqrt( w_so )

    return
end

subroutine mx_mn( xmax, ymax, inc, iwc, v, w, inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, &
        w_mx_i, w_mx_o, inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o )
    integer :: xmax, ymax
    real :: inc( xmax, ymax ), iwc( xmax, ymax ), v( xmax, ymax ), w( xmax, ymax )
    real :: inc_mx_i, iwc_mx_i, v_mx_i, v_mx_o, w_mx_i, w_mx_o
    real :: inc_mn_i, iwc_mn_i, v_mn_i, v_mn_o, w_mn_i, w_mn_o
    real :: T, H   ! tiny and huge
    real :: Ni, No ! numbers of points inside/outside of clouds
    integer :: x, y

    T = 10e-34
    H = 10e+34
    inc_mx_i = T; iwc_mx_i = T; v_mx_i = T; v_mx_o = T; w_mx_i = T; w_mx_o = T
    inc_mn_i = H; iwc_mn_i = H; v_mn_i = H; v_mn_o = H; w_mn_i = H; w_mn_o = H

    do x = 1, xmax
        do y = 1, ymax
            if ( iwc( x, y ) > 0.00001 ) then ! inside a cloud
                ! max values
                if ( inc( x, y ) > inc_mx_i ) inc_mx_i = inc( x, y )
                if ( iwc( x, y ) > iwc_mx_i ) iwc_mx_i = iwc( x, y )
                if ( v( x, y ) > v_mx_i ) v_mx_i = v( x, y )
                if ( w( x, y ) > w_mx_i ) w_mx_i = w( x, y )
                ! min values
                if ( inc( x, y ) < inc_mn_i ) inc_mn_i = inc( x, y )
                if ( iwc( x, y ) < iwc_mn_i ) iwc_mn_i = iwc( x, y )
                if ( v( x, y ) < v_mn_i ) v_mn_i = v( x, y )
                if ( w( x, y ) < w_mn_i ) w_mn_i = w( x, y )
                Ni = Ni + 1
            else ! outside a cloud
                ! max values
                if ( v( x, y ) > v_mx_o ) v_mx_o = v( x, y )
                if ( w( x, y ) > w_mx_o ) w_mx_o = w( x, y )
                ! min values
                if ( v( x, y ) < v_mn_o ) v_mn_o = v( x, y )
                if ( w( x, y ) < w_mn_o ) w_mn_o = w( x, y )
                No = No + 1
            endif
        enddo
    enddo

    return
end
