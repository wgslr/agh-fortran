program main
  use constants
  use gauss
  implicit none
  real(kind = iKIND), allocatable, dimension(:,:) :: A
  real(kind = iKIND), allocatable, dimension(:) :: X, RES
  real(kind = 16), allocatable, dimension(:) :: IDEAL, ERROR
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

  IDEAL(0) = 0
  do i = 1, n
    IDEAL(i) = real(1, kind=16) / real(n, kind=16) * i
  end do

  call init_matrices(A, X, n, h)
  call eliminate(A, X, n)

  do i = 1, n-1
    ! for the sake of completeness, although A(i,i) == 1
    X(i) = X(i) / A(i,i)
  end do

  do i = 0, n
    print *, i, X(i)
  end do

  ! ERROR(:) = X - IDEAL
  ! print *, iKIND, N, (SUM(ABS(ERROR)) / size(ERROR))

  contains

    subroutine init_matrices(A, X, n, h)
      use constants
      integer(kind=8), intent(in) :: n
      integer(kind=8) :: i
      real(kind = iKIND), intent(inout) :: A(0:n, 0:n)
      real(kind = iKIND), intent(inout) :: X(0:n)
      real(kind = iKIND), intent(in) :: h
      real(kind = iKIND) :: diag, side
      ! values to be set on the diagonal and one colument left/right
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

end program main
