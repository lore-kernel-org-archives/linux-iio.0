Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142256511C;
	Wed, 23 Sep 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190982; cv=none; b=MuJAaaQOaD/waZYHhzCpNhSil1zNVuordu9mafTaLuiPabhQswribLHjCo7VCsv+AM4vf61pOWi84S0ZD0ZQ6c1SnAcMDe3djHafDHzHXj9QnENhohcDucTYn/By4n2qY6N4QDK2vgdlEHyl/7cpll7M1gp4M/+y+ckPWZyjmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190982; c=relaxed/simple;
	bh=vdlVvXHfWe8OALIxZzjEsQKZrr/QyUy31KjDyOzJhYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yjfom5h8wsLK4EPmrleVgmvorXNEAOv7vQEHREMB25TwhQ+pzBS71FFDz/+F0Chl6IbU+Cqa5wsa1lXIWNF67+yxmOgTIFyUIGx2djYCMsjlvkjBwRUKdntHlMlmVLAEXtnx8LrkQ/EYnpGaKuzYBi94E3QwMDjU9x3mNU3a4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecY/AkKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecY/AkKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFFB1F000FF;
	Wed, 23 Sep 2026 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790190980;
	bh=ivCyPxmGWO6C1ywTeZY7P0G/eDtRcLhyTFFrk9sDgG0=;
	h=From:To:Cc:Subject:Date;
	b=ecY/AkKbfFRmBOcurunt1Ns1YfQV/lCF7STyskWgAarvv9WT8x0bSmOmWEn1hpT7D
	 Ret4tjXBpzboBvRQgD83W7domQmMBipCBlOK2at59jV5o+0pXBnW4/bPmNOJtSYYGy
	 EPxcVQG2Hy6KSjXoMoeO9BDntSyP45z7W0vxi9INgZBUnHzlRcX4SfHI/FskhdtwbC
	 ccNV7gZ8nZrWZGti+7DmAmj3XiQZb1CENU3TbEWZypttWIe04KLmkxLU5K27pHEbKy
	 f0qCaCYTGO91+lh5di2LOWVRc12ZJPUajvSgO4Etn6P80ogdsf7QykjdBIA2bV6Zpp
	 Lj120ATzwssAQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: Add dedicated CM32181 schema
Date: Wed, 23 Sep 2026 14:16:15 -0500
Message-ID: <20260923191616.2217203-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated Capella CM32181 ambient light sensor schema. The device
has optional vdd-supply and interrupt properties, so it no longer fits
in trivial-devices. Include both optional properties in the binding
example.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - use additionalProperties instead of unevaluatedProperties
---
 .../bindings/iio/light/capella,cm32181.yaml   | 44 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml
new file mode 100644
index 000000000000..e64085a9cb2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/capella,cm32181.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Capella CM32181 ambient light sensor
+
+maintainers:
+  - Kevin Tsai <ktsai@capellamicro.com>
+
+properties:
+  compatible:
+    const: capella,cm32181
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+            compatible = "capella,cm32181";
+            reg = <0x10>;
+            vdd-supply = <&vdd_3v3>;
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index b7ddbeb40a27..1778bf9fe17d 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -81,8 +81,6 @@ properties:
           - atmel,atsha204a
             # BPA-RS600: Power Supply
           - blutek,bpa-rs600
-            # CM32181: Ambient Light Sensor
-          - capella,cm32181
             # CM3232: Ambient Light Sensor
           - capella,cm3232
             # CM3323: Ambient Light Sensor
-- 
2.53.0

