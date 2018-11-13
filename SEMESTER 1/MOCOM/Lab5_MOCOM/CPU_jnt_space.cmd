!
!-------------------------- Default Units for Model ---------------------------!
!
!
defaults units  &
   length = meter  &
   angle = deg  &
   force = newton  &
   mass = kg  &
   time = sec
!
defaults units  &
   coordinate_system_type = cartesian  &
   orientation_type = body313
!
!------------------------ Default Attributes for Model ------------------------!
!
!
defaults attributes  &
   inheritance = bottom_up  &
   icon_visibility = on  &
   grid_visibility = off  &
   size_of_icons = 4.0E-02  &
   spacing_for_grid = 4.0E-02
!
!--------------------------- Plugins used by Model ----------------------------!
!
!
plugin load  &
   plugin_name = .MDI.plugins.controls
!
!------------------------------ Adams View Model ------------------------------!
!
!
model create  &
   model_name = CPU_jnt_space  &
   title = "ADAMS/View model name: lwr"
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_1
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_2
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_3
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_4
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_5
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_6
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_7
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_8
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_9
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_10
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_11
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_12
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_13
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_14
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_15
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_16
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_17
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_18
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_19
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_20
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_21
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_22
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_23
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_24
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_25
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_26
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_27
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_28
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_29
!
model create  &
   model_name = .CPU_jnt_space.CPU_jnt_space
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_30
!
model create  &
   model_name = .CPU_jnt_space.Controls_Plant_31
