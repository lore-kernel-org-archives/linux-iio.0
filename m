Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3A38F925;
	Fri, 15 May 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837402; cv=none; b=B9OSOAiA3M3sLeQGQBmcLHV7YjOHQgipab/zGUa+/5PW0RzYMtqDurXcAjuGn3YkJOVrgk5xvtRxfZzAhYUQSK4V/Ervky0zikI1Dgcg1OAOMohHXTjAnWVp4srbC+FC8Fq7MnygcFp50ND4KgwwHsayywfBytYDd0golRajBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837402; c=relaxed/simple;
	bh=OPKmCAPMJ7Oifes6noXEBJhoydezDZBQBd5mA5U2Kvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guQu4yK3Umr8LVCoOGuntRPAuTgGB6oqhsxieW4ncmOIq6E+V1UTlUzgrHM6voSftrU8JMaVQlBNsdExfPy/yWdSSk/8ktVQC9/SiVHQ2KXUB48a7Ow3FFW0yu9qwHLp8EtgoWZaOnHuE+JU3yKeUqiCW9RSoWogx6WPX9Fes3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iiNM/2sl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iiNM/2sl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778837401; x=1810373401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPKmCAPMJ7Oifes6noXEBJhoydezDZBQBd5mA5U2Kvc=;
  b=iiNM/2slCTokeHI99s0FN9HZbr8DnCzjoW/BvNSJcNwwCp+lYea5ZF2z
   TYl+NrpSOxHmvrAV//eEKFOmmCX+jBnmInhOsxqS9raDqZ25I0Xw5Lb0G
   bTPgiRaD13vc1pzgjWI0XJSN7IYHAyG+VmZCNNVh5hx9uMkRx5ereWzUw
   Mr+BcWUkWUwssQSCjsEBxpDJCVIeTScFkxMWCJwKchtxjne+7bhSU1FCd
   6TnJD3TAEtwyyIHQWnXeolXPOngGd/MJqvz3cDzOL03i7b6Z8zl2OE+Ha
   68wt8v27NblWktOC1B+78vpwAZkFaSOP9Spaxqm/Gz+ZbO8RaGf8Fagrv
   Q==;
X-CSE-ConnectionGUID: sjdS2eLzStWCAF3U+sAbMQ==
X-CSE-MsgGUID: BP5bujAQQL2JwhsMKV+Asw==
X-IronPort-AV: E=Sophos;i="6.23,236,1770620400"; 
   d="scan'208";a="57560893"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2026 02:30:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 15 May 2026 02:29:59 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 15 May 2026 02:29:57 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: add support for PAC1944
Date: Fri, 15 May 2026 12:29:45 +0300
Message-ID: <20260515092946.10791-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260515092946.10791-1-marius.cristea@microchip.com>
References: <20260515092946.10791-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for Microchip PAC194X
and PAC195X series of Power Monitors with Accumulator. The PAC194X
family supports 9V Full-Scale Range and the PAC195X supports 32V
Full-Scale Range.

There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
are for high-side current sensing and the PAC194X/5X-2 devices are
for low-side current sensing or floating VBUS applications.

