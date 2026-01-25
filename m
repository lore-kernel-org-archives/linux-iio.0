Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCA324707
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355744; cv=none; b=CKCPc5/d2XsjSn38WWNieZwl/NjddgsiiAznUHdu6r9RemLdSOkHQLiKdvKWrN5SYMRhv6wE80z/sFfEs2lPzPCrWlj3dU7y7OK217yJXl2n0iMHQUz0AInt3OxWuk8yOYlmRp5NDJqPktyJUP06hTQQ79h3v5y/YB4aCVd+b/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355744; c=relaxed/simple;
	bh=wqWg7lGHql4NrKUKo63XZDMBk154NcJUP3KwEEnKR3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJYh/qmA+TjtOD5p5+UWTpD9TThTbhL7c9N1oKrvAjebf5+cBVCtnqDtbaXhpIEHJ3uIH0/eRnRkfmjof9AWteB4FzxCm41qGI2CBjJrl0s5ykjP8W/tXTVydN+PFIYrWHBNvzdoYV3j1FvxTwei/HNu6JdZQoqTjhqqv1JMvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McmqUzKh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McmqUzKh"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so5688120a12.3
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769355740; x=1769960540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SizrNCMj0rXj5dH31XiLWqtHZ0EndKNEJUxL43/ep/U=;
        b=McmqUzKh2d/qziDvXYdTDEPmiWPb+A2e1SgmtSRuYEFDJdTVZmE4BNLcXdGlSEFJ6q
         6R2tX1li3YF8f+qX7qWygsQGKIRQalG0VG4SQLqW5uHinZ+85U115ogQDBgLtW4lXS7C
         82r3Zt5QDPvdeNCwuMN9eF8vrGhRw3xlFvTm2PKRlaWY2JDyuA+jvkg58CLVeqxauu5s
         /lSv5txm/RZ/Crycna6BOSh9y2XkFvmTMwWxpZbmbAefEP1jpWqPGdQE/ApxKK8kIHkW
         jjEiedIWLDZgdNMu9q30cNCRiYG3vtTbTHgcp6bbwisigiN4CmIUXfyFbeoiyDeWWLqK
         h97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769355740; x=1769960540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SizrNCMj0rXj5dH31XiLWqtHZ0EndKNEJUxL43/ep/U=;
        b=eSd8WDXZxXaBFPKP7i2BdhSZt+7f059I7qVsL9wtbZri3z41jT4uptpr6etWpCZvwy
         7r0cCg0iAuojteaLev0V2L90EkCsz1y3bxlnqsR1ZD2OH5R37yMinT+ZQ1oEpE/uvWRG
         9WZsujPCb7KftolQ/l6nR2jJq9wRuPpC83TjVRT47BT1kHuT9GhIvS3ONSpRlfKu299D
         8lwcVbIULU2VzuQ1RC1dkMx6l8sV6pU2N3cPntVosgpb4Uo5XNRbvahRopq4qUEVEHOY
         8Ff+WYs+T5gb4GGO3IWil9kPWhlBaUYysqdhV990PYWE69BhtGRqJ47UVtCbr/bZQuva
         CTMQ==
X-Gm-Message-State: AOJu0YwASF+QjYinIcVj/427VT7AfUhqFm7JgYbalkxCn9qu6IpZ7iS3
	dH341IF3CcHJ3hJwvf2HJrHcbH2NpASYZ0EYRQ56G7UM0v5Av3VOJPf0u4AYIg==
X-Gm-Gg: AZuq6aK/lUokg9Rx9C6TZN3UFhi6YuDOTLXBeR+DGh4XMnm7qO/NeJuOL4XiDOn6mbc
	iqK9h9BPVmZQ2VX8zugLbRn1tEbtbWwCbjbvbkCEsYLvdpjZjP7tuGub0uUK8MuEUNoTrL+62BM
	1XiPT2qjsv2QOjXZIu1MGDZXLbo0T1RCoGO0k0OgieUFurdu0UCzZrmt+7F6rFLSqe9XlKPKAUz
	yLBCj82loPvkWP1vJ84535u3BWDCh6b7DCumeQrkYsL9jMCMfYyLjK4zAAySr2sAuSvErPNeJRd
	obF6tMBD3orbHAe3ieK84YCzvrvzPwXrKHY0tWKgRtsoSPPDppeBYC+os8zyRSAeP3aUdvHRW1Z
	5gHlVd+1UhtH++4bpufHNaAmR4XD3m7ZqPIl/2N3WYYYy6ImcsGZmaeOSfXj+QCiVVLLN4PAd9p
	og
