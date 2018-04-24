module read_inputs
  public :: read_global
  public :: read_1dmesh_int, read_2dmesh_int, read_2dmesh_t3d, read_2dmesh_gmsh
  public :: read_scilab



  contains

    subroutine read_global()
      use globals
      use globals1D
      use globals2D
      use typy
      use core_tools
      use readtools
      use pde_objs

      integer(kind=ikind) :: i, j, n, ierr
      real(kind=rkind), dimension(3) :: tmp
      character(len=4096) :: filename
      character(len=8192) :: msg
      integer :: local, global
      character(len=256), dimension(17) :: probnames
      
      if (.not. www) then
	local = file_global
	global = file_global
      else
	local = file_global
	global = file_wwwglob
      end if

      
      write(msg, *) "Incorrect option for problem type, the available options are:", new_line("a"),  new_line("a"), new_line("a"),&
	"   RE_std = standard Richards equation, primary solution is capillary pressure head h, matrix is nonsymmetric" , &
	 new_line("a"), new_line("a"),  &
	"   RE_rot = Richards equation in cylindric coordinates, primary solution is capillary pressure head h, matrix is nonsymmetric",& 
	new_line("a") ,  new_line("a"), &
	"   REstdH = Richards equation, primary solution is total hydraulic head H, matrix is symmetric",&
	new_line("a"), new_line("a"),  &
	"   RErotH =  Richards equation in cylindric coordinates,  primary solution is total hydraulic head H, matrix is symmetric", &
	new_line("a"),  new_line("a"), &
	"   RE_mod = modified Richards equation, see Noborio, et al. (1996)", &
	new_line("a"),  new_line("a"), &
	"   boussi = Boussinesq equation for sloping land (1877)", &
	new_line("a"),  new_line("a"), &
	"   ADE_wR = advection dispersion reaction equation (transport of solutes), convection is computed from the Richards equation, ", &
	"equilibrium sorption", &
	new_line("a"),  new_line("a"), &
	"   ADEstd = advection dispersion reaction equation (transport of solutes),  convection is specified in config files,", &
	" equilibrium sorption", &
	new_line("a"),  new_line("a"), &
        "   ADEstd_kinsorb = advection dispersion reaction equation (transport of solutes),",&
        " convection is specified in config files,", &
	" kinetic sorption", &
        new_line("a"),  new_line("a"), &
	"   ADE_RE_std = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in pressure head form, equilibrium sorption ", &
	new_line("a"),  new_line("a"), &
	"   ADE_REstdH = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in total hydraulic head form, equilibrium sorption ", &
		new_line("a"),  new_line("a"), &
	"   ADE_RE_rot = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in pressure hydraulic head form, cylindric coordinates (axisymmetric flow), equilibrium sorption ", &
		new_line("a"),  new_line("a"), &
	"   ADE_RErotH = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in total hydraulic head form, cylindric coordinates (axisymmetric flow), equilibrium sorption ", &
		"   ADE_RE_std_kinsorb = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in pressure head form, kinetic sorption ", &
	new_line("a"),  new_line("a"), &
	"   ADE_REstdH_kinsorb = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in total hydraulic head form, kinetic sorption ", &
		new_line("a"),  new_line("a"), &
	"   ADE_RE_rot_kinsorb = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in pressure hydraulic head form, cylindric coordinates (axisymmetric flow), kinetic sorption ", &
		new_line("a"),  new_line("a"), &
	"   ADE_RErotH_kinsorb = advection dispersion reaction equation (transport of solutes), convection is computed from", &
	" the Richards equation in total hydraulic head form, cylindric coordinates (axisymmetric flow), kinetic sorption ", &
	new_line("a"),  new_line("a"), &
	new_line("a"),  new_line("a"), new_line("a")
	
	probnames(1) = "RE_std"
	probnames(2) = "RE_mod"
	probnames(3) = "REtest"
	probnames(4) = "RE_rot"
	probnames(5) = "REstdH"
	probnames(6) = "RErotH"
	probnames(7) = "boussi"
	probnames(8) = "ADEstd"
	probnames(9) = "ADEstd_kinsorb"
	probnames(10) = "ADE_RE_std"
	probnames(11) = "ADE_REstdH"
	probnames(12) = "ADE_RE_rot"
	probnames(13) = "ADE_RErotH"
	probnames(14) = "ADE_RE_std_kinsorb"
	probnames(15) = "ADE_REstdH_kinsorb"
	probnames(16) = "ADE_RE_rot_kinsorb"
	probnames(17) = "ADE_RErotH_kinsorb"
	
	
      call fileread(drutes_config%name, local, trim(msg), options=probnames)

      call fileread(drutes_config%dimen, local, ranges=(/1_ikind,2_ikind/))
      
      if (drutes_config%name == "boussi" .and. drutes_config%dimen > 1) then
	write(msg, fmt=*) 'You have selected Boussinesq equation, Boussinesq equation originates from Dupuit &
		   approximation, and so it is assumed for 1D only!!! &
		   '//NEW_LINE('A')//'    But your domain was specified for: ', drutes_config%dimen, "D"
	call file_error(local, msg)
      end if

      call fileread(drutes_config%mesh_type, local, ranges=(/1_ikind,3_ikind/))
      
      call fileread(max_itcount, local, ranges=(/1_ikind, huge(1_ikind)/), &
      errmsg="maximal number of iterations must be positive, greater than 1, &
	      and smaller than the maximal number your computer can handle :)")
      
      call fileread(iter_criterion, local, ranges=(/0.0_rkind, huge(0.0_rkind)/), &
      errmsg="iteration criterion must be positive, and smaller than the maximal number your computer can handle :)")

      call fileread(integ_method, global)
      
      if (integ_method/10 < 1 .or. integ_method/10 > 12 .or. modulo(integ_method,10_ikind)/=0  &
	  .or. integ_method == 100 .or. integ_method == 110) then
	  write(msg, *)  '!!!!!!!!!!!!!!!!!-------------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! &
	'//NEW_LINE('A')// 'the proper integration method code names are : 10, 20, 30, 40, 50, 60, 70, 80, 90, 120'//NEW_LINE('A')//&
	 'your incorrect definition was:', integ_method
	call file_error(global, msg)
      end if
      
      call fileread(time_units, local)
      
      call fileread(init_dt, local, ranges=(/tiny(0.0_rkind), huge(0.0_rkind)/),&
      errmsg="initial time step must be positive, and smaller than the maximal number your computer can handle :)")
      
      call fileread(end_time, local, ranges=(/init_dt, huge(tmp(1))/), &
      errmsg="end time must be greater than the minimal time step, and smaller than the maximal number your computer can handle :)")
      
      
      call fileread(dtmin, local, ranges=(/0.0_rkind, init_dt/), &
      errmsg="minimal time step must be positive, and smaller than the initial time step")
      
      call fileread(dtmax, local, ranges=(/dtmin, huge(tmp(1))/), &
      errmsg="maximal time step must be greater than the minimal time step, &
		and smaller than the maximal number your computer can handle :)")
      
      call fileread(print_level, global)
      
      call fileread(info_level, global)
      
      write(msg, fmt=*) "methods for observation time print could be only", new_line('a'), &
	"	1 - adjust time stepping to observation time values",  new_line('a'), &
	"	2 - linearly interpolate solution between two consecutive solutions (recommended)"
      
      call fileread(observe_info%method, local, ranges=(/1_ikind, 2_ikind/), errmsg=msg)
      
      call fileread(observe_info%anime, global)
      
      if (observe_info%anime) then
	call fileread(observe_info%nframes, global, ranges=(/1_ikind, huge(1_ikind)/), &
	errmsg="number of frames for animation must be greater than zero &
	and smaller than the maximal number your computer can handle :)")
      else
	observe_info%nframes = 0
      end if
      
      call fileread(n, local)

      allocate(observe_time(n + observe_info%nframes))
      
      if (.not. observe_info%anime) then
	
       write(msg, *) "HINT 1: check number of the observation time values", new_line('a'), &
	"HINT 2: You have selected [n] (not) to create animation frames, have you commented out the required number of frames?" , & 
	  new_line('a')
      else
	write(msg, *) "HINT: check number of the observation time values"
      end if
      
      
      do i=1, n
	call fileread(observe_time(i)%value, local, errmsg=msg)
      end do
      

      ! reads the observation points number
      call fileread(n, local,ranges=(/0_ikind, huge(1_ikind)/), &
	errmsg="number of observation times cannot be negative :)")
      
      allocate(observation_array(n))   
      
       if (.not. observe_info%anime) then
	
	 write(msg, *) "HINT 1: check number of the observation point values", new_line('a'), &
	     "  HINT 2: check number of the observation points coordinates" , new_line('a'), &
	     "  HINT 3: You have selected [n] (not) to create animation frames, have you commented out the required number of frames?" , &
		new_line('a')
      else
	write(msg, *)  "HINT 1: check number of the observation point values", new_line('a'), &
	 "HINT 2: check number of the observation points coordinates" , new_line('a')
      end if     
      
      do i=1,n
	allocate(observation_array(i)%xyz(drutes_config%dimen))
      end do
      
      do i=1,n
	call fileread(observation_array(i)%xyz(:), local, errmsg=msg)
      end do  
      !----
      
      ! reads coordinates with measured points
      call fileread(n, global, errmsg="strange number of observation points")

      allocate(measured_pts(n))
      do i=1, n
	allocate(measured_pts(i)%xyz(drutes_config%dimen))
      end do
      
      do i=1, n
	call fileread(measured_pts(i)%xyz(:), global, errmsg="HINT: check coordinates of the points with measurement data")
      end do  

      call fileread(i=drutes_config%it_method, fileid=local, ranges=(/0_ikind,2_ikind/),&
	errmsg="you have selected an improper iteration method")
      
      write(msg, *) "Define method of time integration", new_line("a"), &
      "   0 - steady state problem", &
      new_line("a"), &
      "   1 - unsteady problem with lumped (diagonal) capacity matrix (recommended)", new_line("a"), &
      "   2 - unsteady problem with consistent capacity matrix"
      
      call fileread(pde_common%timeint_method, global, ranges=(/0_ikind,2_ikind/), errmsg=msg)
      
      
      call fileread(drutes_config%run_from_backup, global, errmsg="specify [y/n] if you want to relaunch your computation")
      
      
      if (drutes_config%run_from_backup) then
	call fileread(backup_file, global, errmsg="backup file not specified")
      end if
      
      call fileread(debugmode, global,"specify [y/n] for debugging (development option, not recommended)" )
        

    end subroutine read_global
    
  




    subroutine read_1dmesh_int()
      use typy
      use globals
      use globals1d
      use core_tools
      use simegen
      use readtools

      integer :: ierr
      integer :: n, i, j
      character(len=1) :: ch
      character(len=4096) :: msg

      call comment(file_mesh)
      read(unit=file_mesh, fmt = *, iostat = ierr) length_1D ; if (ierr /= 0) call file_error(file_mesh)



      call comment(file_mesh)
      read(unit=file_mesh, fmt = *, iostat = ierr) n; if (ierr /= 0) call file_error(file_mesh)


      allocate(deltax_1D(0:n, 3))

      do i=1, n
	call comment(file_mesh)
	read(unit=file_mesh, fmt=*, iostat = ierr) deltax_1D(i,1), deltax_1D(i,2), deltax_1D(i,3)
	  if (ierr /= 0) call file_error(file_mesh)
      end do
      
      call comment(file_mesh)

      read(unit=file_mesh, fmt=*, iostat=ierr) n ; if (ierr /= 0) call file_error(file_mesh)

      allocate(materials_1D(n,2))

      do i=1,n
	 call comment(file_mesh)
	 read(unit=file_mesh, fmt=* , iostat=ierr) j, materials_1D(i,:) ; if (ierr /= 0) call file_error(file_mesh)
      end do
	
      if (materials_1D(n,2) < length_1D) then
	msg = "ERROR! material description does not cover the entire domain, check 1D domain length value"
	call file_error(file_mesh, msg)
      end if
	
      call simegen1D()

    end subroutine read_1dmesh_int


    subroutine read_2dmesh_int()
      use typy
      use globals
      use globals2d
      use core_tools
      use simegen
      use readtools

      integer :: ierr
      real(kind=rkind) :: width, length, density
      integer(kind=ikind) :: edges, i, proc
      real(kind=rkind), dimension(:,:,:), allocatable :: xy
      real(kind=rkind), dimension(2) :: center_coor
      

      call comment(file_mesh)
      read(unit=file_mesh, fmt=*, iostat = ierr) width; if (ierr /= 0) call file_error(file_mesh)

      call comment(file_mesh)
      read(unit=file_mesh, fmt=*, iostat = ierr) length; if (ierr /= 0) call file_error(file_mesh)
      call comment(file_mesh)

      read(unit=file_mesh, fmt=*, iostat = ierr) density; if (ierr /= 0) call file_error(file_mesh)

      call comment(file_mesh)
      
      read(unit=file_mesh, fmt=*, iostat = ierr) center_coor; if (ierr /= 0) call file_error(file_mesh)    
      
      call comment(file_mesh)
            
      read(unit=file_mesh, fmt=*, iostat=ierr) edges; if(ierr /= 0) call file_error(file_mesh)

      allocate(xy(edges,2,2))
      
      

      do i=1, edges
	call comment(file_mesh)
	read(unit=file_mesh, fmt=*, iostat = ierr) xy(i,1,:); if(ierr /= 0) call file_error(file_mesh)
	read(unit=file_mesh, fmt=*, iostat = ierr) xy(i,2,:); if(ierr /= 0) call file_error(file_mesh)
      end do
	
      call simegen2d(width, length, density, xy, center_coor)


      deallocate(xy)
    end subroutine read_2dmesh_int

