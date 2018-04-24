module manage_pointers
  public :: set_pointers

  contains


    !> set pointers for the entire problem, except the file read pointers
    subroutine set_pointers()
      use typy
      use global_objs
      use pde_objs
      use globals
      use core_tools
      use capmat
      use fem_tools
      use feminittools
      use fem
      use femmat
      use schwarz_dd
      use schwarz_dd2subcyc
      use solver_interfaces
      use debug_tools
      use bousspointers
      use re_pointers
      use ADE_pointers

      integer(kind=ikind) :: i

      select case(adjustl(trim(drutes_config%name)))
	case("RE_std")
	  write(unit=drutes_config%fullname, fmt=*) "Richards' equation, in", drutes_config%dimen, &
	  "D, in pressure head form."
	  call RE_std(pde(1))
	case("REstdH")
	  write(unit=drutes_config%fullname, fmt=*) "Richards' equation, in", drutes_config%dimen, &
	  "D, in total hydraulic head form."
	  call REstdH(pde(1))
	case("RE_rot")
	  write(unit=drutes_config%fullname, fmt=*) "Richards' equation, in", drutes_config%dimen, &
	  "D, in cylindric coordinates and axysimmetric flow, in pressure head form."
	  call RE_rot(pde(1))
	case("RErotH")
	  write(unit=drutes_config%fullname, fmt=*) "Richards' equation, in", drutes_config%dimen, &
	  "D, in cylindric coordinates and axysimmetric flow, in total hydraulic head form."
	  call RErotH(pde(1))
	
	      
	case("boussi")   
	   write(unit=drutes_config%fullname, fmt=*) " Boussinesq equation for hillslope runoff", &
           "(1D approximation of groundwater flow)."
           call boussi(pde(1))
           
        
	case("ADEstd") 
	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation in", &
           drutes_config%dimen, "D, convection is specified in input files, equilibrium sorption"
           call ade(pde(1))

      case("ADEstd_kinsorb")
      
      	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation in", &
           drutes_config%dimen, "D, convection is specified in input files, kinetic sorption"
           call ade(pde(1))
           call adekinsorb(pde(2))
           
      case("ADE_RE_std")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  "  Richards equation in pressure head form in", &
           drutes_config%dimen, "D, convection is computed, equilibrium sorption"	
           
           call RE_std(pde(1))
           call ade(pde(2))
	
      case("ADE_REstdH")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in total hydraulic head form in", &
           drutes_config%dimen, "D, convection is computed, equilibrium sorption"	
           
           call REstdH(pde(1))
           call ade(pde(2))


      case("ADE_RE_rot")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in pressure head form", &
           "flow is axisymmetric, convection is computed, equilibrium sorption"	
           
           call RE_rot(pde(1))
           call ade(pde(2))
           
      case("ADE_RErotH")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in total hydraulic head form", &
           "flow is axisymmetric, convection is computed, equilibrium sorption"	
           
           call RE_rot(pde(1))
           call ade(pde(2))           
	  

      case("ADE_RE_std_kinsorb")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in pressure head form in", &
           drutes_config%dimen, "D, convection is computed, kinetic sorption"	
           
           call RE_std(pde(1))
           call ade(pde(2))
           call adekinsorb(pde(3))
	
      case("ADE_REstdH_kinsorb")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in total hydraulic head form in", &
           drutes_config%dimen, "D, convection is computed, kinetic sorption"	
           
           call REstdH(pde(1))
           call ade(pde(2))
           call adekinsorb(pde(3))

      case("ADE_RE_rot_kinsorb")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in pressure head form", &
           " flow is axisymmetric, convection is computed, kinetic sorption"	
           
           call RE_rot(pde(1))
           call ade(pde(2))
           call adekinsorb(pde(3))
           
      case("ADE_RErotH_kinsorb")
     	  write(unit=drutes_config%fullname, fmt=*) " advection-dispersion-reaction equation", &
     	  " and Richards equation in total hydraulic head form", &
           " flow is axisymmetric, convection is computed, kinetic sorption"	
           
           call RE_rot(pde(1))
           call ade(pde(2))
           call adekinsorb(pde(3))
		
	
       case("REtest")
	  write(unit=drutes_config%fullname, fmt=*) "DRUtES debugs itself"
	  do i=1, 3
	    call RE_std(pde(i))
	  end do

    end select

      
      select case(drutes_config%dimen)
	case(1)
 	    solve_matrix => LDU_face
	case(2)
