Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011568;
	b=SwWr0ha6H8k6efcrFUTYVEHkeXiOW8nFReKNGTQ3KMSuKk+s70Lv9AcRkA0X15LdBZeC
	 /VbI1FFyIqgNbrBF5otUnzeQ9jtHx6L42QxX79Uo8oU9JgLViaevToLzFRvbNpQhO2n/w
	 rGPNixzicg/caPTxxY/aaClk7D9WYheE2iYodrQEiWHMgwGpX3W0vMBUcpbByp6To/0RA
	 AaTavDbCACOpy2LVL3U5GZYNCj+Uz2IJBpdREzROpScuworRw3Q9UrrpUEpR3iWv67OwO
	 vAigRn1qk03aqxEWgBTvFRQXbh5yadPVVX47mqFQeqn2Q64AYWclyohvLmb8eCgxKlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011568;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Ghqi8if3Bs1YW0S7JoLfzeRAWiWoPJXcZKJAFnFQ6PM=;
	b=lesWZOo+3gGnCWr2RAPhXKfLX1I3FgcmJTu2vw8jW2QCkn4gr0AuJBgZsSuXQfSbp3gl
	 ffhRWrQXcub9qYiG2xfKc+VpWLCZmD3IG8tOC0/odUl9aS3MAQz8JvXqax01rn2EIqq2S
	 DBprlTS09YkRCfLQ7bCJNNW/1jAgtSF/6jXAzR4DyaGWw0ujjcJcrtuksh/9v0TPHibjf
	 FMh4ayysetzWMTufA/Md8YSvYqOYs/iSbzmYqg/JfQH7HBClNFgAUEjKC0YXVt8yiAwMC
	 /+fFRyQY5tD7g4HfMBbNEmgYOB262WYJN1QFbva++iCsWeDjm+KboBZuulcsIe/lkxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pIZK346X;
	arc=none smtp.remote-ip=91.218.175.159
Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC660A2613
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 14:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBC660A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pIZK346X
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9KmHjtdnXwXJ1w3kCzrUC66exrS1n7IIqBjE+hCq/yE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795011557; v=1; x=1795616357;
 b=pIZK346XxOkXizfuJqsQPLb5LyslAxxVomOAP2Hs5ITu+ybEVumrQtMdKTCGiBBcBnF3WRsO
 QVC9neDuMMlXZ0jxIO/PCCHylSGkx8RZr9JY9Tk/BGpI7nLWAQI49jepXyKMQ4a33N0IYuiFKnL
 RoyEyaFlefbBio1bcqXyuTYs=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0787a3dd2c003c2f;
	Wed, 18 Nov 2026 14:19:17 +0000
X-Mizu-Trace-ID: 0787a3dd2c003c2f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 16:19:11 +0200
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
Subject: [PATCH 1/2] dt-bindings: iio: Support ROHM BD79111
Message-ID: <f69b996cc07fad1712871fb8b0436c71abd435b9.1795009599.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1795009599.git.mazziesaccount@gmail.com>
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
	protocol="application/pgp-signature"; boundary="KnfmTtM03YGVjooE"
Content-Disposition: inline
In-Reply-To: <cover.1795009599.git.mazziesaccount@gmail.com>

--KnfmTtM03YGVjooE
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

Note, I had to change the 'root-level' additionalProperties: false to
unevaluatedProperties: false in order to allow the properties in the new
allOf:
  - if:
     ...

section. It seems to me this is what a few other bindings in IIO do, but
I suppose it makes this "less strict". Well, since I am terrible with
writing bindings, I'd better point this out and ask if it's ok, or if
there are better way(s) to handle this?
---
 .../bindings/iio/adc/rohm,bd79112.yaml        | 72 +++++++++++++------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
index aa8b07c3fac1..4f105124ee6f 100644
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
@@ -37,23 +40,6 @@ properties:
   "#size-cells":
     const: 0
=20
-patternProperties:
-  "^channel@([0-9]|[12][0-9]|3[01])$":
-    type: object
-    $ref: /schemas/iio/adc/adc.yaml#
-    description: Represents ADC channel. Omitted channels' inputs are GPIO=
s.
-
-    properties:
-      reg:
-        description: AIN pin number
-        minimum: 0
-        maximum: 31
-
-    required:
-      - reg
-
-    additionalProperties: false
-
 required:
   - compatible
   - reg
@@ -62,7 +48,49 @@ required:
   - spi-cpha
   - spi-cpol
=20
-additionalProperties: false
+unevaluatedProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rohm,bd79112
+    then:
+      patternProperties:
+        "^channel@([0-9]|[12][0-9]|3[01])$":
+          type: object
+          $ref: /schemas/iio/adc/adc.yaml#
+          description: Represents ADC channel. Omitted channels' inputs ar=
e GPIOs.
+
+          properties:
+            reg:
+              description: AIN pin number
+              minimum: 0
+              maximum: 31
+
+          required:
+            - reg
+
+          additionalProperties: false
+    else:
+      # BD79111 has only 16 channels
+      patternProperties:
+        "^channel@([0-9]|1[0-5])$":
+          type: object
+          $ref: /schemas/iio/adc/adc.yaml#
+          description: Represents ADC channel. Omitted channels' inputs ar=
e GPIOs.
+
+          properties:
+            reg:
+              description: AIN pin number
+              minimum: 0
+              maximum: 15
+
+          required:
+            - reg
+
+          additionalProperties: false
=20
 examples:
   - |
--=20
2.56.1


--KnfmTtM03YGVjooE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmr9s98ACgkQeFA3/03a
ocV6twgAsWdB8QQP52f5xj3Jq+eNA6bXmVFPSzcKLM4cSRONcMW7HVOPq8Uh65c1
2oxUnO3GgsPL1n5P6w2h3CiqvNN7c64W7VnVDbM+AfpeAot0/jJYmDzZ5yqjZ4Sy
952GvITt0EyQTmNaW7245Q+IzV6cKmTmmfTH8JJOBe+GQbXhfhSfhXR2aLQA62af
eCFyEjV9pUCwb3/PLGTx60wcnJZ27wwM2HdK5lwyJ7aSU7RfKEjqsJJgHRcCMjCD
lBZie0PbOgiHTnXFUvJ1m30KoaEIK5TJkXYH/Toj/ZQv3ws+1Temfdwfjp8YKGkp
3a0PAltOTJ6q1rWtNNyOTi+MYSqtYA==
=w+r8
-----END PGP SIGNATURE-----

--KnfmTtM03YGVjooE--
