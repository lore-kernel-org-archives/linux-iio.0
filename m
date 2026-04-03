Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD65384252;
	Fri,  3 Apr 2026 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213455; cv=none; b=E7A1JPaRxRuTx9cLLMyiG0R0QUyYeAOTGRyPFfiVlcisJnln4rXclJBygKgIHlVSyxjQbocU1mqTeY6IGnWc4jk1wi1lKTak7R9Ocss8BWnRbpaF7ru5gSaPiqR4n1RnKLTAp21ID1LEM3hcBnqidqCSV9lfRO5aSCwAbHtsGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213455; c=relaxed/simple;
	bh=AiH/SG3mloiWc2yGy2juFYW+0HI26Ye9sN7thg3x+6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pG7FluPfAnL3EzCo7L2L9VhmAEHs+e534Xu9/ZMWXVOj/U5BX3R3/aVzzAIwu2piQuthCWBy9RNW/tRoszNnVG6EDCIxsA3KJAq/LCjusWQ8d7fTIA92rMFqENGTBCxETj9LA1V3m+ihA5/5MTtU/FeTJ5JL+xfHD/ZK2h833yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H7dWNaq4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H7dWNaq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775213452; x=1806749452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AiH/SG3mloiWc2yGy2juFYW+0HI26Ye9sN7thg3x+6U=;
  b=H7dWNaq47aAE/tzRBANP2xLsXPw1aUjhJCxeiOuRV1PdcGL6p2TlhkzX
   /16nVTOGOv/Y9RB0/0D4RZjLJmO1f6mAK0A6VGBlUzdTWZiFPPq6LmWdj
   MOk0abWheQfnaY8glDpjIxxciR8KOhagpo6J38D+HgM6+1s3NWD+Nrivl
   S5vhBkD0xVCO+kIRbI55Yf3YspG28VVECBpT8s4m+dA19muv1ZbdeTWgI
   QkUHeyjMarDcvq6CxDgsN1iIWDgw29KyzmPEMD9SnGjsG5rjuLIAoHnFl
   dFS944itS8Mwyi48If8U13NyXvUIeqacz/QycOMZ2493jVcS6IYCIbIvT
   Q==;
X-CSE-ConnectionGUID: sRw3xtFbQm2lIneyrptZQg==
X-CSE-MsgGUID: H8r/TftiSQmvnxzAJjvtng==
X-IronPort-AV: E=Sophos;i="6.23,157,1770620400"; 
   d="scan'208";a="63451604"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:50:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 3 Apr 2026 03:50:22 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 3 Apr 2026 03:50:20 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 3 Apr 2026 13:50:13 +0300
Subject: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02 to MCP47FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
In-Reply-To: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Conor Dooley
	<conor.dooley@microchip.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775213414; l=20442;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=AiH/SG3mloiWc2yGy2juFYW+0HI26Ye9sN7thg3x+6U=;
 b=WoR9MkKYZkjfBEgh2Sx+tk1Vb97C+DHLbjZKZqI8gS4guuOnyckx//YrREQs2igRyNRWP9U+r
 4nsA+aj2A+VDdEoiot5BYmoOtgxb+uVTzjm2u3RXXRLlqLl83XtmIly
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for iio driver for Microchip
MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
Converters with nonvolatile or volatile memory on top of MCP47FEB02.
The families support up to 8 output channels and have 8-bit, 10-bit or
12-bit resolution.

The I2C (MCP47F(E/V)BXX) and SPI (MCP48F(E/V)BXX) DAC families were merged
into the same dt-binding file.

Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip MCP47FEB02")
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Link: https://lore.kernel.org/all/20260216-shiny-itunes-00a31d1f4db7@spud/
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 291 +++++++++++++++------
 MAINTAINERS                                        |   1 -
 2 files changed, 217 insertions(+), 75 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d2466aa6bda2106a8b695347a0edf38462294d03..544755cb6334c311f38d156dcf4b4e6170c6e62d 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -4,90 +4,151 @@
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
     enum:
       - microchip,mcp47feb01
-      - microchip,mcp47feb11
-      - microchip,mcp47feb21
       - microchip,mcp47feb02
+      - microchip,mcp47feb04
+      - microchip,mcp47feb08
+      - microchip,mcp47feb11
       - microchip,mcp47feb12
+      - microchip,mcp47feb14
+      - microchip,mcp47feb18
+      - microchip,mcp47feb21
       - microchip,mcp47feb22
+      - microchip,mcp47feb24
+      - microchip,mcp47feb28
       - microchip,mcp47fvb01
