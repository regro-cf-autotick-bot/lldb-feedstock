@echo on

mkdir build
cd build

echo %PATH%

set "PREFIX_CYG=%PREFIX:\=/%"

cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE="Release" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    -DCLANG_INCLUDE_TESTS=OFF ^
    -DCLANG_INCLUDE_DOCS=OFF ^
    -DLLVM_INCLUDE_TESTS=OFF ^
    -DLLVM_INCLUDE_DOCS=OFF ^
    -DLLVM_TARGETS_TO_BUILD=X86 ^
    -DLLDB_ENABLE_PYTHON=ON ^
    -DLLDB_ENABLE_SWIG=ON ^
    -DLLDB_PYTHON_RELATIVE_PATH:PATH="..\Lib\site-packages" ^
    -DLLDB_EMBED_PYTHON_HOME=OFF ^
    -DPython3_LIBRARIES:FILEPATH="%PREFIX%\libs\python3.lib" ^
    -DPython3_INCLUDE_DIRS:PATH=%PREFIX_CYG%/include ^
    -DPython3_EXECUTABLE:FILEPATH=%PREFIX_CYG%/python.exe ^
    -DSWIG_EXECUTABLE=%LIBRARY_BIN%/swig.exe ^
    %SRC_DIR%\lldb
if %ERRORLEVEL% neq 0 exit 1

ninja -j%CPU_COUNT% --verbose
if %ERRORLEVEL% neq 0 exit 1

ninja install
if %ERRORLEVEL% neq 0 exit 1
