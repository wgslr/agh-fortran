! Returns expected ideal value according
! to f(x) = x
subroutine expected(x, val)
  use constants
  real(kind=iKIND),intent(in)  :: x
  real(kind=iKIND),intent(out) ::  val
  val = x
end subroutine expected

subroutine init_matrices(A, X, n, h)
  use constants
  integer(kind=8), intent(in) :: n
  integer(kind=8) :: i
  real(kind = iKIND), intent(inout) :: A(0:n, 0:n)
  real(kind = iKIND), intent(inout) :: X(0:n)
  real(kind = iKIND), intent(in) :: h
  real(kind = iKIND) :: diag, side
  side = 1/(h**2)
  diag = -2 * side

  X(:) = real(0, kind=iKIND)
  X(n) = real(1, kind=iKIND)
  A(:,:) = real(0, kind=iKIND)

  do i = 1,n-1
    A(i - 1, i) = side
    A(i + 1, i) = side
    A(i, i) = diag
  end do

  A(0, 0) = 1
  A(n, n) = 1
end subroutine init_matrices

program main
  use constants
  use gauss
  implicit none
  real(kind = iKIND), allocatable, dimension(:,:) :: A
  real(kind = iKIND), allocatable, dimension(:) :: X, RES, IDEAL
  real(kind = 16), allocatable, dimension(:) :: ERROR
  real(kind = iKIND) :: h
  integer(kind=8) :: i, n, parse_result
  character(len=10) :: arg

  if (command_argument_count() .NE. 1) then
    print *, "Elements count should be given as program argument, exiting"
    error stop
  else 
    call get_command_argument(1, arg)
  end if


  read(arg, *, iostat=parse_result) n
  if (parse_result .NE. 0) then
    print *, "Invalid size argument format!"
    error stop
  end if
  

  allocate(A(0:n, 0:n))
  allocate(X(0:n))
  allocate(RES(0:n))
  allocate(IDEAL(0:n))
  allocate(ERROR(0:n))
  h = real(1.0/n, kind=iKIND)
  ! IDEAL(:) = (/ (real(1, kind=16) * i / n), i = 0, n) /)

  ! IDEAL(:) = (/ (1_16 * i / n), i = 0, n /)
  IDEAL(0) = 0
  do i = 1, n
    ! IDEAL(i) = IDEAL(i-1) + real(1, kind=16)/n
    IDEAL(i) = real(1, kind=16) / real(n, kind=16) * i
  end do
    ! IDEAL(1) = 1

  call init_matrices(A, X, n, h)

  call eliminate(A, X, n)

  do i = 1, n-1
    X(i) = X(i) / A(i,i)
  end do

  ! avg_err = sum((X - IDEAL))) / (n + 1)
  ERROR(:) = X - IDEAL
  ! print *, "A: ", A
  ! print *, "X: ", X
  ! print *, "IDEAL: ", IDEAL
  ! print *, "ERROR: ", ERROR
  print *, iKIND, N, (SUM(ABS(ERROR)) / size(ERROR))
  ! print *, avg_er

  ! print *, "A: "
  ! call print_rows(A, n)
  ! print *, "X: ", X

  ! print *, "Result: ", X    

  ! print *, "Ideal: ", IDEAL    
  ! print *, "Diff: ", IDEAL - X

  ! if(allocated(A)) deallocate(A)
  ! if(allocated(X)) deallocate(X)

end program main