The PAC194X/5X-1 is named shortly PAC194X/5X.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1944.yaml   | 315 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
new file mode 100644
index 000000000000..eca1b25f038b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
@@ -0,0 +1,315 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1944.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC194x and PAC195x Power Monitors with Accumulator
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with
+  Accumulator. The datasheet for PAC1941-1, PAC1941-2, PAC1942-1, PAC1942-2,
+  PAC1943-1 and PAC1944-1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
+  The datasheet for PAC1951-1, PAC1951-2, PAC1952-1, PAC1952-2, PAC1953-1 and
+  PAC1954-1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1941
+      - microchip,pac1941-2
+      - microchip,pac1942
+      - microchip,pac1942-2
+      - microchip,pac1943
+      - microchip,pac1944
+      - microchip,pac1951
+      - microchip,pac1951-2
+      - microchip,pac1952
+      - microchip,pac1952-2
+      - microchip,pac1953
+      - microchip,pac1954
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    items:
+      - description:
+          ALERT1 output. Asserted when a user-programmed over/under
+          voltage, current, or power limit routed to ALERT1 is exceeded.
+      - description:
+          ALERT2 output. Asserted when a user-programmed over/under
+          voltage, current, or power limit routed to ALERT2 is exceeded.
+    minItems: 1
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - const: alert1
+      - items:
+          - const: alert2
+      - items:
+          - const: alert1
+          - const: alert2
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      GPIO 0 corresponds to the SLOW/ALERT1/GPIO multi-function pin and GPIO 1
+      corresponds to the ALERT2/GPIO multi-function pin. The second cell takes
+      standard GPIO flags.
+
+  powerdown-gpios:
+    description: |
+      A GPIO used to trigger a change in sampling rate (lowering the chip
+      power consumption). Driving this GPIO low puts the device in Power-Down
+      state (all circuitry is powered down, including SMBus). It should be
+      marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  slow-gpios:
+    description: |
+      SLOW input pin. If this pin is forced high, the sampling rate is forced
+      to 8 SPS. When it is forced low, the sampling rate is 1024 SPS, unless
+      a different sample rate has been programmed. This pin is multi-function:
+      SLOW input, ALERT1 output, or general-purpose (open-drain) GPIO; when
+      used as slow-gpios the ALERT1 function is not available. It should be
+      marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+patternProperties:
+  "^channel@[1-4]$":
+    type: object
+    $ref: adc.yaml
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description:
+          Value in micro Ohms of the shunt resistor connected between
+          the SENSE+ and SENSE- inputs, across which the current is measured.
+          Value is needed to compute the scaling of the measured current.
+        minimum: 1
+
+      microchip,vbus-input-range-microvolt:
+        description: |
+          In order to increase measurement resolution while keeping the same
+          number of bits, the device has a configurable VBUS full-scale range
+          (FSR). The range should be set by hardware design and it should not
+          be changed during runtime. The bipolar capability for VBUS enables
+          accurate offset measurement and correction.
+          The VBUS could be configured into the following full-scale range:
+            - VBUS has unipolar 0V to 32V FSR (default) for PAC195X or 0V to 9V
+              (default) for PAC194X.
+            - VBUS has bipolar -32V to 32V FSR for PAC195X or -9V to 9V for
+              PAC194X. The actual range is limited to about -200 mV due to the
+              impact of the ESD structures.
+            - VBUS has bipolar -16V to 16V FSR for PAC195X or -4.5V to 4.5V for
+              PAC194X. The actual range is limited to about -200 mV due to the
+              impact of the ESD structures.
+
+      microchip,vsense-input-range-microvolt:
+        description: |
+          In order to decrease the power dissipation on the shunt resistor
+          and, at the same time, to increase measurement resolution while
+          keeping the same number of bits, the device has a configurable
+          VSENSE full-scale scale (FSR). The range should be set by hardware
+          design and it should not be changed during runtime.
+          The VSENSE could be configured into the following full-scale range:
+            - VSENSE has unipolar 0V to 100 mV FSR (default)
+            - VSENSE has bipolar -100 mV to 100 mV FSR
+            - VSENSE has bipolar -50 mV to 50 mV FSR
+        oneOf:
+          - items:
+              - const: 0
+              - const: 100000
+          - items:
+              - const: -50000
+              - const: 50000
+          - items:
+              - const: -100000
+              - const: 100000
+
+      microchip,accumulation-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The Hardware Accumulator may be used to accumulate VPOWER or VSENSE
+          values for any channel. By setting the accumulator for a channel
+          to accumulate the VPOWER values gives a measure of accumulated power
+          over a time period, which is equivalent to energy. Setting the
+          accumulator for a channel to accumulate VSENSE values gives a measure
+          of accumulated current, which is equivalent to charge. This allows the
+          accumulator to be used as a coulomb counter.
+          This functionality needs to be setup once and must not be changed
+          during the runtime, just in case the user wants to measure the charge
+          or the energy consumed from board power up till the user has control
+          or during a reboot of the system.
+          The Hardware Accumulator could be configured to accumulate VPOWER
+          or VSENSE
+            <0>  -  Accumulator accumulates VPOWER (default)
+            <1>  -  Accumulator accumulates VSENSE
+        enum: [0, 1]
+        default: 0
+
+    required:
+      - reg
+      - shunt-resistor-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac194"
+    then:
+      patternProperties:
+        "^channel@[1-4]$":
+          properties:
+            microchip,vbus-input-range-microvolt:
+              oneOf:
+                - items:
+                    - const: 0
+                    - const: 9000000
+                - items:
+                    - const: -9000000
+                    - const: 9000000
+                - items:
+                    - const: -4500000
+                    - const: 4500000
+              default: [0, 9000000]
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac195"
+    then:
+      patternProperties:
+        "^channel@[1-4]$":
+          properties:
+            microchip,vbus-input-range-microvolt:
+              oneOf:
+                - items:
+                    - const: 0
+                    - const: 32000000
+                - items:
+                    - const: -32000000
+                    - const: 32000000
+                - items:
+                    - const: -16000000
+                    - const: 16000000
+              default: [0, 32000000]
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac19[45]1(-2)?$"
+    then:
+      patternProperties:
+        "^channel@[2-4]$": false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac19[45]2(-2)?$"
+    then:
+      patternProperties:
+        "^channel@[3-4]$": false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac19[45]3(-2)?$"
+    then:
+      properties:
+        channel@4: false
+  - if:
+      required:
+        - slow-gpios
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          oneOf:
+            - items:
+                - const: alert2
+  - if:
+      properties:
+        interrupt-names:
+          contains:
+            const: alert1
+      required:
+        - interrupt-names
+    then:
+      properties:
+        slow-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@10 {
+            compatible = "microchip,pac1954";
+            reg = <0x10>;
+            vdd-supply = <&vdd>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <24900>;
+                label = "CPU";
+                microchip,vbus-input-range-microvolt = <0 32000000>;
+                microchip,vsense-input-range-microvolt = <(-50000) 50000>;
+            };
+
+            channel@3 {
+                reg = <0x3>;
+                shunt-resistor-micro-ohms = <75000>;
+                label = "MEM";
+                microchip,vbus-input-range-microvolt = <(-16000000) 16000000>;
+                microchip,vsense-input-range-microvolt = <0 100000>;
+            };
+
+            channel@4 {
+                reg = <0x4>;
+                shunt-resistor-micro-ohms = <100000>;
+                label = "NET";
+                microchip,vbus-input-range-microvolt = <(-32000000) 32000000>;
+                microchip,vsense-input-range-microvolt = <(-100000) 100000>;
+                microchip,accumulation-mode = <1>;
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 48fda1f8332e..a642d095ad34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17385,6 +17385,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 F:	drivers/iio/adc/pac1934.c
 
+MICROCHIP PAC1944 ADC DRIVER
+M:	Marius Cristea <marius.cristea@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
+
 MICROCHIP PCI1XXXX GP DRIVER
 M:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
 M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
-- 
2.51.0

