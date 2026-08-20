Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619B208D0
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212135; cv=none; b=VwreSCsDViND5rk/0AxJfzGre4mb6UeVlAWwlM1qt0P6Y+a98BfuaGlMwcaUD89jsXPNqJUrDQv6ORH2KE407jX8wvrUS/1zuv/G3z91OeCdL57BOAuCFYMoLOfXdy9KbzRro3FjJZCvZaYSebrer2EM9jFoKb9IgjPjWPI12Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212135; c=relaxed/simple;
	bh=JTfh/5RRli2YzhegnL1r0+hLfKtf4xrV2HIbgfpnUbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5Kdc7K2A13og9nUHowZUXg8EHclZ2vKGdDPPyc4KGWNrFWqxGJx0hOQpSYGva1h5v0Mwwe9nn4fWvF3CnL+AoRFyo/7eXfz/3o4uCoLkY/zfw6TmmtW9BZwUe5NCpOr+lUqZk1eKtvak59oLUHxmWUUeH5jCQ9t7lSQF/PAclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz6SNxde; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz6SNxde"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2678630a91.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787212132; x=1787816932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p1NWnTLgFrUrPQnnbLgbg2OXshjEOvthUk4VO+d5cYM=;
        b=Oz6SNxdekhftnsGIj6mg/uo2VYzB3HxelSVrMR72cUBxWx2NuTuVBiZoajWEUPqg1z
         AIIBVRErhi5+m0FyzFG2gXvRZOG5/zVmYL6P1lCz6ttB5urhaJPuRGAcFNUjCWWKKzuQ
         Kjwa1RNZEEIxWhVL/OCp6g0n81U2rWPwfIAMYlx8hSNvgu2HVa3vzXzYddG7cTQEj6ZU
         S6K/GCVTJjsflRSP1z22/H6lJcTuBfPSXCbW7PHnlDpDO49EmYjzS0W7TbZGGObOIGOS
         vNw1hDOg1d150Okqlc1y0V+KTYjZ37FC8IMej8n1rqVEhLuQK87j4kYqZuNZndoXIWP3
         8zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212132; x=1787816932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1NWnTLgFrUrPQnnbLgbg2OXshjEOvthUk4VO+d5cYM=;
        b=bcXbQGstNbTmziNTauUxwVJJMAiuH6K0S4UeS/RJNc0uscAJiyFzLXac+cnWQdUheC
         E4LgHofAwhTaA2pGW6tYv30W3S7jmQpMgiTvVEYYI9V9wpHhBw6dumIGmitckz40qzFm
         ireD6saiKcQavLcOKuihv8tWpCkxUcc+pJtXPmZKiIx+B+O44QSs8P5wNVVU5nh2bMSt
         Jjl8kU9vh2JGrwwOZqF+LnKwFvAw2z7WfpJyAtxtNrb8KpsIzcZAGxv2Dp58ch6N9LV5
         AsJDAhOew9EtGuO1Kh0ICFarGtJfxxo/1l85CgvAB1L/RjkVFd8KETuP4QrrA19lB7pG
         ExPg==
X-Gm-Message-State: AFuF++n6pg7DUiUPWIyKDsBw5NIK3olmh5NuI++S/1tkZn/bBzI38BbL
	svtOGUZPM023WYolFtFP5PeNniqUoRKe1//4cyl3DXnXKw0eB5Vj8lJY4OzaSg==
X-Gm-Gg: AR+sD102aI6nMNZaAYSWzvWfWf0MTETpUgwWV1gUQOBgvs1vtjj//0Hl3tDDLdBdtyB
	b5ObgPd/XRV/EdbEAwNUOwqfNjM/PqyUkXG7ibj5kdFAsgDA8zHjgUBFMrErYnWCLvCSaoXC9nZ
	emYpWAtGuoJo3HgT3LHMq0aov4ic2tNMBbnm+1mOAO0HEjAiMtjoH1nngPlkzqY/b2+OCwsnypy
	4VN3FSRs+99tQhL4+dVYWx9v/Iqx3kxSxSFPVaek+XXW0srctOOcrTd4T+6/ef73+9qfHeTHaZA
	E2ckw6MUhNyQnNZT5Shme9x+azgOYiGy6mHOq3/HGzGxujhP60dViY3Gsiw3BstcpPoeYkSkshM
	k5ZKsf4ayMfKzC+1css9A5LTaLajK9mQk9/6s+bJna4ZbyrVMAJv+3x80nNi3ewrkj9ONl5Ih+x
	6XPKEma+e766mg/i5cG5MVThtMMvhT41lvXJp4xj9WovFm0ppBdGVmRu4ZYkiFDi+n23DaPPyzR
	3/TQzHLi/OZ7U9nvfMHhNTw5dGF
