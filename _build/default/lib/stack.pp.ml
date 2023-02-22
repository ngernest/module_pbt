Caml1999M030����            ,lib/stack.ml����  �  �  D  ������1ocaml.ppx.context��&_none_@@ �A����������)tool_name���*ppx_driver@@@����,include_dirs����"[]@@@����)load_path!����
%@%@@����,open_modules*����.@.@@����+for_package3����$None8@8@@����%debug=����%falseB@B@@����+use_threadsG����
K@K@@����-use_vmthreadsP����T@T@@����/recursive_typesY����]@]@@����)principalb����%f@f@@����3transparent_modulesk����.o@o@@����-unboxed_typest����7x@x@@����-unsafe_string}����@�@�@@����'cookies�����"::�����������,library-name�@�@@����*module_pbt��.<command-line>A@A�A@K@@��A@@�A@L@@@@�@@����������������/ppx_optcomp.env�@�@@�������#env��&_none_A@ �A@@���(flambda2����'Defined�����%false@@@@@���/flambda_backend��������%false@@@@@���-ocaml_version���&�������!4@.@@����"13@3@@����!1@8@@@8@@8@@���'os_type���5?����$UnixD@D@@D@@@D@@@�@@������@@@@@@@@@@@@@@@@@@@���@������"()��,lib/stack.mlA@@�A@@A@��A@@�A@@A@@�������8Ppx_module_timer_runtime,record_start��A@@�A@@A��A@@�A@@A@@��@�����*__MODULE__��A@@�A@@A��!A@@�"A@@A@@@��$A@@�%A@@A@@@��'A@@�(A@@A@��*A@@�+A@@A���@������"()��7A@@�8A@@A@��:A@@�;A@@A@@���������-Ppx_bench_lib5Benchmark_accumulator/Current_libname#set��JA@@�KA@@A��MA@@�NA@@A@@��@���Ȱ�UA@@�VA@@A@��XA@@�YA@@A@@@��[A@@�\A@@A@@@��^A@@�_A@@A@��aA@@�bA@@A���@������"()��nA@@�oA@@A@��qA@@�rA@@A@@��������5Expect_test_collector,Current_file#set��A@@��A@@A���A@@��A@@A@@���1absolute_filename�������A@@��A@@A@���A@@��A@@A@@@���A@@��A@@A@@@���A@@��A@@A@���A@@��A@@A���@������7���A@@��A@@A@���A@@��A@@A@@��������3Ppx_inline_test_lib'Runtime5set_lib_and_partition���A@@��A@@A���A@@��A@@A@@��@���3���A@@��A@@A@���A@@��A@@A@@��@��� ���A@@��A@@A@���A@@��A@@A@@@���A@@��A@@A@@@���A@@��A@@A@���A@@��A@@A��������$Core���A@F��A@J@���A@F��A@J@@@���A@@��A@J@@���A@@��A@J@�����%Stack���CLX��CL]@������A�    �!t��Ddn�Ddo@����!a��Ddk�Ddm@@@�BA@@@A@@��Ddf�Ddo@@��Ddf�Ddo@�����������)Invariant"S1��"Fq{�#Fq G@��%Fq{�&Fq G@@����!t��-Fq U�.Fq V@    ���2Fq U�3Fq V@����!a��:Fq R�;Fq T@@@�BA@@@A�����!t��DFq ]�EFq ^@���!a��KFq Z�LFq \@@@@��NFq Z�OFq ^@@@@��QFq M�RFq ^@@��TFq{�UFq ^@@��WFqs�XFq ^@@��ZFqs�[Fq ^@���Р(is_empty��cI � ��dI � �@��@����!t��mI � ��nI � �@���!a��tI � ��uI � �@@@@��wI � ��xI � �@@@����$bool��I � ���I � �@@���I � ���I � �@@@���I � ���I � �@@@@���)ocaml.doc���@@ ���@@ �A�������	= [is_empty t] returns true if the stack is empty, else false ���H ` b��H ` �@@���H ` b��H ` �@@@@���H ` b��H ` �@@���H ` b��H ` �@@���I � ���I � �@���I � ���I � �@���Р$push���L � ��L �@��@��!a���L ���L �	@@@��@����!t���L ���L �@���!a���L ���L �@@@@���L ���L �@@@����!t���L ���L �@���!a���L ���L �@@@@���L ���L �@@@���L ���L �@@@���L ���L �@@@@���^���@@ ���@@ �A�������	. [push t a] adds [a] to the top of stack [t]. ���K � ���K � �@@���K � ���K � �@@@@���K � ���K � �@@���K � ���K � �@@�� L � ��L �@��L � ��L �@���Р#top��P���P��@��@����!t��P���P��@���!a��P���P��@@@@�� P���!P��@@@����&option��(P���)P��@���!a��/P���0P��@@@@��2P���3P��@@@��5P���6P��@@@@������H@@ ��I@@ �A�������	w [top t] returns [Some a], where [a] is the top of [t], unless [is_empty t], in which
      case [top] returns [None]. ��FN�GOv�@@��IN�JOv�@@@@��LN�MOv�@@��ON�POv�@@��RP���SP��@��UP���VP��@���Р#pop��^T+1�_T+4@��@����!t��hT+:�iT+;@���!a��oT+7�pT+9@@@@��rT+7�sT+;@@@����&option��zT+D�{T+J@�����!t���T+B��T+C@���!a���T+?��T+A@@@@���T+?��T+C@@@@���T+?��T+J@@@���T+7��T+J@@@@������@@ ���@@ �A�������	j [pop t] removes and returns the top element of [t] as [Some a], or returns [None] if
      [t] is empty. ���R����S*@@���R����S*@@@@���R����S*@@���R����S*@@���T+-��T+J@���T+-��T+J@���Р&length���W~���W~�@��@����!t���W~���W~�@���!a���W~���W~�@@@@���W~���W~�@@@����#int���W~���W~�@@���W~���W~�@@@���W~���W~�@@@@���Y���@@ ���@@ �A�������	* [length t] returns the size of the stack ���VLN��VL}@@���VLN��VL}@@@@���VLN��VL}@@���VLN��VL}@@���W~���W~�@���W~���W~�@@��CL`�X��@@@��CLL�X��@��CLL�X��@���@���������X���X��A@��X���X��A@@��������on)unset_lib��"X���#X��A��%X���&X��A@@��@������-X���.X��A@��0X���1X��A@@@��3X���4X��A@@@��6X���7X��A@��9X���:X��A���@������ذ�EX���FX��A@��HX���IX��A@@����������%unset��TX���UX��A��WX���XX��A@@��@����"()��aX���bX��A@��dX���eX��A@@@��gX���hX��A@@@��jX���kX��A@��mX���nX��A���@������C��yX���zX��A@��|X���}X��A@@���������BA@%unset���X����X��A���X����X��A@@��@����_���X����X��A@���X����X��A@@@���X����X��A@@@���X����X��A@���X����X��A���@����������X����X��A@���X����X��A@@��������,record_until���X����X��A���X����X��A@@��@����������X����X��A���X����X��A@@@���X����X��A@@@���X����X��A@���X����X��A@