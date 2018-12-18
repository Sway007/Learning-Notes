
- `$` or `jQuery`
    > The jQuery library exposes its methods and properties via two properties of the window object called jQuery and $. $ is simply an alias for jQuery and it's often employed because it's shorter and faster to write.

- Methods in the $ namespace are generally utility-type methods, and do not work with selections; they are not automatically passed any arguments, and their return value will vary.
- A page can't be manipulated safely until the document is "ready."
- Code included inside `$( document ).ready()` will only run once the page Document Object Model (DOM) is ready for JavaScript code to execute. 
- Code included inside `$( window ).on( "load", function() { ... })` will run once the entire page (images or iframes), not just the DOM, is ready.
- `$()` is shorhand for `$( document ).ready()`
- Putting jQuery Into No-Conflict Mode

    ```javascript
    var $j = jQuery.noConflict();
    // $j is now an alias to the jQuery function; creating the new alias is optional.
    ```
- The `.attr()` method
    - `.attr()` as a setter:

        ```js
        $( "a" ).attr( "href", "allMyHrefsAreTheSameNow.html" );
        $( "a" ).attr({
            title: "all titles are the same too!",
            href: "somethingNew.html"
        });
        ```

    - `.attr()` as a getter:
        ```js
        $( "a" ).attr( "href" ); // Returns the href for the first a element in the document
        ``` 

- A selection only fetches the elements that are on the page at the time the selection is made.
- Refining & Filtering Selctions
  
   ```js
    // Refining selections.
    $( "div.foo" ).has( "p" );         // div.foo elements that contain <p> tags
    $( "h1" ).not( ".bar" );           // h1 elements that don't have a class of bar
    $( "ul li" ).filter( ".current" ); // unordered list items with class of current
    $( "ul li" ).first();              // just the first unordered list item
    $( "ul li" ).eq( 5 );              // the sixth
   ```

## Working with Selections

- Setters affect all elements in a selection, whereas getters return the requested value only for the first element in the selection, with the exception of .text(), which retrieves the values of all the elements.
- Creating new elements

```js
// Creating new elements from an HTML string.
$( "<p>This is a new paragraph</p>" );
$( "<li class=\"new\">new list item</li>" );

// Creating a new element with an attribute object.
$( "<a/>", {
    html: "This is a <strong>new</strong> link",
    "class": "new",
    href: "foo.html"
});

```

# Events

- Every event handling function receives an event object
    - `pageX`, `pageY`
    - `type`
    - `which`
    - `data`
    - `target`
    - `timeStamp`
    - 