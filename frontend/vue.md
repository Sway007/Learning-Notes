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


```html
<!-- Even though `42` is static, we need v-bind to tell Vue that -->
<!-- this is a JavaScript expression rather than a string.       -->
<blog-post v-bind:likes="42"></blog-post>

<!-- Including the prop with no value will imply `true`. -->
<blog-post is-published></blog-post>

<!-- Even though `false` is static, we need v-bind to tell Vue that -->
<!-- this is a JavaScript expression rather than a string.          -->
<blog-post v-bind:is-published="false"></blog-post>

<!-- Even though the array is static, we need v-bind to tell Vue that -->
<!-- this is a JavaScript expression rather than a string.            -->
<blog-post v-bind:comment-ids="[234, 266, 273]"></blog-post>

<!-- Even though the object is static, we need v-bind to tell Vue that -->
<!-- this is a JavaScript expression rather than a string.             -->
<blog-post
  v-bind:author="{
    name: 'Veronica',
    company: 'Veridian Dynamics'
  }"
></blog-post>
```

- [Passing the Properties of an Object](https://vuejs.org/v2/guide/components-props.html#Passing-the-Properties-of-an-Object)

- Prop Validation
    ```js
    Vue.component('my-component', {
    props: {
        // Basic type check (`null` matches any type)
        propA: Number,
        // Multiple possible types
        propB: [String, Number],
        // Required string
        propC: {
        type: String,
        required: true
        },
        // Number with a default value
        propD: {
        type: Number,
        default: 100
        },
        // Object with a default value
        propE: {
        type: Object,
        // Object or array defaults must be returned from
        // a factory function
        default: function () {
            return { message: 'hello' }
        }
        },
        // Custom validator function
        propF: {
        validator: function (value) {
            // The value must match one of these strings
            return ['success', 'warning', 'danger'].indexOf(value) !== -1
        }
        }
    }
    })
    ```

- `v-model` 双向绑定

    > By default, v-model on a component uses value as the prop and input as the event, but some input types such as checkboxes and radio buttons may want to use the value attribute for a different purpose. Using the model option can avoid a conflict in such cases:
    ```js
    Vue.component('base-checkbox', {
    model: {
        prop: 'checked',
        event: 'change'
    },
    props: {
        checked: Boolean
    },
    template: `
        <input
        type="checkbox"
        v-bind:checked="checked"
        v-on:change="$emit('change', $event.target.checked)"
        >
    `
    })
    ```

- `sync` 单向绑定

    ```js
    this.$emit('update:title', newTitle)
    ```
    ```html
    <text-document
    v-bind:title="doc.title"
    v-on:update:title="doc.title = $event"
    ></text-document>
    ```
    equivalent to
    ```html
    <text-document v-bind:title.sync="doc.title"></text-document>
    ```

# todo: [Scoped Slots](https://vuejs.org/v2/guide/components-props.html#One-Way-Data-Flow)


----------------------

# Vue-cli

## 常用命令

- `vue init <template-name> <project-name>`

  veu-cli官方5个模板
  - webpack
  - webpack-simple
  - browserify
  - browserify-simple
  - simple 

