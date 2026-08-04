Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC23C5522;
	Tue,  4 Aug 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850205; cv=none; b=VHBr0Df9iH9twltGTkTdtAxejaUgvxiIteZolNXKGMwRNk6Or3nTa39LXG1z8+X6Sdnwn2gMa6qI1wPkdgQ90X6OpGv0Y/gwnbUkL0abuq9iRec1x6Ubmo38qkbdHM3lStmdnQb4T6UtPtvlWkCI/QlRhF/7RD0C/SvbbgcfBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850205; c=relaxed/simple;
	bh=IrGSUsaEQh7cM2Tk8OzYgRRqqEJozsZMFWYurO4B/MY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mTz4FdHVud+DgfmMB//gnXL3kuHmQRg+uDwhMSdSWeIIB6SUz+4NV26TxCyVEZChmWJg2MhL9JlStZe+YMKU10jy3zivjP7Igtf8H/WGwOZHveifLtAF+yYX3XyykOn1cuKr/TzUxIf3cHwlgnnUcP4gbYs4ZUVMzn/D2s7G634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z7gywPMh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z7gywPMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785850203; x=1817386203;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IrGSUsaEQh7cM2Tk8OzYgRRqqEJozsZMFWYurO4B/MY=;
  b=Z7gywPMho4c9he9hVlAgywz70JSgcF/owM2aQP88miU5Q9FF7PXjpJeS
   nFuQ9CWpxiIUbr5h1gNRipyWaEn0XVxLPcMmDN59g7FHXQlN57tbwKvHI
   i2u9Muz3eM+wmiM6nssl66igN+/p46ZRY3TOpkTPBIF1H+As8S+eToPUp
   An2rBgRPbCv470HqJHT3Fp2kfud97TpbP3yLD9Ar72bqI70/Ik5h3a9KL
   5Gmhx9skDKOOq3gFFkpJ/WxTDc83cbFRIToLBfBMjWU+bR8pSqQijgP+b
   bIY61YIen09MJSfekPEbK99apb49tpUbGgm4tIFLvSV2rPbG1zwXArNK1
   g==;
X-CSE-ConnectionGUID: fQKmqtbBQHmSFLb2qRznkg==
X-CSE-MsgGUID: UTCervoYQMOyRntO9T2+Xg==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="292999134"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 06:30:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 06:30:01 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Aug 2026 06:29:59 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 4 Aug 2026 16:29:48 +0300
Subject: [PATCH v3 2/3] dt-bindings: iio: dac: add support for MCP48FEB02
 SPI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-mcp47feb02_refactor-v3-2-97f8b81f3628@microchip.com>
References: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com>
In-Reply-To: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785850193; l=15506;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=IrGSUsaEQh7cM2Tk8OzYgRRqqEJozsZMFWYurO4B/MY=;
 b=3kaYARB8aGcSiw/6bs0zeT/EiXWSmsz4rGIw7tEU00LwPt/KIRe85MDKW68/+EpH3buNKSmsS
 EjSAfbTSeoDBU78iMpLdZLNRipHnP0wBl1vHfolCIZOr30q/oViRkcQ
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add the SPI MCP48FxBy1/2/4/8 part numbers, the spi-max-frequency property
and a devicetree example for SPI usage to the existing binding.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 ++++++++++++++++-----
 1 file changed, 173 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d131f136bd15161666932261bcacd6d124b23ede..a86d094f0d4b54f9d9cc39fd54222f5968714668 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -4,58 +4,92 @@
 $id: http://devicetree.org/schemas/iio/dac/microchip,mcp47feb02.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip MCP47F(E/V)B(0/1/2)(1/2/4/8) DAC with I2C Interface Families
+title: Microchip MCP4(7/8)F(E/V)B(0/1/2)(1/2/4/8) DAC with I2C/SPI Interface Families
 
 maintainers:
   - Ariana Lazar <ariana.lazar@microchip.com>
 
 description: |
