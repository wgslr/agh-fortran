#ifndef DEF_KIND
#define DEF_KIND 8
#endif

module utils
implicit none

integer, parameter :: iKIND = DEF_KIND

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
    implicit none
    integer :: i
    integer, intent(in) :: n
    real(kind = iKIND), intent(inout) :: A(0:n, 0:n)
    do i = 0, n
      print *, i, ": ", A(:, i)
    end do
  end subroutine print_rows


end module utils