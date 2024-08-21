if(NOT EXISTS "D:/Projects/iio-oscilloscope-main/cmake-build-debug/install_manifest.txt")
	message(FATAL_ERROR "Cannot find install manifest: D:/Projects/iio-oscilloscope-main/cmake-build-debug/install_manifest.txt")
endif()

file(READ "D:/Projects/iio-oscilloscope-main/cmake-build-debug/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")
foreach(file ${files})
	message(STATUS "Uninstalling $ENV{DESTDIR}${file}")
	if(IS_SYMLINK "$ENV{DESTDIR}${file}" OR EXISTS "$ENV{DESTDIR}${file}")
		if(${CMAKE_VERSION} VERSION_LESS "3.17")
			exec_program(
				"${CMAKE_COMMAND}" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
				OUTPUT_VARIABLE rm_out
				RETURN_VALUE rm_retval
				)
		else()
			exec_program(
				"${CMAKE_COMMAND}" ARGS "-E rm -r \"$ENV{DESTDIR}${file}\""
				OUTPUT_VARIABLE rm_out
				RETURN_VALUE rm_retval
				)
		endif()
		if(NOT "${rm_retval}" STREQUAL 0)
			message(FATAL_ERROR "Problem when removing $ENV{DESTDIR}${file}")
		endif()
	else(IS_SYMLINK "$ENV{DESTDIR}${file}" OR EXISTS "$ENV{DESTDIR}${file}")
		message(STATUS "File $ENV{DESTDIR}${file} does not exist.")
	endif()
endforeach()

set(OSC_LIB_DIR $ENV{DESTDIR}C:/Program Files (x86)/iio-oscilloscope/lib/osc)
set(OSC_SHARE_DIR $ENV{DESTDIR}C:/Program Files (x86)/iio-oscilloscope/share/osc)

file (REMOVE_RECURSE ${OSC_LIB_DIR})
file (REMOVE_RECURSE ${OSC_SHARE_DIR})