-  Datasheet for MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
-  MCP47FEB22 can be found here:
-    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
-  Datasheet for MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02, MCP47FVB12,
-  MCP47FVB22 can be found here:
-    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
-  Datasheet for MCP47FEB04, MCP47FEB14, MCP47FEB24, MCP47FEB08, MCP47FEB18,
-  MCP47FEB28, MCP47FVB04, MCP47FVB14, MCP47FVB24, MCP47FVB08, MCP47FVB18,
-  MCP47FVB28 can be found here:
-    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
-
-  +------------+--------------+-------------+-------------+------------+
-  | Device     |  Resolution  |   Channels  | Vref number | Memory     |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FEB01 |     8-bit    |      1      |      1      |   EEPROM   |
-  | MCP47FEB11 |    10-bit    |      1      |      1      |   EEPROM   |
-  | MCP47FEB21 |    12-bit    |      1      |      1      |   EEPROM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FEB02 |     8-bit    |      2      |      1      |   EEPROM   |
-  | MCP47FEB12 |    10-bit    |      2      |      1      |   EEPROM   |
-  | MCP47FEB22 |    12-bit    |      2      |      1      |   EEPROM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FVB01 |     8-bit    |      1      |      1      |      RAM   |
-  | MCP47FVB11 |    10-bit    |      1      |      1      |      RAM   |
-  | MCP47FVB21 |    12-bit    |      1      |      1      |      RAM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FVB02 |     8-bit    |      2      |      1      |      RAM   |
-  | MCP47FVB12 |    10-bit    |      2      |      1      |      RAM   |
-  | MCP47FVB22 |    12-bit    |      2      |      1      |      RAM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FVB04 |     8-bit    |      4      |      2      |      RAM   |
-  | MCP47FVB14 |    10-bit    |      4      |      2      |      RAM   |
-  | MCP47FVB24 |    12-bit    |      4      |      2      |      RAM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FVB08 |     8-bit    |      8      |      2      |      RAM   |
-  | MCP47FVB18 |    10-bit    |      8      |      2      |      RAM   |
-  | MCP47FVB28 |    12-bit    |      8      |      2      |      RAM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FEB04 |     8-bit    |      4      |      2      |   EEPROM   |
-  | MCP47FEB14 |    10-bit    |      4      |      2      |   EEPROM   |
-  | MCP47FEB24 |    12-bit    |      4      |      2      |   EEPROM   |
-  |------------|--------------|-------------|-------------|------------|
-  | MCP47FEB08 |     8-bit    |      8      |      2      |   EEPROM   |
-  | MCP47FEB18 |    10-bit    |      8      |      2      |   EEPROM   |
-  | MCP47FEB28 |    12-bit    |      8      |      2      |   EEPROM   |
-  +------------+--------------+-------------+-------------+------------+
+  Datasheets for MCP47F(E/V)B(0/1/2)(1/2/4/8) DAC with I2C Interface Families:
+   Datasheet for MCP47FEB01, MCP47FEB02, MCP47FEB11, MCP47FEB12, MCP47FEB21,
+   MCP47FEB22 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+   Datasheet for MCP47FVB01, MCP47FVB02, MCP47FVB11, MCP47FVB12, MCP47FVB21,
+   MCP47FVB22 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+   Datasheet for MCP47FEB04, MCP47FEB08, MCP47FEB14, MCP47FEB18, MCP47FEB24,
+   MCP47FEB28, MCP47FVB04, MCP47FVB08, MCP47FVB14, MCP47FVB18, MCP47FVB24,
+   MCP47FVB28 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
+   Datasheets for MCP48F(E/V)B(0/1/2)(1/2/4/8) DAC with SPI Interface Families:
+   Datasheet for MCP48FEB01, MCP48FEB02, MCP48FEB11, MCP48FEB12, MCP48FEB21,
+   MCP48FEB22 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005429B.pdf
+   Datasheet for MCP48FVB01, MCP48FVB02, MCP48FVB11, MCP48FVB12, MCP48FVB21,
+   MCP48FVB22 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005466A.pdf
+   Datasheet for MCP48FEB04, MCP48FEB14, MCP48FEB24, MCP48FEB08, MCP48FEB18,
+   MCP48FEB28, MCP48FVB04, MCP48FVB14, MCP48FVB24, MCP48FVB08, MCP48FVB18,
+   MCP48FVB28 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP48FXBX4-8-Family-Data-Sheet-DS20006362A.pdf
+
+  +------------+--------------+-------------+-------------+------------+------------+
+  | Device     |  Resolution  |   Channels  | Vref number |   Memory   | Interface  |
+  |------------|--------------|-------------|-------------|------------|------------|
+  | MCP47FEB01 |              |      1      |      1      |   EEPROM   |    I2C     |
+  | MCP47FEB02 |              |      2      |      1      |   EEPROM   |    I2C     |
+  | MCP47FEB04 |              |      4      |      2      |   EEPROM   |    I2C     |
+  | MCP47FEB08 |     8-bit    |      8      |      2      |   EEPROM   |    I2C     |
+  | MCP48FEB01 |              |      1      |      1      |   EEPROM   |    SPI     |
+  | MCP48FEB02 |              |      2      |      1      |   EEPROM   |    SPI     |
+  | MCP48FEB04 |              |      4      |      2      |   EEPROM   |    SPI     |
+  | MCP48FEB08 |              |      8      |      2      |   EEPROM   |    SPI     |
+  |------------|--------------|-------------|-------------|------------|------------|
+  | MCP47FEB11 |              |      1      |      1      |   EEPROM   |    I2C     |
+  | MCP47FEB12 |              |      2      |      1      |   EEPROM   |    I2C     |
+  | MCP47FEB14 |              |      4      |      2      |   EEPROM   |    I2C     |
+  | MCP47FEB18 |    10-bit    |      8      |      2      |   EEPROM   |    I2C     |
+  | MCP48FEB11 |              |      1      |      1      |   EEPROM   |    SPI     |
+  | MCP48FEB12 |              |      2      |      1      |   EEPROM   |    SPI     |
+  | MCP48FEB14 |              |      4      |      2      |   EEPROM   |    SPI     |
+  | MCP48FEB18 |              |      8      |      2      |   EEPROM   |    SPI     |
+  |------------|--------------|-------------|-------------|------------|------------|
+  | MCP47FEB21 |              |      1      |      1      |   EEPROM   |    I2C     |
+  | MCP47FEB22 |              |      2      |      1      |   EEPROM   |    I2C     |
+  | MCP47FEB24 |              |      4      |      2      |   EEPROM   |    I2C     |
+  | MCP47FEB28 |    12-bit    |      8      |      2      |   EEPROM   |    I2C     |
+  | MCP48FEB21 |              |      1      |      1      |   EEPROM   |    SPI     |
+  | MCP48FEB22 |              |      2      |      1      |   EEPROM   |    SPI     |
+  | MCP48FEB24 |              |      4      |      2      |   EEPROM   |    SPI     |
+  | MCP48FEB28 |              |      8      |      2      |   EEPROM   |    SPI     |
+  |------------|--------------|-------------|-------------|------------|------------|
+  | MCP47FVB01 |              |      1      |      1      |   RAM      |    I2C     |
+  | MCP47FVB02 |              |      2      |      1      |   RAM      |    I2C     |
+  | MCP47FVB04 |              |      4      |      2      |   RAM      |    I2C     |
+  | MCP47FVB08 |     8-bit    |      8      |      2      |   RAM      |    I2C     |
+  | MCP48FVB01 |              |      1      |      1      |   RAM      |    SPI     |
+  | MCP48FVB02 |              |      2      |      1      |   RAM      |    SPI     |
+  | MCP48FVB04 |              |      4      |      2      |   RAM      |    SPI     |
+  | MCP48FVB08 |              |      8      |      2      |   RAM      |    SPI     |
+  |------------|--------------|-------------|-------------|------------|------------|
+  | MCP47FVB11 |              |      1      |      1      |   RAM      |    I2C     |
+  | MCP47FVB12 |              |      2      |      1      |   RAM      |    I2C     |
+  | MCP47FVB14 |              |      4      |      2      |   RAM      |    I2C     |
+  | MCP47FVB18 |    10-bit    |      8      |      2      |   RAM      |    I2C     |
+  | MCP48FVB11 |              |      1      |      1      |   RAM      |    SPI     |
+  | MCP48FVB12 |              |      2      |      1      |   RAM      |    SPI     |
+  | MCP48FVB14 |              |      4      |      2      |   RAM      |    SPI     |
+  | MCP48FVB18 |              |      8      |      2      |   RAM      |    SPI     |
+  |------------|--------------|-------------|-------------|------------|------------|
+  | MCP47FVB21 |              |      1      |      1      |   RAM      |    I2C     |
+  | MCP47FVB22 |              |      2      |      1      |   RAM      |    I2C     |
+  | MCP47FVB24 |              |      4      |      2      |   RAM      |    I2C     |
+  | MCP47FVB28 |    12-bit    |      8      |      2      |   RAM      |    I2C     |
+  | MCP48FVB21 |              |      1      |      1      |   RAM      |    SPI     |
+  | MCP48FVB22 |              |      2      |      1      |   RAM      |    SPI     |
+  | MCP48FVB24 |              |      4      |      2      |   RAM      |    SPI     |
+  | MCP48FVB28 |              |      8      |      2      |   RAM      |    SPI     |
+  +------------+--------------+-------------+-------------+------------+------------+
 
 properties:
   compatible:
@@ -84,10 +118,37 @@ properties:
       - microchip,mcp47feb08
       - microchip,mcp47feb18
       - microchip,mcp47feb28
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
 
   reg:
     maxItems: 1
 
+  spi-max-frequency:
+    maximum: 10000000
+
   "#address-cells":
     const: 1
 
@@ -178,6 +239,21 @@ required:
   - vdd-supply
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "^microchip,mcp48f[ev]b[0-2][1248]$"
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+      dependencies:
+        spi-cpha: [ spi-cpol ]
+        spi-cpol: [ spi-cpha ]
+    else:
+      properties:
+        spi-max-frequency: false
+        spi-cpha: false
+        spi-cpol: false
   - if:
       properties:
         compatible:
@@ -189,6 +265,12 @@ allOf:
               - microchip,mcp47fvb01
               - microchip,mcp47fvb11
               - microchip,mcp47fvb21
+              - microchip,mcp48feb01
+              - microchip,mcp48feb11
+              - microchip,mcp48feb21
+              - microchip,mcp48fvb01
+              - microchip,mcp48fvb11
+              - microchip,mcp48fvb21
     then:
       properties:
         lat1-gpios: false
@@ -211,6 +293,12 @@ allOf:
               - microchip,mcp47fvb02
               - microchip,mcp47fvb12
               - microchip,mcp47fvb22
