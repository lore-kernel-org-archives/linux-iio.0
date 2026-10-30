Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378846;
	b=KOYiBpPc81FpintESr31/+mry+8V8TzWHnv6/p3A96i3DBnfYDVp3PNVDypQZAO2Ncir
	 AikQE0JnYidJGHwGCEbxODaRiNntNV8q/LxUJ8L3gZbUyEBJ7VPFX0BDEduRrC9N5Cqja
	 ipZxB4iJT+lo9ru0vMDN/z4lDEBNpU0no6UWlcq61fbJ1VZ07wZvchn8rGSqCo4NeCPiY
	 0bG1ieY67LT5+L2OH/xwIWYs2W1Y8MCSkJTmvZZqIOYDACw4Ush7WwkcHYxLPoHIdrJLL
	 87xgqiJbIZ37G6ILijWEkooX9eqdlWGses8alBpJKuX25hOUR8vP5WBUeEI1owWCp2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378846;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Vc5E4+Ssczp9QqqAMSwBt1/0zekjXCj4f66pJCUu2A4=;
	b=wwJiW9PBNz/f4Q4J+oY1BNR/dZshiaMjbgwg7ZW1/nG/ezj535N8HaY455RRWG+bG1X4
	 t4MfQXiCZ+Eie9zolJbma2qboQUiuibWjrjw4PM2mSQPFIgHBB6/gJzfRgYi3OVhXnmYS
	 t/02c/S7evg7nGySTucVjrOk1vVqysWLjQkSL2H/E6Z+MzL3d/h+xkt+tByd4g3onG+tR
	 5U5JGzNJVHj4BprFJXxj4ZuggulrMtifsnK57+2ATTzu/Eo6zkMqVH4x7wHjQyXTkRNwd
	 encfsCRPbZC7CYdSGr9oUV2w9/mLL+wrOyh/y4G2ZfEMZ4biG7R29vvj7UTvGCG5Lrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0pUMXTt2;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547A606A31C;
	Fri, 30 Oct 2026 16:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C547A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0pUMXTt2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 810931A13CC;
	Fri, 30 Oct 2026 16:47:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 556F4603C2;
	Fri, 30 Oct 2026 16:47:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59B1410328D09;
	Fri, 30 Oct 2026 17:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793378837; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vc5E4+Ssczp9QqqAMSwBt1/0zekjXCj4f66pJCUu2A4=;
	b=0pUMXTt2WjegjNz6CgycCAwFApRiGG7Teb7c/515QxSGN6/+NeSV0nRHdGUm8fcvU/BAik
	uiuY5nhwH1y70mGFVs8+OrdDwpokpeqBta1QtdpbF4bCd9cVj/8xJCawGbNdz1oerHQBH8
	YpqNQhagEKy565Tb4NgOMVX1xjqD5hrUO8l+6jd60t9vZHUUMZRJromBlIolgB7a8Fes4L
	Y9qkxyXFcmt6ZaG8kY5ca04gOd1kW3JQi4hKZqjdDHkUvYq1V8L2ReHb4r4nvgCYCuPI2S
	RRbfm+HLVhKIs5aPMWJ8IpTKZM3eAquJtBonSQsAGuAsoWB+3LvE4R4dGTZlmA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz,
	herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add Texas Instruments TLA2528
Date: Fri, 30 Oct 2026 17:47:03 +0100
Message-ID: <20261030164705.297354-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The TI TLA2528 is a simple 8-channel, 12-bit ADC and GPIO chip
accessible over i2c. The ADC part has an AVDD supply that doubles as a
reference.

As this chip can be used both for its ADC and GPIOs, let's allow
describing each ADC channel individually. If no ADC chan description is
represented, all channels will be exposed as analog inputs.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../bindings/iio/adc/ti,tla2528.yaml          | 91 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
new file mode 100644
index 000000000000..7a50a5026c1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,tla2528.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TLA2528 8-channel 12-bit I2C ADC
+
+maintainers:
+  - Maxime Chevallier <maxime.chevallier@bootlin.com>
+
+description:
+  Each of the 8 input pins can be configured as an analog input, a digital
+  input or a digital output.
+
+properties:
+  compatible:
+    const: ti,tla2528
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog supply, also used as the ADC reference voltage.
+
+  dvdd-supply: true
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  "#io-channel-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@[0-7]$":
+    type: object
+    $ref: adc.yaml
+    description: Represents an analog input.
+
+    properties:
+      reg:
+        description: AIN pin number
+        minimum: 0
+        maximum: 7
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@17 {
+            compatible = "ti,tla2528";
+            reg = <0x17>;
+            avdd-supply = <&reg_adc_supply>;
+            dvdd-supply = <&reg_adc_supply>;
+            #io-channel-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+            };
+
+            channel@3 {
+                reg = <3>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a162e9bcab1..471585b29c19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27715,6 +27715,12 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
+TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
+M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
+
 TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
 M:	Puranjay Mohan <puranjay@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.56.0

