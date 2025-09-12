## CloudFront

CloudFront is AWS's CDN (Content Delivery Network) service.

A CDN is a network that helps deliver content to end users quickly by routing their requests to the nearest server containing the requested resources.

**Without a CDN:**  
Resources are delivered directly from the server to the client. Depending on the geographical distance, access speed may vary.

**With a CDN:**  
Resources are cached on Edge servers. User requests to CloudFront are redirected to the nearest Edge server.

---

## Basic Concepts of CloudFront

- **Distribution:** CloudFront distributes content from the origin to edge locations through a distribution. A distribution defines how CloudFront delivers content, including the origin address, edge locations, security, and caching settings.
- **Edge Location:** CloudFront uses a global network of edge locations (servers around the world) to deliver content to users from the closest location.
- **Origin:** The original source of your content (origin content), such as files, web applications, APIs, or databases. The origin can be a web server, S3 bucket, or other AWS services.
- **Cache:** CloudFront stores resources at edge locations to reduce response time and speed up website loading. Cached resources include images, CSS, JavaScript files, etc.
- **Logging and Reporting:** CloudFront provides reports on distribution activity, including traffic and access counts.
- **Security:** CloudFront supports various security features, including HTTPS, digital certificates, and user authentication.
- **Customize at the Edge:** With Lambda@Edge, you can run functions on CloudFront events at edge locations for speed and efficiency. Use cases include authentication/authorization, simple computation, SEO, intelligent routing, anti-bot, real-time image transformation, A/B testing, and user prioritization.

---

## How CloudFront Delivers Content

[CloudFront Documentation](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

1. User accesses a website and requests a resource (e.g., HTML file, image, CSS).
2. DNS routes the user's request to the nearest CloudFront edge location (based on latency).
3. a) CloudFront forwards the request to the origin server (HTTP server or S3 bucket).
   b) The origin server returns the response to the edge location.
   c) As soon as the edge location receives the first byte, it forwards the object to the end-user and caches the content for future requests.
   _From the second request onward, the edge location serves the cached object without calling the origin server, improving access speed._

---

## Use Cases

CloudFront is used for:

- Accelerating websites (images, CSS, documents, videos, etc.)
- On-demand video & video streaming
- Field-level encryption: CloudFront automatically encrypts data sent from users; only the backend application with the key can decrypt it.
- Customize at the edge: Return error codes during server maintenance or authorize users before forwarding requests to the backend (using Lambda@Edge).

---

## Pricing

CloudFront charges for:

- No up-front fee; pay only for what you use.
- Actual data transferred out to the internet.
- CloudFront Functions, Lambda@Edge.
- Invalidation requests (cache clearing).
- Real-time logs.
- Field-level encryption.

---

## Sample

A static website (HTML/CSS/JS only) can be deployed to S3 and served via CloudFront.  
Most modern frameworks (Angular, Vue, Node.js, etc.) support building static websites for S3 deployment.

![cdn](/img/cdn_hosting_static.png)

Media is distributed to end users via CloudFront for a better experience, as content is redirected to the edge location closest to the user.

![cdn](/img/cdn_server_media.png)

---

## CloudFront Behavior

A CloudFront distribution can have more than one origin server behind it.  
For example, a system with an S3 bucket hosting a static website and a backend server (ALB + Container) can use a single CloudFront distribution.

To distinguish which requests go to which origin, you define behaviors.  
Behaviors allow you to specify which requests (by pattern) are forwarded to which origin.

![cdn](/img/cdn_behavior.png)

By configuring different behaviors, CloudFront routes user requests to the correct origin.  
_Note: The order of behaviors matters; once a path matches, subsequent paths are not evaluated._

---

## Cache Policy

A CloudFront cache policy defines how CloudFront caches and serves content to users.  
Cache policies can be set per distribution or per behavior.  
Rules include cache duration, compression, forwarding cookies & query strings, etc.

Applying different caching policies for each distribution or behavior allows fine-tuning of caching control for each URL or request pattern.  
This optimizes caching for different content types, e.g., static assets (images, CSS, JS, video) or dynamic API responses.

---

## Origin Request Policy

A CloudFront origin request policy defines how CloudFront handles requests to the origin.  
When a user requests content, CloudFront forwards the request to origins like S3, EC2, or ALB.  
Origin request policies allow you to add/modify/remove headers or query strings to optimize caching and performance.  
You can also configure CloudFront to sign or encrypt requests to protect the backend from unauthorized access.

Origin request policies are useful for complex backend architectures
