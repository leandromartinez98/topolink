!
! Subroutine that creates the initial guess for the path
!

subroutine initguess(n,x,iguess,seed)

  use functionpars
  implicit none
  integer :: n, iguess, seed, ix, iy, iz, i, j, ntrial
  double precision :: x(*), theta, phi, random, vec(3), overlap
  double precision, parameter :: pi = 4.d0*datan(1.d0)

  ! Initial guesses as straight lines pointing outwards
  ! from atom1, at random directions 

  ntrial = 100

  if ( iguess == 1 ) then
    do j = 1, ntrial
      call random_number(random)
      theta = pi*random
      call random_number(random)
      phi = 2.d0*pi*random
      vec(1) = dsin(theta)*dcos(phi) 
      vec(2) = dsin(theta)*dsin(phi)
      vec(3) = dcos(theta)
      do i = 1, nlinkatoms
        ix = (i-1)*3 + 1
        iy = ix + 1
        iz = ix + 2
        x(ix) = coor(atom1,1) + vec(1)*i*dbond
        x(iy) = coor(atom1,2) + vec(2)*i*dbond
        x(iz) = coor(atom1,3) + vec(3)*i*dbond
      end do
      if ( overlap(n,x) < 1.d0 ) exit
    end do
  end if

  ! Similar to iguess=1, but the segment is devided into two, pointing
  ! each from final and end atoms

  if ( iguess == 2 ) then
    ntrial = 100
    do j = 1, ntrial
      call random_number(random)
      theta = pi*random
      call random_number(random)
      phi = 2.d0*pi*random
      vec(1) = dsin(theta)*dcos(phi) 
      vec(2) = dsin(theta)*dsin(phi)
      vec(3) = dcos(theta)
      do i = 1, nlinkatoms/2
        ix = (i-1)*3 + 1
        iy = ix + 1
        iz = ix + 2
        x(ix) = coor(atom1,1) + vec(1)*i*dbond
        x(iy) = coor(atom1,2) + vec(2)*i*dbond
        x(iz) = coor(atom1,3) + vec(3)*i*dbond
      end do
      call random_number(random)
      theta = pi*random
      call random_number(random)
      phi = 2.d0*pi*random
      vec(1) = dsin(theta)*dcos(phi) 
      vec(2) = dsin(theta)*dsin(phi)
      vec(3) = dcos(theta)
      do i = nlinkatoms, nlinkatoms/2+1, -1
        ix = (i-1)*3 + 1
        iy = ix + 1
        iz = ix + 2
        x(ix) = coor(atom2,1) + vec(1)*(nlinkatoms-i+1)*dbond
        x(iy) = coor(atom2,2) + vec(2)*(nlinkatoms-i+1)*dbond
        x(iz) = coor(atom2,3) + vec(3)*(nlinkatoms-i+1)*dbond
      end do
      if ( overlap(n,x) < 1.d0 ) exit
    end do
  end if

end subroutine initguess
