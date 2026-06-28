Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77067317143
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782624991; cv=none; b=VfqK1W/9ozwzTQQiC+w9CniLCrX/4M9fWRI90UXEZnnDkAd/WiI5OSN0HIJh6vYyJrfHGCwfQ/ZrSjPK2SdBkpA6reJfbql8r4NBYiCusdje15vf14mN+8Z6DDxfLbRL0fOGlKL0g5rbs+SWQj6l4xWoumkQNSWiNRZLnLVntbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782624991; c=relaxed/simple;
	bh=zF53m+JOkK1WK2BW84Mp+re0gOGbMANVo2OsHlgfr8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nsjru/Jh3/fFanxnqaC1nSZ4YBlO4cYE/EVuEvodFxksP4VHLvgCdJQqbiDIrQLqN9nGV6tITLpNZeRzLBkEEj4nsNGCk6YUo/GV6nrOzs2JfK/FLsMKjuSH3HBShY5TjQ5kMzGWTEIMt1d8IpDzOPUJoFXz5Di8JYsMngtbuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKVOevcg; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKVOevcg"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bbd26a2729so2575611e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 22:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782624988; x=1783229788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WL5df8Sfay0HOTIr9EVQfpl2D/UXAdO2FX38ZEjJLFU=;
        b=dKVOevcgwegu7/iYH2raxrBDurZWo8Em90ZOcCVWnrMasIaqZKKo7gMvoIKd/RSWL1
         VNm8im035SMBdBsZQn1KeZAnhaNuUSW3yi6oBHAVyLOSFFq0ryhI3j5y0A5I9f47J6pd
         Sg1DHqreNs9VQKzBJ+KPjIPv+qq72Kocf46gNAmtzGQv4WzYHWaFHuB8dZYLrZqx7AQU
         FHouYbqSuvnVjtzMU+o7VILi/oPOwGvcGYDUASJZL+l/VR+P5VkmZhKfxkI7fg/NyWIe
         7vndeyHxxJzxN7GCXKo7F/tNHU9q14U+Whvx7/XoOnimxWMTCsuCnSbsGhtH7vLCxN5i
         62vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782624988; x=1783229788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WL5df8Sfay0HOTIr9EVQfpl2D/UXAdO2FX38ZEjJLFU=;
        b=mVtEKXs2BjERA5k16c6fUwp8L9T4pyii58w7s1CEU9HNFv3NtW6BILl2+voXU9YJ1X
         s2PfxKhzYv+pCCXXP7FaqMgLvutEtqIY0QozWEqHyRw8ngyYNmSy854PNwk+D3NgLrCq
         nXX2xMsSdPedB2OWm0ZGlc2EdPQF0Jg+23NW+qUWVhmZGHyGnw9ur0Pfdmlj+jFXzzOB
         kJ68hhk4lay+LPQTQJm8w65oDE1PsKshOv3rw0H3EgqIeh4VDtkGQVhwCMwb087qMPwR
         SmjyfC7u/4mU/Wb+YJ8RKiHBS8BBnJDR7k6GEF/eCzEQPCgJqWmPh+iyVbybwmWja6ib
         IJug==
X-Forwarded-Encrypted: i=1; AHgh+RqD4fmMYtcAdH0nMAsyUyLyPcbYizsCldD+lSZErWLSZMxtuvPVI3kbKEfenMuKWNEaPUdD9kN8RYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fiDEjON2K6PeOfEtscs9S/MDaIA6pHwUQnq5lhXeBAYmR7eK
	QujHV9OW6e8xdFLxpJSg6uLPoQkY/g/6ZUAUnFj1enS1BJnCpnIu+D6B
X-Gm-Gg: AfdE7cnKRUsK6gzeuRxWy6SMI7lsQwMxmLhOTmDwRFjD2MEUppEMBRgzXIZLdIjwE2I
	8XcPn/EwM+3+Dao4Tf2VCP3op7v5tglCv5HlV9QKUKPziZ8YDEa5laTyaPkF0jIjgHPelEZsFeo
	VL4NHfoRSZJtquVuPdEvd4hBR/3povTDaqWfSUFiLRsiKsBbPsCJkG2+d9/5myaQ1zylDWIb0xG
	FArCz0vtyAWbyxlPmG6//4sT2LKa4/bx61+90b2TQyn+lLXcSULk0pw5bspDFDejS0Xt8AowxA2
	Gh/PIa7IvcKjPmNhIdwouek1EdiVqWLKH57X5mUWASXRMT49klehqfsJdfRXT8NNtKJoQ0vOXgg
	AyBLtBescj3dhiLPdvrH73U42oG6P4H7SQ6LbG8FWiBPFntlkangLsunn3RwXCPpG+oEdF9Kam6
	JrMxdmQgZKLovBqs8m
X-Received: by 2002:a05:6122:7d0:b0:5a5:3eea:4513 with SMTP id 71dfb90a1353d-5bd69dc3af5mr5608256e0c.12.1782624988393;
        Sat, 27 Jun 2026 22:36:28 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bda2dd64c3sm229003e0c.1.2026.06.27.22.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:36:28 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 28 Jun 2026 00:36:02 -0500
Subject: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
In-Reply-To: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10645; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=zF53m+JOkK1WK2BW84Mp+re0gOGbMANVo2OsHlgfr8I=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkOm66fnnRTtSZt0hpHhtt+zSH7FA/y8q+8vbXJQXsHQ
 0z8pb4THaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRmDhGhvVR+gelAtrX6Z+W
 q7v6Qy73ylv7pwZdc78oR6lkRq9qzGBk2C5+7qx0ehNfp7vhxW3nvx/wi2szztn0tLLzBnP4mmP
 aDAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