!> loads mesh data files from external mesh generator and allocate required mesh structures
    subroutine read_2dmesh_t3d()
      use typy
      use globals
      use globals2D
      use core_tools
      use readtools
      use debug_tools


      integer(kind=ikind) :: i, okro, l
      real :: ch

 
  
      call comment(file_mesh)
      read(unit=file_mesh, fmt=*) ch
      call comment(file_mesh)
      read(unit=file_mesh, fmt=*) nodes%kolik, ch, elements%kolik
      call comment(file_mesh) 

      call mesh_allocater()

      do i=1, nodes%kolik
	call comment(file_mesh)
	read(unit=file_mesh, fmt=*) nodes%id(i), nodes%data(i,:), ch, ch, ch, nodes%edge(i) 
	if (nodes%edge(i) > 100 .and. nodes%edge(i) < 1000 ) then
	  CONTINUE
	else
	  nodes%edge(i) = 0
	end if
      end do
      
   
    
      do i=1, elements%kolik
	call comment(file_mesh)
	read(unit=file_mesh, fmt=*) elements%id(i), elements%data(i,:), ch, ch, elements%material(i,1)
	elements%material(i,1) = elements%material(i,1)  - 10000
      end do
     

      close(file_mesh)

    end subroutine read_2dmesh_t3d
    
    
    subroutine read_2dmesh_gmsh
      use typy
      use globals
      use globals2D
      use core_tools
      use readtools
      use pde_objs
      use debug_tools
      
      character(len=256) :: ch
      integer(kind=ikind) :: i, itmp, jtmp, itmp2, edge, nd1, nd2, i_err, k, l, j
      integer(kind=ikind), dimension(:), allocatable :: tmp_array
      
    
      do
	read(unit=file_mesh, fmt=*) ch
	if (trim(ch) == "$Nodes") EXIT
      end do
      
      read(unit=file_mesh, fmt=*) nodes%kolik

      do 
	read(unit=file_mesh, fmt=*) ch
	if (trim(ch) == "$Elements") EXIT
      end do

      read(unit=file_mesh, fmt=*) itmp
      
      elements%kolik = 0
      
      do i=1, itmp
	read(unit=file_mesh, fmt=*) ch, itmp2
	if (itmp2 == 2) then
	  elements%kolik = elements%kolik + 1
	end if
      end do
      
      call mesh_allocater()

            
      do 
	itmp = ftell(file_mesh)
	backspace(unit=file_mesh, iostat=i_err)
	jtmp = ftell(file_mesh)
	if(itmp == jtmp) EXIT
      end do
  
  
      do
	read(unit=file_mesh, fmt=*) ch
	if (trim(ch) == "$Nodes") then
	  read(unit=file_mesh, fmt=*) ch
	  EXIT
	end if
      end do
      
      do i=1, nodes%kolik
	read(unit=file_mesh, fmt=*) ch, ch, nodes%data(i,:)
      end do
      
      do 
	read(unit=file_mesh, fmt=*) ch
	if (trim(ch) == "$Elements") then
	  read(unit=file_mesh, fmt=*) ch
	  EXIT
	end if
      end do
      
      jtmp = 0
      
      nodes%edge = 0
      
      do 
	read(unit=file_mesh, fmt=*, iostat=i_err) ch, itmp
	if (ch == "$EndElements") then
	  EXIT
	end if
	backspace(file_mesh, iostat = i_err)
	if (i_err /= 0) then
	  print *, "Something wrong with your GMSH input file"
	  print *, "called from read_inputs::read_2dmesh_gmsh"
	  STOP
	end if

	
	select case(itmp)
	  case(1)
	    read(unit=file_mesh, fmt=*) k, l, i, edge, j,  nd1, nd2
	    if (i > 2) then
	      call write_log("number of tags for edge must be equal 1, in mesh file it equals", int1=i)
	      call write_log("update your GMSH input file!")
	      allocate(tmp_array(i-1))
	      backspace(file_mesh)
	      read(unit=file_mesh, fmt=*) k, l, i, edge,  tmp_array,  nd1, nd2
	      edge = tmp_array(1)
	      call write_log(text="tags with positions greater than 1 were ignored")
	      deallocate(tmp_array)
	    end if
	    
