import { useEffect, useState } from "react";

function ServiceCard({ title, technology, data }) {
const healthy =
data &&
((data.status === "healthy") ||
(data.status === "UP"));

return (
<div
style={{
background: "#fff",
padding: "20px",
borderRadius: "12px",
boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
minWidth: "280px",
}}
> <h3>{title}</h3>

```
  <p>
    <strong>Technology:</strong> {technology}
  </p>

  <p>
    <strong>Status:</strong>{" "}
    <span
      style={{
        color: healthy ? "green" : "red",
        fontWeight: "bold",
      }}
    >
      {healthy ? "🟢 Healthy" : "🔴 Unhealthy"}
    </span>
  </p>

  <pre
    style={{
      background: "#f5f5f5",
      padding: "10px",
      borderRadius: "8px",
      overflow: "auto",
    }}
  >
    {JSON.stringify(data, null, 2)}
  </pre>
</div>


);
}

function App() {
const [jsApi, setJsApi] = useState(null);
const [javaApi, setJavaApi] = useState(null);
const [rustApi, setRustApi] = useState(null);

useEffect(() => {
fetch("/api/js/health")
.then((r) => r.json())
.then(setJsApi)
.catch(console.error);

```
fetch("/api/java/actuator/health")
  .then((r) => r.json())
  .then(setJavaApi)
  .catch(console.error);

fetch("/api/rust/health")
  .then((r) => r.json())
  .then(setRustApi)
  .catch(console.error);
```

}, []);

const healthyCount =
[jsApi, javaApi, rustApi].filter(Boolean).length;

return (
<div
style={{
background: "#f4f6f8",
minHeight: "100vh",
padding: "30px",
fontFamily: "Segoe UI, sans-serif",
}}
> <h1>🚀 Polyglot Enterprise Platform</h1>

```
  <p>
    React + Node.js + Java + Rust
  </p>

  <>
    <p>
      Kubernetes • ArgoCD • Helm • GitOps
    </p>

    <hr />

    <div
      style={{
        display: "flex",
        gap: "20px",
        flexWrap: "wrap",
        marginTop: "20px",
        marginBottom: "30px",
      }}
    >
      <div
        style={{
          background: "white",
          padding: "20px",
          borderRadius: "12px",
          boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
        }}
      >
        <h3>Platform Summary</h3>
        <p>Total Services: 3</p>
        <p>Healthy Services: {healthyCount}</p>
        <p>Environment: Development</p>
        <p>Namespace: polyglot-dev</p>
      </div>

      <div
        style={{
          background: "white",
          padding: "20px",
          borderRadius: "12px",
          boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
        }}
      >
        <h3>Infrastructure</h3>
        <p>Ingress: NGINX</p>
        <p>GitOps: ArgoCD</p>
        <p>Container Runtime: containerd</p>
        <p>Cluster: kind</p>
      </div>
    </div>

    <h2>Service Health</h2>

    <div
      style={{
        display: "flex",
        gap: "20px",
        flexWrap: "wrap",
      }}
    >
      <ServiceCard
        title="JavaScript API"
        technology="Node.js Express"
        data={jsApi}
      />

      <ServiceCard
        title="Java Service"
        technology="Spring Boot"
        data={javaApi}
      />

      <ServiceCard
        title="Rust Processor"
        technology="Rust Actix"
        data={rustApi}
      />
    </div>

    <div
      style={{
        marginTop: "40px",
        background: "white",
        padding: "20px",
        borderRadius: "12px",
        boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
      }}
    >
      <h2>Architecture</h2>

      <pre>
{`                React Dashboard
                        │
                        ▼
                 NGINX Ingress
                        │
             ┌──────────┼──────────┐
             ▼          ▼          ▼
      JavaScript     Java      Rust
          API      Service   Processor`}
      </pre>
    </div>
  </>

```
  <div
    style={{
      textAlign: "center",
      marginTop: "40px",
      color: "#666",
    }}
  >
    Managed by Effulgence Tech
  </div>
</div>


);
}

export default App;
