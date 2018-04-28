module gauss
    use constants
  implicit none

  ! integer, parameter :: iKIND2 = DEF_KIND

  contains
  subroutine print_diagonal(A, n)
    implicit none
    integer :: i
    integer, intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(0:n, 0:n)
    do i = 0, n
      print *, A(i, i)
    end do
  end subroutine print_diagonal

  subroutine print_rows(A, n)
    use constants
    implicit none
    integer :: i
    integer, intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(0:n, 0:n)
    do i = 0, n
      print *, i, ": ", A(:, i)
    end do
  end subroutine print_rows

  subroutine eliminate(A, X, n)
    integer(kind=8), intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(0:N, 0:N), X(0:N)
    real(kind = iKIND) :: ratio
    integer(kind=8) :: i, j

    do i = 0, N
      ! scale row i to have 1 on the diagonal
      X(i) = X(i) / A(i, i)
      A(:, i) = A(:, i) / A(i, i)
      do j = 0, N
        IF ((i .NE. j) .AND. (A(i, i) .NE. 0)) THEN
          ratio = A(i, j) / A(i, i)
          A(:,j) = A(:,j) - ratio * A(:, i)
          X(j) = X(j) - ratio * x(i)
        END IF
      END DO
    END DO
  end subroutine eliminate
end module gauss
