Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716683;
	b=gwyYlG1If/uBJm+yTMwk8gMnR1h97eQnSRhh0PS+1xDl7ycD4YD7RZ7yWrj124rTqQDj
	 BFlckJCwsEqaKOMTz+4mNvBMMpQlVRlzm4gIo3WYlHSJzTKD9kKmjUShMuhDh1i0ni+C6
	 /1Bnwete2rxCAIvl2bbSuKmXmU2V5kAM37JmzIfnjcGl2sTORiMuaKzdUOA5GD/TTun8E
	 1V68oihhmp68FMDjxJNsL6CmvHfZ35CoS+P6hqEm846V4cpuJtFW/haPx7tPUpF1ALrxq
	 sh+dK4CqRLoU8BYuTqw3xPm4RBYkOjP+EJhKDeHlVuBPLHGH/qCDjYPG7BUERM1loXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716683;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=leHzs4RreBeMv0JjRDW/2jJpJ3s6XFiVTM1A5UvDtmc=;
	b=1BYCC6sL3MBG7Y1xHhSe7W7snsFQUGVqQmPyyVyxsbQgrO+khvCUGv3SrS+h8adNiQ1k
	 yw03gpdFN+lRE1SxbNRweBb7DpDaO9CMA0G/hjR+W643IhuutAGLRWlxfTHZ6kwVF4sDU
	 NbaVk9p4/jueNFIgAdE9c2m7ZdblP6H7eXjI72Yby8FPRndft671hTdhyXJamb3HtANol
	 EVoB/v/X6nvQL6nYSD6HGndUdgpNuHW/plO6wC4HZGWyzy5HsMJpg3RhJS1fbertpQFdv
	 1AkrV4NqjisCrn7c0dHgSlwUdmciQTH7OUO27AT9RB/41xdSa3zSMpBj/z1BFiem10g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=zfwonjgP;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD765606A326;
	Tue,  3 Nov 2026 14:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD765606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=zfwonjgP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793716682; x=1825252682;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DUxQaNWfjyy4GHOs35JjJYUnwSXjtV8jv+KkuiKQfDI=;
  b=zfwonjgPHjOKOXBzJHfjXZQ/GWwqjbMcqrODg6N8UBuDKyInCMskaqUq
   Z+AL0Go764myN7VbHW85vgHLq0C3JQJOx9dtJq76hwqHOPj+7SIOPL8+A
   VWugyyYC9D42ofqCmWcxEmoHVRn88TOxCRb1V9EqdycUKgx57r200iKNY
   Y8TdIdosJcHK3IKJuM4+JnqoWulQiAetLfTL/qQTPjNmxoETlya1oj9cv
   TtSKq9fZHTscOyFXTjOLCs3vXnbDtq92vHcoTMHnjyMIqYfWj/ETYKhhu
   UpjLjOcz5NpENhpNkSkCyZKyOQBbomaQvDKFmAx++ssR5OuvUYcztNy6L
   g==;
X-CSE-ConnectionGUID: YHmEmCZxTAqDgubKT1Zd1w==
X-CSE-MsgGUID: s+4QE1N9Q5C4vvjKAAjeHA==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="76535174"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2026 07:38:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Nov 2026 07:38:01 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Nov 2026 07:37:58 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 3 Nov 2026 16:37:14 +0200
Subject: [PATCH v5 4/5] dt-bindings: iio: adc: add support for PAC1711
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-pac1711-v5-4-71c20101a52e@microchip.com>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
In-Reply-To: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Marius Cristea <marius.cristea@microchip.com>,
	Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793716664; l=8814;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=DUxQaNWfjyy4GHOs35JjJYUnwSXjtV8jv+KkuiKQfDI=;
 b=F678N2edFa8rBFOa3sb/ivgnmtJruGpyLYeTRQuUMjMkGxl/0HCgGCWPE6sYp1aqKXewCKEP/
 8LZ0TCdiDLUC/2E0qNhKMbtQPR1k28qE7tkoPFMIDg0MMyHdXbrJ4tL
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

The accumulation-source property aims to specify what kind of hardware is
intended to be used/available for the user. There are two main cases here:
- the user wants to measure also the current/power consumed before the
driver insertion (e.g. from the boot to user control) and if this is a
runtime setting, the hardware accumulator will be reset by the default
configuration the driver starts with.
- the driver does not know what type of hardware it's dealing with. In
case the part is monitoring the charge/discharge current it does not
make sense in user-space to change the accumulator to calculate energy.
Same if the hardware is intended to calculate energy it does not make
sense in user-space to change to Coulomb counter. Changing the setting
from one mode to another will reset the hardware accumulator inside the
chip.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/adc/microchip,pac1711.yaml        | 169 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 175 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1ddf8a485c9c3e56dc96f82394c137259e00f541
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
@@ -0,0 +1,169 @@
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
index 3a19da74d00c9dfb48e900df71a86d4686d3ec2c..ebba9b0b3f834576b422b96283f9a3cc79405c3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17889,6 +17889,12 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
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