! 	    print *, tmp_array, nd1, nd2 ; stop
! 	    print *, itmp, jtmp, i, tmp_array,  nd1, nd2
	    
	    nodes%edge(nd1) = edge 
	    nodes%edge(nd2) = edge 
	    
	  case(2)
	    jtmp = jtmp + 1
	    read(unit=file_mesh, fmt=*) k, l, i, elements%material(jtmp,:), j,  elements%data(jtmp,:)
	    if (i /= pde_common%processes + 1) then
	      call write_log("number of tags for element must be equal to the number &
	      of solution components plus one, e.g. Richards equation + ADE equation (solution h and c) number of tags = 2 + 1 ")
	      call write_log("update your GMSH input file!")
	      if (i > pde_common%processes + 1) then
		
		call write_log("the number of tags is greater than the number of solution components")
		
		if (allocated(tmp_array)) deallocate(tmp_array)
		
		allocate(tmp_array(i-1))
		
		backspace(file_mesh)
		read(unit=file_mesh, fmt=*) k, l, i, elements%material(jtmp,:), tmp_array, elements%data(jtmp,:)
		elements%material(jtmp,:) = tmp_array(1:ubound(elements%material,2))
		call write_log(text="tags with position", int1=1_ikind*(ubound(elements%material,2)+1), &
		    text2="were ignored")
		deallocate(tmp_array)
	      else
		call write_log("the number of tags is lower than the number of solution components, I don't know what to do :(")
	        print *, "called from read_inputs::read_2dmesh_gmsh"
	        error STOP
	      end if
	    end if
	      
	  case default
	    print *, "your GMSH input file contains unsupported element type"
	    print *, "called from read_inputs::read_2dmesh_gmsh"
	    STOP
	 end select
	 
      end do

     
    end subroutine read_2dmesh_gmsh
    
    subroutine read_scilab(name, proc)
      use typy
      use globals
      use global_objs
      use pde_objs
      use core_tools
      use debug_tools
      
      character(len=*), intent(in)  :: name
      integer(kind=ikind), intent(in) :: proc
      integer :: fileid, ierr
      character(len=1) :: ch
      integer(kind=ikind) :: i,j,k,l
      real(kind=rkind) :: tmp
      real(kind=rkind), dimension(3,3) :: elloc
      integer(kind=ikind), dimension(3) :: pmt
      


      call find_unit(fileid,20)
      
      open(unit=fileid, file=trim(name), action="read", status="old", iostat=ierr)
      
      if (ierr /=0) then
	print *, "unable to open input file with scilab data, called from read_inputs::read_scilab"
	print *, "the specified location was:", trim(name)
	error stop
      end if
      
      read(unit=fileid, fmt=*) ch, time
      
      read(unit=fileid, fmt=*) ch, ch, i
      
      if (i/=elements%kolik) then
	print *, "the mesh in the scilab file has different number of elements then the mesh "
	print *, i, "/=", elements%kolik
	print *, "that is loaded or gerenerated from drutes config files"
	print *, "called from read_inputs::read_scilab"
	error stop
      end if
      

      
      read(unit=fileid, fmt=*) ch
      read(unit=fileid, fmt=*) ch
      read(unit=fileid, fmt=*) ch
      
      do i=1,elements%kolik
	do j=1,3
	  read(unit=fileid, fmt=*) ch, ch, ch, ch, elloc(j,1)
	end do
	
	do j=1,3
	  read(unit=fileid, fmt=*) ch, ch, ch, ch, elloc(j,2)
	end do
	
	do j=1,3
	  read(unit=fileid, fmt=*) ch, ch, ch, ch, elloc(j,3)
	end do
	
	pmt = 0
	do j=1,3
	  l=elements%data(i,j)
	  do k=1,3
	    if (norm2(nodes%data(l,:)-elloc(k,1:2)) < 10*epsilon(tmp) ) then
	      pmt(k) = j
	    end if
	  end do
	end do
	
	if (minval(pmt) == 0) then
	  print *, "the scilab file has a different mesh (probably boundary conditions)"
	  print *, "than the one defined from drutes config files"
	  print *, "called from read_inputs::read_scilab"
	  ERROR STOP
	end if
	  
        pde(proc)%solution(elements%data(i,:)) = elloc(pmt,3)  
! 	  print *, pmt ; stop
	  

      end do
      
      do i=1,4
	read(unit=fileid, fmt=*) ch
      end do
      
!       read(unit=fileid, fmt=*) ch, ch, time

      close(fileid)    
      
    
    end subroutine read_scilab




      

end module read_inputs

! 	   if (r /= nodes%data(elements%data(i,j),2)) then

! 	   end if
