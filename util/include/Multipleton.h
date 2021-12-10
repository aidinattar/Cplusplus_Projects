#ifndef Multipleton_H
#define Multipleton_H

#include <vector>

template <class T>
class Multipleton {

 public:

  // get the object instance
  static T* instance( unsigned int i );
  static bool verbose;

 protected:

  // the object can be created only through a derived object
  // created in its turn by the "instance()" function
  Multipleton();
  ~Multipleton();

  virtual void setId( unsigned int i );

  // retrieve the instance number
  unsigned int id() const;

 private:

  unsigned int instId;

};

#include "Multipleton.hpp"

#endif

