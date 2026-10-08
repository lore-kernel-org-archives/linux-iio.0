Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385946D567;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448345; cv=none; b=Ot2qGOLQubKzL2FaeGFleeToJlEeV7vYGSaKu/lX4jXy0bsbdOT1lV0frZGqxo6jlMNO904fUcA5OmaDGW9bNSGl0E2ek57MQ9X7+LjSN282kOoznZABSmkrO3+orAcVZn9ckEfJZzh7HvAvHlQ5R4ODW7T1z2YXK3LqV+PAdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448345; c=relaxed/simple;
	bh=/8TJlDcLrRL+BoQNjggqyuHKHSMjL8+lUnc0Pf8WTXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuPRiPdQHDcQmWnILo58144pTMlPMITAk4K1eUUfaCNPfX6PfcscrPMNqcatZ+s13jKOklbSLv316iDd4hOeMXA1fBl9yoTVmNML0sfG6EseuzOo7CUDiN1yFvwoeiJaLSUcbXJYP33fTwkMHrWZZZaA3eEU0+FDN3e+/cqASgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+SbaLor; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+SbaLor"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE110C2BCFF;
	Thu,  8 Oct 2026 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791448345;
	bh=/8TJlDcLrRL+BoQNjggqyuHKHSMjL8+lUnc0Pf8WTXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f+SbaLorJpmoU0Pfmz4pIN8vzITZqXoW1XztopEZafl+EKg294GRC+dYokWgLbMjY
	 l83UBIgQxeTk4c3lMEGCU010yaB+pSqu28xOfJ0AcswVJYZ1jD5WvolBqJ/nuTIwMt
	 JmZO0Plu9eHcwGG0dvRENE/hbP6/E3EyDOYaZADg9JIa+TSZ98GNl1Z1l5RvjDsEhH
	 cc6/bRrFtyfVSvSxsCKtQE37FR1z07SyqWoqcoP1AJxPl/7kWeU81gDrB7XJFKnBGB
	 fi7/fhDoe4Wg5+F/mvhmuqzBWNWtqdMSlhnbsxKMsBn651sYh6ETfBEXSGV1UasHo+
	 ElOW+Xg/2Pogg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD473CA600E;
	Thu,  8 Oct 2026 08:32:24 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 08 Oct 2026 11:31:54 +0300
Subject: [PATCH v2 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-adis16607-v2-2-7c94df80878a@analog.com>
References: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
In-Reply-To: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791448342; l=3728;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=BeAQfUZcwLtaBfmttCle/5QJs6p9ASgihqqd+QRaDz4=;
 b=iE3TxOiSk2oBbEGkuAz7FH/TbH+pe/pv3wNmS8lyd0W3Lq9HZnKlC+APTvPAE7qPB2vwg2+dM
 QFWw4kh3AZkD5sHNec/V/hK63XWvBuYk3E4BsvDa5+9772lXRzETcYT
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

Add device tree bindings for the Analog Devices ADIS16607 Precision
MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
gyroscope, triaxial accelerometer, and temperature sensor, and
communicates over SPI Half-Duplex.

Two compatible variants are supported: adis16607-2 and adis16607-3.

The binding exposes optional properties for:
  - An external clock for sync mode (falling back to the internal 8 kHz
    clock when absent)
  - A hardware reset GPIO (active low)
  - FIFO mode for buffered data acquisition with a configurable watermark

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 83 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
new file mode 100644
index 000000000000..b08809e2f327
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16607.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16607 IMU
+
+maintainers:
+  - Radu Sabau <radu.sabau@analog.com>
+
+description: |
+  Analog Devices ADIS16607 Precision MEMS Inertial Measurement Unit (IMU)
+  with a triaxial gyroscope, triaxial accelerometer, and temperature sensor.
+  Uses SPI Half-Duplex communication protocol.
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16607-2
+      - adi,adis16607-3
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Optional external clock for sync mode. If not provided, the internal
+      8 kHz clock is used.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Optional GPIO for hardware reset. If specified, it will be asserted
+      during driver probe. The line is active low.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-cpha
+  - spi-cpol
+  - vdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "adi,adis16607-2";
+            reg = <0>;
+            spi-cpha;
+            spi-cpol;
+            spi-max-frequency = <10000000>;
+            vdd-supply = <&vdd>;
+            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&gpio>;
+            clocks = <&sync_clk>;
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a7fd31320b38..f6ad73be5260 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1717,6 +1717,13 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 
+ANALOG DEVICES INC ADIS16607 DRIVER
+M:	Radu Sabau <radu.sabau@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
+
 ANALOG DEVICES INC ADL8113 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0


