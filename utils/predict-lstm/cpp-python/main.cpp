#include <Python.h>
#include "pyerrors.h"
#include <numpy/arrayobject.h>
#include <iostream>
#include <unistd.h>

int main(int argc, const char *argv[])
{
    wchar_t *programName = new wchar_t[strlen(argv[0])];
    if (!programName) {
        std::cerr << "Out of memory." << std::endl;
        return EXIT_FAILURE;
    }

    mbstowcs(programName, argv[0], strlen(argv[0]));
    Py_SetProgramName(programName);
    Py_Initialize();
    import_array();

    // Build the 2D array in C++
    const int SIZE = 10;
    npy_intp dims[2] = {SIZE, SIZE};
    const int ND = 2;
    long double (*cArr)[SIZE] = new long double[SIZE][SIZE];
    if (!cArr) {
        std::cerr << "Out of memory." << std::endl;
        return EXIT_FAILURE;
    }
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            cArr[i][j] = i * SIZE + j;
        }
    }

    // Convert it to a NumPy array.
    PyObject *pArray = PyArray_SimpleNewFromData(ND, dims, NPY_LONGDOUBLE, reinterpret_cast<void *>(cArr));
    if (!pArray) {
        return EXIT_FAILURE;
    }
    PyArrayObject *npArr = reinterpret_cast<PyArrayObject *>(pArray);

    std::string LSTMPath = "/home/resaglow/Dev/llvm-global/llvm-git/utils/predict-lstm/cpp-python";
    std::cout << LSTMPath << std::endl;
    PyObject* SysPath = PySys_GetObject((char *)"path");
    PyObject* PyLSTMPath = PyUnicode_FromString(LSTMPath.c_str());
    PyList_Append(SysPath, PyLSTMPath);
    Py_DECREF(PyLSTMPath);

    // import mymodule.testing_func
    const char *moduleName = "mymodule";
    PyObject *pName = PyUnicode_FromString(moduleName);
    if (!pName) {
        return EXIT_FAILURE;
    }
    PyObject *pModule = PyImport_Import(pName);
    Py_DECREF(pName);
    if (!pModule) {
        return EXIT_FAILURE;
    }

    const char *func_name = "testing_func";
    PyObject *pFunc = PyObject_GetAttrString(pModule, func_name);
    if (!pFunc) {
        return EXIT_FAILURE;
    }
    if (!PyCallable_Check(pFunc)) {
        std::cerr << moduleName << "." << func_name << " is not callable." << std::endl;
        return EXIT_FAILURE;
    }

    PyObject *pArgs = PyTuple_New(1);
    PyTuple_SetItem(pArgs, 0, reinterpret_cast<PyObject*>(npArr));

    // np_ret = mymodule.testing_func(np_arg)
    PyObject *pReturn = PyObject_CallFunctionObjArgs(pFunc, pArray, NULL);
    if (!pReturn) {
        return EXIT_FAILURE;
    }
    if (!PyArray_Check(pReturn)) {
        std::cerr << moduleName << "." << func_name << " did not return an array." << std::endl;
        return EXIT_FAILURE;
    }
    PyArrayObject *npRet = reinterpret_cast<PyArrayObject *>(pReturn);
    if (PyArray_NDIM(npRet) != ND - 1) {
        std::cerr << moduleName << "." << func_name << " returned array with wrong dimension." << std::endl;
        return EXIT_FAILURE;
    }

    // Convert back to C++ array and print.
    int len = PyArray_SHAPE(npRet)[0];
    long double *cOutArr = reinterpret_cast<long double *>(PyArray_DATA(npRet));
    std::cout << "Printing output array" << std::endl;
    for (int i = 0; i < len; i++) {
        std::cout << cOutArr[i] << ' ';
    }
    std::cout << std::endl;

    Py_XDECREF(pReturn);
    Py_XDECREF(pFunc);
    Py_XDECREF(pModule);
    Py_XDECREF(pArray);
    Py_XDECREF(pArgs);
    delete[] cArr;
    Py_Finalize();

    return EXIT_SUCCESS;
}