!
view erase
!
!-------------------------------- Data storage --------------------------------!
!
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q1  &
   adams_id = 1  &
   comments = "SFORCE/8", ", ROTATIONAL", ", I = 69", ", J = 70",  &
              ", FUNCTION = .1", "SFORCE/9", ", ROTATIONAL", ", I = 71",  &
              ", J = 72", ", FUNCTION = .1", "SFORCE/10", ", ROTATIONAL",  &
              ", I = 73", ", J = 74", ", FUNCTION = .1", "SFORCE/11",  &
              ", ROTATIONAL", ", I = 75", ", J = 76",  &
              ", FUNCTION = VARVAL(6)", "SFORCE/12", ", ROTATIONAL",  &
              ", I = 77", ", J = 78", ", FUNCTION = .1", "SFORCE/13",  &
              ", ROTATIONAL", ", I = 79", ", J = 80", ", FUNCTION = .1",  &
              "SFORCE/14", ", ROTATIONAL", ", I = 81", ", J = 82",  &
              ", FUNCTION = .1"  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w1  &
   adams_id = 2  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd1  &
   adams_id = 3  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w2  &
   adams_id = 4  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w3  &
   adams_id = 5  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w4  &
   adams_id = 6  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w5  &
   adams_id = 7  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w6  &
   adams_id = 8  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.w7  &
   adams_id = 9  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q2  &
   adams_id = 10  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q3  &
   adams_id = 11  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q4  &
   adams_id = 12  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q5  &
   adams_id = 13  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q6  &
   adams_id = 14  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.q7  &
   adams_id = 15  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd2  &
   adams_id = 16  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd3  &
   adams_id = 17  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd4  &
   adams_id = 18  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd5  &
   adams_id = 19  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd6  &
   adams_id = 20  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .CPU_jnt_space.qd7  &
   adams_id = 21  &
   initial_condition = 0.0  &
   function = ""
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_1.ctrl_pinput  &
   adams_id = 1  &
   variable_name = .CPU_jnt_space.w1
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_2.ctrl_pinput  &
   adams_id = 2  &
   variable_name = .CPU_jnt_space.w1
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.PINPUT  &
   adams_id = 3  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_3.ctrl_pinput  &
   adams_id = 4  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_4.ctrl_pinput  &
   adams_id = 5  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_5.ctrl_pinput  &
   adams_id = 6  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_6.ctrl_pinput  &
   adams_id = 7  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_7.ctrl_pinput  &
   adams_id = 8  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_8.ctrl_pinput  &
   adams_id = 9  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_9.ctrl_pinput  &
   adams_id = 10  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_10.ctrl_pinput  &
   adams_id = 11  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_11.ctrl_pinput  &
   adams_id = 12  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_12.ctrl_pinput  &
   adams_id = 13  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_13.ctrl_pinput  &
   adams_id = 14  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_14.ctrl_pinput  &
   adams_id = 15  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_15.ctrl_pinput  &
   adams_id = 16  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_16.ctrl_pinput  &
   adams_id = 17  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_17.ctrl_pinput  &
   adams_id = 18  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_18.ctrl_pinput  &
   adams_id = 19  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_19.ctrl_pinput  &
   adams_id = 20  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_20.ctrl_pinput  &
   adams_id = 21  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_21.ctrl_pinput  &
   adams_id = 22  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_22.ctrl_pinput  &
   adams_id = 23  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_23.ctrl_pinput  &
   adams_id = 24  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_24.ctrl_pinput  &
   adams_id = 25  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_25.ctrl_pinput  &
   adams_id = 26  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_26.ctrl_pinput  &
   adams_id = 27  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_27.ctrl_pinput  &
   adams_id = 28  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_28.ctrl_pinput  &
   adams_id = 29  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_29.ctrl_pinput  &
   adams_id = 30  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.CPU_jnt_space.ctrl_pinput  &
   adams_id = 31  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_30.ctrl_pinput  &
   adams_id = 32  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant input  &
   plant_input_name = .CPU_jnt_space.Controls_Plant_31.ctrl_pinput  &
   adams_id = 33  &
   variable_name =  &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_1.ctrl_poutput  &
   adams_id = 1  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.qd1
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_2.ctrl_poutput  &
   adams_id = 2  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.qd1
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.POUTPUT  &
   adams_id = 3  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_3.ctrl_poutput  &
   adams_id = 4  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_4.ctrl_poutput  &
   adams_id = 5  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_5.ctrl_poutput  &
   adams_id = 6  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_6.ctrl_poutput  &
   adams_id = 7  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_7.ctrl_poutput  &
   adams_id = 8  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_8.ctrl_poutput  &
   adams_id = 9  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_9.ctrl_poutput  &
   adams_id = 10  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_10.ctrl_poutput  &
   adams_id = 11  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_11.ctrl_poutput  &
   adams_id = 12  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_12.ctrl_poutput  &
   adams_id = 13  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_13.ctrl_poutput  &
   adams_id = 14  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_14.ctrl_poutput  &
   adams_id = 15  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_15.ctrl_poutput  &
   adams_id = 16  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_16.ctrl_poutput  &
   adams_id = 17  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_17.ctrl_poutput  &
   adams_id = 18  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_18.ctrl_poutput  &
   adams_id = 19  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_19.ctrl_poutput  &
   adams_id = 20  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_20.ctrl_poutput  &
   adams_id = 21  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_21.ctrl_poutput  &
   adams_id = 22  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_22.ctrl_poutput  &
   adams_id = 23  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_23.ctrl_poutput  &
   adams_id = 24  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_24.ctrl_poutput  &
   adams_id = 25  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_25.ctrl_poutput  &
   adams_id = 26  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_26.ctrl_poutput  &
   adams_id = 27  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_27.ctrl_poutput  &
   adams_id = 28  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_28.ctrl_poutput  &
   adams_id = 29  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_29.ctrl_poutput  &
   adams_id = 30  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.CPU_jnt_space.ctrl_poutput  &
   adams_id = 31  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_30.ctrl_poutput  &
   adams_id = 32  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
data_element create plant output  &
   plant_output_name = .CPU_jnt_space.Controls_Plant_31.ctrl_poutput  &
   adams_id = 33  &
   variable_name =  &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