-      - microchip,mcp47fvb11
-      - microchip,mcp47fvb21
       - microchip,mcp47fvb02
-      - microchip,mcp47fvb12
-      - microchip,mcp47fvb22
       - microchip,mcp47fvb04
-      - microchip,mcp47fvb14
-      - microchip,mcp47fvb24
       - microchip,mcp47fvb08
+      - microchip,mcp47fvb11
+      - microchip,mcp47fvb12
+      - microchip,mcp47fvb14
       - microchip,mcp47fvb18
+      - microchip,mcp47fvb21
+      - microchip,mcp47fvb22
+      - microchip,mcp47fvb24
       - microchip,mcp47fvb28
-      - microchip,mcp47feb04
-      - microchip,mcp47feb14
-      - microchip,mcp47feb24
-      - microchip,mcp47feb08
-      - microchip,mcp47feb18
-      - microchip,mcp47feb28
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
 
@@ -111,7 +172,7 @@ properties:
         - for single-channel device: Vout0;
         - for dual-channel device: Vout0, Vout1;
         - for quad-channel device: Vout0, Vout2;
-        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
+        - for octal-channel device: Vout0, Vout2, Vout4, Vout6;
 
   vref1-supply:
     description: |
@@ -141,7 +202,7 @@ properties:
     description:
       Enable buffering of the external Vref/Vref0 pin in cases where the
       external reference voltage does not have sufficient current capability in
-      order not to drop it’s voltage when connected to the internal resistor
+      order not to drop its voltage when connected to the internal resistor
       ladder circuit.
 
   microchip,vref1-buffered:
@@ -149,7 +210,7 @@ properties:
     description:
       Enable buffering of the external Vref1 pin in cases where the external
       reference voltage does not have sufficient current capability in order not
-      to drop it’s voltage when connected to the internal resistor ladder
+      to drop its voltage when connected to the internal resistor ladder
       circuit.
 
 patternProperties:
@@ -161,8 +222,7 @@ patternProperties:
     properties:
       reg:
         description: The channel number.
-        minItems: 1
-        maxItems: 8
+        maxItems: 1
 
       label:
         description: Unique name to identify which channel this is.
@@ -178,6 +238,13 @@ required:
   - vdd-supply
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "mcp48"
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -189,6 +256,12 @@ allOf:
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
@@ -211,6 +284,12 @@ allOf:
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
@@ -227,12 +306,18 @@ allOf:
         compatible:
           contains:
             enum:
-              - microchip,mcp47fvb04
-              - microchip,mcp47fvb14
-              - microchip,mcp47fvb24
               - microchip,mcp47feb04
               - microchip,mcp47feb14
               - microchip,mcp47feb24
+              - microchip,mcp47fvb04
+              - microchip,mcp47fvb14
+              - microchip,mcp47fvb24
+              - microchip,mcp48feb04
+              - microchip,mcp48feb14
+              - microchip,mcp48feb24
+              - microchip,mcp48fvb04
+              - microchip,mcp48fvb14
+              - microchip,mcp48fvb24
     then:
       patternProperties:
         "^channel@[0-3]$":
@@ -245,12 +330,12 @@ allOf:
         compatible:
           contains:
             enum:
-              - microchip,mcp47fvb08
-              - microchip,mcp47fvb18
-              - microchip,mcp47fvb28
               - microchip,mcp47feb08
               - microchip,mcp47feb18
               - microchip,mcp47feb28
+              - microchip,mcp48fvb08
+              - microchip,mcp48fvb18
+              - microchip,mcp48fvb28
     then:
       patternProperties:
         "^channel@[0-7]$":
@@ -272,7 +357,40 @@ allOf:
       properties:
         microchip,vref1-buffered: false
 
-additionalProperties: false
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
+unevaluatedProperties: false
 
 examples:
   - |
@@ -280,7 +398,7 @@ examples:
 
         #address-cells = <1>;
         #size-cells = <0>;
-        dac@0 {
+        dac@60 {
           compatible = "microchip,mcp47feb02";
           reg = <0>;
           vdd-supply = <&vdac_vdd>;
@@ -299,4 +417,29 @@ examples:
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
+          reg = <0>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d664add6d40891fb4a94dba34c58d401df81d657..5997cf04b0732beaf69ac78cb762c42c56e4fcd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15850,7 +15850,6 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
-F:	drivers/iio/dac/mcp47feb02.c
 
 MCP4821 DAC DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>

-- 
2.43.0

