Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D83D6472
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304425; cv=none; b=Fj0PdLgRkf4lqvmQ2Xc/az1UMBFnAy7i5iHGwx9+3Amkw0/TNpbPynl0s1s1Ne/9uSG/63A9NpdixtKjiSxtqq6Yuc5OLpOaCtLqoEeoml5nbVsu57mGhoviZkAU8yUNO3ly+ItN1I0KZcYybxDjnCqfbFDFrFa35LZc8K/Fh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304425; c=relaxed/simple;
	bh=wPe+MCGV7y8p2VWX5tNsJUlFInLquvWFNJQafrXkt8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M97Wrefp6M3pNxcyrDrazVLDTfrG7AY1UHKcC+RZzSh25EOPYfD9ko7vuMI2pPAIsGfnTGA0oNmKA3m5BW9iJ46ZBJK6pF5/66DczRbyV+GFGTZizkRR2M5y7mabT4cwsi4fw/epB+4msSB7yH8kP3RGfajA8fn9HTem1CjzWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxnDBCdz; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxnDBCdz"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59d541955f8so592742e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781304422; x=1781909222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1aVnlrURhUdP5DcLJVh35bGmgGAkbGlAndwroGP4wM=;
        b=hxnDBCdzIZv4YMA1Wgah5WeTrWWD2KHv5VQovlcfT7AwAGetZFFOrxz2JwTKr9cw4i
         xYSvQkN+C8sPmsYpDcfdix+piaxHqMtyOvLHbueVCsFLaXpvb9ZyFvofwig4xguk/KFz
         Y0JulkGIu5k8yu/lhtdeoSBfYIHjE6zdeVUl7lth8dWKcJDcy3+mCXvGqUR2aCkZzFxV
         +MdU844pUQr/vU8qYa4735KcFAmYERoyFhYjco0zHToOm1gF7DMYBeb6R3GRQdfrKGrQ
         XtD6VWTfOp8XWpw4Xm7Y4BqOEoCd4+4I2JciZkM20p8ZLa3GzmWOw8MhHpQctkLS5cit
         GNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304422; x=1781909222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1aVnlrURhUdP5DcLJVh35bGmgGAkbGlAndwroGP4wM=;
        b=e/TJvTY3MVEQhGaTm8ok6RD/dO9VTi923CfasYBfYgjA7eATU/LjQOOJrIfUopDuGj
         CXs11waDQ6CRLH448hOq89mSSTt1ez/f7kE/bOxwtzk0/ZjgzGtiT6n+vfgJBN3IR9Ci
         azHsucpVqb9gaBbd/L2dnn6leE01ENxZ3EQAknm/8eZzalEF36+aFenPpyrmlallk08+
         3Bvewmku/YCloJWMjqpM1OqpiHPVwtO69fTy4Mk56jrDuYkiEFxvFtgXpppD1iVFYVsA
         L2tK2+F7BWgdXC0nYm4V/Jqb1+GZ2uDql7Fo9ihqTrM4t3ZGcGJYeFfbE/FGGeZyYMFc
         BH3A==
X-Forwarded-Encrypted: i=1; AFNElJ/MYsgYs+Wfqs6lnfH9sUgjARFAqMhFgyD04MbAMwPxIfP0vAfQv2XgUN2Plr2TIfBQnSqD15K9zYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEPIdqmN6qNJ9luRe/caXh3j5QfZkj5MUvZNv308UFfHEZFyD
	FfgNZVsCxppUM9jnjJS9D5fJzfRVyRk+RJmNW8e8rb/D8Z9ciDzSDq9j
X-Gm-Gg: Acq92OFUnmQ9mxAhLmhHsilWHytSelom3q/53TwdZzQVEOFqPOgPyBLcaabb2aDXk6w
	6V13CUc94CZKnM9l+F7cs0dRr5452dJ6diTWyE06FTfHwvciPO8SEzTDFW71tQ1uA6rAJ1w0UWS
	pzc04pMOI3DldSlKZq5485UxZ8a1LcRdLyYNHHprgUr9SV9c5/iSwu0v9FSsBbaoLNqmE5fnuho
	D44EPbTe6a0ux/gP+EbAB21F5p6ypLCjv+iqnnaJ9fAIiy115JY6jcCfd0PyqGYSV3IL9I6q/pZ
	I7RYa6xecvk6nhwO19KdBk6jsIozhFh7hzVwmbOXEWU5vSXqP/x/bzHT9RkRYsDZlsXOnTfEoxl
	cXtDghSLeSgP2O+L3j/x8kAx7Rwb5E2G/d37CBnaEOu2lKrKVLT4Q6ngOJNQ4In9ad5ru8guMI2
	W4V9kemziFFkiHxz3XzzqTLw==