!-------------------------------- Rigid Parts ---------------------------------!
!
! Create parts and their dependent markers and graphics
!
!------------------------------------ base ------------------------------------!
!
!
! ****** Ground Part ******
!
part modify rigid_body name_and_position  &
   part_name = ground  &
   new_part_name = base
!
part modify rigid_body name_and_position  &
   part_name = base  &
   adams_id = 2
!
defaults model  &
   part_name = base
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.base.MAR5  &
   adams_id = 5  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.base.cm  &
   adams_id = 36  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.base.MARKER_40  &
   adams_id = 40  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.base.MARKER_42  &
   adams_id = 42  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.base.MARKER_56  &
   adams_id = 56  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.base.MARKER_70  &
   adams_id = 70  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
!------------------------------------- A1 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.A1  &
   adams_id = 3  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.A1
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MAR7  &
   adams_id = 7  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.cm  &
   adams_id = 37  &
   location = -5.10394667E-05, 2.33251438E-02, -8.51481019E-02  &
   orientation = 0.170205272d, 165.8636798009d, 269.8251010014d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_39  &
   adams_id = 39  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_41  &
   adams_id = 41  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_44  &
   adams_id = 44  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_55  &
   adams_id = 55  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_58  &
   adams_id = 58  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_69  &
   adams_id = 69  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A1.MARKER_72  &
   adams_id = 72  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.A1  &
   mass = 2.687002077  &
   center_of_mass_marker = .CPU_jnt_space.A1.cm  &
   inertia_marker = .CPU_jnt_space.A1.MAR7  &
   ixx = 3.88305543E-02  &
   iyy = 3.71587284E-02  &
   izz = 6.4997741E-03  &
   ixy = -1.909844823E-06  &
   izx = 1.09868814E-06  &
   iyz = -1.9376898E-03
!
!------------------------------------- A2 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.A2  &
   adams_id = 4  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.A2
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.A2.cm  &
   adams_id = 1  &
   location = 0.0, -2.5273E-02, 7.8752E-02  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MAR9  &
   adams_id = 9  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MARKER_43  &
   adams_id = 43  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MARKER_46  &
   adams_id = 46  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MARKER_57  &
   adams_id = 57  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MARKER_60  &
   adams_id = 60  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MARKER_71  &
   adams_id = 71  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A2.MARKER_74  &
   adams_id = 74  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.A2  &
   mass = 2.687002854  &
   center_of_mass_marker = .CPU_jnt_space.A2.cm  &
   inertia_marker = .CPU_jnt_space.A2.MAR9  &
   ixx = 3.56537056E-02  &
   iyy = 6.7674749E-03  &
   izz = 3.37147772E-02  &
   ixy = -7.719426853E-07  &
   izx = 1.105327586E-06  &
   iyz = 2.3652766E-03
!
!------------------------------------- E1 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.E1  &
   adams_id = 5  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.E1
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MAR10  &
   adams_id = 10  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.cm  &
   adams_id = 38  &
   location = 2.370543488E-07, -2.59139393E-02, 0.3121966761  &
   orientation = 179.9984745807d, 164.9003779494d, 90.0017811656d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MARKER_45  &
   adams_id = 45  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MARKER_48  &
   adams_id = 48  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MARKER_59  &
   adams_id = 59  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MARKER_62  &
   adams_id = 62  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MARKER_73  &
   adams_id = 73  &
   location = 0.0, 0.0, 0.4  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.E1.MARKER_76  &
   adams_id = 76  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.E1  &
   mass = 2.687009069  &
   center_of_mass_marker = .CPU_jnt_space.E1.cm  &
   inertia_marker = .CPU_jnt_space.E1.MAR10  &
   ixx = 4.01021511E-02  &
   iyy = 3.80387161E-02  &
   izz = 6.7863204E-03  &
   ixy = -3.09191156E-08  &
   izx = -1.572918957E-07  &
   iyz = 2.522474E-03
