! Copyright (c) 2012-2013 Bartosz Szczesny
! LICENSE: The MIT License (MIT)

! status="old" means a file should exist already
! if it does not then go to 123 and print iostat
! same thing for status="new" if file does exist

program open_status_iostat_err
    integer :: ierr, u = 22

    open( unit = u, file = "nope.txt", status = "old", err = 123, iostat = ierr )
    close( u )
    print *, "File open/close successful."
    stop

123 print  "( A, I2 )", "File open error: iostat =", ierr
    stop
end
