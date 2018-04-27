
module gauss
implicit none

! integer, parameter :: iKIND2 = DEF_KIND

contains
subroutine eliminate(arg1,  arg2)
  use constants
  ! real,intent(in)  :: arg1
  ! real(kind = iKIND), intent(in) ::  arg2
  real,intent(in)  :: arg1
  real(kind = iKIND), intent(in) ::  arg2
  ! real, intent(in) ::  arg2

  ! write(*,*) "Gauss is eliminating you"
  !   !TODO_add_body
  write(*,*) "Gauss says hello"
  write(*,*) "Kind is: ", iKIND
    
end subroutine eliminate
end module gauss
  