!
!------------------------------------- A3 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.A3  &
   adams_id = 6  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.A3
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.A3.cm  &
   adams_id = 11  &
   location = 0.0, 2.3273E-02, 0.478752  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MAR12  &
   adams_id = 12  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MARKER_47  &
   adams_id = 47  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MARKER_50  &
   adams_id = 50  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MARKER_61  &
   adams_id = 61  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MARKER_64  &
   adams_id = 64  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MARKER_75  &
   adams_id = 75  &
   location = 0.0, 0.0, 0.4  &
   orientation = 180.0000000235d, 90.0000000118d, 180.0000000235d
!
marker create  &
   marker_name = .CPU_jnt_space.A3.MARKER_78  &
   adams_id = 78  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.A3  &
   mass = 2.687002854  &
   center_of_mass_marker = .CPU_jnt_space.A3.cm  &
   inertia_marker = .CPU_jnt_space.A3.MAR12  &
   ixx = 3.53929597E-02  &
   iyy = 6.5067289E-03  &
   izz = 3.37147772E-02  &
   ixy = -7.719565852E-07  &
   izx = -1.122073911E-06  &
   iyz = -1.9418013E-03
!
!------------------------------------- A4 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.A4  &
   adams_id = 7  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.A4
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.A4.cm  &
   adams_id = 13  &
   location = 0.0, 2.1556E-02, 0.680669  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MAR16  &
   adams_id = 16  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MARKER_49  &
   adams_id = 49  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MARKER_52  &
   adams_id = 52  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MARKER_63  &
   adams_id = 63  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MARKER_66  &
   adams_id = 66  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MARKER_77  &
   adams_id = 77  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A4.MARKER_80  &
   adams_id = 80  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.A4  &
   mass = 1.798003887  &
   center_of_mass_marker = .CPU_jnt_space.A4.cm  &
   inertia_marker = .CPU_jnt_space.A4.MAR16  &
   ixx = 3.20961188E-02  &
   iyy = 3.05167072E-02  &
   izz = 4.763466E-03  &
   ixy = 9.711915964E-08  &
   izx = -1.490678132E-07  &
   iyz = -1.3595485E-03
!
!------------------------------------- A5 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.A5  &
   adams_id = 8  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.A5
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.A5.cm  &
   adams_id = 14  &
   location = 0.0, -4.018E-03, 0.787047  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MAR17  &
   adams_id = 17  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MARKER_51  &
   adams_id = 51  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MARKER_54  &
   adams_id = 54  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MARKER_65  &
   adams_id = 65  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MARKER_68  &
   adams_id = 68  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MARKER_79  &
   adams_id = 79  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 90.0000000118d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A5.MARKER_82  &
   adams_id = 82  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.A5  &
   mass = 1.741003896  &
   center_of_mass_marker = .CPU_jnt_space.A5.cm  &
   inertia_marker = .CPU_jnt_space.A5.MAR17  &
   ixx = 3.5027431E-03  &
   iyy = 3.771367E-03  &
   izz = 3.4749439E-03  &
   ixy = -1.397871752E-07  &
   izx = 6.97040578E-08  &
   iyz = 9.114663756E-06
!
!------------------------------------- A6 -------------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
part create rigid_body name_and_position  &
   part_name = .CPU_jnt_space.A6  &
   adams_id = 9  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.A6
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .CPU_jnt_space.A6.cm  &
   adams_id = 15  &
   location = 1.204336054E-06, 4.970408849E-04, 0.8521882524  &
   orientation = 294.9201973277d, 89.9993357245d, 90.0029820852d
