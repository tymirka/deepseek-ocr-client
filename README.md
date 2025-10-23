# DeepSeek-OCR Client

A real-time Electron-based desktop GUI for [DeepSeek-OCR](https://github.com/deepseek-ai/DeepSeek-OCR)

**Unaffiliated with [DeepSeek](https://www.deepseek.com/)**

## Features

- **🌐 Web Access:** Use from any device on your local network (new!)
- Drag-and-drop image upload
- Real-time OCR processing

<img src="docs/images/document.gif" width="1000">

- Click regions to copy 
- Export results as ZIP with markdown images
- GPU acceleration (CUDA)

<img src="docs/images/document2.png" width="1000">

## Requirements

- Windows 10/11, other OS are experimental
- Node.js 18+ ([download](https://nodejs.org/))
- Python 3.12+ ([download](https://www.python.org/))
- NVIDIA GPU with CUDA

## Quick Start (Windows)

1. **Extract** the [ZIP file](https://github.com/ihatecsv/deepseek-ocr-client/archive/refs/heads/main.zip)
2. **Run** `start-client.bat`
   - First run will automatically install dependencies.
   - Subsequent runs will start quicker.
3. **Load Model** - Click the "Load Model" button in the app, this will download or load the model.
   - If this is the first run, this might take some time.
4. **Drop an image** or click the drop zone to select one.
5. **Run OCR** - Click "Run OCR" to process.

Note: if you have issues processing images but the model loads properly, please close and re-open the app and try with the default resolution for "base" and "size". This is a [known issue](https://github.com/ihatecsv/deepseek-ocr-client/issues/2), if you can help to fix it I would appreciate it!

## Web Access (Local Network)

**New Feature:** The Flask server now serves the entire client interface on your local network!

You can access the OCR client from any device on your network (phone, tablet, another computer) without installing the Electron app.

### How to use:

1. **Start the server** on your main machine:
   ```bash
   python start.py
   ```

2. **Find your server's IP address:**
   - Windows: `ipconfig`
   - Linux/macOS: `ip addr` or `ifconfig`

3. **Access from any device on your network:**
   ```
   http://[YOUR-SERVER-IP]:5000
   ```
   Example: `http://192.168.1.100:5000`

### Features:
- Full OCR functionality in the browser
- No Electron installation needed on client devices
- Drag-and-drop image upload works in the browser
- All processing happens on the server
- Perfect for using from mobile devices or remote machines

**Note:** The server runs on `0.0.0.0:5000` to accept connections from any device on your local network. Make sure your firewall allows incoming connections on port 5000.

## Linux/macOS

**Note:** Linux and macOS have not been tested yet. Use `start-client.sh` instead of `start-client.bat`.

**PRs welcome!** If you test on Linux/macOS and encounter issues, please open a pull request with fixes.

## Links

- [Model HuggingFace](https://huggingface.co/deepseek-ai/DeepSeek-OCR)
- [Model Blog Post](https://deepseek.ai/blog/deepseek-ocr-context-compression)
- [Model GitHub](https://github.com/deepseek-ai/DeepSeek-OCR)

## Future goals (PRs welcome!)

- [ ] Code cleanup needed (quickly put together)
- [ ] TypeScript
- [ ] Updater from GitHub releases
- [ ] PDF support
- [ ] Batch processing
- [ ] CPU support?
- [x] Web version (so you can run the server on a different machine) ✅ **Implemented!**
- [ ] Better progress bar algo
- [ ] ???

## License

MIT