X-Received: by 2002:a05:6122:828e:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5bb6c0352d7mr3035023e0c.7.1781304422519;
        Fri, 12 Jun 2026 15:47:02 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691fd8adsm4244553e0c.13.2026.06.12.15.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:47:02 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 12 Jun 2026 17:46:19 -0500
Subject: [PATCH 1/5] dt-bindings: iio: adc: Add TI ADS126x ADC family
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260612-ads126x-v1-1-894c788d03ed@gmail.com>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
In-Reply-To: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10990; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=wPe+MCGV7y8p2VWX5tNsJUlFInLquvWFNJQafrXkt8k=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFk6PUnTRJR7nf5drStyczgZVCfYKLl+gtOnH7YvhOSTs
 67W35raUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABNZ0s/wT3F91lqm2v0qbpeX
 VEi+jvm5/NKn3Ml8TysePRDzDJqrnczwP+qDGE9UT9fO21ejZ7oUayxmv32UUdlvS863Vtm3Mzm
 VGAE=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add TI ADS1262 and TI ADS1263 ADC2 devicetree bindings documentation.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 308 +++++++++++++++++++++
 .../bindings/iio/adc/ti,ads1263-adc2.yaml          |  49 ++++
 MAINTAINERS                                        |   7 +
 3 files changed, 364 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