!
marker create  &
   marker_name = .CPU_jnt_space.A6.MAR19  &
   adams_id = 19  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A6.MARKER_53  &
   adams_id = 53  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A6.MARKER_67  &
   adams_id = 67  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .CPU_jnt_space.A6.MARKER_81  &
   adams_id = 81  &
   location = 0.0, 0.0, 0.79  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .CPU_jnt_space.A6  &
   mass = 0.1270005409  &
   center_of_mass_marker = .CPU_jnt_space.A6.cm  &
   inertia_marker = .CPU_jnt_space.A6.MAR19  &
   ixx = 5.399765311E-04  &
   iyy = 5.399567373E-04  &
   izz = 8.182922917E-05  &
   ixy = 6.93823724E-09  &
   izx = 9.888288263E-09  &
   iyz = 3.923881127E-06
!
!----------------------------------- Joints -----------------------------------!
!
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_A1  &
   adams_id = 1  &
   i_marker_name = .CPU_jnt_space.A1.MARKER_41  &
   j_marker_name = .CPU_jnt_space.base.MARKER_42
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_A2  &
   adams_id = 2  &
   i_marker_name = .CPU_jnt_space.A2.MARKER_43  &
   j_marker_name = .CPU_jnt_space.A1.MARKER_44
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_E1  &
   adams_id = 3  &
   i_marker_name = .CPU_jnt_space.E1.MARKER_45  &
   j_marker_name = .CPU_jnt_space.A2.MARKER_46
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_A3  &
   adams_id = 4  &
   i_marker_name = .CPU_jnt_space.A3.MARKER_47  &
   j_marker_name = .CPU_jnt_space.E1.MARKER_48
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_A4  &
   adams_id = 5  &
   i_marker_name = .CPU_jnt_space.A4.MARKER_49  &
   j_marker_name = .CPU_jnt_space.A3.MARKER_50
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_A5  &
   adams_id = 6  &
   i_marker_name = .CPU_jnt_space.A5.MARKER_51  &
   j_marker_name = .CPU_jnt_space.A4.MARKER_52
!
constraint create joint revolute  &
   joint_name = .CPU_jnt_space.JOINT_A6  &
   adams_id = 7  &
   i_marker_name = .CPU_jnt_space.A6.MARKER_53  &
   j_marker_name = .CPU_jnt_space.A5.MARKER_54
!
!----------------------------------- Forces -----------------------------------!
!
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_1  &
   adams_id = 1  &
   comments = "MOTION/1", ", ROTATIONAL", ", JOINT = 1",  &
              ", FUNCTION = VARVAL(2)", "MOTION/2", ", ROTATIONAL",  &
              ", JOINT = 2", ", FUNCTION = VARVAL(4)", "MOTION/3",  &
              ", ROTATIONAL", ", JOINT = 3", ", FUNCTION = VARVAL(5)",  &
              "MOTION/4", ", ROTATIONAL", ", JOINT = 4",  &
              ", FUNCTION = VARVAL(6)", "MOTION/5", ", ROTATIONAL",  &
              ", JOINT = 5", ", FUNCTION = VARVAL(7)", "MOTION/6",  &
              ", ROTATIONAL", ", JOINT = 6", ", FUNCTION = VARVAL(8)",  &
              "MOTION/7", ", ROTATIONAL", ", JOINT = 7",  &
              ", FUNCTION = VARVAL(9)"  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.A1.MARKER_55  &
   j_marker_name = .CPU_jnt_space.base.MARKER_56  &
   action_only = off  &
   function = ""
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_2  &
   adams_id = 2  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.A2.MARKER_57  &
   j_marker_name = .CPU_jnt_space.A1.MARKER_58  &
   action_only = off  &
   function = ""
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_3  &
   adams_id = 3  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.E1.MARKER_59  &
   j_marker_name = .CPU_jnt_space.A2.MARKER_60  &
   action_only = off  &
   function = ""
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_4  &
   adams_id = 4  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.A3.MARKER_61  &
   j_marker_name = .CPU_jnt_space.E1.MARKER_62  &
   action_only = off  &
   function = ""
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_5  &
   adams_id = 5  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.A4.MARKER_63  &
   j_marker_name = .CPU_jnt_space.A3.MARKER_64  &
   action_only = off  &
   function = ""
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_6  &
   adams_id = 6  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.A5.MARKER_65  &
   j_marker_name = .CPU_jnt_space.A4.MARKER_66  &
   action_only = off  &
   function = ""
