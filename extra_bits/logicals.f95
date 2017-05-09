! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

! for logicals:
!  .eq. -->  .eqv.
! .neq. --> .neqv.

program logicals
    logical :: bool = .true.

    if ( bool .neqv. .false. ) then
        print "( A, L1 )", "bool != ", .false. ! prints 'F'
        print "( A, L1 )", "bool == ", bool    ! prints 'T'
    endif

    stop
end
