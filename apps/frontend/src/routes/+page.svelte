<script lang="ts">
	const { data } = $props();

	type Article = {
		article_id?: string;
		title?: string;
		link?: string;
		description?: string;
	};

	const articles: Article[] = $derived(
		Array.isArray(data?.data?.results) ? data.data.results : []
	);
</script>

<h1>Latest News</h1>

{#if articles.length === 0}
	<p>No articles available.</p>
{:else}
	<ul>
		{#each articles as article (article.article_id ?? article.link ?? article.title)}
			<li>
				<a href={article.link ?? '#'} target="_blank" rel="noreferrer">
					{article.title ?? 'Untitled article'}
				</a>
			</li>
		{/each}
	</ul>
{/if}
