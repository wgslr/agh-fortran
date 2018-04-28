module gauss
    use constants
  implicit none

  ! integer, parameter :: iKIND2 = DEF_KIND

  contains
  subroutine print_diagonal(A, n)
    implicit none
    integer :: i
    integer, intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(n, n)
    do i = 1, n
      print *, A(i, i)
    end do
  end subroutine print_diagonal

  subroutine print_rows(A, n)
    use constants
    implicit none
    integer :: i
    integer, intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(n, n)
    do i = 1, n
      print *, i, ": ", A(:, i)
    end do
  end subroutine print_rows

  subroutine eliminate(A, X, n)
    integer :: i, j
    integer, intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(N, N), X(N)
    real(kind = iKIND) :: ratio

    print *, "Arrays to eliminate: "
    call print_rows(A, n)          
    call print_rows(X, n)          
    
    do i = 1, N
      do j = 1, N
        IF ((i .NE. j) .AND. (A(i, i) .NE. 0)) THEN
          ratio = A(i, j) / A(i, i)
          A(:,j) = A(:,j) - ratio * A(:, i)
          X(j) = X(j) - ratio * x(i)

          print *, "After ", i, j, ": A = "
          call print_rows(A, n)          

          print *, "X = ", X
          print *, "Diagonal: "
          call print_diagonal(A, n)
        END IF
      END DO
      ! scale row i to have 1 on the diagonal
      X(i) = X(i) / A(i, i)
      A(:, i) = A(:, i) / A(i, i)
    END DO

    print *, "Eliminated arrays: A = "
    call print_rows(A, n)          

    print *, "X = ", X
    print *, "Diagonal: "
    call print_diagonal(A, n)
      
  end subroutine eliminate
end module gauss
  