new file mode 100644
index 000000000000..1c4fde94f6c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
@@ -0,0 +1,308 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1262/ADS1263 analog to digital converter
+
+maintainers:
+  - Kurt Borja <kuurtb@gmail.com>
+
+description: |
+  The ADS1262 and ADS1263 are 38.4-kSPS, delta-sigma (ΔΣ) ADCs with an
+  integrated PGA, reference, and internal fault monitors. The ADS1263 integrates
+  an auxiliary, 24-bit, ΔΣ ADC intended for background measurements.
+
+  Datasheets:
+    - ADS126x: https://www.ti.com/lit/ds/symlink/ads1262.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1262
+      - ti,ads1263
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 8000000
+
+  spi-cpha: true
+
+  interrupts:
+    description: Data ready (DRDY) interrupt line.
+    maxItems: 1
+
+  start-gpios:
+    description: Start conversion control.
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  dvdd-supply:
+    description: Digital power supply.
+
+  avdd-supply:
+    description: Analog power supply.
+
+  vref-supply:
+    description: Optional external voltage reference.
+
+  ti,pos-refmux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Selects the positive voltage reference input:
+      0: Internal 2.5 V reference
+      1: AIN0 pin
+      2: AIN2 pin
+      3: AIN4 pin
+      4: AVDD pin
+    minimum: 0
+    maximum: 4
+    default: 0
+
+  ti,neg-refmux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Selects the negative voltage reference input:
+      0: Internal 2.5 V reference
+      1: AIN1 pin
+      2: AIN3 pin
+      3: AIN5 pin
+      4: AVSS pin
+    minimum: 0
+    maximum: 4
+    default: 0
+
+  ti,vbias:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables the level-shift voltage on the AINCOM pin.
+    default: false
+
+  ti,idac1-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Selects the analog input pin to connect IDAC1:
+      0: AIN0
+      1: AIN1
+      2: AIN2
+      3: AIN3
+      4: AIN4
+      5: AIN5
+      6: AIN6
+      7: AIN7
+      8: AIN8
+      9: AIN9
+      10: AINCOM
+      11: No Connection
+    minimum: 0
+    maximum: 11
+    default: 11
+
+  ti,idac1-microamp:
+    description: Selects the current values of IDAC1.
+    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
+    default: 0
+
+  ti,idac2-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Selects the analog input pin to connect IDAC2:
+      0: AIN0
+      1: AIN1
+      2: AIN2
+      3: AIN3
+      4: AIN4
+      5: AIN5
+      6: AIN6
+      7: AIN7
+      8: AIN8
+      9: AIN9
+      10: AINCOM
+      11: No Connection
+    minimum: 0
+    maximum: 11
+    default: 11
+
+  ti,idac2-microamp:
+    description: Selects the current values of IDAC2.
+    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
+    default: 0
+
+  clocks:
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 1
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+  adc:
+    $ref: /schemas/iio/adc/ti,ads1263-adc2.yaml#
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+patternProperties:
+  "^channel@[0-9]+$":
+    $ref: /schemas/iio/adc/adc.yaml#
+    additionalProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+
+      diff-channels:
+        description: |
+          Selects the analog input configuration for this channel. The first
+          value is the positive input and the second is the negative input.
+          The following values are available:
+          0: AIN0 pin
+          1: AIN1 pin
+          2: AIN2 pin
+          3: AIN3 pin
+          4: AIN4 pin
+          5: AIN5 pin
+          6: AIN6 pin
+          7: AIN7 pin
+          8: AIN8 pin
+          9: AIN9 pin
+          10: AINCOM pin
+          11: Temperature sensor monitor
+          12: Analog power supply monitor
+          13: Digital power supply monitor
+          14: TDAC test signal
+          15: Float (open connection)
+        items:
+          minimum: 0
+          maximum: 15
+
+      ti,chop-mode:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          When enabled, the ADC performs two internal conversions to cancel the
+          input offset voltage. The first conversion is taken with normal input
+          polarity. The ADC reverses the internal input polarity for the second
+          conversion. The difference of the two conversions is computed to yield
+          the final corrected result with the offset voltage removed.
+        default: false
+
+      ti,idac-rotation-mode:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The rotation mode automatically swaps the IDAC1 and IDAC2 connections
+          of alternate conversions. The ADC averages the alternate conversions
+          to eliminate IDAC mismatch.
+        default: false
+
+      ti,pga-bypass:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: Bypass the Programmable Gain Amplifier (PGA).
+        default: false
+
+      ti,rev-vref-pol:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The reference polarity can be negative, but the ADC requires a
+          positive voltage reference. In this case, the reference
+          polarity-reversal switch changes the reference polarity from negative
+          to positive.
+        default: false
+
+      ti,sbias-connection:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Selects the sensor bias current source connection:
+          0: Sensor bias connected to ADC1 mux out
+          1: Sensor bias connected to ADC2 mux out
+        minimum: 0
+        maximum: 1
+        default: 0
+
+      ti,sbias-polarity:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Selects the sensor bias current source polarity:
+          0: Sensor bias pull-up
+          1: Sensor bias pull-down
+        minimum: 0
+        maximum: 1
+        default: 0
+
+      ti,sbias-magnitude:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Selects the sensor bias magnitude:
+          0: No sensor bias current or resistor
+          1: 0.5-uA sensor bias current
+          2: 2-uA sensor bias current
+          3: 10-uA sensor bias current
+          4: 50-uA sensor bias current
+          5: 200-uA sensor bias current
+          6: 10-Mohm resistor
+        minimum: 0
+        maximum: 6
+        default: 0
+
+    required:
+      - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1263";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+
+            /* AINP: 0 - AINN: AINCOM */
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0x0 0xA>;
+            };
+
+            /* Temperature sensor monitor */
+            channel@1 {
+                reg = <1>;
+                diff-channels = <0xB 0xB>;
+            };
+
+            adc {
+                compatible = "ti,ads1263-adc2";
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1263-adc2.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1263-adc2.yaml
new file mode 100644
index 000000000000..9dd5577589b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1263-adc2.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1263-adc2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1263 ADC2 analog-to-digital converter
+
+maintainers:
+  - Kurt Borja <kuurtb@gmail.com>
+
+description:
+  The ADS1263 includes an auxiliary, 24-bit, delta-sigma ADC (ADC2). ADC2
+  operation is independent of ADC1, with independent selections of input
+  channel, reference voltage, sample rate, and channel gain.
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1263-adc2
+  vref-supply:
+    description: Optional external voltage reference.
+
+  ti,refmux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Selects the positive voltage reference input:
+      0: Internal 2.5 V reference
+      1: AIN0-AIN1 pins
+      2: AIN2-AIN3 pins
+      3: AIN4-AIN5 pins
+      4: AVDD-AVSS pins
+    minimum: 0
+    maximum: 4
+    default: 0
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#io-channel-cells':
+    const: 1
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 396d4e76dccc..9379699d99c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26668,6 +26668,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
 F:	drivers/iio/adc/ti-ads1018.c
 
+TI ADS1262 ADC DRIVER
+M:	Kurt Borja <kuurtb@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1263-adc2.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org

-- 
2.54.0