integrated PGA, internal reference, excitation and burn-out current
sources for sensor biasing and diagnostics. The ADS1263 adds a second,
24-bit delta-sigma ADC (ADC2) for background measurements.

Each can configure it's own voltage reference source, the two excitation
current sources (IDAC), plus input and excitation channels rotation for
offset and IDAC mismatch cancellation. This lets the device drive and
ratiometrically measure RTDs and other resistive sensors.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 309 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 315 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
new file mode 100644
index 0000000000000000..2f4e812ae2af135a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
@@ -0,0 +1,309 @@
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
+    oneOf:
+      - const: ti,ads1262
+      - items:
+          - const: ti,ads1263
+          - const: ti,ads1262
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
+  refp-supply:
+    description: External positive voltage reference.
+
+  refn-supply:
+    description: External negative voltage reference.
+
+  ti,vbias:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables the level-shift voltage on the AINCOM pin.
+
+  clocks:
+    maxItems: 1
+
+  '#io-channel-cells':
+    minimum: 1
+    maximum: 2
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+patternProperties:
+  "^channel@[0-9]+$":
+    $ref: /schemas/iio/adc/adc.yaml#
+    unevaluatedProperties: false
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
+      reference-sources:
+        minItems: 2
+        description:
+          Indicates the reference sources for this channel. The first and second
+          items are the positive and negative sources of the main ADC (ADC1).
+          The third item is the reference source of the secondary ADC (ADC2).
+        items:
+          - enum: [internal, ain0, ain2, ain4, avdd]
+          - enum: [internal, ain1, ain3, ain5, avss]
+          - enum: [internal, ain0-ain1, ain2-ain3, ain4-ain5, avdd-avss]
+
+      excitation-channels:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 2
+        description: |
+          Selects pins for the IDAC sources from the following options:
+            0: AIN0
+            1: AIN1
+            2: AIN2
+            3: AIN3
+            4: AIN4
+            5: AIN5
+            6: AIN6
+            7: AIN7
+            8: AIN8
+            9: AIN9
+            10: AINCOM
+            11: No Connection
+          The first value corresponds to IDAC1 and the second to IDAC2.
+        items:
+          minimum: 0
+          maximum: 11
+
+      excitation-current-nanoamp:
+        minItems: 2
+        maxItems: 2
+        description:
+          The first value corresponds to IDAC1 and the second to IDAC2.
+        items:
+          enum: [0, 50000, 100000, 250000, 500000, 750000, 1000000, 1500000,
+                 2000000, 2500000, 3000000]
+
+      burn-out-current-nanoamp:
+        description:
+          The ADC incorporates a sensor bias current source that can be used to
+          apply a small test current to diagnose broken sensor leads or problems
+          existing in the sensor.
+        enum: [0, 500, 2000, 10000, 50000, 200000]
+
+      ti,burn-out-resistor:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: |
+          Instead of a fixed current, the sensor bias (burn-out) current source
+          can be pulled using an internal 10 MΩ resistor.
+
+      ti,burn-out-polarity:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The sensor bias can be configured to either pull-up or pull-down mode.
+          In pull-up mode, the current flows into the positive input and flows
+          out of the negative input. In pull-down mode, the polarities are
+          reversed.
+        enum: [pull-up, pull-down]
+
+      input-chopping:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          When enabled, the ADC performs two internal conversions to cancel the
+          input offset voltage. The first conversion is taken with normal input
+          polarity. The ADC reverses the internal input polarity for the second
+          conversion. The difference of the two conversions is computed to yield
+          the final corrected result with the offset voltage removed.
+
+      ti,idac-chopping:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Automatically swap the IDAC1 and IDAC2 connections of alternate
+          conversions. The ADC averages the alternate conversions to eliminate
+          IDAC mismatch.
+
+      ti,pga-bypass:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: Bypass the Programmable Gain Amplifier (PGA).
+
+    dependencies:
+      excitation-channels: [excitation-current-nanoamp]
+      excitation-current-nanoamp: [excitation-channels]
+      burn-out-current-nanoamp:
+        not:
+          required:
+            - ti,burn-out-resistor
+
+    required:
+      - reg
+
+dependencies:
+  refn-supply: [refp-supply]
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - '#address-cells'
+  - '#size-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads1263
+    then:
+      properties:
+        '#io-channel-cells':
+          const: 2
+      patternProperties:
+        "^channel@[0-9]+$":
+          properties:
+            reference-sources:
+              minItems: 3
+    else:
+      properties:
+        '#io-channel-cells':
+          const: 1
+      patternProperties:
+        "^channel@[0-9]+$":
+          properties:
+            reference-sources:
+              maxItems: 2
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1262";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+            interrupts-extended = <&gpio 10 IRQ_TYPE_EDGE_FALLING>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0x0 0xA>;
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1263", "ti,ads1262";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            refp-supply = <&refp>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+            interrupts-extended = <&gpio 10 IRQ_TYPE_EDGE_FALLING>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0x4 0x5>;
+                reference-sources = "ain2", "ain3", "ain2-ain3";
+                excitation-channels = <0x1 0x6>;
+                excitation-current-nanoamp = <500000 500000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c0471487974f145..9b83d294734b574d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26923,6 +26923,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
 F:	drivers/iio/adc/ti-ads1018.c
 
+TI ADS1262 ADC DRIVER
+M:	Kurt Borja <kuurtb@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org

-- 
2.54.0

