Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177633;
	b=klwfXtciMj9pdhKAE1Jjs3cjLp0+nEv2iwqMUcrTxmzakueyZaRE5O+/KOoBKmPTBnYE
	 993W+yt+8/z+QrAmCFiufSfk+AKsroW9lUx9ign9tbzLLPrkDB1Xb38LmKv1yQHs1uaDT
	 dSUhg4477M9CfmOqqF+FjSywUpTxex34KOxTB/a3ZWNNDnb8NvgqnC/5i3IwItE0iUSES
	 fB83ZA56UijgaXodyUTFd3aPLNyYQK1n5BhSHko40ETJCOqkM7TszJjoboSWslDJ9TyfP
	 k3Owlq4Cmjf39uLihW8EX2IKpB1asprFcafOOBiCBIHHfty4+0rJpBcxIKUMaL65pew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177633;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=PgbpVfC2b4m1zF42iM6pw9d004VHioJhfQHO1IRaDGk=;
	b=eQNxekomcrmVHwK3ASFUXZfSdMVwJEf4qTPQLq5bzISUlEZWwuogfKjVZIbGjr0P058E
	 Ao1EZJQfSKaz2zOKED8u9Fli1VzrYFEJQDD1qmnOXeuDCDbGlzihD7Zfb5kBrciyykni/
	 dXIDV1nHTym0EQzsFMgACl8njh86ofm3KMH+SnkNOg/No2GFACdP5hC8GLKKXPjSsIAwh
	 KOxNLX0iDDzoI4dADtX2/HpIClE/u0D17eSuMLcrCTEwpkiBU939KpZIMQqhbCSIFZj4B
	 7VKBr5Op7Z+jwP87DlqJTjM/v7jR6UDKikWiWB2xrwiJEhyhozZnCVLPVp4g7lhxN+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CCdAZEX8;
	arc=none smtp.remote-ip=95.215.58.13
Received: from mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C33606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C33606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CCdAZEX8
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aN66IFFhjAtU9epXvHNsFOX6+rV4ZuUO+flQxejx8x8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795177630; v=1; x=1795782430;
 b=CCdAZEX8fkv2RfhR/lre3LTPN3a2hO2W+0ajQufbidybx8BSnlKi4l02GPoBfTeHx/V4srzQ
 q5LvhHFXC6DvXfCH/CGlTkiiHPdlZlWOaqRu0rUXv7H64jGUOrHrino2KNnxYWgy9dUAscsA3TI
 jRJGzXUp3ViTnA9tTGmzs/zM=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 7e2be00868a1975e;
	Fri, 20 Nov 2026 12:27:10 +0000
X-Mizu-Trace-ID: 7e2be00868a1975e
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 14:27:02 +0200
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
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: iio: Support ROHM BD79111
Message-ID: <578cd514c24a47ffd5cb3e02b78aeaf2fd3838bc.1795176984.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
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
	protocol="application/pgp-signature"; boundary="0nDIJTg58eDe1L2J"
Content-Disposition: inline
In-Reply-To: <cover.1795176984.git.mazziesaccount@gmail.com>

--0nDIJTg58eDe1L2J
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

---
Revision history:
v1 =3D> v2:
Disallow additional properties again
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


--0nDIJTg58eDe1L2J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmsAPJYACgkQeFA3/03a
ocUvJQgAufl9aYi0aafoLf5CsiJnobYLdS/usKFwnZpgG+z7/sjekm9pBds4m9F5
7JRZqOiNFafJk+ZcpCpfpUOf8LT8G2TvgL3qjbfDKWOubBZ16gdCdMxWEAZHNeK5
4Ltv3ruuwonK113TKJc8NHgnW7j1kqjTJb4v938z6PK53CO5Vl/pOIxwtFVE82Z8
wa+Cq2+X6WhznqxlwhlDGiiYutzd4lWRjiLsC16GiZv8OTC/PsRmAXA4+o9/dd7q
Mhu8PaBT6Gtp/kYcVfy8Gu22702XwVOQi/0kUIX1Msh38ZX7+50hqxqmjB7WFe19
d778okV8brvnKGwD7AFGzZVswCjFjA==
=mUQA
-----END PGP SIGNATURE-----

--0nDIJTg58eDe1L2J--
