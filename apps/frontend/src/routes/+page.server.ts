// create a server-side load function for the page
export const load = async ({ fetch }) => {
	// example fetch request to the backend API
	const res = await fetch('http://localhost:8080/api/v1/news');
	const data = await res.json();

	return {
    data
	};
};