!
! Module that contains some ahestetic format definitions
!

module ioformat

  character(len=*), parameter :: dashes = "( tr2,121('-') )"
  character(len=*), parameter :: hashes = "( tr2,121('#') )"

  contains

  !
  ! Subroutine that writes a beatiful progress bar
  !
  
  subroutine progress(current,start,end)
  
    implicit none
    integer :: i
    integer :: current, start, end

    if ( current == start ) then
      write(*,"('  Progress: ',i10,' of ', i10$)") start, end
      return
    end if
    if ( current > start .and. current < end ) then
      write(*,"(24a,$)") (achar(8),i=1,24)
      write(*,"(i10,' of ',i10,$)") current, end
    end if
    if ( current == end ) then
      write(*,"(24a,$)") (achar(8),i=1,24)
      write(*,"(i10,' of ',i10)") current, end
    end if
   
  end subroutine progress

end module ioformat

