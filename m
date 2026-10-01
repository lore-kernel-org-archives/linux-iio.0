Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72E4BA9F2;
	Thu,  1 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845911; cv=none; b=Ggx6w5HHL4V3gcibI4iEdFWACTGaW9aU/vh8JlVzVPlqIwYNrrmfusunCxqlGTpCBitTbkbF9qLRcZSr/jrCKb94UQCmkgltac9vLC/IGdPfadNWzJcLp68/Hz/lwyFHylnRFYGMVFP715poi7jsm5IaOvwMR+i3JbFIm/NSFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845911; c=relaxed/simple;
	bh=eaIRGBPsbebSoItVlZ6+wkDtiLX8dohBaanVuPbPoVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deTT4XAb2Br98iubRyBC+jtGF9sztteTewzQ6cJFW0kl6pBEqNIZfnZFv8x4A9WKIGNfapUAUtf1SNZKr5HhME69WjB+VLA7yVToGLcZqufInvIx6jbMNamV1CiOjVBOUwIYpbWkhQszWtSgVv3iQBFXtxD0GhMb/qMYQrMtIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huLJ5qZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huLJ5qZO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBFA4C4AF12;
	Thu,  1 Oct 2026 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790845911;
	bh=eaIRGBPsbebSoItVlZ6+wkDtiLX8dohBaanVuPbPoVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=huLJ5qZOA5I/Ix5g1RIoFt0dB+daW3/3ujmMt9qvbVDjOsPYAlTSIgxx/BTiNVcMM
	 dQdOMWzZcPaLbgHnBjwtiKA1Hy6t22B7MN8xr3fMYFeKnbzmDBOYj6n0LsnzvT9uhP
	 N9zMsZWPjZQ2iDWsfVO1xIQrmnkIjRTKp/gc667MxgClmPKiyii1cSZOz7zQ18ZARq
	 xS+2wDYIDqGLrNy8P2WcAtqbYPRh4LidsgxfLhL8EFUQFdg9dd9smjwsB/+aAOKByG
	 diISJxqswZT2+5+4YR0vFxccEBmO9aF1jjUF2xHMcmrDQHYqJW+NrF6X8r/hgIvtQj
	 cuzHnmCAE2Eag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA4CA5FB3;
	Thu,  1 Oct 2026 09:11:50 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 01 Oct 2026 12:11:49 +0300
Subject: [PATCH 1/2] dt-bindings: iio: imu: Add bindings for ADI ADIS16607
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-adis16607-v1-1-9c89cee35d56@analog.com>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
In-Reply-To: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790845909; l=4043;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=sOKcxtH40IXx9ikDNcFZu7DbWJsM2j9tuLA7Q4TiFOA=;
 b=ZAsBjVKphLB4J2i3GsLqAHYjDK3Q33BCol+qEr8Y/dftId4U2GR5pDmt2zni4gayJVBJWplew
 0AsCXcZuZwHCh9wYM7cJmYx4Wf1uRnlHKynPn4IbMN9ArdKwhTLsUQ8
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

Three compatible variants are supported: adis16607-1, adis16607-2,
and adis16607-3.

The binding exposes optional properties for:
  - An external clock for sync mode (falling back to the internal 8 kHz
    clock when absent)
  - A hardware reset GPIO (active low)
  - FIFO mode for buffered data acquisition with a configurable watermark

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 91 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
new file mode 100644
index 000000000000..5fb1ba36e0b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
@@ -0,0 +1,91 @@
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
+    maximum: 15000000
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
+  adi,fifo-enable:
+    type: boolean
+    description:
+      Enable hardware FIFO mode for buffered data acquisition. When enabled,
+      the driver uses the device FIFO with configurable watermark threshold
+      instead of single-sample burst reads.
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
+            spi-max-frequency = <15000000>;
+            vdd-supply = <&vdd>;
+            interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio>;
+            clocks = <&sync_clk>;
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+            adi,fifo-enable;
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


