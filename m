Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7344915B5;
	Wed,  7 Oct 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384131; cv=none; b=e64lY3l+l9V0A/ojOCo3Ik2yRZEsnlCmLr+FXzYN5WNHV6w9I+JvKruJHwKavW5HkQyJk6+nE2iNqv59IvUHMAsrozHm+P4Jquv4lRnMVNysZVWMHEaS6bgETiaAuW3hGFBQXq5BOjaij7OI64Yu71OqsesSYoH+ikMaZ0EW1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384131; c=relaxed/simple;
	bh=qy0O1V/c54IYPpLrejYBsuD7Bssg3FW8fMFLCwBm84k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hVao1p3Rms1l2ml6T/Y/9itVJubrXXODkVLks4pAkzYWZAoZ0BSGohtDlfmKX1d3vFLE93+t7MM1htFkZFW1cuS5LU2v6OdHE8zQuJoy38GleFUiPRma/19lQo2fVWmK9G/VR7US6NfejgGzhiDiz/GYV0CrcEL7Lzc8bb53TR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hKoW06N/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hKoW06N/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791384124; x=1822920124;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qy0O1V/c54IYPpLrejYBsuD7Bssg3FW8fMFLCwBm84k=;
  b=hKoW06N/6OAQTlfjlL2AWW4mCMirWh7Pd5KXCo8XuqSr+0aDGjmVZzLi
   PRPrGEW4I/go8SKddtpI3aPo8AIjkHBMGUyCU7EIaKzc8RnWvRmfUNaBx
   FbI5S0ubU5+bOK+w3jMTZ02qMY3/kCmGRUbfg+A32eUlteAYmUBtX2X4V
   JJ4kd9COmuV9zW2fM62ahdel5NbS0QBuj03vwyCSCiJXM8rRp4aStUJBV
   tzy2Eo3BaeJmR1P63DoVartXWFm+bET6M/fxbHcgTrUX80kNyvfn/ffEr
   GFLeTUorjKwlCgTpBZmfS+wkA0m/9/XCl+rUwAOdnxVHwdaZTrhNZjZe7
   A==;
X-CSE-ConnectionGUID: tykTdmmxQ6CGiH4gRytUQQ==
X-CSE-MsgGUID: R9dQ9T7cTpa1zClG9BSvkg==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="74989023"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 07:42:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 7 Oct 2026 07:42:03 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 7 Oct 2026 07:42:00 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 7 Oct 2026 17:41:54 +0300
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: add support for PAC1711
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-pac1711-v4-2-6ef34d7a7947@microchip.com>
References: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
In-Reply-To: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791384113; l=8764;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=qy0O1V/c54IYPpLrejYBsuD7Bssg3FW8fMFLCwBm84k=;
 b=nwE/sm9XS27jTXW9OH5dj1uqrJdpAZm4dQCRAGj0ALR0svXXp7xDsmPSHd7aW/w8dGL5uUzTa
 F+gAnj3RBSWBtMB/w9BDDINROc2p5TW6h9q7At7ZO+Na/xopLX7ebtU
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

