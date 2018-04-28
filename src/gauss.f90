module gauss
  use utils
  implicit none

  contains
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
