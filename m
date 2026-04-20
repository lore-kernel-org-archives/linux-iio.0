Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9834EF05;
	Mon, 20 Apr 2026 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681389; cv=none; b=KkX1HyZy/fpARK2ou7JD4FvawlEnxYdfYgGk6cuteRyQfjM2+MSRHltaEslT7P8pSpDXsYLso94KhPQ5elE+cyD1R9Yo+kKRhDrzExdRNq/mE34kBtco6k6OJXbbL4V7u1UF1aDdCC/8fQidZ4xvEenYYfov9h6FuB3dEexd2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681389; c=relaxed/simple;
	bh=g6Y+HIa3KaZNj3kLoIRibO0OlbChMFZy7ytAPOtqlS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QVj2H3h9+48G82SlFP1OJzUW89hqKZnCd8gHTwpEey7EWsaegQwe1hqcXNb0/VUEOPX2jJlSxv/jlXKRDAsOWdA7kw0Mc6/jBwyt4YEIK6DeHxXGXiSjm4XSFdOrqP7yDmOGAaWMwvgCWxhDR9h9w7zrYsvcuau7vdZNsUwKd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aXvzQQok; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aXvzQQok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776681388; x=1808217388;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=g6Y+HIa3KaZNj3kLoIRibO0OlbChMFZy7ytAPOtqlS4=;
  b=aXvzQQokpPZuTs5WxXzu+UoradC4vJtYzlufJyEa0r8nPLCRh2aFNzoV
   4mlPLFOXzqfJGLaLtTeelTspoZIl26JrVYR0iTFFgoI7jJn9bLLgb7EjW
   XRzjmw4Ivid4h4EgIZzHvbSVZOZ+Jyvabqiz3iF+NoYmhMU8gY6kT6eki
   zriNpoWMpjmZJXU/WdaCI5u4JXcHTCxYdAwPgcX2v9v6vvUwKL34821dR
   Yjias3UjxzeG8MN+CQK4By+iugdS/kruudq6KgLlWvvrKqjQSKa9O/OaD
   thp5U+6tWu9k4+tJ4ZHm8Vi+Guy6NhBwJnipdxyn8/ByuDw0ndOmUOAcA
   A==;
X-CSE-ConnectionGUID: 1knUbxXNTDGosyOaqf7Urw==
X-CSE-MsgGUID: DDnIxAZuSECxbItLRy5xpg==
X-IronPort-AV: E=Sophos;i="6.23,189,1770620400"; 
   d="scan'208";a="55582303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 03:36:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 20 Apr 2026 03:36:09 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 20 Apr 2026 03:36:06 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 20 Apr 2026 13:36:02 +0300
Subject: [PATCH] dt-bindings: iio: dac: mcp47feb02: Fix I2C address in
 example
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260420-mcp47feb02-fix6-v1-1-ae1808fea11d@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJEB5mkC/x2MQQqAIBAAvyJ7TjAxrb4SHTLX2kMlChGEf2/pO
 AMzLxTMhAVG8ULGmwpdJ0PbCFj35dxQUmAGrbRVpnXyWJNxEb3SMtJjpQ/WDib0xnUKuEoZ2f/
 Haa71A/H8lgdhAAAA
X-Change-ID: 20260417-mcp47feb02-fix6-bd6694d84750
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776681365; l=2125;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=g6Y+HIa3KaZNj3kLoIRibO0OlbChMFZy7ytAPOtqlS4=;
 b=ZipeLF7+YzlPBaL0cSxnq7tkjTa/i4h6iL/Lt/eTM5FUr9Frq3cdiIy9zwjgRkzNcqFhulS3M
 o+/yXSAe3dlBFYhFlD4cI0nJUSCY1dsBK0lF2AcS6noMC4hqLeE6xRo
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Change example reg value from 0 to 0x60 in order to use a valid I2C address

Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip MCP47FEB02")
Link: https://lore.kernel.org/all/dd0dbadb-604b-4f12-8674-268b7db096fd@baylibre.com/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d2466aa6bda2106a8b695347a0edf38462294d03..95ddc8321eff34ed27dab8ce712210d2cb9ae785 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -280,23 +280,23 @@ examples:
 
         #address-cells = <1>;
         #size-cells = <0>;
-        dac@0 {
-          compatible = "microchip,mcp47feb02";
-          reg = <0>;
-          vdd-supply = <&vdac_vdd>;
-          vref-supply = <&vref_reg>;
+        dac@60 {
+            compatible = "microchip,mcp47feb02";
+            reg = <0x60>;
+            vdd-supply = <&vdac_vdd>;
+            vref-supply = <&vref_reg>;
 
-          #address-cells = <1>;
-          #size-cells = <0>;
-          channel@0 {
-            reg = <0>;
-            label = "Adjustable_voltage_ch0";
-          };
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                label = "Adjustable_voltage_ch0";
+            };
 
-          channel@1 {
-            reg = <0x1>;
-            label = "Adjustable_voltage_ch1";
-          };
-      };
+            channel@1 {
+                reg = <0x1>;
+                label = "Adjustable_voltage_ch1";
+            };
+        };
     };
 ...

---
base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
change-id: 20260417-mcp47feb02-fix6-bd6694d84750

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

