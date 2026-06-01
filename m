Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942C3DC873
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327148; cv=none; b=OLXuRpq13WlGMJC6btmxgkZbq/nzcQMslNbwXy8etfupCAZcwWax+5bBIxfo1C4Z9939zcytPbF/qEmXNFTzKlCoFBdtceQ/1qn5JbmRmObTNkarPQYNKuWxNMtVNAPXGokEV9mfQLmJos/JfLggeua85DaXKxyQj2wHA2uF+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327148; c=relaxed/simple;
	bh=YBMg+awBYgcG4Vce7y/BtlVgWy+Flfw+/fkKW/iu418=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgNofomIHJEN+KtbFhkYoPP6FncjKmnKAYGQt3XhYE1ZdATl7vnvZK0pvQuPHKBAvJSDWXQYKcPHrmgBfrf2ekpTI5gMLPIyIBVCf4WD7DEhUc09NTpOYyRUjAFHsQEScG27ILzYh3mBsusby346p0MnkqTWbQIaTtz7Gagt94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRnG2+A2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRnG2+A2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so3780535e9.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327139; x=1780931939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6+moLw/JKUO1sAY74jZ/JznO1AkiBJL3Ukd8DYl1yY=;
        b=dRnG2+A2s1DNK/4PadWvnSm+Y/8eUwO0CtLYOLZoaEhsAWcaRNEha9wUcgv7rDf+A8
         GEi1RZlCJ/PdhpByJhuklsXUbMLWBUr9oJ15Z+vpnMiEbDXXPSzlxL13PVhk4QOHs/9b
         vQ9AjFToJzJc0iET7HiU1WXPE2OjpzqX7yxs/nWgrgN8oxYSB8fy8Ur0L7hfGbsCUdMi
         +N1tGzsJsXBIiziFR6q4mgRi2UEZUohV64UMe+O9KN5N5bSYJkkO00apPIXLKSeltZAS
         QjG2FUI8IMZG+DdK5Jz6P0lKjtgN64tcEpgA6GXUOHa/8ceU73lmDomebiJeDZotPkkE
         U4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327139; x=1780931939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6+moLw/JKUO1sAY74jZ/JznO1AkiBJL3Ukd8DYl1yY=;
        b=R480SdDY7UTXgncpiVQsp594IRgx4Ru+ySlPvf1GbdqXbl8FeCawWCjOfJXQJfFvtE
         LHs8ilKiqnsskTY7aBgijq5JqiWn0g1s61aSrH/z7gVDuF6lBAmzBc8ItqU4OwiS5wDX
         W4H4zKsWGVC/8AWit/2Y8V6mUfledTDQlr5efFuQv848/LqedFEaYJYOEvP8QPcgW7NF
         4RzPqYAxJlmWYjrG45Irv1CJjVeUDphpslp+e+QfprS2IRoIk/QqaoncH/91Yvv+w2mv
         bXbLCWpSsPHz50PKxiTe4QyEMxuR9Gjp8kkRYv/67WWKTWMi9f5L6XoY7Df8vLCGp4LS
         Wscg==
X-Forwarded-Encrypted: i=1; AFNElJ/BaUBHnEb+RYoIth8TMPKkvIZ+l3lhXE/ejGAFj72RCOBwPcjvMix7q8tCKtLF+38LWwiF81H3kP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tIGIu9IxFtI/W87jVrWMQlntXUnOggPsmkqLplIU70K6wbos
	SMLk3VCJiKXSaOcORnN1Px4DdW8Z6knf/3bbx6g8IGZzpJh+rrFLSukJ
