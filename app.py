from flask import Flask, render_template, request, send_file
import qrcode
from io import BytesIO
import base64
import os

app = Flask(__name__)

#http://127.0.0.1:5000/api/qr?url=demourl.com
@app.route('/api/qr', methods=['GET'])
def generate_qr_api():
    url = request.args.get('url')
    if not url:
        return "Error: No URL provided. Please specify a URL parameter.", 400

    qr_img = qrcode.make(url)
    bytes_io = BytesIO()
    qr_img.save(bytes_io, 'PNG')
    bytes_io.seek(0)
    return send_file(bytes_io, mimetype='image/png')


@app.route('/', methods=['GET', 'POST'])
def home():
    qr_data = ""
    if request.method == 'POST':
        url = request.form['url']
        if url:
            qr_img = qrcode.make(url)
            bytes_io = BytesIO()
            qr_img.save(bytes_io, format='PNG')
            qr_data = base64.b64encode(bytes_io.getvalue()).decode()

    return render_template('index.html', qr_data=qr_data)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