X-Received: by 2002:a05:6000:186a:b0:435:729b:c390 with SMTP id ffacd0b85a97d-435ca39bb3fmr2499194f8f.47.1769348601406;
        Sun, 25 Jan 2026 05:43:21 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 08/10] dt-bindings: mfg: motorola-cpcap: convert to schema
Date: Sun, 25 Jan 2026 15:43:00 +0200
Message-ID: <20260125134302.45958-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML.
Audio codec bindings adjusted with common ports node for port@0 and
port@1. Added compatible for Mot board CPCAP. Other bindings remain the
same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/mfd/motorola,cpcap.yaml          | 389 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 2 files changed, 389 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
new file mode 100644
index 000000000000..f75f884c7b3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -0,0 +1,389 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/motorola,cpcap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC MFD
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap
+      - st,6556002
+      - motorola,mapphone-cpcap
+      - motorola,mot-cpcap
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  spi-max-frequency:
+    maximum: 8000000
+
+  spi-cs-high: true
+
+  adc:
+    $ref: /schemas/iio/adc/motorola,cpcap-adc.yaml
+
+  audio-codec:
+    type: object
+
+    properties:
+      interrupts:
+        items:
+          - description: headset detect interrupt
+          - description: microphone bias 2 detect interrupt
+
+      interrupt-names:
+        items:
+          - const: hs
+          - const: mb2
+
+      "#sound-dai-cells":
+        const: 1
+
+      ports:
+        $ref: /schemas/graph.yaml#/properties/ports
+        description: The audio-codec provides two DAIs. The first one is
+          connected to the Stereo HiFi DAC and the second one is connected
+          to the Voice DAC.
+
+    required:
+      - interrupts
+      - interrupt-names
+      - "#sound-dai-cells"
+
+  battery:
+    $ref: /schemas/power/supply/cpcap-battery.yaml
+
+  charger:
+    $ref: /schemas/power/supply/cpcap-charger.yaml
+
+  key-power:
+    $ref: /schemas/input/motorola,cpcap-pwrbutton.yaml
+
+  phy:
+    $ref: /schemas/phy/motorola,cpcap-usb-phy.yaml
+
+  regulator:
+    $ref: /schemas/regulator/motorola,cpcap-regulator.yaml
+
+  rtc:
+    $ref: /schemas/rtc/motorola,cpcap-rtc.yaml
+
+patternProperties:
+  "^led(-[a-z]+)?$":
+    $ref: /schemas/leds/motorola,cpcap-leds.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpcap: pmic@0 {
+            compatible = "motorola,cpcap";
+            reg = <0>; /* cs0 */
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            spi-max-frequency = <3000000>;
+            spi-cs-high;
+
+            cpcap_adc: adc {
+                compatible = "motorola,cpcap-adc";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <8 IRQ_TYPE_NONE>;
+                interrupt-names = "adcdone";
+
+                #io-channel-cells = <1>;
+            };
+
+            cpcap_audio: audio-codec {
+                interrupt-parent = <&cpcap>;
+                interrupts = <9 IRQ_TYPE_NONE>, <10 IRQ_TYPE_NONE>;
+                interrupt-names = "hs", "mb2";
+
+                #sound-dai-cells = <1>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    /* HiFi */
+                    port@0 {
+                        reg = <0>;
+                        cpcap_audio_codec0: endpoint {
+                        };
+                    };
+
+                    /* Voice */
+                    port@1 {
+                        reg = <1>;
+                        cpcap_audio_codec1: endpoint {
+                        };
+                    };
+                };
+            };
+
+            cpcap_battery: battery {
+                compatible = "motorola,cpcap-battery";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <6 IRQ_TYPE_NONE>, <5 IRQ_TYPE_NONE>,
+                             <3 IRQ_TYPE_NONE>, <20 IRQ_TYPE_NONE>,
+                             <54 IRQ_TYPE_NONE>, <57 IRQ_TYPE_NONE>;
+                interrupt-names = "eol", "lowbph", "lowbpl",
+                                  "chrgcurr1", "battdetb", "cccal";
+
+                io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+                              <&cpcap_adc 5>, <&cpcap_adc 6>;
+                io-channel-names = "battdetb", "battp",
+                                   "chg_isense", "batti";
+                power-supplies = <&cpcap_charger>;
+            };
+
+            cpcap_charger: charger {
+                compatible = "motorola,mapphone-cpcap-charger";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <13 IRQ_TYPE_NONE>, <12 IRQ_TYPE_NONE>,
+                             <29 IRQ_TYPE_NONE>, <28 IRQ_TYPE_NONE>,
+                             <22 IRQ_TYPE_NONE>, <21 IRQ_TYPE_NONE>,
+                             <20 IRQ_TYPE_NONE>, <19 IRQ_TYPE_NONE>,
+                             <54 IRQ_TYPE_NONE>;
+                interrupt-names = "chrg_det", "rvrs_chrg", "chrg_se1b",
+                                  "se0conn", "rvrs_mode", "chrgcurr2",
+                                  "chrgcurr1", "vbusvld", "battdetb";
+
+                mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>,
+                             <&gpio3 23 GPIO_ACTIVE_LOW>;
+
+                io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+                              <&cpcap_adc 2>, <&cpcap_adc 5>,
+                              <&cpcap_adc 6>;
+                io-channel-names = "battdetb", "battp",
+                                   "vbus", "chg_isense",
+                                   "batti";
+            };
+
+            key-power {
+                compatible = "motorola,cpcap-pwrbutton";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <23 IRQ_TYPE_NONE>;
+            };
+
+            led-red {
+                compatible = "motorola,cpcap-led-red";
+                vdd-supply = <&vdd_led>;
+                label = "status-led::red";
+            };
+
+            led-green {
+                compatible = "motorola,cpcap-led-green";
+                vdd-supply = <&vdd_led>;
+                label = "status-led::green";
+            };
+
+            led-blue {
+                compatible = "motorola,cpcap-led-blue";
+                vdd-supply = <&vdd_led>;
+                label = "status-led::blue";
+            };
+
+            cpcap_usb2_phy: phy {
+                compatible = "motorola,mapphone-cpcap-usb-phy";
+
+                pinctrl-0 = <&usb_gpio_mux_sel1>, <&usb_gpio_mux_sel2>;
+                pinctrl-1 = <&usb_ulpi_pins>;
+                pinctrl-2 = <&usb_utmi_pins>;
+                pinctrl-3 = <&uart3_pins>;
+                pinctrl-names = "default", "ulpi", "utmi", "uart";
+                #phy-cells = <0>;
+
+                interrupts-extended =
+                    <&cpcap 15 IRQ_TYPE_NONE>, <&cpcap 14 IRQ_TYPE_NONE>,
+                    <&cpcap 28 IRQ_TYPE_NONE>, <&cpcap 19 IRQ_TYPE_NONE>,
+                    <&cpcap 18 IRQ_TYPE_NONE>, <&cpcap 17 IRQ_TYPE_NONE>,
+                    <&cpcap 16 IRQ_TYPE_NONE>, <&cpcap 49 IRQ_TYPE_NONE>,
+                    <&cpcap 48 IRQ_TYPE_NONE>;
+                interrupt-names = "id_ground", "id_float", "se0conn",
+                                  "vbusvld", "sessvld", "sessend",
+                                  "se1", "dm", "dp";
+
+                mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,
+                             <&gpio1 0 GPIO_ACTIVE_HIGH>;
+
+                io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
+                io-channel-names = "vbus", "id";
+
+                vusb-supply = <&avdd_usb>;
+            };
+
+            regulator {
+                compatible = "motorola,cpcap-regulator";
+
+                regulators {
+                    vdd_cpu: SW1 {
+                        regulator-name = "vdd_cpu";
+                        regulator-min-microvolt = <750000>;
+                        regulator-max-microvolt = <1125000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_core: SW2 {
+                        regulator-name = "vdd_core";
+                        regulator-min-microvolt = <950000>;
+                        regulator-max-microvolt = <1300000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_1v8_vio: SW3 {
+                        regulator-name = "vdd_1v8_vio";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <1800000>;
+                        regulator-enable-ramp-delay = <0>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_aon: SW4 {
+                        regulator-name = "vdd_aon";
+                        regulator-min-microvolt = <950000>;
+                        regulator-max-microvolt = <1300000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_led: SW5 {
+                        regulator-name = "vdd_led";
+                        regulator-min-microvolt = <5050000>;
+                        regulator-max-microvolt = <5050000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-boot-on;
+                    };
+
+                    vdd_hvio: VHVIO {
+                        regulator-name = "vdd_hvio";
+                        regulator-min-microvolt = <2775000>;
+                        regulator-max-microvolt = <2775000>;
+                        regulator-enable-ramp-delay = <1000>;
+                    };
+
+                    vcore_emmc: VSDIO {
+                        regulator-name = "vcore_emmc";
+                        regulator-min-microvolt = <1500000>;
+                        regulator-max-microvolt = <3000000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    avdd_dsi_csi: VCSI {
+                        regulator-name = "avdd_dsi_csi";
+                        regulator-min-microvolt = <1200000>;
+                        regulator-max-microvolt = <1200000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-boot-on;
+                    };
+
+                    avdd_3v3_periph: VWLAN2 {
+                        regulator-name = "avdd_3v3_periph";
+                        regulator-min-microvolt = <2775000>;
+                        regulator-max-microvolt = <3300000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-boot-on;
+                    };
+
+                    vddio_usd: VSIMCARD {
+                        regulator-name = "vddio_usd";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <2900000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-boot-on;
+                    };
+
+                    vdd_haptic: VVIB {
+                        regulator-name = "vdd_haptic";
+                        regulator-min-microvolt = <1300000>;
+                        regulator-max-microvolt = <3000000>;
+                        regulator-enable-ramp-delay = <1000>;
+                    };
+
+                    avdd_usb: VUSB {
+                        regulator-name = "avdd_usb";
+                        regulator-min-microvolt = <3300000>;
+                        regulator-max-microvolt = <3300000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    VAUDIO {
+                        regulator-name = "vdd_audio";
+                        regulator-min-microvolt = <2775000>;
+                        regulator-max-microvolt = <2775000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+                };
+            };
+
+            cpcap_rtc: rtc {
+                compatible = "motorola,cpcap-rtc";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
deleted file mode 100644
index 18c3fc26ca93..000000000000
--- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-Motorola CPCAP PMIC device tree binding
-
-Required properties:
-- compatible		: One or both of "motorola,cpcap" or "ste,6556002"
-- reg			: SPI chip select
-- interrupts		: The interrupt line the device is connected to
-- interrupt-controller	: Marks the device node as an interrupt controller
-- #interrupt-cells	: The number of cells to describe an IRQ, should be 2
-- #address-cells	: Child device offset number of cells, should be 1
-- #size-cells		: Child device size number of cells, should be 0
-- spi-max-frequency	: Typically set to 3000000
-- spi-cs-high		: SPI chip select direction
-
-Optional subnodes:
-
-The sub-functions of CPCAP get their own node with their own compatible values,
-which are described in the following files:
-
-- Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
-- Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
-- Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
-- Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
-- Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
-- Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
-- Documentation/devicetree/bindings/leds/leds-cpcap.txt
-- Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
-
-The only exception is the audio codec. Instead of a compatible value its
-node must be named "audio-codec".
-
-Required properties for the audio-codec subnode:
-
-- #sound-dai-cells = <1>;
-- interrupts		: should contain jack detection interrupts, with headset
-			  detect interrupt matching "hs" and microphone bias 2
-			  detect interrupt matching "mb2" in interrupt-names.
-- interrupt-names	: Contains "hs", "mb2"
-
-The audio-codec provides two DAIs. The first one is connected to the
-Stereo HiFi DAC and the second one is connected to the Voice DAC.
-
-Example:
-
-&mcspi1 {
-	cpcap: pmic@0 {
-		compatible = "motorola,cpcap", "ste,6556002";
-		reg = <0>;	/* cs0 */
-		interrupt-parent = <&gpio1>;
-		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		spi-max-frequency = <3000000>;
-		spi-cs-high;
-
-		audio-codec {
-			#sound-dai-cells = <1>;
-			interrupts-extended = <&cpcap 9 0>, <&cpcap 10 0>;
-			interrupt-names = "hs", "mb2";
-
-			/* HiFi */
-			port@0 {
-				endpoint {
-					remote-endpoint = <&cpu_dai1>;
-				};
-			};
-
-			/* Voice */
-			port@1 {
-				endpoint {
-					remote-endpoint = <&cpu_dai2>;
-				};
-			};
-		};
-	};
-};
-
-- 
2.51.0

