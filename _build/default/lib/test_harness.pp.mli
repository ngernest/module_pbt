Caml1999N030����            4lib/test_harness.mli����  )  |  {  ������1ocaml.ppx.context��&_none_@@ �A����������)tool_name���*ppx_driver@@@����,include_dirs����"[]@@@����)load_path!����
%@%@@����,open_modules*����.@.@@����+for_package3����$None8@8@@����%debug=����%falseB@B@@����+use_threadsG����
K@K@@����-use_vmthreadsP����T@T@@����/recursive_typesY����]@]@@����)principalb����%f@f@@����3transparent_modulesk����.o@o@@����-unboxed_typest����7x@x@@����-unsafe_string}����@�@�@@����'cookies�����"::�����������,library-name�@�@@����*module_pbt��.<command-line>A@A�A@K@@��A@@�A@L@@@@�@@����������������/ppx_optcomp.env�@�@@�������#env��&_none_A@ �A@@���(flambda2����'Defined�����%false@@@@@���/flambda_backend��������%false@@@@@���-ocaml_version���&�������!4@.@@����"13@3@@����!1@8@@@8@@8@@���'os_type���5?����$UnixD@D@@D@@@D@@@�@@������@@@@@@@@@@@@@@@@@@@�����$Spec��4lib/test_harness.mliA@L�A@P@������A�    �#cmd��CW^�CWa@@@@A@���)ocaml.doc��@@ ��@@ �A�������6 The type of commands �� Dbd�!Db@@��#Dbd�$Db@@@@��&Dbd�'Db@@��)Dbd�*Db@@��,CWY�-CWa@@��/CWY�0CWa@���A�    �%state��9F A H�:F A M@@@@A@���+��H@@ ��I@@ �A�������? The type of the model's state ��JG N P�KG N t@@��MG N P�NG N t@@@@��PG N P�QG N t@@��SG N P�TG N t@@��VF A C�WF A M@@��YF A C�ZF A M@���A�    �#sut��cI v }�dI v �@@@@A@���U��r@@ ��s@@ �A�������	# The type of the system under test ��tJ � ��uJ � �@@��wJ � ��xJ � �@@@@��zJ � ��{J � �@@��}J � ��~J � �@@���I v x��I v �@@���I v x��I v �@���Р'gen_cmd���L � ���L � �@��@����%state���L � ���L � �@@���L � ���L � �@@@������/Base_quickcheck)Generator!t���L � ���L � �@�����#cmd���L � ���L � �@@���L � ���L � �@@@@���L � ���L � �@@@���L � ���L � �@@@@�������@@ ���@@ �A�������	] A command generator. Accepts a state parameter to enable state-dependent {!cmd} generation. ���M � ���M �J@@���M � ���M �J@@@@���M � ���M �J@@���M � ���M �J@@���L � ���L � �@���L � ���L � �@���Р*init_state���OLR��OL\@����%state���OL_��OLd@@���OL_��OLd@@@@���ݰ��@@ ���@@ �A�������< The model's initial state. ���Peg��Pe�@@���Peg� Pe�@@@@��Peg�Pe�@@��Peg�Pe�@@��OLN�	OLd@��OLN�OLd@���Р*next_state��R���R��@��@����#cmd��R���R��@@��!R���"R��@@@��@����%state��+R���,R��@@��.R���/R��@@@����%state��6R���7R��@@��9R���:R��@@@��<R���=R��@@@��?R���@R��@@@@���1��N@@ ��O@@ �A�������	� [next_state c s] expresses how interpreting the command [c] moves the
      model's internal state machine from the state [s] to the next state.
      Ideally a [next_state] function is pure. ��PS���QUJ{@@��SS���TUJ{@@@@��VS���WUJ{@@��YS���ZUJ{@@��\R���]R��@��_R���`R��@���Р(init_sut��hW}��iW}�@��@����$unit��rW}��sW}�@@��uW}��vW}�@@@����#sut��}W}��~W}�@@���W}���W}�@@@���W}���W}�@@@@���u���@@ ���@@ �A�������	# Initialize the system under test. ���X����X��@@���X����X��@@@@���X����X��@@���X����X��@@���W}��W}�@���W}��W}�@���Р'cleanup���Z����Z��@��@����#sut���Z����Z��@@���Z����Z��@@@����$unit���Z����Z��@@���Z����Z��@@@���Z����Z��@@@@�������@@ ���@@ �A�������	� Utility function to clean up the {!sut} after each test instance,
      e.g., for closing sockets, files, or resetting global parameters���[����\*r@@���[����\*r@@@@���[����\*r@@���[����\*r@@���Z����Z��@���Z����Z��@���Р'precond���^tz��^t�@��@����#cmd���^t���^t�@@���^t���^t�@@@��@����%state��^t��^t�@@��
^t��^t�@@@����$bool��^t��^t�@@��^t��^t�@@@��^t��^t�@@@��^t��^t�@@@@�����*@@ ��+@@ �A�������	� [precond c s] expresses preconditions for command [c] in terms of the model state [s].
      A [precond] function should be pure.
      [precond] is useful, e.g., to prevent the shrinker from breaking invariants when minimizing
      counterexamples. ��,_���-b��@@��/_���0b��@@@@��2_���3b��@@��5_���6b��@@��8^tv�9^t�@��;^tv�<^t�@���Р'run_cmd��Dd���Ed��@��@����#cmd��Nd���Od��@@��Qd���Rd��@@@��@����%state��[d���\d��@@��^d���_d��@@@��@����#sut��hd���id��@@��kd���ld��@@@����$bool��sd���td��@@��vd���wd��@@@��yd���zd��@@@��|d���}d��@@@��d����d��@@@@���q���@@ ���@@ �A�������
  i [run_cmd c s i] should interpret the command [c] over the system under test (typically side-effecting).
      [s] is in this case the model's state prior to command execution.
      The returned Boolean value should indicate whether the interpretation went well
      and in case [c] returns a value: whether the returned value agrees with the model's result. ���e����h�:@@���e����h�:@@@@���e����h�:@@���e����h�:@@���d����d��@���d����d��@@���BSS��i;>@@@���A@@��i;>@���A@@��i;>@������$Make���k@G��k@K@�����$Spec���k@M��k@Q@����$Spec���k@T��k@X@���k@T��k@X@@�������*ocaml.text���@@ ���@@ �A�������	M {3 The resulting test framework derived from a state machine specification} ���m`b��m`�@@���m`b��m`�@@@@���m`b��m`�@@���m`b��m`�@���m`b��m`�@���Р(gen_cmds���o����o��@��@�����$Spec%state���o����o��@@�� o���o��@@@��@����#int��
o���o��@@��o���o��@@@������/Base_quickcheck)Generator!t��o���o�@�����$list��"o���#o��@������$Spec#cmd��-o���.o��@@��0o���1o��@@@@��3o���4o��@@@@��6o���7o�@@@��9o���:o�@@@��<o���=o�@@@@���.��K@@ ��L@@ �A�������	n A fueled command list generator.
      Accepts a state parameter to enable state-dependent [cmd] generation. ��Mp�Nq1@@��Pp�Qq1@@@@��Sp�Tq1@@��Vp�Wq1@@��Yo���Zo�@��\o���]o�@���Р'cmds_ok��es���fs��@��@�����$Spec%state��qs���rs��@@��ts���us��@@@��@����$list��~s���s��@������$Spec#cmd���s����s��@@���s����s��@@@@���s����s��@@@����$bool���s����s��@@���s����s��@@@���s����s��@@@���s����s��@@@@�������@@ ���@@ �A�������	� A precondition checker (stops early, thanks to short-circuit Boolean evaluation).
        Accepts the initial state and the command sequence as parameters.  ���t����u^@@���t����u^@@@@���t����u^@@���t����u^@@���s����s��@���s����s��@���Р(arb_cmds���w`h��w`p@��@�����$Spec%state���w`s��w`}@@���w`s��w`}@@@������/Base_quickcheck)Generator!t���w`���w`�@�����$list���w`���w`�@������$Spec#cmd���w`���w`�@@���w`���w`�@@@@���w`���w`�@@@@��w`��w`�@@@��w`s�w`�@@@@������@@ ��@@ �A�������	K A generator of command sequences. Accepts the initial state as parameter. ��x���x��@@��x���x��@@@@��x���x��@@��x���x��@@��!w`d�"w`�@��$w`d�%w`�@���Р0consistency_test��-z			�.z		@���&trials����#int��9z		#�:z		&@@��<z		#�=z		&@@@����$unit��Dz		*�Ez		.@@��Gz		*�Hz		.@@@��Jz		�Kz		.@@@@���<��Y@@ ��Z@@ �A�������	� A consistency test that generates a number of [cmd] sequences and
        checks that all contained [cmd]s satisfy the precondition [precond].
        Accepts a labeled parameters [trials], which is the no. of trials ��[{	/	3�\}	�
@@��^{	/	3�_}	�
@@@@��a{	/	3�b}	�
@@��d{	/	3�e}	�
@@��gz		�hz		.@��jz		�kz		.@���Р,interp_agree��s

�t

(@��@�����$Spec%state��

+��

5@@���

+��

5@@@��@�����$Spec#sut���

9��

A@@���

9��

A@@@��@����$list���

N��

R@������$Spec#cmd���

E��

M@@���

E��

M@@@@���

E��

R@@@����$bool���

V��

Z@@���

V��

Z@@@���

E��

Z@@@���

9��

Z@@@���

+��

Z@@@@�������@@ ���@@ �A�������	� Checks agreement between the model and the system under test
        (stops early, thanks to short-circuit Boolean evaluation). ��� @
[
_�� A
�
�@@��� @
[
_�� A
�
�@@@@��� @
[
_�� A
�
�@@��� @
[
_�� A
�
�@@���

��

Z@���

��

Z@���Р*agree_prop��� C
�
��� C
�
�@��@����$list��� C
��� C
�	@������$Spec#cmd��� C
�
��� C
�@@�� C
�
�� C
�@@@@�� C
�
�� C
�	@@@����$bool�� C
�� C
�@@�� C
�� C
�@@@�� C
�
�� C
�@@@@�����!@@ ��"@@ �A�������	� The agreement property: the command sequence [cs] yields the same observations
      when interpreted from the model's initial state and the [sut]'s initial state.
      Cleans up after itself by calling [Spec.cleanup] ��# D�$ F��@@��& D�' F��@@@@��) D�* F��@@��, D�- F��@@��/ C
�
��0 C
�@��2 C
�
��3 C
�@���Р*agree_test��; H��< H�@���&trials����#int��G H��H H�@@��J H��K H�@@@����$unit��R H��S H�!@@��U H��V H�!@@@��X H��Y H�!@@@@@��[ H���\ H�!@��^ H���_ H�!@@��al\\�b I%(@@��dk@L�e I%(@@@��gk@@�h I%(@��jk@@�k I%(@@