import { useEffect, useState } from "react";

function App() {
  const [jsApi, setJsApi] = useState(null);
  const [javaApi, setJavaApi] = useState(null);
  const [rustApi, setRustApi] = useState(null);

  useEffect(() => {
    fetch("http://javascript-api.local/health")
      .then((res) => res.json())
      .then(setJsApi)
      .catch(console.error);

    fetch("http://java-service.local/actuator/health")
      .then((res) => res.json())
      .then(setJavaApi)
      .catch(console.error);

    fetch("http://rust-processor.local/health")
      .then((res) => res.json())
      .then(setRustApi)
      .catch(console.error);
  }, []);

  return (
    <div style={{ padding: "2rem", fontFamily: "Arial" }}>
      <h1>Polyglot Microservices Dashboard</h1>

      <hr />

      <h2>JavaScript API</h2>
      <pre>{JSON.stringify(jsApi, null, 2)}</pre>

      <h2>Java Service</h2>
      <pre>{JSON.stringify(javaApi, null, 2)}</pre>

      <h2>Rust Processor</h2>
      <pre>{JSON.stringify(rustApi, null, 2)}</pre>

      {/* Added footer text */}
      <div style={{ marginTop: "2rem", fontStyle: "italic", textAlign: "center" }}>
        Managed by Effulgence Tech
      </div>
    </div>
  );
}

export default App;
