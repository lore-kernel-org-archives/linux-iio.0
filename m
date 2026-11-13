Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582963;
	b=H6a+TQQEQ491dcGvaCx+A4v2Hm96xuCkEWE1QwgR0MBpczoeHivsgbj2l5CQBCKdU2ry
	 GftCezOIRWNzIaxW4jJFXbBX+MMHQZPFlJLr7IAKQhfRHPnyVrHBcNR3M6DWrFmjmZ0GT
	 FJao3Ax0vntuJlyr52eBlT5OT91iXbzpQr3rzlkuQI3Ifn2o1W+Umj+Jnn9un42W+WKnz
	 Gw3qdEnPWaYfAnigarseQO3jtBiA/Gepp4W4BmNo1IjlwGLekAr7yxn1DkOgL4GY8w2kV
	 pP81aQpdd3HOTjEo49ckSpNMI+o0mOilg+INKa7yVBmaGSsD3bHImp7GzhCETg5HhgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582963;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Q7kkxG+BEYFfTL9KrEFgnZUXIhcurSfYGIqRRj0dQ5c=;
	b=DJlWeYMY5WjrQXQCocdNDs+LQtwKZspq4yuz4S8xD1fxdFEhPlPxw+KzJ9F57eIFbW2C
	 1ZWckJFQQlV0UTzHYs1/rHqtCj21t9rrxRFIiht1ieoyAkgH3ntAiuGHfnl+z00p8ttlP
	 ZPQXmQsGYHevoxvKRS1tIrYkDHtfsdjJ/jHvIBrD+rzlayfqn7nWFZgHowa6lIDG8YQtY
	 1I2DzqlR3VHxLAqyS8gCsWpUK8Zs0un1PIBocO9Dv8nfbe+glAoa/L1jFWt8Ha1zIQeDo
	 Ol2tqnh3XbhO7uQlKyihLAIPOSgU3OoP8cVIUijrqWYUbsNBeawqxLaiMfprdvKlKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="D2+Zf/oQ";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E2606A89F;
	Fri, 13 Nov 2026 15:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0E2606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=D2+Zf/oQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3DE741A164C;
	Fri, 13 Nov 2026 15:16:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B2BA60015;
	Fri, 13 Nov 2026 15:16:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E188E11BC0C42;
	Fri, 13 Nov 2026 16:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794582959; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q7kkxG+BEYFfTL9KrEFgnZUXIhcurSfYGIqRRj0dQ5c=;
	b=D2+Zf/oQQBcrGgSz5YTf6qjskX0N6/dsLkEVOmhqD6vzTGeQAxX+uS68vGiL6VpHibUhnL
	OWhJIRdGKYEMVn147SNpsL3WasjRbs6NCtjoLe136UNYIcuhpa+W8zfJySSpOInDa7GjyF
	RclLKRCH4Qt+8cBzIZecxvFDOMhA+VQSDmzUJIz14jp+mfqEV3WUdHwBkwdV3YqXczs/20
	Dtmd/JdAvmu0eGDZmlI10HDK1aLmpXN+T6c8GBT6xG3CQT0qxiB72R27JvFslfz7qnlkg6
	1/tzS1Jj+PoRYKu6/tC9/LtipA/b0MnyC5DOS4JpTTrNS4u0SiWKY9wxTA8N6Q==
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
	Joshua Crofts <crofts@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: add Texas Instruments TLA2528
Date: Fri, 13 Nov 2026 16:15:41 +0100
Message-ID: <20261113151543.2241604-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../bindings/iio/adc/ti,tla2528.yaml          | 91 +++++++++++++++++++
 MAINTAINERS                                   |  5 +
 2 files changed, 96 insertions(+)
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
index 93abbb315065..2cf3fc9bb74d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27758,6 +27758,11 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
+TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
+M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
+
 TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
 M:	Puranjay Mohan <puranjay@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.56.0