X-Received: by 2002:a17:90b:4b0e:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-39580f6c042mr19676341a91.9.1787212132356;
        Thu, 20 Aug 2026 00:48:52 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96ca41sm5600419a91.4.2026.08.20.00.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:48:51 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Thu, 20 Aug 2026 15:51:51 +0800
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-ti-ads112c04-driver-v6-1-0e8f0aacce9b@gmail.com>
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
In-Reply-To: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=JTfh/5RRli2YzhegnL1r0+hLfKtf4xrV2HIbgfpnUbE=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqhrIgCTixoCAebLz9xfZTYM4vCemXxR1168e/I
 NccYFRJgDGJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaoayIAAKCRClg0K3CVbE
 gfCnB/0U3Sr5REcCqlMopDg3pVqzS2waF5buxpgALXvdNqZQ+hu+xpWeLbdgs7Fdojm7u4GWfYS
 SdYz5AfvKvn4BI7KfU0744nDptVVAzTgRyujbG0X2H+hg0mVsddJfmwVQG1Pg33fs8YEZzprst8
 Y0+tcIRL3n4wHjmzGMI0Tw9k8VJ4enFptTQBY/ZQp79gR4SBywMm1AO9m+ZGu3RoD+YWsnhoSPg
 TuS3h+UJaVYeob3Q58qvxo4B/Dt5P17H5SllQLYFwI4dSjSGaTFBI6CusMn6cboxYGqCpD/V/Rg
 w2iJpyTUhR2sxvANaJGTkTg9vls8aZ4fgMlXirw8wryBeYnS
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add device tree binding documentation for Texas Instruments ADS112C04
I2C Analog-to-Digital Converters.

These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
interface, programmable gain amplifier (PGA), and data-ready (DRDY)
interrupt output.

The binding uses child nodes to dynamically define the connected
single-ended or differential channels.

Excitation current, burn-out current, and reference source properties
are also included to fully describe the chip's hardware capabilities,
aligned with the ti,ads112c14 binding conventions.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 146 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 152 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
new file mode 100644
index 000000000000..81b3511139f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads112c04.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS112C04 ADC
+
+maintainers:
+  - Kyle Hsieh <kylehsieh1995@gmail.com>
+
+description:
+  The ADS112C04 (16-bit) are precision analog-to-digital converters (ADCs)
+  with an I2C interface. They feature a flexible input multiplexer, a
+  low-noise programmable gain amplifier (PGA), two programmable excitation
+  current sources, a voltage reference, and a precision temperature sensor.
+
+properties:
+  compatible:
+    enum:
+      - ti,ads112c04
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  interrupts:
+    maxItems: 1
+    description: Data ready (DRDY) interrupt output.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to the RESET pin. Active low.
+
+  avdd-supply: true
+  dvdd-supply: true
+
+  refp-supply: true
+  refn-supply: true
+
+  ti,refp-refn-resistor-ohms:
+    description: Resistance of the external resistor between REFP and REFN.
+
+patternProperties:
+  "^channel@[0-9a-b]$":
+    $ref: adc.yaml
+    unevaluatedProperties: false
+    properties:
+      reg:
+        items:
+          - maximum: 11
+
+      single-channel:
+        maximum: 3
+
+      diff-channels:
+        items:
+          maximum: 3
+
+      excitation-channels:
+        maxItems: 2
+        items:
+          maximum: 5
+        description:
+          Additionally to AIN0-AIN3, IDAC1/IDAC2 can also be routed to
+          REFP0 (4) and REFN0 (5).
+
+      excitation-current-nanoamp:
+        enum: [10000, 50000, 100000, 250000, 500000, 1000000, 1500000]
+
+      burn-out-current-nanoamp:
+        const: 10000
+
+      reference-sources:
+        items:
+          - enum: [internal, external, avdd]
+        default: [ internal ]
+
+    dependencies:
+      excitation-channels: [ excitation-current-nanoamp ]
+      excitation-current-nanoamp: [ excitation-channels ]
+
+    oneOf:
+      - required: [ single-channel ]
+      - required: [ diff-channels ]
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+
+dependencies:
+  refn-supply: [ refp-supply ]
+
+oneOf:
+  - required:
+      - refp-supply
+  - required:
+      - ti,refp-refn-resistor-ohms
+  - properties:
+      refp-supply: false
+      refn-supply: false
+      ti,refp-refn-resistor-ohms: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@40 {
+            compatible = "ti,ads112c04";
+            reg = <0x40>;
+            interrupt-parent = <&gpio>;
+            interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+
+            reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&vdd_3v3_reg>;
+            dvdd-supply = <&vdd_3v3_reg>;
+            refp-supply = <&vref_reg>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0>, <1>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                single-channel = <2>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa5322d9f7..417d74b6d6cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26987,6 +26987,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS112C04 ADC DRIVER
+M:	Kyle Hsieh <kylehsieh1995@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
+
 TI ADS112C14 ADC DRIVER
 M:	David Lechner <dlechner@baylibre.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1

