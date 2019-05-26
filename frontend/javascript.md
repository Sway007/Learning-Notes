## Object Creation

- Factory Pattern
  
   (didn’t address the issue of object identification)

- Constructor Pattern

    constructors are simply functions that create objects.  
    To create a new instance using constructor, use the `new` operator:
    1. Create a new object
    2. Assign the this value of the constructor to the new object (so this points to the new object).
    3. Execute the code inside the constructor (adds properties to the new object).
    4. Return the new object.

    > Any function that is called with the new operator acts as a constructor, whereas any function called without it acts just as you would expect a normal function call to act.

    **Problems with Constructors**

    - methods are created once for each instance

- Prototype Pattern

    Each function is created with a prototype property, which is an object containing properties and methods that should be available to instances of a particular reference type.

    property lookup:  
    
    - first on instance itself.
    - then on the prototype object.

    > Although it’s possible to read values on the prototype from object instances, it is not possible to overwrite them. If you add a property to an instance that has the same name as a property on the prototype, you create the property on the instance, which then masks the property on the prototype.

- Combination Constructor/Prototype Pattern

    > The constructor pattern defines instance properties, whereas the prototype pattern defines methods and shared properties.

## Inheritance

- Prototype Chaining
  
  cannot pass arguments into the supertype constructor when the subtype instance is being created.

- Constructor Stealing
  ```js
    function SubType(){
        //inherit from SuperType
        SuperType.call(this);
    }
  ``` 
