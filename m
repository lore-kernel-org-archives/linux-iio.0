Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6431159C
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003816; cv=none; b=A0kM4RWIsVZFvKwpYiAOzsJE9oqzvwdYXw+xd+VXxUjZTEjTzAbEx5154q4qppPtp/v4HI+zJP/ns0q0z0fx7F7Q605eJ0Epa3gxN6BTNRmPy1bCxjN8lvq1PTAa/eo+aO381HDhP2cQPRAoGJW45zylaiWbahAdGB7Gb3Au9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003816; c=relaxed/simple;
	bh=/lQ5p0ayr6Df3JRkR1L9VpuelhqYjdc8n9A686KbQ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6b/9I51cegOsAKdF9CyAPRuaDDXKsybMOpmczQQKPbexiOWZB9mEE5xoLEeTi7RDZ8oad4iiwXocLnhP46EazPl35E02+TiJ6MZ4vNe5YZnWvckxP1YSQPAIuSnOmaU9g92rofaf96YyA9Jv67nuQAuY1mu5jZdfWr67n5ZR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6r8JckQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6r8JckQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-449de065cb3so1100261f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003812; x=1779608612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZKo5UvI/gJnxHMbxa9ycLb7RHsv/YC/zH6YHBOw+mM=;
        b=Q6r8JckQaZmzEcWMCW1IlDib5w/BSx9TX4M89boT3EoUKnz+b34wo4sgh8C/EBRjZw
         gzX4tjYBUZGS6WO6BOO/5K8dukMbKeb0F2bknhOmtRGTgGAWlhXm+6OPA+GH4MpHYNGZ
         Vg8gcOibNUiFIA6/R2EoO4YzzYULCrktERHtwe48re/j+LYhSncKtyTJWgH2PhpA3nNP
         mIvfV8M4AwPbeWq/TCwJoQoKwpghiJ1nl9JbBfuVUUYFzm+zkvXCBMmiuF633l8ZYoVZ
         gQHycrXNLKb4fOEWm7Jh36Q87CtR3tYWXExFa4WvlSd6bT3SOGKNh1SmZ/BvEEmyvpPA
         q/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003812; x=1779608612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZKo5UvI/gJnxHMbxa9ycLb7RHsv/YC/zH6YHBOw+mM=;
        b=PtnN3EbUvub9Msf07uYBvD7+8QDpaZqXCNPbZNQ97NCbYJUQX4Y4H6xp4SrKf5XrIv
         n5DVxgsJIocQZUNnd58w5GFa0ZvmpT6bhWw4ExT83DI9mWu+PMKfEKhUOQU9ituWUesI
         IwlA2Rvm9zGMvI8Wpz11UIiTTYDR608HEdea+vfXYvnM2mvcbdXklveufuD1ikqGZHMz
         LtAS1/uPpzG/Co7pze6YtGHPKNHBWQpczzrgBA9vfM+u/HiwZ4RoNgm1cXNoFfkT+iWa
         AuXm/qFdjgRlJOSXJ1gbQUSeE7ykIXXglot/RDyWWPQVvkLhs0KFm+iY+rbqrMAZ6S0d
         WSMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NmL8BuEJ90B+w7eDDpBsZTRe5BuhkrmttXnkhWgmClSf1kDb/p9gZ8gfdmHuukk13FgSbL0vDZuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw28EGJSKH3kv9sL6izkChedgyLe8oTGdtWk8oK6bHywb4xHZ6I
	uu5t5cj+q/wauVjCBTJAExfDyG7eXwOvwy1vHP7vPhiLXvJWq6ymB7q0
X-Gm-Gg: Acq92OFixGZZQ8x9Y635t4jT8Da+csOK59nMS5jQMlj79LfulXu019UN8rOxnIghcr1
	e8V+hQjfPzKrx58PDelcUHuFUK1z9jN46fPcg3Rz5YdhX6JiguOuuEU6RaTEMR/VfMpgPwRD8QD
	O59wyw/pNRcCDy3Zb8SBWPsHlUHCJZ6HCuNawr35XImo0YMvzeGPdpgaZdLWX+wvbFscQP0JCJq
	bXupu5bybzVuU4O9uxue5jqX4RkGjh8gqjKGfY/Af8uZav2Xfdhls3MyMR3Bhp/4fD80bcEZ9JP
	hMz6A+eJqseOf/y81cYLeqLg/2dzVwgDRECAGzKQj9/BWMG7d0q879bKEUALUWkGoLENTBH9s7r
	/Slq8jrBRZGeJ/+zxwTD4f/+yzuho9yvJxS4yAUHgnxMaxIVnCeB50ZncF1D9H1uHfewio04AHt
	SlWyqgGxNr2CtW
X-Received: by 2002:a05:6000:26c4:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-45e5c5e1da2mr15644370f8f.42.1779003811985;
        Sun, 17 May 2026 00:43:31 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:31 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: leds: Document TI LM3533 LED controller
Date: Sun, 17 May 2026 10:43:01 +0300
Message-ID: <20260517074306.30937-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
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
---
 .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  66 ++++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 190 ++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
new file mode 100644
index 000000000000..866b0fb8ed04
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
@@ -0,0 +1,68 @@
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
index 000000000000..a582d7d2f955
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
@@ -0,0 +1,66 @@
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
+      maximum: 5
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
index 000000000000..2e200f172400
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
@@ -0,0 +1,190 @@
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
+  voltage control banks for individual LEDs. Additionally, LM3533 features an ALS
+  sensor support.
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
+      ti,resistor-ohm:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Internal configuration resister value when ALS is in Analog Sensor
+          mode and PWM mode is disabled.
+        minimum: 1575
+        maximum: 200000
+
+      ti,pwm-mode:
+        type: boolean
+        description:
+          Switch for mode in which ALS is running. If this property is set
+          then ALS is running in PWM mode, internal resistor value is set to
+          high-impedance (0) and ti,resistor-ohm property is ignored.
+
+    required:
+      - compatible
+
+    anyOf:
+      - required:
+          - ti,resistor-ohm
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
+  - light-sensor
+  - backlight@0
+  - backlight@1
+  - led@2
+  - led@3
+  - led@4
+  - led@5
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
+                led-sources = <0>;
+            };
+
+            backlight@1 {
+                compatible = "ti,lm3533-backlight";
+                reg = <1>;
+
+                default-brightness = <113>;
+
+                led-max-microamp = <23400>;
+                led-sources = <1>;
+            };
+
+            led@2 {
+                compatible = "ti,lm3533-leds";
+                reg = <2>;
+
+                led-max-microamp = <23400>;
+                led-sources = <0>;
+            };
+
+            led@3 {
+                compatible = "ti,lm3533-leds";
+                reg = <3>;
+
+                led-max-microamp = <23400>;
+                led-sources = <1>;
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

