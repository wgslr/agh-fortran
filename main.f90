! Returns expected ideal value according
! to f(x) = x
subroutine expected(x, val)
  use constants
  real(kind=iKIND),intent(in)  :: x
  real(kind=iKIND),intent(out) ::  val
  val = x
end subroutine expected

program main
  use constants
  use gauss
  implicit none
  real(kind = iKIND), allocatable, dimension(:,:) :: A
  real(kind = iKIND), allocatable, dimension(:) :: X
  integer(kind=8) :: i, j, n, parse_result
  character(len=10) :: arg

  print *, "Start"

  if (command_argument_count() .NE. 1) then
    print *, "Elements count should be given as program argument, exiting"
    error stop
  else 
  print *, "Argument count: ", command_argument_count()
    call get_command_argument(1, arg)
  end if


  read(arg, *, iostat=parse_result) n
  if (parse_result .NE. 0) then
    print *, "Invalid size argument!"
    error stop
  end if

  allocate(A(n, n))
  allocate(X(n))

!   ! call eliminate(1.0, 2.0d0)
!   write(*,*) "Hello World"
!   arr(1, 1) = 0.5d0
!   call expected(arr(1, 1), arr(1, 2))
!   print *, "Expected: ", arr(1, 2)
!   idx = 1d0
  ! idx = 1.0
  ! do i = 1,3
  !     do j = 1,3
  !         print *, i, j, idx
  !         A(i, j) = idx + 7
  !         idx = idx + 1.0
  !     enddo
  !     X(i) = idx
  !     idx = idx + 1.0
  ! enddo
  ! A = reshape ( (/1.0, 1.0, 1.0, 2.0, 3.0, 5.0, 4.0, 0.0, 5.0 /) , shape(A))
  ! X = (/ 5.0, 8.0, 2.0 /)

  ! call eliminate(A, X, 3)

!   print *, arr

  if(allocated(A)) deallocate(A)
  if(allocated(X)) deallocate(X)

end program main
