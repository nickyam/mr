// Cloudflare Pages Functions middleware.
//
// Cloudflare Pages hard-codes a 308 redirect from /path.html -> /path
// (extensionless) and this cannot be disabled in the dashboard. That breaks the
// site's locked .html permalinks (old Hexo URLs). This middleware intercepts
// requests ending in .html, fetches the extensionless asset internally through
// the ASSETS binding, and returns it with a 200 at the original .html URL --
// so .html is served directly with zero redirect hops.
//
// If anything goes wrong it falls back to default Cloudflare routing (the old
// 308 behaviour), so the site can never be taken down by this file.

export async function onRequest(context) {
  const url = new URL(context.request.url);

  if (url.pathname.endsWith('.html')) {
    try {
      let path = url.pathname.slice(0, -5);
      if (path === '/index') path = '/'; // keep the root working
      url.pathname = path;
      const rewritten = new Request(url.toString(), context.request);
      return await context.env.ASSETS.fetch(rewritten);
    } catch (e) {
      return context.next();
    }
  }

  return context.next();
}