+              - microchip,mcp48feb02
+              - microchip,mcp48feb12
+              - microchip,mcp48feb22
+              - microchip,mcp48fvb02
+              - microchip,mcp48fvb12
+              - microchip,mcp48fvb22
     then:
       properties:
         lat1-gpios: false
@@ -233,6 +321,12 @@ allOf:
               - microchip,mcp47feb04
               - microchip,mcp47feb14
               - microchip,mcp47feb24
+              - microchip,mcp48feb04
+              - microchip,mcp48feb14
+              - microchip,mcp48feb24
+              - microchip,mcp48fvb04
+              - microchip,mcp48fvb14
+              - microchip,mcp48fvb24
     then:
       patternProperties:
         "^channel@[0-3]$":
@@ -251,6 +345,12 @@ allOf:
               - microchip,mcp47feb08
               - microchip,mcp47feb18
               - microchip,mcp47feb28
+              - microchip,mcp48feb08
+              - microchip,mcp48feb18
+              - microchip,mcp48feb28
+              - microchip,mcp48fvb08
+              - microchip,mcp48fvb18
+              - microchip,mcp48fvb28
     then:
       patternProperties:
         "^channel@[0-7]$":
@@ -272,7 +372,7 @@ allOf:
       properties:
         microchip,vref1-buffered: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -299,4 +399,29 @@ examples:
             };
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+          compatible = "microchip,mcp48feb02";
+          reg = <0x0>;
+          vdd-supply = <&vdac_vdd>;
+          vref-supply = <&vref_reg>;
+          spi-max-frequency = <10000000>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+          channel@0 {
+            reg = <0>;
+            label = "Adjustable_voltage_ch0";
+          };
+
+          channel@1 {
+            reg = <0x1>;
+            label = "Adjustable_voltage_ch1";
+          };
+        };
+    };
 ...

-- 
2.43.0

