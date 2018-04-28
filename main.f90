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
  integer(kind=8) :: i, j
  real(kind = iKIND), intent(inout) :: A(n, n)
  real(kind = iKIND), intent(inout) :: X(n)
  real(kind = iKIND), intent(in) :: h
  real(kind = iKIND) :: diag, side
  side = 1/(h**2)
  diag = -2 * side

  ! X(:) = real(0, kind=iKIND)
  X(:) = 1.0
  A(:,:) = real(0, kind=iKIND)

  ! X(:) = (/ ((h * i), i = 1, n) /)

  ! print *, "Side, diag, h:"
  ! write (*, '(F3.3, F3.3, F3.3)') side, diag, h
  ! print *, side, diag, h

  do i = 1,n-1
    A(i - 1, i) = side
    A(i + 1, i) = side
    A(i, i) = diag
  end do
  A(0, 0) = diag
  A(1, 0) = side
  A(n - 1, n) = side
  A(n, n) = diag

    
end subroutine init_matrices

program main
  use constants
  use gauss
  implicit none
  real(kind = iKIND), allocatable, dimension(:,:) :: A
  real(kind = iKIND), allocatable, dimension(:) :: X, RES, IDEAL
  real(kind = iKIND) :: h
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
  
  ! actual array size - skipping x = 0
  h = real(1.0/n, kind=iKIND)
  n = n - 1

  allocate(A(n, n))
  allocate(X(n))
  allocate(RES(0:n + 1))
  allocate(IDEAL(0:n + 1))
  IDEAL(:) = (/ ((h * i), i = 0, n+1) /)

  call init_matrices(A, X, n, h)

  call eliminate(A, X, n)

  print *, "X: ", X

  RES(:) = 0
  RES(n + 1) = 1
  RES(n) = X(n) / A(n, n)
  ! do i = 1, n
  !   ! RES(i) = A(i, i) * (h * i)
  !   ! RES(i) = X(i) * (h * i)
  !   RES(i) = X(i) / A(i, i) ! knowing that A(i, k) for k != i is 0
  ! end do
  do i = n-1, 1, -1
    ! see http://eduinf.waw.pl/inf/alg/001_search/0076.php
    ! RES(i) = A(i, i) * (h * i)
    ! RES(i) = X(i) * (h * i)
    RES(i) = X(i)
    do j = n, i + 1, -1
      print *, "i, j: ", i, j
      print *, RES(i), A(i,j), RES(j)
      RES(i) = RES(i) - A(i, j) * RES(j)
    end do
    RES(i) = RES(i) / A(i, i)
  end do

  print *, "Result: ", RES    

  print *, "Ideal: ", IDEAL    
  print *, "Diff: ", IDEAL - RES
  ! print *, (IDEAL - RES)

  if(allocated(A)) deallocate(A)
  if(allocated(X)) deallocate(X)

end program main
