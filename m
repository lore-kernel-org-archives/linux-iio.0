Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28843B38A2;
	Fri, 16 Oct 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178671; cv=none; b=TQgD1T+fIvENJk5kTtkzVx0gcceLorpoGe0XUb3ZgcuQF0aFbEO5kEErDX+ueMx1TkYzAzHtnWmPzdTyT/1jjsiBdQ/vWIbVJJpwV8haMFKmqihi+bc3Dx7V+WTcBAEDE07YtaDuPp3rtivdmWC8HLKTDxkFc7p9eJHtaLzzntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178671; c=relaxed/simple;
	bh=z7dcKT6WCCfmpum6XRApOFeLE/iqEriMmhaCDMDjN+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ofyq9vwUXxWdEKBTT1o1U7CR8dUszLhXHgUz5lvLsOTIMsw1sN6NhxnOjKamsgtP0XPzsye3lAlMd8JbZJYLASl01b+/JYRbro9Tbp+9JByges6RdXkwvwgHB4/vMkllM2oORbwrz0Hv2WeLXbIMr1n3JKv/MFKuBbv6OL8BYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlWAYR/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlWAYR/l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 437ECC2BCF5;
	Fri, 16 Oct 2026 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792178671;
	bh=z7dcKT6WCCfmpum6XRApOFeLE/iqEriMmhaCDMDjN+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VlWAYR/lB5iTj/Raj5+i99p2v4PbdJZa2IEG4fIwB5G6tGyz++woQ8mnxWh9Y5IpZ
	 rtnQXjIwHtTg6f/JkK8/qbaQWjc1S/O8LySKbMfyPQ7L/AfBHtH/4ak6aheEBeQ1G/
	 ksPNjdgwf/aWJa3PpxGcH6zJcKPG8Fjo4+YsUjYFhHjbjBIiv+R4oUW3VcNnnqWB+0
	 z5ancKR2bIX7VdP/RSohcboRgIqqHiFlQOpPH/9Gqv3dZjW90G1PV3dz/Xs4LTkwLY
	 sJ5CK5vNqOJmYAjbaxfFt2zAmd94H64YJCH142a61eMnJmIR+LU95RDU5jpydMo2Ce
	 04CWo1n+HQtpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FBCCF2C3;
	Fri, 16 Oct 2026 19:24:31 +0000 (UTC)
From: Bruce Tsao via B4 Relay <devnull+bruce.tsao.analog.com@kernel.org>
Date: Sat, 17 Oct 2026 03:23:53 +0800
Subject: [PATCH 1/2] dt-bindings: iio: dac: Document Analog Devices AD5413
 single-channel DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-ad5413-upstream-v1-1-61f40c8fef25@analog.com>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
In-Reply-To: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bruce Tsao <bruce.tsao@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792178669; l=3103;
 i=bruce.tsao@analog.com; s=20261017; h=from:subject:message-id;
 bh=MLPV8sK6YxrCDJ3rbi7e0JiFTKRnM1tj3rvbSW15OFA=;
 b=quDm8XU1PO9wKKXa4zW6z2ltCpe32WYd7d5NnP8xnp5kYdHA50dl+wSh78dMWOEqcXsHF6tRE
 qlI1ickDsuWCO8iKl4oi67jqSOa+ujzj4mQsroX1+8nIJmgvs1gA0gI
X-Developer-Key: i=bruce.tsao@analog.com; a=ed25519;
 pk=dT7qI1i91oYvnYmY2ljmdZ0ZQoCZIzrQ8hnsyjuBedg=
X-Endpoint-Received: by B4 Relay for bruce.tsao@analog.com/20261017 with
 auth_id=1215
X-Original-From: Bruce Tsao <bruce.tsao@analog.com>
Reply-To: bruce.tsao@analog.com

From: Bruce Tsao <bruce.tsao@analog.com>

Document the devicetree bindings for the Analog Devices AD5413, a
single-channel precision DAC controlled via SPI. The device supports
voltage or current output modes and programmable slew-rate control.

Signed-off-by: Bruce Tsao <bruce.tsao@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5413.yaml    | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5413.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5413.yaml
new file mode 100644
index 000000000000..74e869304aab
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5413.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5413.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5413 DAC
+
+description:
+  Analog Devices AD5413 is a single-channel precision DAC supporting voltage
+  or current output modes with programmable slew-rate control.
+  The output mode is selected via the adi,chan-current-mode property.
+  Optional reset GPIO may be provided.
+
+maintainers:
+  - bruce.tsao@analog.com
+
+properties:
+  compatible:
+    const: adi,ad5413
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  spi-cpha: true
+
+  spi-cpol: false
+
+  reset-gpios:
+    maxItems: 1
+    description: Optional reset GPIO (active low).
+
+  avdd-supply:
+    description: Analog positive supply (AVDD)
+
+  dvdd-supply:
+    description: Digital positive supply (DVDD)
+
+  avss-supply:
+    description: Analog negative supply (AVSS)
+
+  adi,chan-current-mode:
+    type: boolean
+    description: Select current output mode. If absent, voltage mode is used.
+
+  adi,slew-time-us:
+    description: Output digital slew control time in microseconds
+    minimum: 0
+    maximum: 1000000
+    default: 0
+
+required:
+  - compatible
+  - spi-cpha
+  - avdd-supply
+  - dvdd-supply
+  - avss-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5413";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpha;
+            reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            avss-supply = <&avss>;
+            adi,slew-time-us = <125>;
+        };
+    };
+
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5413";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            avss-supply = <&avss>;
+
+            adi,chan-current-mode;
+        };
+    };

-- 
2.53.0


