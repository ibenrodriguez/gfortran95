! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

program equivalent_variables
    integer :: i, j, n( 3 ), m( 3 )
    equivalence ( i, j )
    equivalence ( n, m )

    i = 1
    print "( a, i1, a, i1 )", "i = ", i, ", j = ", j

    j = 2
    print "( a, i1, a, i1 )", "i = ", i, ", j = ", j

    n( 1 ) = 11
    n( 2 ) = 22
    n( 3 ) = 33
    print "( a, 3i3 )", "m =", m

    stop
end
