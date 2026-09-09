Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBE576ED8;
	Wed,  9 Sep 2026 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963561; cv=none; b=KOGi/Ehb2sPUy++rZKKgfJZNZTQszxgAK7229Eye/QxO2y7H+jsxqoI5YWXfARDGz56otUUe7Q14gouDVPifm1/KtU1HgPtRrRR0Lby5sCoc7eMevIHIiz2OFnEdyGJcqeoFIitZZb9QPLfVqr2md4TIb2IfAfN2C6OsC3eq8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963561; c=relaxed/simple;
	bh=acUL/CcC7KE1IDiRXLEfBcTJXBXILIApK2E6Dz8MP1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lavTws5T6F5cPEqlgjKj6rBkGNlUPeZAkhUOeRyYowxYRCt3+X7SGz+6asxuENKgXV7QSx1HrR6h3VR+YSY83ODqMCSLZCp1eCEBp/OWMxfll8U5k0Q8uzyXJzckTkzAe2dvxYNrAiRyLwwKNUFmLI8ekQaY7XAh7nKJDdugA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qNF30iut; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qNF30iut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963559; x=1820499559;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=acUL/CcC7KE1IDiRXLEfBcTJXBXILIApK2E6Dz8MP1c=;
  b=qNF30iutMsWKhQLYE2GZ4jMFZclYBLet13u3ZxZ7Z8tdZch2uYxCa6q+
   ofanNJb3d1UNMkMSpAZRJBRTQdwDc523b0bw9amnV3Oi62nhusPi/Jdwb
   o/a/sdWiMByfiIUjbm5n+6fK+MQQbttu+bkxaIYD0HnJN2g9B0jF06QKV
   fNQomIp38iqD0ganwrxJsXtWwWah/ClAm6deEvkluKzRgqqLtnMmHmUfF
   PwC7c2Xudqz941AQc4Boa8kVznsEw+VMdBQDqq1WFBUW8lX7HVxV8S3Vv
   JgAyXUUNubL8DPhIi0IOJXte1mP7NWBR9x9gnDmX1gxWodIzXniPxuG44
   Q==;
X-CSE-ConnectionGUID: fkgjmZFaTC6q1/lL6hTtFg==
X-CSE-MsgGUID: 9r+VTsdQRtWLJG916+lvAw==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294764013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:19:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 07:19:18 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:19:16 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:52 +0300
Subject: [PATCH v5 09/10] dt-bindings: iio: dac: add support for MCP48FEB02
 SPI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-9-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=15556;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=acUL/CcC7KE1IDiRXLEfBcTJXBXILIApK2E6Dz8MP1c=;
 b=xhlvG75CSN4C2phq6yYEPdQRbZ4r2HxqFHnncK7S76g40EfMtts6Kl9Kx8RhLwCFEdYPoJqMW
 l4jif/rgYquBYKIFst6OwrIW3iQDb+T3JT/EnWINOhEGzRe2Ey0rTpk
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add the SPI MCP48FxBy1/2/4/8 part numbers, the spi-max-frequency property
and a devicetree example for SPI usage to the existing binding.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