!
force create direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_7  &
   adams_id = 7  &
   type_of_freedom = rotational  &
   i_marker_name = .CPU_jnt_space.A6.MARKER_67  &
   j_marker_name = .CPU_jnt_space.A5.MARKER_68  &
   action_only = off  &
   function = ""
!
!-------------------------- Adams View UDE Instances --------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
undo begin_block suppress = yes
!
ude create instance  &
   instance_name = .CPU_jnt_space.Controls_Plant_32  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.input_channels  &
   object_value =   &
      .CPU_jnt_space.w1,  &
      .CPU_jnt_space.w2,  &
      .CPU_jnt_space.w3,  &
      .CPU_jnt_space.w4,  &
      .CPU_jnt_space.w5,  &
      .CPU_jnt_space.w6,  &
      .CPU_jnt_space.w7
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.output_channels  &
   object_value =   &
      .CPU_jnt_space.q1,  &
      .CPU_jnt_space.q2,  &
      .CPU_jnt_space.q3,  &
      .CPU_jnt_space.q4,  &
      .CPU_jnt_space.q5,  &
      .CPU_jnt_space.q6,  &
      .CPU_jnt_space.q7,  &
      .CPU_jnt_space.qd1,  &
      .CPU_jnt_space.qd2,  &
      .CPU_jnt_space.qd3,  &
      .CPU_jnt_space.qd4,  &
      .CPU_jnt_space.qd5,  &
      .CPU_jnt_space.qd6,  &
      .CPU_jnt_space.qd7
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.file_name  &
   string_value = "CPU_jnt_space"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.target  &
   string_value = "MATLAB"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.host  &
   string_value = "DESKTOP-CEB9BHA"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .CPU_jnt_space.Controls_Plant_32.include_mnf  &
   string_value = "no"
!
ude modify instance  &
   instance_name = .CPU_jnt_space.Controls_Plant_32
!
undo end_block
!
!------------------------------ Dynamic Graphics ------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .CPU_jnt_space.base
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_force_graphic_1  &
   adams_id = 51  &
   force_element_name = .CPU_jnt_space.SFORCE_1  &
   applied_at_marker_name = .CPU_jnt_space.A1.MARKER_55
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_2_force_graphic_1  &
   adams_id = 52  &
   force_element_name = .CPU_jnt_space.SFORCE_2  &
   applied_at_marker_name = .CPU_jnt_space.A2.MARKER_57
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_2_force_graphic_2  &
   adams_id = 53  &
   force_element_name = .CPU_jnt_space.SFORCE_3  &
   applied_at_marker_name = .CPU_jnt_space.E1.MARKER_59
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_2_force_graphic_3  &
   adams_id = 54  &
   force_element_name = .CPU_jnt_space.SFORCE_4  &
   applied_at_marker_name = .CPU_jnt_space.A3.MARKER_61
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_2_force_graphic_4  &
   adams_id = 55  &
   force_element_name = .CPU_jnt_space.SFORCE_5  &
   applied_at_marker_name = .CPU_jnt_space.A4.MARKER_63
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_3_force_graphic_1  &
   adams_id = 56  &
   force_element_name = .CPU_jnt_space.SFORCE_6  &
   applied_at_marker_name = .CPU_jnt_space.A5.MARKER_65
!
geometry create shape force  &
   force_name = .CPU_jnt_space.SFORCE_1_2_force_graphic_5  &
   adams_id = 57  &
   force_element_name = .CPU_jnt_space.SFORCE_7  &
   applied_at_marker_name = .CPU_jnt_space.A6.MARKER_67