!  solve_matrix => pcg
	    solve_matrix => CG_normal_face
! 	    solve_matrix => sparse_gem_pig_AtA
! 	    solve_matrix => jacobi_face
      end select

      select case (drutes_config%it_method)
	case(0) 
	  pde_common%treat_pde => solve_picard
	case(1)
	  pde_common%treat_pde => schwarz_picard
	case(2)
	  pde_common%treat_pde => schwarz_subcyc
      end select
    

      select case(pde_common%timeint_method)
	case(0)
	  pde_common%time_integ => steady_state_int
	case(1)
	  pde_common%time_integ => impl_euler_np_diag
	case(2)
	  pde_common%time_integ => impl_euler_np_nondiag
      end select


  end subroutine set_pointers

! 	case("RE_mod")
! 	  !pde(1) Richards eq.
! 	  !pde(2) Heat flux
! 	  !pde(3) Transport of solutes
! 	  
! 	  pde_common%nonlinear = .true.
! 	  pde(1)%mass => mass_R
! 	  pde(1)%pde_fnc(1)%elasticity => elas_R_to_potential
! 	  pde(1)%pde_fnc(1)%dispersion => disp_R_to_potential
! 	  pde(1)%pde_fnc(1)%convection => conv_R_to_gravity
! 	  pde(1)%pde_fnc(1)%der_convect => dummy_vector
! 	  pde(1)%pde_fnc(1)%reaction => dummy_scalar
! 	  
! 	  pde(1)%pde_fnc(2)%elasticity => dummy_scalar  
! 	  pde(1)%pde_fnc(2)%dispersion => disp_R_to_heat
! ! 	  pde(1)%pde_fnc(2)%dispersion => dummy_tensor
! 	  pde(1)%pde_fnc(2)%convection => dummy_vector
! 	  pde(1)%pde_fnc(2)%der_convect => dummy_vector
! 	  pde(1)%pde_fnc(2)%reaction => dummy_scalar
! 	  
! 	  pde(1)%pde_fnc(3)%elasticity => dummy_scalar  
! 	  pde(1)%pde_fnc(3)%dispersion => disp_R_to_solute
! ! 	  pde(1)%pde_fnc(3)%dispersion => dummy_tensor
! 	  pde(1)%pde_fnc(3)%convection => dummy_vector
! 	  pde(1)%pde_fnc(3)%der_convect => dummy_vector
! 	  pde(1)%pde_fnc(3)%reaction => dummy_scalar
! 	  
! 	  
! 	  pde(2)%mass => dummy_scalar  
! 	  pde(2)%pde_fnc(1)%elasticity => dummy_scalar
! 	  pde(2)%pde_fnc(1)%dispersion => disp_H_to_potential
! ! 	  pde(2)%pde_fnc(1)%dispersion => dummy_tensor
! 	  pde(2)%pde_fnc(1)%convection => dummy_vector
! 	  pde(2)%pde_fnc(1)%der_convect => dummy_vector
! 	  pde(2)%pde_fnc(1)%reaction => dummy_scalar
! 	  
! 	  pde(2)%pde_fnc(2)%elasticity => elas_H_to_heat 
! 	  pde(2)%pde_fnc(2)%dispersion => disp_H_to_heat
! 	  pde(2)%pde_fnc(2)%convection => conv_H_to_heat
! 	  pde(2)%pde_fnc(2)%der_convect => dummy_vector
! 	  pde(2)%pde_fnc(2)%reaction => dummy_scalar
! 	  
! 	  pde(2)%pde_fnc(3)%elasticity => dummy_scalar  
! 	  pde(2)%pde_fnc(3)%dispersion => disp_H_to_solute
! ! 	  pde(2)%pde_fnc(3)%dispersion => dummy_tensor
! 	  pde(2)%pde_fnc(3)%convection => dummy_vector
! 	  pde(2)%pde_fnc(3)%der_convect => dummy_vector
! 	  pde(2)%pde_fnc(3)%reaction => dummy_scalar
! 	  
! 	  
! 	  pde(3)%mass => dummy_scalar  
! 	  pde(3)%pde_fnc(1)%elasticity => dummy_scalar
! 	  pde(3)%pde_fnc(1)%dispersion => dummy_tensor
! 	  pde(3)%pde_fnc(1)%convection => dummy_vector
! 	  pde(3)%pde_fnc(1)%der_convect => dummy_vector
! 	  pde(3)%pde_fnc(1)%reaction => dummy_scalar
! 	  
! 	  pde(3)%pde_fnc(2)%elasticity => dummy_scalar  
! 	  pde(3)%pde_fnc(2)%dispersion => dummy_tensor
! 	  pde(3)%pde_fnc(2)%convection => dummy_vector
! 	  pde(3)%pde_fnc(2)%der_convect => dummy_vector
! 	  pde(3)%pde_fnc(2)%reaction => dummy_scalar
! 	  
! 	  pde(3)%pde_fnc(3)%elasticity => elas_S_to_solute
! 	  pde(3)%pde_fnc(3)%dispersion => disp_S_to_solute
! 	  pde(3)%pde_fnc(3)%convection => conv_S_to_solute
! 	  pde(3)%pde_fnc(3)%der_convect => dummy_vector
! 	  pde(3)%pde_fnc(3)%reaction => dummy_scalar
! 	  
! ! 	  ! ! ! ! Pocatecni podminky ! ! ! ! 
! 	  pde(1)%initcond => modre_initcond
! 	  pde(2)%initcond => modheat_initcond
! 	  pde(3)%initcond => modsolute_initcond
! 	  ! ! ! ! 
! 	  
! 
! 	  do i=1, ubound(pde,1)  
! 	    pde(i)%dt_check => time_check_ok
! 	  end do
! 	  
! 	  ! okrajove podminky transportu vody
! 	  do i=lbound(pde(1)%bc,1), ubound(pde(1)%bc,1)
! 	    select case(pde(1)%bc(i)%code)
! 	      case(-1)
! 		  pde(1)%bc(i)%value_fnc => re_dirichlet_height_bc
! 	      case(0)
! 		    pde(1)%bc(i)%value_fnc => re_null_bc
! 	      case(1)
! 		    pde(1)%bc(i)%value_fnc => re_dirichlet_bc
! 	      case(2)
! 		    pde(1)%bc(i)%value_fnc => re_neumann_bc
! 	      case(3)
! 		    pde(1)%bc(i)%value_fnc => re_null_bc
! 	      case default
! 		    print *, "ERROR! You have specified an unsupported boundary type definition for the Richards equation"
! 		    print *, "the incorrect boundary code specified is:", pde(1)%bc(i)%code
! 		    ERROR stop
! 	    end select
! 	  end do
! 
! 	  ! okrajove podminky transportu tepla
! 	  do i=lbound(pde(2)%bc,1), ubound(pde(2)%bc,1)
! 	    select case(pde(2)%bc(i)%code)
! 	      case(0)
! 		    pde(2)%bc(i)%value_fnc => re_null_bc
! 	      case(1)
! 		    pde(2)%bc(i)%value_fnc => T_dirichlet_bc
! 	      case(2)
! 		    pde(2)%bc(i)%value_fnc => T_neumann_bc
! 	      case(3)
! 		    pde(2)%bc(i)%value_fnc => re_null_bc
! 	      case default
! 		    print *, "ERROR! You have specified an unsupported boundary type definition for the Richards equation"
! 		    print *, "the incorrect boundary code specified is:", pde(1)%bc(i)%code
! 		    ERROR stop
! 	    end select
! 	  end do
! 	
! 	  ! okrajove podminky transportu kontaminantu
! 	  do i=lbound(pde(3)%bc,1), ubound(pde(3)%bc,1)
! 	    select case(pde(1)%bc(i)%code)
! 	      case(0)
! 		    pde(3)%bc(i)%value_fnc => re_null_bc
! 	      case(1)
! 		    pde(3)%bc(i)%value_fnc => C_dirichlet_bc
! 	      case(2)
! 		    pde(3)%bc(i)%value_fnc => C_neumann_bc
! 	      case(3)
! 		    pde(3)%bc(i)%value_fnc => re_null_bc
! 	      case default
! 		    print *, "ERROR! You have specified an unsupported boundary type definition for the Richards equation"
! 		    print *, "the incorrect boundary code specified is:", pde(1)%bc(i)%code
! 		    ERROR stop
! 	    end select
! 	  end do
  

end module manage_pointers