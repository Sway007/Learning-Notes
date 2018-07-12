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

// TODO: [link](https://learn.jquery.com/using-jquery-core/selecting-elements/)