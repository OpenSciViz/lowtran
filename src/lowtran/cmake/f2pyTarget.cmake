include(${CMAKE_CURRENT_LIST_DIR}/f2py.cmake)

function(f2py_target module_name module_src out_dir)

set(out ${CMAKE_CURRENT_BINARY_DIR}/${module_name}${f2py_suffix})

set(f2py_arg --quiet -m ${module_name} -c ${module_src})
if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  list(APPEND f2py_arg --compiler=mingw32)
endif()

add_custom_command(
  OUTPUT ${out}
  COMMAND ${f2py} ${f2py_arg}
  )

add_custom_target(${module_name} ALL DEPENDS ${out})

add_custom_command(
  TARGET ${module_name} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy ${out} ${out_dir}/
  )

endfunction(f2py_target)
