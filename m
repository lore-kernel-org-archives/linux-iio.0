Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8035B13D;
	Thu, 12 Feb 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900610; cv=none; b=R+34ujRZHaAmXmVHtfLJF9wYwirhFpCeeNV9M7vxRy4c8ywA2pjW4xYVDW8HasXmjALvGSwqxNh/6I2UkkP6dC71niHU0qLXrKGyn7cFdjyaKv9oDUuS9VVp+8FcUzLqiY0ry1hd4e15ha9bx6/hyAb+40aai6DhUK/sjYW0ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900610; c=relaxed/simple;
	bh=y8/2LMQknpXUPApu2sSJXjFMN1uVTnwP6RbYK9VaXTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JtXpRJlQxWreWov7U191YVAMPqjJ6NOo6ssbxZ03VEd9OxfvZZQ50asDyanwEh9sd0dlDdkFvQSGcKErM3X8vfRu7WB8Q8PVGh2wNnOtn8Nv9GXeAr254b+porXA8CChUFKWL1l1txKygNiSAT+wa63N7wyUTTC+WKT7eKOsWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PVEfUi2q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PVEfUi2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1770900609; x=1802436609;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=y8/2LMQknpXUPApu2sSJXjFMN1uVTnwP6RbYK9VaXTk=;
  b=PVEfUi2qYAImNHb3ITpVjZ5xqrkrwW0uOxCSdZJTV4AyxWifdCBIWyn+
   iaQ4itbM0wU8WhVmEernLFOnS6DywceJfH5ys84JQarqFnjLPFTbpwMGz
   J1CFwYGl8y/s8VZZ1xI2T7suGnkzhnAtMeZuwTe2WxBerNVGTmT5D4ZIG
   e8T3oN/sE24+ukgmoTq9QjSvnYvQ4/s4NjfgL/sOEu2/n+ARBr6XLuItd
   WJr551V/01T19AnQ3AmLx7HvKwqSyRrFbVs2IYnXqPL8VSQsRkOOpCj2p
   RV4p6VUacGk0MOqfrpT1DovCBT8Mc4E6jUGuWnWcASH5hYkhqcq5q9SyI
   w==;
X-CSE-ConnectionGUID: N3asO01KQNe+aWoU2cBmgg==
X-CSE-MsgGUID: hbzv1aGGQk+EMSfhHWvL+w==
X-IronPort-AV: E=Sophos;i="6.21,286,1763449200"; 
   d="scan'208";a="53739859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:50:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 05:49:07 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 12 Feb 2026 05:49:05 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 12 Feb 2026 14:48:34 +0200
