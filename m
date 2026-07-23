Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF81495524;
	Thu, 23 Jul 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814218; cv=none; b=g/aR0Dx0F1ojAADttsUHnfKhL+1xnpHdKshvi4Xt75gnHNO9qglLBiYBmc0WSHYNvEi40Hyum/k/Uw4HMwtpkWJ42g1d/b5bz2JgPkz5ovr8ho6WkiizsX1rLEsia5m4s1qv0dIAyei+jiazwWkL/0+5SRcP+OCTffYHZG7hGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814218; c=relaxed/simple;
	bh=2eCL6Ve56cznAUIZu21dq4yIYihvpuGC3XwDoU2PTtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KROeKqCi/iQJutolfWYYJ+OcFJBm5rCQHqMdhBGa0t/K9t8gw8FBg6tqrbl6us04uWFt32cq1G17mRZu66Te7xNiv2PHJV0ZZ9sly0C4GGbRwiP5m+5kQp2LMjCtPQLn8od2NrX1jEm8eQ9yRRDs2m3fWEqCnwy6+YqWzPVCjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DUbE88l2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DUbE88l2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784814215; x=1816350215;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2eCL6Ve56cznAUIZu21dq4yIYihvpuGC3XwDoU2PTtM=;
  b=DUbE88l28hINsaVTs/Qsl3Do1hUpI9gTggfAw6uRTwjQWBOYr/KvRPls
   0XWioHL7sLg01ko7eE0UcYH/iLwqvMlWR82HP5Y9US4A4Rz1gwH7fjS7U
   I8VlWCgW9iAEHd5AUjj7GIntL4zV4GgX2SJGJvDIsGlV6dxRlEveJaUdi
   aRrJcDQ3J/H5H1S/zBWCifxhJb1zKFxhPmXFmh//ZxaYYOijrGeCpePFw
   jdlTXm5AL/08ySBnACjLdNidKT5zDkzvdXJUrWAGtNl3fbzeO9ecGTCWQ
   cIlfSNi8jl2fFWib/qwT7Vea0aOPXdKfpNAlwat9hhPLyxt/EukHBFP2x
   Q==;
X-CSE-ConnectionGUID: 24N+Dl64Swqx6stchVBlxQ==
X-CSE-MsgGUID: IHmOjmcwQDa3LFkvItvOAA==
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="228212210"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:43:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 23 Jul 2026 06:43:22 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 23 Jul 2026 06:43:19 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 23 Jul 2026 16:43:11 +0300
Subject: [PATCH 2/3] dt-bindings: iio: dac: add support for MCP48FEB02 SPI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260723-mcp47feb02_refactor-v1-2-ee59e63672bc@microchip.com>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
In-Reply-To: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784814192; l=16363;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=2eCL6Ve56cznAUIZu21dq4yIYihvpuGC3XwDoU2PTtM=;
 b=z/2Bsx7YD2oTgMV8CvkhQJ+ObdCGCNnnG4epKv8MrixywHhoqA9ujMKP8TRM7buFo2DSDT+mB
 3eqeAWdMofZBkowc3PlFnFKVClHIqufGf3Chwm8JDrCj/r1cNfPNMVL
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add the SPI MCP48FxBy1/2/4/8 part numbers, the spi-max-frequency property
and a devicetree example for SPI usage to the existing binding.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 244 +++++++++++++++++----
 1 file changed, 197 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d131f136bd15161666932261bcacd6d124b23ede..d25c763241a4f4b147e690213a26efa06282c7c0 100644
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
+   Datasheet for MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
+   MCP47FEB22 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+   Datasheet for MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02, MCP47FVB12,
+   MCP47FVB22 can be found here:
+     https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+   Datasheet for MCP47FEB04, MCP47FEB14, MCP47FEB24, MCP47FEB08, MCP47FEB18,
+   MCP47FEB28, MCP47FVB04, MCP47FVB14, MCP47FVB24, MCP47FVB08, MCP47FVB18,
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
 
@@ -178,6 +239,13 @@ required:
   - vdd-supply
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "^microchip,mcp48f[ev]b[0-2][1248]$"
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -189,6 +257,12 @@ allOf:
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
@@ -211,6 +285,12 @@ allOf:
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
@@ -233,6 +313,12 @@ allOf:
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
@@ -251,6 +337,12 @@ allOf:
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
@@ -272,6 +364,39 @@ allOf:
       properties:
         microchip,vref1-buffered: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp47feb01
+              - microchip,mcp47feb02
+              - microchip,mcp47feb04
+              - microchip,mcp47feb08
+              - microchip,mcp47feb11
+              - microchip,mcp47feb12
+              - microchip,mcp47feb14
+              - microchip,mcp47feb18
+              - microchip,mcp47feb21
+              - microchip,mcp47feb22
+              - microchip,mcp47feb24
+              - microchip,mcp47feb28
+              - microchip,mcp47fvb01
+              - microchip,mcp47fvb02
+              - microchip,mcp47fvb04
+              - microchip,mcp47fvb08
+              - microchip,mcp47fvb11
+              - microchip,mcp47fvb12
+              - microchip,mcp47fvb14
+              - microchip,mcp47fvb18
+              - microchip,mcp47fvb21
+              - microchip,mcp47fvb22
+              - microchip,mcp47fvb24
+              - microchip,mcp47fvb28
+    then:
+      properties:
+        spi-max-frequency: false
+
 additionalProperties: false
 
 examples:
@@ -299,4 +424,29 @@ examples:
             };
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@60 {
+          compatible = "microchip,mcp48feb02";
+          reg = <0x60>;
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

