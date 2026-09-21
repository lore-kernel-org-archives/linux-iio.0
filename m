Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156935187F9;
	Mon, 21 Sep 2026 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033293; cv=none; b=sQv1K9wvhHxgNjlwUlnVxYh2c67P1v6hB1qqABzmdNCjgiJNl/u8o0xXgvvSqtKS6Gzy+LI94UpjZ1HUVPfp7a7NQTRb2AbOTE+BWLXnitaevDPiBE04mEAcfN903XleeJENufI4H/w3bmVna2wQPSq67wRGALG8IOnMxCrppoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033293; c=relaxed/simple;
	bh=WsLSf+qnHq0yGR6VmDwK8Wr3TjmpvTXaFFLSt/oyEMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zemkqb17C3k78fnqnHDTuupDcDR9cm7Zda/S57zs0xJ37RCs6HXvQMdLsxRChHA36FBKzLwQPCl7CP1L83TNRfQNd+XXibIW034pmRYF4RJlJNFJ/38LHPqVtAmDPjC7b7nt7Wa3ps4YRE7njf+di290wycrHRwkHPP4XabfF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkUwtSYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkUwtSYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3301F00893;
	Mon, 21 Sep 2026 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033275;
	bh=Ml9KxPG2/iFwRpn7Lwg7J4zJT5THTLC34N1bTCQkm5Y=;
	h=From:To:Cc:Subject:Date;
	b=IkUwtSYP8uC4JZMSnwmogAZtGS2GK3IoX4q6gl9ylDPbtPbMwruHJD8Rl3G/1tw2y
	 iTdaTXRTZWVT717KTnKLwccfVDidLo/QV+4gvPWEWug027vxyFw7HmklaXVjbVOChG
	 X0cGc1QSUHTCiOzxDHhD8Rr8+1To8Zhy0xwjw4cP486TMl/QR+t1LqmEIhQHHJUVF3
	 qP//Tg6fO7e2hVI9a3b2D044lC0tyQkN3mGruFUmFDmnyFYJJTz7Fvs+ZoeEDb+xWh
	 d0hAPo+AAwxWQFmDqifK/lCpVNRlvYEnAxf5fQ9mgiD097v14nQ6AgRt2IuPd9TAgE
	 ZOcQ/WAkWMWlg==
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
Subject: [PATCH] dt-bindings: iio: Add dedicated CM32181 schema
Date: Mon, 21 Sep 2026 18:27:51 -0500
Message-ID: <20260921232752.3136129-1-robh@kernel.org>
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
 .../bindings/iio/light/capella,cm32181.yaml   | 44 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm32181.yaml
new file mode 100644
index 000000000000..63212e3ec96b
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
+unevaluatedProperties: false
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

