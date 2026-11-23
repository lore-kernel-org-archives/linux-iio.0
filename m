Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421959;
	b=LB0xqvrxy49GXDD61eMWbeWXy3eKsnFp01ZMn7ncasXTBwNfvpgOlG/jxy0B+H5l/1Bc
	 PZ9ezvA1AcTf8UzKWAYq1/MWSRYmjIUgmKW2oxlZngBJKvMMLs0nofRRaVzT4B2Gi4NpE
	 lProtVEzO9GHtFzv6TqJx42Fk/N6fZihRzT7A0R8+V9z5sbvmRxnDGGJyqwYu5h0iIJ2v
	 w5BoK1j6LiuKdgfWKXlL0tx723hQt9cWEXGGb/VwBYK8kuPecCP10smN9CXyHJMkIJ4Yt
	 a8brUNdRudW46xkwaipSJIq+YL64XhNHgi6OaWLAr3YacemImiaERyg4JphNlY6j4NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421959;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=kMwNhIuC2YlcL171wo+XyDF8jZlForwDkSr7ngqU/QA=;
	b=JHvEvzXS5d+bX5nw1Gu1HwZPlYc2+i4TRDFCdr6TRVIVr0nYmCmrKCbhXRVAzhyRxt4R
	 /n+ecvM0wcEpDOM8GbPt11Neub+H+0stQJG2NI+50XgRAwe/f+oZHwcdjg7yesRfSpOQI
	 kBHxJCKLKnctiOWP7aVe6f/rDWlavgY6kywp2H5MsYMbynaMxOClBglAjvPqodsB4nPMp
	 gRjcW/dVWkYGyk2/e8xa5J8/LAL3Scna8eGIro9B36hREcahN9HsWHDzDGOLX6uPGZWRQ
	 1jEdoZdmu6MBDwf9u0ywDVnebvl1vIOGjSkhxMteYfAf+HA43Hdg+FjXHYJZzcBlpXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aDzL7KyF;
	arc=none smtp.remote-ip=91.218.175.91
Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59B606A31F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE59B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aDzL7KyF
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OfOwvOHvkBpohcgTPdiVb5bdoAeeSI8pBm+R/aMqz6c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795421957; v=1; x=1796026757;
 b=aDzL7KyFyq178jPq+6TrddHbQb3w0OaJCXawhLqEQH/AnvDK5ElJxDeDmfYzFA6MY/2oENMa
 7vwJ8LrZd5LOk3JsEvFBKEYW/c5LwWg+gTqmgWJ/AE6YpkLb3nP2gNTCIjDdZz5FD+FF8Wx1gJh
 yNEwavO/Z2bNCYNSowPgTnjA=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 794c4746cfecb259;
	Mon, 23 Nov 2026 08:19:16 +0000
X-Mizu-Trace-ID: 794c4746cfecb259
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 10:19:08 +0200
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: Support ROHM BD79111
Message-ID: <6e76f5f0cc28d7e981a037e703435e1688409aa6.1795421473.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1795421473.git.mazziesaccount@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tgEaR3Vp78LrHKNc"
Content-Disposition: inline
In-Reply-To: <cover.1795421473.git.mazziesaccount@gmail.com>

--tgEaR3Vp78LrHKNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
where pins can be configured to be either used as GPIO or ADC inputs.
ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
sources.

The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
clock.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
Revision history:
v2 =3D>
 - No changes
---
 .../bindings/iio/adc/rohm,bd79112.yaml        | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
index aa8b07c3fac1..a0fd87716611 100644
--- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
@@ -4,18 +4,21 @@
 $id: http://devicetree.org/schemas/iio/adc/rohm,bd79112.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM BD79112 ADC/GPO
+title: ROHM BD79111 and BD79112 ADC/GPIO
=20
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
-  The ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. ADC input pins can be
-  also configured as general purpose inputs/outputs. SPI should use MODE 3.
+  The ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. The ROHM BD79111 is
+  a 12-bit, 16-channel, SAR ADC. ADC input pins can be also configured as
+  general purpose inputs/outputs. SPI should use MODE 3.
=20
 properties:
   compatible:
-    const: rohm,bd79112
+    enum:
+      - rohm,bd79111
+      - rohm,bd79112
=20
   reg:
     maxItems: 1
@@ -45,7 +48,9 @@ patternProperties:
=20
     properties:
       reg:
-        description: AIN pin number
+        description:
+          AIN pin number. The BD79111 has pins 0 - 15, the BD79112 has pins
+          0 - 31.
         minimum: 0
         maximum: 31
=20
@@ -64,6 +69,20 @@ required:
=20
 additionalProperties: false
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rohm,bd79111
+    then:
+      patternProperties:
+        "^channel@([0-9]|1[0-5])$":
+          properties:
+            reg:
+              maximum: 15
+        "^channel@(1[6-9]|2[0-9]|3[01])$": false
+
 examples:
   - |
     spi {
--=20
2.56.1


--tgEaR3Vp78LrHKNc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmsD9vwACgkQeFA3/03a
ocXBiggApdlslXHrBZkMCl6AvScV1KsvDURL6o6YTiCGNyBw1YMYckBRx9ga9lLP
bTYuuXkeGcgwnZYO6z97HZi4wrF5L2TNjdaT/8mPvS55vphD3ph5onV1uxzPDkk5
CPdwL9MSqHG25CipDbL3fYLIht2nxfENQSUirZdFDXtY4WD+KbllGkQ3AEcW7yPH
YMxeolxNM/t4SYk575x1Dt1trBFlKDEOC6V7MDl9nrPRLd0gpeFkQBpo1erktpaq
UP96Wd2//EMwlatShhmZSIe6cKgFJu0iB+o9E3xQgk8mO/15d0Gs0EXxsHNvfKex
/SgGYK/GpyDkhM2PS/htQxshPswfBw==
=o0Cq
-----END PGP SIGNATURE-----

--tgEaR3Vp78LrHKNc--
