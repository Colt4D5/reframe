<script lang="ts">
	const { data } = $props();

  $inspect(data);
</script>

<h1>{data.data.message}</h1>
<p>Visit <a href="https://svelte.dev/docs/kit">svelte.dev/docs/kit</a> to read the documentation</p>