Subject: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
In-Reply-To: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770900543; l=12142;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=y8/2LMQknpXUPApu2sSJXjFMN1uVTnwP6RbYK9VaXTk=;
 b=+wcEir+7Siwls6v1Eelr/v+T54nKAAchgy9P0Qe6LsuRkSNOAD2SoQqL7Q68t0S0BdKIT4nj6
 r+zfC8OXAwECt7HfFTpsWFf3cKoa1VbFODTrQZvU8lz7HYRb0j0WTJA
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for iio driver for Microchip
MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
Converters with nonvolatile or volatile memory and an SPI Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp48feb02.yaml     | 299 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 305 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..78c6bd641c6e37321e4fc056db83eb4277f429b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml
@@ -0,0 +1,299 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp48feb02.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP48F(E/V)B(0/1/2)(1/2/4/8) DAC with SPI Interface Families
+
+maintainers:
+  - Ariana Lazar <ariana.lazar@microchip.com>
+
+description: |
+  Datasheet for MCP48FEB01, MCP48FEB02, MCP48FEB11, MCP48FEB12, MCP48FEB21,
+  MCP48FEB22 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005429B.pdf
+  Datasheet for MCP48FVB01, MCP48FVB02, MCP48FVB11, MCP48FVB12, MCP48FVB21,
+  MCP48FVB22 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005466A.pdf
+  Datasheet for MCP48FEB04, MCP48FEB14, MCP48FEB24, MCP48FEB08, MCP48FEB18,
+  MCP48FEB28, MCP48FVB04, MCP48FVB14, MCP48FVB24, MCP48FVB08, MCP48FVB18,
+  MCP48FVB28 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP48FXBX4-8-Family-Data-Sheet-DS20006362A.pdf
+
+  +------------+--------------+-------------+-------------+------------+
+  | Device     |  Resolution  |   Channels  | Vref number | Memory     |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP48FEB01 |              |      1      |      1      |   EEPROM   |
+  | MCP48FEB02 |     8-bit    |      2      |      1      |   EEPROM   |
+  | MCP48FEB04 |              |      4      |      2      |   EEPROM   |
+  | MCP48FEB08 |              |      8      |      2      |   EEPROM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP48FEB11 |              |      1      |      1      |   EEPROM   |
+  | MCP48FEB12 |    10-bit    |      2      |      1      |   EEPROM   |
+  | MCP48FEB14 |              |      4      |      2      |   EEPROM   |
+  | MCP48FEB18 |              |      8      |      2      |   EEPROM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP48FEB21 |              |      1      |      1      |   EEPROM   |
+  | MCP48FEB22 |    12-bit    |      2      |      1      |   EEPROM   |
+  | MCP48FEB24 |              |      4      |      2      |   EEPROM   |
+  | MCP48FEB28 |              |      8      |      2      |   EEPROM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP48FVB01 |              |      1      |      1      |   RAM      |
+  | MCP48FVB02 |     8-bit    |      2      |      1      |   RAM      |
+  | MCP48FVB04 |              |      4      |      2      |   RAM      |
+  | MCP48FVB08 |              |      8      |      2      |   RAM      |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP48FVB11 |              |      1      |      1      |   RAM      |
+  | MCP48FVB12 |    10-bit    |      2      |      1      |   RAM      |
+  | MCP48FVB14 |              |      4      |      2      |   RAM      |
+  | MCP48FVB18 |              |      8      |      2      |   RAM      |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP48FVB21 |              |      1      |      1      |   RAM      |
+  | MCP48FVB22 |    12-bit    |      2      |      1      |   RAM      |
+  | MCP48FVB24 |              |      4      |      2      |   RAM      |
+  | MCP48FVB28 |              |      8      |      2      |   RAM      |
+  +------------+--------------+-------------+-------------+------------+
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp48feb01
+      - microchip,mcp48feb02
+      - microchip,mcp48feb04
+      - microchip,mcp48feb08
+      - microchip,mcp48feb11
+      - microchip,mcp48feb12
+      - microchip,mcp48feb14
+      - microchip,mcp48feb18
+      - microchip,mcp48feb21
+      - microchip,mcp48feb22
+      - microchip,mcp48feb24
+      - microchip,mcp48feb28
+      - microchip,mcp48fvb01
+      - microchip,mcp48fvb02
+      - microchip,mcp48fvb04
+      - microchip,mcp48fvb08
+      - microchip,mcp48fvb11
+      - microchip,mcp48fvb12
+      - microchip,mcp48fvb14
+      - microchip,mcp48fvb18
+      - microchip,mcp48fvb21
+      - microchip,mcp48fvb22
+      - microchip,mcp48fvb24
+      - microchip,mcp48fvb28
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  vdd-supply:
+    description:
+      Provides power to the chip and it could be used as reference voltage. The
+      voltage is used to calculate scale. For parts without EEPROM at powerup
+      this will be the selected as voltage reference.
+
+  vref-supply:
+    description: |
+      Vref pin (it could be found as Vref0 into the datasheet) may be used as a
+      voltage reference when this supply is specified. The internal reference
+      will be taken into account for voltage reference besides VDD if this supply
+      does not exist.
+
+      This supply will be voltage reference for the following outputs:
+        - for single-channel device: Vout0;
+        - for dual-channel device: Vout0, Vout1;
+        - for quad-channel device: Vout0, Vout2;
+        - for octal-channel device: Vout0, Vout2, Vout4, Vout6;
+
+  vref1-supply:
+    description: |
+      Vref1 pin may be used as a voltage reference when this supply is specified.
+      The internal reference will be taken into account for voltage reference
+      beside VDD if this supply does not exist.
+
+      This supply will be voltage reference for the following outputs:
+        - for quad-channel device: Vout1, Vout3;
+        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
+
+  lat-gpios:
+    description:
+      LAT pin to be used as a hardware trigger to synchronously update the DAC
+      channels. The pin is active Low. It could be also found as LAT0 in
+      datasheet.
+    maxItems: 1
+
+  lat1-gpios:
+    description:
+      LAT1 pin to be used as a hardware trigger to synchronously update the odd
+      DAC channels on devices with 4 and 8 channels. The pin is active Low.
+    maxItems: 1
+
+  microchip,vref-buffered:
+    type: boolean
+    description:
+      Enable buffering of the external Vref/Vref0 pin in cases where the
+      external reference voltage does not have sufficient current capability in
+      order not to drop its voltage when connected to the internal resistor
+      ladder circuit.
+
+  microchip,vref1-buffered:
+    type: boolean
+    description:
+      Enable buffering of the external Vref1 pin in cases where the external
+      reference voltage does not have sufficient current capability in order not
+      to drop its voltage when connected to the internal resistor ladder
+      circuit.
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: dac.yaml
+    type: object
+    description: Voltage output channel.
+
+    properties:
+      reg:
+        description: The channel number.
+        maxItems: 1
+
+      label:
+        description: Unique name to identify which channel this is.
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp48feb01
+              - microchip,mcp48feb11
+              - microchip,mcp48feb21
+              - microchip,mcp48fvb01
+              - microchip,mcp48fvb11
+              - microchip,mcp48fvb21
+    then:
+      properties:
+        lat1-gpios: false
+        vref1-supply: false
+        microchip,vref1-buffered: false
+        channel@0:
+          properties:
+            reg:
+              const: 0
+      patternProperties:
+        "^channel@[1-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp48feb02
+              - microchip,mcp48feb12
+              - microchip,mcp48feb22
+              - microchip,mcp48fvb02
+              - microchip,mcp48fvb12
+              - microchip,mcp48fvb22
+    then:
+      properties:
+        lat1-gpios: false
+        vref1-supply: false
+        microchip,vref1-buffered: false
+      patternProperties:
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              enum: [0, 1]
+        "^channel@[2-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp48fvb04
+              - microchip,mcp48fvb14
+              - microchip,mcp48fvb24
+              - microchip,mcp48feb04
+              - microchip,mcp48feb14
+              - microchip,mcp48feb24
+    then:
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              enum: [0, 1, 2, 3]
+        "^channel@[4-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp48fvb08
+              - microchip,mcp48fvb18
+              - microchip,mcp48fvb28
+              - microchip,mcp48feb08
+              - microchip,mcp48feb18
+              - microchip,mcp48feb28
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              enum: [0, 1, 2, 3, 4, 5, 6, 7]
+  - if:
+      not:
+        required:
+          - vref-supply
+    then:
+      properties:
+        microchip,vref-buffered: false
+  - if:
+      not:
+        required:
+          - vref1-supply
+    then:
+      properties:
+        microchip,vref1-buffered: false
+
+additionalProperties: false
+
+examples:
+    - |
+      spi {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          dac@0 {
+            compatible = "microchip,mcp48feb08";
+            reg = <0>;
+            vdd-supply = <&vdac_vdd>;
+            vref-supply = <&vref_reg>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+              reg = <0>;
+              label = "Adjustable_voltage_ch0";
+            };
+
+            channel@1 {
+              reg = <0x1>;
+              label = "Adjustable_voltage_ch1";
+            };
+          };
+      };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..ed24fd2758ad0103dbc5191d0ec180f8ee5e8298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14945,6 +14945,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
 F:	drivers/iio/dac/mcp4821.c
 
+MCP48FEB02 MICROCHIP DAC DRIVER
+M:	Ariana Lazar <ariana.lazar@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml
+
 MCR20A IEEE-802.15.4 RADIO DRIVER
 M:	Stefan Schmidt <stefan@datenfreihafen.org>
 L:	linux-wpan@vger.kernel.org

-- 
2.43.0

