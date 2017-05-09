! Copyright (c) 2011-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program tmpcon
    real :: tc, tf

    tc = 30.0
    tf = 9.0 * tc / 5.0 + 32.0

    print *, 'Temp. Conv.'
    print *, 'T[C]=', tc, 'T[F]=', tf

    stop
end