X-Gm-Gg: Acq92OH9ixNQw3KcjIaIOyslJ1kACaLDXKCWjw3p7UmPWWYtdoeYDrxzoeKBJcuC94I
	vbRxeNCiVDbmw0pXtmGyAydp24CFla5dzgxlqSnBz4FXmV+pCHaFTJ26IRyYfP5jgzeidmpxDHE
	kP12+HLWEfphNXvmp66MbH3FJNzDcRCMAsg5/jCfqjRha7KlBU6sIU1veBeAyCpiRO2i4/rLz4D
	RNbQ1layF+mn5PcUmhp0hePC+JmXd9bpKMzGtLXyZaYdxPqhE9v3ApranYJHkTEF9tGTL5CPXuw
	a71GcqC9nH64j/yvF5rK2r72UJGQDCRQieIYSotiyXCr81+pwFx4jwBQy/F5VpkbP2P9Vmmq4Bj
	6Hvj2cEglT0YhQJLHYPkYRX1nXUYSF1jrYV3w446OFH378n0PfhoVDMtztX46ZFUkPgb046aygK
	1jRvjrKa7nnrgvV3a//JEhbdI=
X-Received: by 2002:a05:600c:c092:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-490a2959113mr190065465e9.21.1780327139267;
        Mon, 01 Jun 2026 08:18:59 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:18:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 01/11] dt-bindings: leds: Document TI LM3533 LED controller
Date: Mon,  1 Jun 2026 18:18:21 +0300
Message-ID: <20260601151831.76350-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the LM3533 - a complete power source for backlight, keypad and
indicator LEDs in smartphone handsets. The high-voltage inductive boost
converter provides the power for two series LED strings display backlight
and keypad functions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
---
 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 +++++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 +++++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
