Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACC54DAEF;
	Wed,  9 Sep 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956629; cv=none; b=ta22AMUm1xE25pXr9MGhsGBJq/HYhZfTCu1wT+mh8wieNjkz+dsUqYxnIDCu29fv42NO3l48Yc4b4C2iTcDjxqDGm+TUNKwkH0hcjiXJ2c2hRh7Nx+WhgR9LjOgekpWu0WTRl+dZ2UHv5TOL4C/rrYbJae/iYBWyyraXxPr8bLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956629; c=relaxed/simple;
	bh=Z1hodFjkwo706DlbzsfQGq1Fv/O7E3+lpisnjegX+1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Nf+HIX92VUl1Qy721PjB0WQeuc6T33uQ7I/l3MEhrs2i0MHYiJzzSkjl8aDJJF4SXzRWIR0NwEQrQUEO8qvcXQ1HpGvetUo34zeds08sQpvntq3LHIt+PVM6mfphWWiLYr1dfrX8ERH6Yzc5kHyVhAomtLB7k0XoQcJ1Pf2DiYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pjQy1qfE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pjQy1qfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788956631; x=1820492631;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Z1hodFjkwo706DlbzsfQGq1Fv/O7E3+lpisnjegX+1g=;
  b=pjQy1qfEbwFODK6FMLuw8DIbwHxOVaajdux0zgpqRFf4rYoBadffjiaC
   Mv0B1CGzdi0AZ3yczpRta3lnLPbi7qQfahYjJr0ukaTfBlENhzoJnuSxM
   wtGaCKv7LXloM6Eb8DrTt6DX2PS0KutK1eoynGFcrO6b+tmJU5AHYZw4U
   W8f2g0qiFFVtlfnHVkFdQx/t9dbGwETAyhf/in5sAGnm/9lszSpc2uDNZ
   DUawJoZvWP3BWM4pt8ZjtwM4P48jaHxv8niuBxrK0CvnbmIxBk7ucwfL7
   FkGr4EHb3hCaEy6puPN+GGxCbLzd/IF+sht3g7683T3Uci5F31ed5qequ
   w==;
X-CSE-ConnectionGUID: Hnzo4HVmT5CwU0eOcjjmgA==
X-CSE-MsgGUID: uca0rH1fQYWBHTVesc8C5Q==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294758083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 05:23:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 05:23:41 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 05:23:38 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 15:23:34 +0300
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add support for PAC1711
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-pac1711-v3-1-dff81003b82f@microchip.com>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
In-Reply-To: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788956615; l=8844;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=Z1hodFjkwo706DlbzsfQGq1Fv/O7E3+lpisnjegX+1g=;
 b=S/TAHiZG6PWWxESAqe92MffnT3A18ofEnMgfbvQiHmKrAPavlTRser/0ClsLTSSR/iFRDX4mp
 OFXpETbw0SfCQgMZkH/3T6GxL9AmgJzpWnfKVROs7ex9eXatzB74zia
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for Microchip PAC1711, PAC1721, PAC1811 and
PAC1821 single-channel power monitor with accumulator. The PAC1711 and
PAC1721 devices use 12-bit resolution for voltage and current measurements
and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
resolution and use 32 bits for power calculations. The 56-bit accumulator
register accumulates power (energy) or current (Coulomb counter).

PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
PAC1721 and PAC1821.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1711.yaml        | 183 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 189 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..c10b4b83a08d690b8045a3f42d4e43d17a8058d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
@@ -0,0 +1,183 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1711.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1711 Power Monitors with Accumulator
+
+maintainers:
+  - Ariana Lazar <ariana.lazar@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with Accumulator.
+  Datasheet links:
+  [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
+  [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator-DS20007088.pdf
+  [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
+  [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
+
+  PAC1711, PAC1721, PAC1811 and PAC1821 are Single Channel Power Monitors
+  with Accumulator, having 12-bit or 16-bit resolution. The devices PAC1711
+  and PAC1811 can measure up to 42V Full-Scale Range, respectively 9V
+  Full-Scale Range for PAC1721 and PAC1821.
+
+  The accumulation-source property aims to specify what kind of hardware is
+  intended to be used/available for the user. There are two main cases here:
+    - the user wants to measure also the current/power consumed before the
+      driver insertion (e.g. from the boot to user control) and if this is a
+      runtime setting, the hardware accumulator will be reset by the default
+      configuration the driver starts with.
+    - the driver does not know what type of hardware it's dealing with. In
+      case the part is monitoring the charge/discharge current it does not
+      make sense in user-space to change the accumulator to calculate energy.
+      Same if the hardware is intended to calculate energy it does not make
+      sense in user-space to change to Coulomb counter. Changing the setting
+      from one mode to another will reset the hardware accumulator inside the
+      chip.
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1711
+      - microchip,pac1721
+      - microchip,pac1811
+      - microchip,pac1821
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value in micro Ohms of the shunt resistor connected between the VSENSE+
+      and VSENSE- inputs, across which the current is measured. This value is
+      needed to compute the scaling of the measured current.
+
+  label:
+    description: Unique name to identify which device this is.
+
+  microchip,vbus-input-range-microvolt:
+    description: |
+      Specifies the voltage range in microvolts chosen for the voltage full
+      scale range (FSR). The range should be set as <minimum, maximum> by
+      hardware design and should not be changed during runtime.
+
+      The VBUS could be configured into the following full scale range:
+        - for PAC1711 or PAC1811:
+            - VBUS has unipolar 0V to 42V FSR (default)
+            - VBUS has bipolar -42V to 42V FSR
+            - VBUS has bipolar -21V to 21V FSR
+        - for PAC1721 or PAC1821:
+            - VBUS has unipolar 0V to 9V FSR (default)
+            - VBUS has bipolar -9V to 9V FSR
+            - VBUS has bipolar -4.5V to 4.5V FSR
+
+  microchip,vsense-input-range-microvolt:
+    description: |
+      Specifies the voltage range in microvolts chosen for the current full
+      scale range (FSR). The current is calculated by dividing the vsense
+      voltage by the value of the shunt resistor. The range should be set as
+      <minimum, maximum> by hardware design and it should not be changed
+      during runtime.
+
+      The VSENSE could be configured into the following full scale range:
+        - VSENSE has unipolar 0 mV to 100 mV FSR (default)
+        - VSENSE has bipolar -100 mV to 100 mV FSR
+        - VSENSE has bipolar -50 mV to 50 mV FSR
+    oneOf:
+      - items:
+          - const: 0
+          - const: 100000
+      - items:
+          - const: -100000
+          - const: 100000
+      - items:
+          - const: -50000
+          - const: 50000
+
+  microchip,accumulation-source:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      The Hardware Accumulator may be used to accumulate VPOWER or VSENSE values
+      for any channel. By setting the accumulator for a channel to accumulate
+      the VPOWER values gives a measure of accumulated power over a time period,
+      which is equivalent to energy. Setting the accumulator for a channel to
+      accumulate VSENSE values gives a measure of accumulated current, which is
+      equivalent to charge.
+
+      The Hardware Accumulator could be configured as:
+       "energy" - Accumulator accumulates VPOWER (energy)
+       "charge" - Accumulator accumulates VSENSE (Coulomb Counter)
+    enum: [energy, charge]
+    default: energy
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - shunt-resistor-micro-ohms
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac1[78]11$"
+    then:
+      properties:
+        microchip,vbus-input-range-microvolt:
+          oneOf:
+            - items:
+                - const: 0
+                - const: 42000000
+            - items:
+                - const: -42000000
+                - const: 42000000
+            - items:
+                - const: -21000000
+                - const: 21000000
+          default: [0, 42000000]
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac1[78]21$"
+    then:
+      properties:
+        microchip,vbus-input-range-microvolt:
+          oneOf:
+            - items:
+                - const: 0
+                - const: 9000000
+            - items:
+                - const: -9000000
+                - const: 9000000
+            - items:
+                - const: -4500000
+                - const: 4500000
+          default: [0, 9000000]
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@40 {
+            compatible = "microchip,pac1711";
+            reg = <0x40>;
+
+            shunt-resistor-micro-ohms = <11000000>;
+            label = "VDD3V3";
+            vdd-supply = <&vdd>;
+            microchip,vbus-input-range-microvolt = <(-21000000) 21000000>;
+            microchip,vsense-input-range-microvolt = <(-50000) 50000>;
+            microchip,accumulation-source = "energy";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..399da37f79fd9768f29cc60aa5384a1ba9fe8afc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16337,6 +16337,12 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
+MICROCHIP PAC1711 POWER/CURRENT MONITOR DRIVER
+M:	Ariana Lazar <ariana.lazar@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
+
 MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
 M:	Matteo Martelli <matteomartelli3@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

