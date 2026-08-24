Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F783EAC84
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561208; cv=none; b=ZwzJ3+ASZuHZMe+VncWCDRwOp7My56TdR4YBBA5oDB/f+a/dLn1dxqcq8Fn4ib+orYfjMYJXh2une5Qlk2dj2JmHfxTa8Y2yHE5tEOAQT5ruDJ0MYRGqCg5HN503xPzUPWrnJX91HOu4tfTzJtFSJq6T8uD1Cc/GFEFCixhmO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561208; c=relaxed/simple;
	bh=mZLDs79Db2Zx+KUIRqHP990qtmdC8drsa//LHtCDuF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPvTyM12XFGzrmYJAPfh2l35jjJOfTD0TsAHTDJQBvxeLx5U5DwgqToeB4Ui0UX9aQXmLkTjkNafXy2OMqDjjYR06eDZT40iJKRqSoYcHs5BUGYetisg9JKILkP6TJq2KkF8BLAuASsKnnxUTqt7y44gJNcqFlE+n3rCwqaZyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITmYATLL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITmYATLL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce7d2adef4so42557275ad.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787561202; x=1788166002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+4kiW1wmf6ThJa6PW0OMOTGTvahVVw3yujYchGBBZR4=;
        b=ITmYATLLQk6xsb4EEWBfg5nbQMVm30HjFM1VVhHGTpfs6nQPwg0PgOwoksiPJ1pJnZ
         xEqiUBQoTVoimEy0pQq8c2caxdwApGhNI4GoECtu7Z0+rpG9QZsFfeUuFB8LPO7UF5ac
         FaE+KcoEr7+J1Td9Cu15utX2kq4I8GY416WDLIJq1jmB7AUvZDmFFUwQf1ke840HDror
         W007obWhp5oAf6j1Z9ZEVvW9bfGeHcP7zUkmrx7NJ1qzw1892Im/ZOWkvZStiiVFLfvm
         kQK/92muSGCTooRqBRW0Eoum9xLHQ9lH+cyW0zhzVXn0uHU4YveWQy1QIaGyDOpnS3LE
         H/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561202; x=1788166002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4kiW1wmf6ThJa6PW0OMOTGTvahVVw3yujYchGBBZR4=;
        b=Uon+A4IJZpvbHe+v5HIjDIu6vnexT/a3t7/+GuIQvIEQ7OljdOTU80VhR4hf50MXNy
         GWC9L62qaT0i28nDDuWusCPNHBxG1peSmFj51epL13X+vFtVkjNRl6gkNHsYBGyvDqv3
         l2SqpDQvDBYW2/r4BlKAGbOWGI99v/60pNoACqS1T0TZBSa7phIJ0nE38RpnY6SmLMom
         kS7fokUjHe8lAnImJiqK5Hc2GggLoBduUXrKV/CqCfCzhxZDQCuHYBXG4oI05ztM1hy8
         AE7LUbFKsK/nq8IC/M3AzWOJ/6VqDe4lunoL0gMjArPuOz+d2b+EQFQ9AAkJFHgLkfqV
         snSw==
X-Gm-Message-State: AFuF++k/kk8OiqpEL3tl2xquSPylIFUCAyo94FQjd+HzLzR+BZWdFVOy
	epu3NnVhJL08ETRMxQsdj4Ipk1hsrJJfDxXM46lBkMfwNBE7T9MgRHxa
X-Gm-Gg: AR+sD11VeoaHGCZhDWB0wdN8EdIEktEON0F8oDwIm9DAwQXc0OEdnIZTczwzXRrPLWR
	VnIczEC3sz6zRi2YT+/dj9x9Ylu8UDt1P2mtIUO//r6BBNhYG8JYq6tIIXsjSHJCYYpLdI9XJSf
	fof6V8OknCArGPnLPBWBxR2nCPkaWLt4FnOavp7mjABOTEcHFRv15kTtZik1NnZQTRs50KP891E
	3DQODd1sryEzaz5rGdjHlvofrHj1N1TTaOLzRulXlhXNCquHrNZNDgnTjw+yjqoVZFxxrjL0PyL
	7YzLWpkADZgQ9nwnXvgGXsikZK+aYn7OaIhfD4oKei0wP8rPxALEHa9cO0MVcbEEgSeHzzXCgYX
	AXFLBjYJbVFb3NCIx4SPzU8r2AxjtBZe7XIXJC5kUhrkqKd1ZNZiAn1s320jsbaVDbaBiu0ILhH
	zUhyKjNWULm+srLjwVt1yAbE3Bl9r4+UJeDoMdol24VhkhK5yV0wQ0WLmmOUaw6tNbYKT1VZ2It
	ZZo/cbD8zags1BJuqqgvDv29ZtQ
X-Received: by 2002:a17:903:b10:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d64a9f80afmr469626455ad.0.1787561202264;
        Mon, 24 Aug 2026 01:46:42 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768e9ebbsm15343265ad.80.2026.08.24.01.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:46:41 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 24 Aug 2026 16:49:38 +0800
Subject: [PATCH v7 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ti-ads112c04-driver-v7-1-6b3c9c87d0e4@gmail.com>
References: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
In-Reply-To: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5503;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=mZLDs79Db2Zx+KUIRqHP990qtmdC8drsa//LHtCDuF8=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqjAWwm3fjve7AXbTJLgNgabrI2ybDBtcQLkIv3
 Y7IvbR3TCiJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaowFsAAKCRClg0K3CVbE
 gdzLCACTY/SsTMiu26pui6pH+4XJLAlbe+3ypqi+Y7oINPwQB6Ju9h3QBW6x3dwIRPR7Ef85k0M
 uN4zGKwsPY7jyQWeF5yl4UY067G/sgcB1GoQ6tKVnAySTAo+KSM7SdZx+zNP+CvTm2LXUMzLPov
 kPqYmwgMFkrAaCyzOAC9sF8Yg0rAMVxIdX1y0saY0gGe1cGXUUoVT2dfUe9DtFcvpqYO2Jg18Dy
 BCcX1pLafie3nLKIG51lP6jmm46zUsP8xje/61L20bE3mTJOeqOgHuseaxEb3x3qW4pUiu+pY6N
 sFd5l5my3SlSlFgUQqQ1w/A3HULNsBiKSuRl1TJ14FWUaDKR
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
 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 149 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 155 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
new file mode 100644
index 000000000000..95a123cd7b67
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
@@ -0,0 +1,149 @@
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
+    description:
+      Data ready (DRDY) interrupt output. DRDY pulses low when a conversion
+      result is ready and returns high once the result is latched, so an
+      edge trigger should be used.
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