new file mode 100644
index 000000000000..a25846e9b375
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 high voltage series LED strings
+
+description:
+  This is part of the TI LM3533 MFD device. It represents two high voltage series
+  LED strings for display backlight controlled by the TI LM3533.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/leds/backlight/common.yaml#
+
+properties:
+  compatible:
+    const: ti,lm3533-backlight
+
+  reg:
+    description: Control bank selection (0 = bank A, 1 = bank B).
+    maximum: 1
+
+  led-max-microamp:
+    description: maximum current in uA with a 800 uA step.
+    minimum: 5000
+    maximum: 29800
+    default: 5000
+
+  led-sources:
+    description: |
+      HVLED strings associated with this control bank:
+        0 - HVLED1
+        1 - HVLED2
+    minItems: 1
+    maxItems: 2
+    items:
+      maximum: 1
+
+  ti,pwm-config-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Control Bank PWM Configuration Register mask that allows to configure
+      PWM input in Zones 0-4
+      BIT(0) - PWM Input is enabled
+      BIT(1) - PWM Input is enabled in Zone 0
+      BIT(2) - PWM Input is enabled in Zone 1
+      BIT(3) - PWM Input is enabled in Zone 2
+      BIT(4) - PWM Input is enabled in Zone 3
+      BIT(5) - PWM Input is enabled in Zone 4
+    default: 0
+
+  ti,linear-mapping-mode:
+    description:
+      Enable linear mapping mode. If disabled, then it will use exponential
+      mapping mode in which the ramp up/down appears to have a more uniform
+      transition to the human eye.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+# see ti,lm3533.yaml for an example
diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml b/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
new file mode 100644
index 000000000000..d8dbefef3323
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ti,lm3533-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 low voltage control banks for individual LEDs
+
+description:
+  This is part of the TI LM3533 MFD device. It represents four low voltage
+  control banks for individual LEDs provided by the TI LM3533.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+
+properties:
+  compatible:
+    const: ti,lm3533-leds
+
+  reg:
+    description:
+      Control bank selection (2 = bank C, 3 = bank D, 4 = bank E, 5 = bank F).
+    minimum: 2
+    maximum: 5
+
+  led-max-microamp:
+    description: maximum current in uA with a 800 uA step.
+    minimum: 5000
+    maximum: 29800
+    default: 5000
+
+  led-sources:
+    description: |
+      LVLED associated with this control bank. May be more than 1 source per bank.
+        0 - LVLED1
+        1 - LVLED2
+        2 - LVLED3
+        3 - LVLED4
+        4 - LVLED5
+    minItems: 1
+    maxItems: 5
+    items:
+      maximum: 4
+
+  ti,pwm-config-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Control Bank PWM Configuration Register mask that allows to configure
+      PWM input in Zones 0-4
+      BIT(0) - PWM Input is enabled
+      BIT(1) - PWM Input is enabled in Zone 0
+      BIT(2) - PWM Input is enabled in Zone 1
+      BIT(3) - PWM Input is enabled in Zone 2
+      BIT(4) - PWM Input is enabled in Zone 3
+      BIT(5) - PWM Input is enabled in Zone 4
+    default: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+# see ti,lm3533.yaml for an example
diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533.yaml b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
new file mode 100644
index 000000000000..bdc05a9f3d66
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ti,lm3533.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 Complete Lighting Power Solution
+
+description: >
+  The LM3533 is a complete power source for backlight, keypad, and indicator LEDs
+  in smartphone handsets. The high-voltage inductive boost converter provides the
+  power for two high voltage series LED strings for display backlight and four low
+  voltage control banks for individual LEDs. Additionally, LM3533 features an
+  interface for an external light sensor.
+
+  https://www.ti.com/product/LM3533
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: ti,lm3533
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to the HWEN pin.
+    maxItems: 1
+
+  vin-supply:
+    description: Supply connected to the IN line (2.7 V to 5.5 V).
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  ti,boost-ovp-microvolt:
+    description: boost OVP select (16V, 24V, 32V, 40V)
+    enum: [ 16000000, 24000000, 32000000, 40000000 ]
+    default: 16000000
+
+  ti,boost-freq-hz:
+    description: boost frequency select (500KHz or 1MHz)
+    enum: [ 500000, 1000000 ]
+    default: 500000
+
+  light-sensor:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: ti,lm3533-als
+
+      interrupts:
+        maxItems: 1
+
+      ti,resistor-ohms:
+        description:
+          Internal configuration resistor value when light sensor is in
+          Analog Sensor mode and PWM mode is disabled. The expectation is
+          the input is a current from the external analog light sensor and
+          this is used to convert it to a voltage within the target range.
+        minimum: 1575
+        maximum: 200000
+
+      ti,pwm-mode:
+        type: boolean
+        description:
+          Switch for mode in which light sensor interface is running. If
+          this property is set then the light sensor interface is running
+          in PWM mode, internal resistor value is set to high-impedance (0)
+          and ti,resistor-ohms property is ignored.
+
+    required:
+      - compatible
+
+    oneOf:
+      - required:
+          - ti,resistor-ohms
+      - required:
+          - ti,pwm-mode
+
+patternProperties:
+  "^backlight@[01]$":
+    $ref: /schemas/leds/backlight/ti,lm3533-backlight.yaml#
+
+  "^led@[2-5]$":
+    $ref: /schemas/leds/ti,lm3533-leds.yaml#
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@36 {
+            compatible = "ti,lm3533";
+            reg = <0x36>;
+
+            enable-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+            vin-supply = <&vdd_3v3_bat>;
+
+            ti,boost-ovp-microvolt = <24000000>;
+            ti,boost-freq-hz = <500000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            backlight@0 {
+                compatible = "ti,lm3533-backlight";
+                reg = <0>;
+
+                default-brightness = <113>;
+
+                led-max-microamp = <23400>;
+                led-sources = <0 1>;
+            };
+
+            led@2 {
+                compatible = "ti,lm3533-leds";
+                reg = <2>;
+
+                led-max-microamp = <23400>;
+                led-sources = <0 1>;
+            };
+
+            led@4 {
+                compatible = "ti,lm3533-leds";
+                reg = <4>;
+
+                led-max-microamp = <23400>;
+                led-sources = <2>;
+            };
+
+            led@5 {
+                compatible = "ti,lm3533-leds";
+                reg = <5>;
+
+                led-max-microamp = <23400>;
+                led-sources = <3 4>;
+            };
+
+            light-sensor {
+                compatible = "ti,lm3533-als";
+
+                interrupt-parent = <&gpio>;
+                interrupts = <80 IRQ_TYPE_LEVEL_LOW>;
+
+                ti,pwm-mode;
+            };
+        };
+    };
+...
-- 
2.51.0

