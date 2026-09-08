import subprocess
import os

cwd = os.path.dirname(os.path.abspath(__file__))
java_home = os.environ.get("JAVA_HOME", r"C:\Program Files\Android\Android Studio\jbr")
os.environ["JAVA_HOME"] = java_home

print("Running flutter build...")
result = subprocess.run(
    ["flutter.bat", "build", "apk", "--release"],
    capture_output=True,
    text=True,
    cwd=cwd
)

with open(os.path.join(cwd, "build_err.txt"), "w", encoding="utf-8") as f:
    f.write(result.stdout)
    f.write("\n\nSTDERR:\n")
    f.write(result.stderr)

print("Build complete. Output written to build_err.txt")
