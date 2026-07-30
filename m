Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934539A076;
	Thu, 30 Jul 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439928; cv=none; b=QjmTZT70qfoSIBx/1lLgpdQF9qmFXp/KQsUtKpm3Dn6mXeWCNxidoVNtctbNnOYsaAy/fAyAzRAGrc4d8TTtcl5dZOsCEfN3rYHvZhrT9RGY2edXjOCqS+/90iKYi6wcgq6N05jytMMQXM4Du0S5pVhB/tO9ktlbM6v+DANYzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439928; c=relaxed/simple;
	bh=8RNNJicbOxkofsbn69rExkYA+ETIbn8fNyoaONjKg8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXIdw+WSUJN7qW2Jjq1XqEM22X+2AGRBzZQT+ZaGlqo6krEW4RL7uSB68cTP+OP9/8TbdIYfyQe4uwITo2VdDzUPm/SNsGhvObu+sYs4U1lylJwV4xfjBac0TcbNMTFdIfPLE55obMLvFqZw3HQMB8eGHDd/zoWYqXWJkQhK3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=j2pCtOu9; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="j2pCtOu9"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A637641B81;
	Thu, 30 Jul 2026 21:32:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYaESqNX0ObY; Thu, 30 Jul 2026 21:32:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785439922; bh=8RNNJicbOxkofsbn69rExkYA+ETIbn8fNyoaONjKg8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j2pCtOu9ZNhE+tGuNUgE0fzLmJB9Src1nUoVnmUBvzSdc5sVEm1IjDFQRJTcpT+c4
	 WV71tXPMXXyQu1xcShnug+yJgmlpRfOCR3UE0Kse9ER0WH/xDU7GT44nEAxwECmPV/
	 ZVnN1/N9sRz+kyys+2ny2E7gUoHJgH6mSnJGpvnIL9+tDWSgZNHnCPUXco+WYYA/kJ
	 QZsu2EHtUbI/DYHTiLfAwjKfo3T77pWUncpghtNRmix5iNAhJjTkL9Luy9nG5lNV8F
	 pRi5N21OobKK/8XFCFjYpM/oehCG8S2xacnIrOqXb2v+Mb6KJUfKV6U5tyvllI/wH0
	 KpoDSLMnlxZ+Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:01:29 +0530
Subject: [PATCH v2 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gp2ap070s-v2-1-1bdfee07d5ea@disroot.org>
References: <20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org>
In-Reply-To: <20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org>
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
distance.

This chip has been used in production mobile devices such as the Samsung
Galaxy J6.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/iio/proximity/sharp,gp2ap070s.yaml    | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml b/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml
new file mode 100644
index 000000000000..bcae68303b3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml
@@ -0,0 +1,59 @@
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

