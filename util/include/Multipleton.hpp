// included by "Multipleton.h"
#include <iostream>

template <class T>
bool Multipleton<T>::verbose = false;

template <class T>
Multipleton<T>::Multipleton() {
  if ( verbose ) std::cout << "create Multipleton " << this << std::endl; 
}

template <class T>
Multipleton<T>::~Multipleton() {
  if ( verbose ) std::cout << "delete Multipleton " << this << std::endl; 
}

template <class T>
T* Multipleton<T>::instance( unsigned int i ) {
  if ( verbose ) std::cout << "Multipleton::instance " << std::endl; 
  // the object list is created only once,
  // the first time "instance( i )" is called
  static std::vector<T*> objList;
  // create new object if necessary
  if ( i >= objList.size() ) objList.resize( i + 1, 0 );
  T*& objPtr = objList[i];
  if ( objPtr == 0 ) {
    objPtr = new T;
    objPtr->setId( objPtr->instId = i );
  }
  return objPtr;
}

template <class T>
void Multipleton<T>::setId( unsigned int i ) {
  return;
}

template <class T>
unsigned int Multipleton<T>::id() const {
  return instId;
}

