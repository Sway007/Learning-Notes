## Vue Instance

- `data`
    add all property in `data` object to Vue's reactivity system

### Directives

> special attributes with the `v-` prefix

- `v=bind` and `v-on` shorthand
```html
<!-- full syntax -->
<a v-bind:href="url"> ... </a>

<!-- shorthand -->
<a :href="url"> ... </a>

<!-- full syntax -->
<a v-on:click="doSomething"> ... </a>

<!-- shorthand -->
<a @click="doSomething"> ... </a>
```

- Computed Caching vs Methods

> the difference is that computed properties are cached based on their dependencies. A computed property will only re-evaluate when some of its dependencies have changed. This means as long as message has not changed, multiple access to the reversedMessage computed property will immediately return the previously computed result without having to run the function again.