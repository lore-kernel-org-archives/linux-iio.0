Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D023E325;
	Thu,  6 Aug 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045766; cv=none; b=g6SeoHCDafTG3xPzQtWv4sGIO7fczO0GnuBKh+4Ea5YfrWj7ETsUkJcusFoNnhqnle8DjrcQDfjmZVC35ml9mAnRqTpfljbd2TQBOGOYv10pWzFr7b1XDgnsrsFFefWp/2BziBDDH0Qjsw0a/a25ntHWcGAztgKwTEV1u9WK73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045766; c=relaxed/simple;
	bh=sD2ttyi1AZR6Zq2YrL2GU2IPJ5gSb8y1BWyzSisavgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arsol3CXTe2lBv3SI1XaZtxfYo6J2q/4rGhZWVipTVMFx7q5PrT7vaNWC8DABoc4kYlr1yCVpi/HoaJe/WUWziOIOhZ3oP2v6u1VBb270Abm7o/TjCJCAQNa7BtQtM6vo78l95sJjLeCWQUKDc6TTNJO378IFtSnzqu+alG6I44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=drX8aEal; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="drX8aEal"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 132C0418A8;
	Thu, 06 Aug 2026 21:49:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TX4d1873iFKH; Thu,  6 Aug 2026 21:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1786045741; bh=sD2ttyi1AZR6Zq2YrL2GU2IPJ5gSb8y1BWyzSisavgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=drX8aEalvzR/JLisqZZWEt2B/9mgarj6P3nUBGnMPaVNAf3yuEZ3284cXFRi9Wpvs
	 7D+aXyEaOoktjoMnHeiDdA4lm1yN/pUp8U53hyj2wnrkJvJEMFJ0I+ik51r9m5Xx2E
	 hL1+3ib2Ju7VZ2AzErs1GacpKjQncfrQIk1ik1dAYJgo9RR6GYFvsPyKJMNjBA/Ocm
	 pNoysk/bBhIANdN4ifI3ZLooxeZDtn8PNqmRCPKHydWT78fhuq6TsxTisURyrfbOCY
	 c1d1TPVIaYDFMX1EtHY0nriPh62NNZ0RjvWBLvoPr2AFt2WtgzjpAHZ9Z1PnQbfCkV
	 v9Z0MI20iC+cQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 07 Aug 2026 01:18:41 +0530
Subject: [PATCH v4 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-gp2ap070s-v4-1-74f6a67b6272@disroot.org>
References: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
In-Reply-To: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org

The GP2AP070S is a proximity sensor designed and manufactured by Sharp
Corporation. Unlike the other GP2AP* schemas, this is strictly a
proximity sensor and NOT an ambient light sensor.

For power supplies, it expects two voltage supplies, one for core and
other for driving the infrared LED which is used to measure proximity
distance. However, some variants may not explicitly require a separate
regulator for the LED as they're able to draw power from the main
supply.

This chip has been used in production mobile devices such as the Samsung
Galaxy J6.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/iio/proximity/sharp,gp2ap070s.yaml    | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml b/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml
new file mode 100644
index 000000000000..73f0abc1f09c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/sharp,gp2ap070s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp GP2AP070S Proximity sensor
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+allOf:
+  - $ref: ../common.yaml#
+
+properties:
+  compatible:
+    const: sharp,gp2ap070s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Voltage supply for the internal circuitry
+
+  vled-supply:
+    description: Voltage supply for the IR LED
+
+  proximity-near-level: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      proximity@39 {
+        compatible = "sharp,gp2ap070s";
+        reg = <0x39>;
+        interrupt-parent = <&gpio>;
+        interrupts = <1 IRQ_TYPE_EDGE_BOTH>;
+        vdd-supply = <&vdd_supply>;
+        vled-supply = <&vled_supply>;
+        proximity-near-level = <500>;
+      };
+    };
+
+...

-- 
2.54.0