!
!---------------------------------- Accgrav -----------------------------------!
!
!
force create body gravitational  &
   gravity_field_name = .CPU_jnt_space.ACC  &
   x_component_gravity = 0.0  &
   y_component_gravity = 0.0  &
   z_component_gravity = -9.80665
!
!----------------------------- Analysis settings ------------------------------!
!
!
!---------------------------- Adams View Variables ----------------------------!
!
!
variable create  &
   variable_name = .CPU_jnt_space._model  &
   string_value = ".CPU_jnt_space"
!
!---------------------------- Function definitions ----------------------------!
!
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q1  &
   function = "AZ(.CPU_jnt_space.A1.MARKER_41,.CPU_jnt_space.base.MARKER_42)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w1  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd1  &
   function = "WZ(.CPU_jnt_space.A1.MARKER_39, .CPU_jnt_space.base.MARKER_40, .CPU_jnt_space.base.MARKER_40)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w2  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w3  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w4  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w5  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w6  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.w7  &
   function = "0"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q2  &
   function = "AZ(.CPU_jnt_space.A2.MARKER_43,.CPU_jnt_space.A1.MARKER_44)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q3  &
   function = "AZ(.CPU_jnt_space.E1.MARKER_45,.CPU_jnt_space.A2.MARKER_46)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q4  &
   function = "AZ(.CPU_jnt_space.A3.MARKER_47,.CPU_jnt_space.E1.MARKER_48)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q5  &
   function = "AZ(.CPU_jnt_space.A4.MARKER_49,.CPU_jnt_space.A3.MARKER_50)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q6  &
   function = "AZ(.CPU_jnt_space.A5.MARKER_51,.CPU_jnt_space.A4.MARKER_52)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.q7  &
   function = "AZ(.CPU_jnt_space.A6.MARKER_53,.CPU_jnt_space.A5.MARKER_54)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd2  &
   function = "WZ(.CPU_jnt_space.A2.MARKER_43, .CPU_jnt_space.A1.MARKER_44, .CPU_jnt_space.A1.MARKER_44)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd3  &
   function = "WZ(.CPU_jnt_space.E1.MARKER_45, .CPU_jnt_space.A2.MARKER_46, .CPU_jnt_space.A2.MARKER_46)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd4  &
   function = "WZ(.CPU_jnt_space.A3.MARKER_47, .CPU_jnt_space.E1.MARKER_48, .CPU_jnt_space.E1.MARKER_48)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd5  &
   function = "WZ(.CPU_jnt_space.A4.MARKER_49, .CPU_jnt_space.A3.MARKER_50, .CPU_jnt_space.A3.MARKER_50)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd6  &
   function = "WZ(.CPU_jnt_space.A5.MARKER_51, .CPU_jnt_space.A4.MARKER_52, .CPU_jnt_space.A4.MARKER_52)"
!
data_element modify variable  &
   variable_name = .CPU_jnt_space.qd7  &
   function = "WZ(.CPU_jnt_space.A6.MARKER_53, .CPU_jnt_space.A5.MARKER_54, .CPU_jnt_space.A5.MARKER_54)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_1  &
   function = "VARVAL(.CPU_jnt_space.w1)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_2  &
   function = "VARVAL(.CPU_jnt_space.w2)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_3  &
   function = "VARVAL(.CPU_jnt_space.w3)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_4  &
   function = "VARVAL(.CPU_jnt_space.w4)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_5  &
   function = "VARVAL(.CPU_jnt_space.w5)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_6  &
   function = "VARVAL(.CPU_jnt_space.w6)"
!
force modify direct single_component_force  &
   single_component_force_name = .CPU_jnt_space.SFORCE_7  &
   function = "VARVAL(.CPU_jnt_space.w7)"
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .CPU_jnt_space.Controls_Plant_32
!
model display  &
   model_name = CPU_jnt_space
