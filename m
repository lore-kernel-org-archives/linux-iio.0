Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FA23E33D;
	Wed, 22 Apr 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865258; cv=none; b=EjOQM2Iu6H2mwvtmtQNk933nhEDIb7ia4uNmc23lHb99XbkpXDCdMwT+8MesNdkrtAP86JdT+xzGXiGgQqE3RjXpxDpYNBKCRa8Hj6J1zG4LfOHhspP23VPYymEaYLJqY3iJZRfXkHJKGXlW0GBVGe5/JoaVITIgngJgbgYQfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865258; c=relaxed/simple;
	bh=iv8NQZu8jNVkAJbPXfcqwXfyHsB60Q0RjPt2lXfIB8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sqLdNrNgdoaMVj7j+aBJEeiFpnrH9MlOtLtnPR6eBJ0850v+hBg+cQoef9oMLnIJ720MWi38u6OOR8JvSHywIkfBDPVwYKIyuci0n5GwDhnslFM/xEawq+hdIdRseU+DxwpZ+0gZ0CFXiLr5vO3pKoHZVbmQzLEzgHxA+dXkyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d3fQdrxS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d3fQdrxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776865257; x=1808401257;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=iv8NQZu8jNVkAJbPXfcqwXfyHsB60Q0RjPt2lXfIB8c=;
  b=d3fQdrxSML6w5VX2Rtzp9BIQsC2Qb1ZkbGJ+rG0yHrkhcVaru61tjLMD
   6TaxmsXTPXgEna89L3V3jopw2sxdJvWaS8GlxYxQW3Y+QSqOMMjA6fkG4
   BOQACrlNrRBoudrz3/TIHAqFqChyZtvZxMNzQGCV6+Bjuz7Q/Uq+A3wOa
   8J5CdQwhaGl2wK/l5N9I7AkqA3UDnk5Crg4qLGJQiACYOx3GiO8dcZAhc
   r+MUtVuiPki55ceCpLp0Sf+tNCU8hLxRfeJcFjoMY3TbWXm9odII8Awlp
   yqSS2LWHfB397a95Y5+cBUX0QRAsnu5a3bthLRiWZyMJI6CfLt4X90Txe
   g==;
X-CSE-ConnectionGUID: y3iZcVPqS2eSi2dpvi2QuQ==
X-CSE-MsgGUID: 36xl3ZS0QLeIvDX1YfY/+g==
X-IronPort-AV: E=Sophos;i="6.23,193,1770620400"; 
   d="scan'208";a="55696481"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2026 06:40:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Apr 2026 06:40:55 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Apr 2026 06:40:53 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 22 Apr 2026 16:40:52 +0300
Subject: [PATCH] dt-bindings: iio: dac: mcp47feb02: fix example indentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260422-mcp47feb02-fix7-v1-1-709c7c02799e@microchip.com>
X-B4-Tracking: v=1; b=H4sIAOPP6GkC/x2MSQqAMBDAviJztlCHLuJXxEOXqc7BhRZEKP7d4
 jGBpEKhzFRg6ipkurnweTQY+g7C5o6VBMfGgBKNVIhiD5eyibxEkfixIroQUVs9Gm+hVVem5v/
 jvLzvB/DJnLlhAAAA
X-Change-ID: 20260422-mcp47feb02-fix7-dacd257586b7
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776865252; l=1917;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=iv8NQZu8jNVkAJbPXfcqwXfyHsB60Q0RjPt2lXfIB8c=;
 b=CqXnswnjudYgDMXJRD1luUL2PbW+U+74iREVx7WiqFyju+CF1obgXw03DLv4dEJOQhxc0YsD9
 naEjW+Xv3YrByJFYd//CMnBV6C7l4nPWpK5Pelu/dS182jw6dmjNCR/
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Correct inconsistent indentation in the example and use consistent 4-space
indentation.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d2466aa6bda2106a8b695347a0edf38462294d03..ad078137a8eb78e70544dfdd8e3153f2cc91777f 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -281,22 +281,22 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         dac@0 {
-          compatible = "microchip,mcp47feb02";
-          reg = <0>;
-          vdd-supply = <&vdac_vdd>;
-          vref-supply = <&vref_reg>;
-
-          #address-cells = <1>;
-          #size-cells = <0>;
-          channel@0 {
+            compatible = "microchip,mcp47feb02";
             reg = <0>;
-            label = "Adjustable_voltage_ch0";
-          };
+            vdd-supply = <&vdac_vdd>;
+            vref-supply = <&vref_reg>;
+
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
change-id: 20260422-mcp47feb02-fix7-dacd257586b7

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

