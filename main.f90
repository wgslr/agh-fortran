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
  real(kind = iKIND) :: A(4, 4), X(4), idx
  integer(kind=8) :: i, j



!   ! call eliminate(1.0, 2.0d0)
!   write(*,*) "Hello World"
!   arr(1, 1) = 0.5d0
!   call expected(arr(1, 1), arr(1, 2))
!   print *, "Expected: ", arr(1, 2)
!   idx = 1d0
  do i = 1,4
      do j = 1,4
          print *, i, j, idx
          A(j, i) = idx
          idx = idx + 1.0
      enddo
      X(i) = idx
      idx = idx + 1.0
  enddo

  call eliminate(A, X, 4)

!   print *, arr

end program main
