Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB143385B2;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436113; cv=none; b=uoRz3S3DFh8zGdWIYLUDVrafyHtlgmCeBw3rXtcpuBgaV73v0S6qawCwy0Sj7Hbx8SHEzpBUQtnJEeq3FMeqARSu1me/xZBPn7ypm3JITgWDthV3gHNuaHKrSkJaELrTMqge/6TjEN1CwM19z9W88AdJEIIPttIp7sTfmhmdXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436113; c=relaxed/simple;
	bh=lUrvkbVAkhcasr7sLxxFFv65MuvFiA8vFFbwSu7C8C8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qG4ifOXjF8slRHnh5a7sDXlxVqPMf3hf/qW/93epz7LMJUM9Sg0j2w/KRztmtoBeT5h/RWbxxGtk2e3zgRWjQ7aP+1NTA/iilgLf10pSS7hkNKkoj8cMB/mhSRUlrmW9e7EdC8K5zw4SGwJ6V6yN/7bdLLmHFjC6VCWa7VrqYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3hmLCHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3hmLCHx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CE6CC2BCB0;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769436113;
	bh=lUrvkbVAkhcasr7sLxxFFv65MuvFiA8vFFbwSu7C8C8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H3hmLCHxXx2MFE7YC2UqIjfFbRYy4WJwp0tvJ7BjEVzMoaS27t7kkt23jB4yvyVsy
	 /g3mmbw6+9QmYuRRMCrhAPIHua5V2NLa8n2mx3h4ujwK3h227M9iV93pf73TqgATA9
	 yGjt82RKE6zji+IezV6MiRYl5zZ8cdZqO8pKE9HnpR70XnztHh4t0ckxKrwNndT0gi
	 T5KsuM80jbxI3DuYOZCK+rAmXHD2Utc1Dsa9j8nJ7ZrZsUxQhD97cpLWiaq+Xw2nf/
	 Fsn4+yx3zQNx7vu4JQCIyKaXiGfIjD6z0Io9F3xoKr+rsZz888ecfdfnWX3S8yVYfx
	 cB1btbnBqTFCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E2AD13C1B;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Jan 2026 13:51:03 +0000
Subject: [PATCH v2 2/6] dt-bindings: iio: amplifiers: Add AD8366 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
In-Reply-To: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769436111; l=2610;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=PH30WSr8qpiolFuH2hsqx+jrXGR0KzrfQM8KgsHyz8Q=;
 b=JcPFr/Gu8SY4SPvzzEjP7VQraWwBjQXjUTHeQehJT5ayaH+75nBdTyKdmUcgcYikDu49lFqK/
 Ha0SwqEVu0UBH4qG56bEQ0jPtL5ob+ECvm9UZcAsg7QsW7BhD90kVFT
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add device tree binding documentation for amplifiers and digital
attenuators. This covers different device variants with similar
SPI control.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../bindings/iio/amplifiers/adi,ad8366.yaml        | 68 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
new file mode 100644
index 000000000000..02f790fd73d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
@@ -0,0 +1,68 @@
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
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8b5bb7030fa6..c3403ae478b7 100644
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


