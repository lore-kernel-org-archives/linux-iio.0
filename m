Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF02333451;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117859; cv=none; b=PZ+0IsbQOA//nm8jb54LNEBOZpAtMHMjMZJwUpCewQfTs+OyaSnDS9kLsPvv2LsvDzPmD7zoziurxK91WH9tb6UQ4yWktxc+rbfL/LqU7eG/aBQx/VyD4lQcslxRNjAW5Kxfns3EHXUEVq7pC6zBCoi0q7p7toNhgxLX3T8KuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117859; c=relaxed/simple;
	bh=aBPIntVD4TEFyPcuBJUSgguCDZx2ov8b6calvONPeKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orbaH8kYR5HFX1duvwwhBqXoIMspZvbmXRFSp7RmvzVw5xJQAXgMvBN5lhTGYp9MU3Rq2VP+CRN+ATIPeABdlg+chn/colZ5yE0cioHmSgom+bi7SvGlrsPgBihus9UijYCPF8SZwIwlhAUjHRCnlJutnhx9It5j+Y4foOCRTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHnjaSZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHnjaSZy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C5ACC2BC87;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=aBPIntVD4TEFyPcuBJUSgguCDZx2ov8b6calvONPeKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CHnjaSZyHTsAftAPy+fPDPIqMvEC7lRE/O0UvSBgmELwKwl8WtZylt0BjeG3u3zZB
	 fkHOU8GxPThIr7LmWb4LChKDpxAgVexjsnTWH1rVLYn7pG7x2rjCS3VauPDR6+XoQf
	 5Nu5toMXT6mL8G3wpxtFIaq/KNO75sIJPzi5Zm5skeyPD1pgz5Twf5GMAcYKQcTWuh
	 UOArk2xFndoFRrlv8qTVNge2qJEajt7ROFIZev0rMVsD7SUhL2WhOhZjoWSd6z+NA9
	 gHRhCCaqn+zp8FicfpgwRZ7lhoBNJPdVnCjcXnHBMy9eTSVNPx4gs8fegwC4k4Ydqh
	 0aBjTNlG5Cvpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201BE6E813;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:08 +0000
Subject: [PATCH v3 2/9] dt-bindings: iio: amplifiers: Add AD8366 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-2-5d5636b5181a@analog.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
In-Reply-To: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=3527;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z+RKl7OEhNSJ75C0Rq25IwQV3k770yUF9OzeepsRMoE=;
 b=mrY7/uK5urx1izXJEND8WQuaPxLFT3ZAMegqfEtnKKRM9QTdClOFz2ESMOVgPlEs1AchYDWp9
 LkG/klQi7F7B+CmKiIsBagi6asLaoX6aTJDRfLizC9mWq/iRXeEtZRZ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add device tree binding documentation for amplifiers and digital
attenuators. This covers different device variants with similar
SPI control. Each device has its own gain range and step, hence
no fallback compatibles are used.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../bindings/iio/amplifiers/adi,ad8366.yaml        | 97 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
new file mode 100644
index 000000000000..2719de1166a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad8366.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD8366 and similar Gain Amplifiers and Digital Attenuators
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Rodrigo Alencar <rodrigo.alencar@analog.com>
+
+description:
+  Digital Variable Gain Amplifiers (VGAs) and Digital Attenuators with
+  SPI interface.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad8366
+      - adi,ada4961
+      - adi,adl5240
+      - adi,adrf5720
+      - adi,adrf5730
+      - adi,adrf5731
+      - adi,hmc271a
+      - adi,hmc792a
+      - adi,hmc1018a
+      - adi,hmc1019a
+      - adi,hmc1119
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: Regulator that provides power to the device.
+
+  reset-gpios:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+    description: Power-up or Serial Mode Enable GPIO.
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: adi,hmc271a
+    then:
+      properties:
+        reset-gpios: false
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              anyOf:
+                - const: adi,ad8366
+                - const: adi,ada4961
+                - const: adi,adrf5720
+                - const: adi,adrf5730
+                - const: adi,adrf5731
+                - const: adi,hmc792a
+                - const: adi,hmc1018a
+                - const: adi,hmc1019a
+                - const: adi,hmc1119
+    then:
+      properties:
+        enable-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      amplifier@0 {
+        compatible = "adi,ad8366";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        vcc-supply = <&vcc_3v3>;
+        enable-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ec9a6beb7619..ab4e487d603a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1589,6 +1589,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
 F:	drivers/iio/amplifiers/ad8366.c
 
 ANALOG DEVICES INC AD9467 DRIVER

-- 
2.43.0


