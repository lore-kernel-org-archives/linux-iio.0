Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007867;
	b=oWGbbE1+a9SG+L94fY3iXohxxvbeSLyyungoN7JP1JP0LrjuRJwXVbvuBWNdXdq8HU2C
	 bQ54EJAhXQ7+V3Ky45b24VZnM9pUnuN35BIPfN81C8Jk6Kl8Kqb6kG17+AGz2XNKW9ON6
	 7yeEU4vL0P0AXvnRknO2gQEksd9LWPpYkYI9+eQAvUe+PRJ+B+ayOawygeCUaKeBFWAui
	 2PlGzRQwN6aJ9OxuEoBBmNTIqy2huAqLh4xxDmok5Xz77qyM4yRyzz94kU4MlWn+d9ZUI
	 1j3kp4ERSJvj8zA9E1a3OF0MqxzL08UV1jpEBUtenuI/Aeghg9jeC8dO++ZCCGlGjFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007867;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E9Y6nNGHJugVcqKOZKUfSAKqOS2/UKJtdJBYK5Mn9fs=;
	b=N0x5GNCDcMENflM+8h21pqVAeebdubbdya4MkooiPqC6V0Zk0h5yEXhZ2oGuAY5LVMuc
	 3PKu7mk/fFVf0XyPzcLAHuHzpSYe6eVl6ixs0Qvm2lDQbSZB6kKqlVSiVIYYGraX2EptP
	 RdJXon/fHfdUPp1H90UW79Ohyrsao1R3xSqmhEm7qRA0NlRsebxLs0gGrqjAHCabD1iNN
	 5i0afWO8A0lJ87fiYQpdrGBpJGMKp+Fpf5RqmdmZCajOdCww5xnhWJh9Isn15Xt/VT8xQ
	 +Lym1J85ai2cC+VUO5B2sfJZdaeJo1PaKMOQm9zjMERg8k7crZsrHQ2IvXo/Vxn+y2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPjgkS8n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FA60A2608;
	Wed, 18 Nov 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPjgkS8n
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795007867;
	b=HMv0piO3d22/epBI4Kflb3NqDkVl4rsMPIz8Q+/Lt06bnDyNo2klm7zbBu8oVctA+LBZ
	 VyqOpV7k8im16BDxZR5/vCy5FYc+Vflq/BXtKj6YlD3yMeKw5ncMtW2LyJmAweRE3K2Ia
	 xFrko5AAEG0GJPiESwBPSA2qb1eeAWuCQz44Jr34sNGaMgjVlFzOtxaoehMSJlYnA1vh0
	 IgKh0TQ3+xY0aQS0qhZsCmrVNE70eFoMF5iyl6ndiitLiBNvniyi+EzoBZLFgO7xULmoA
	 YrW1YgoVR1wArlKoBBChIHf92qyEr88+UpPtWtHHGTcKTO7+3BSy0dfEkrPgSkgt6nA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007867;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E9Y6nNGHJugVcqKOZKUfSAKqOS2/UKJtdJBYK5Mn9fs=;
	b=HFbuxxT0AuGZKlOdW21oPkpCIDFqmdg9JcaHK8IPM7+dkhk1lVVqKC++MnqYCfykBpRi
	 4G7+IQ5w5O89MuMJZ6Uzrx4xbyXhCtNkx+Nl+cKdF8tjtIMzpoKAa+Eg2A9fZE43/9vuC
	 bAHQ091Dd2NB7+96Rzi2N4AhSvd90tB19A38bdNesWTeosfne6QgKH506Ct3HOb5jiLha
	 Bmj2BEIrFIbwys5TyQ1G6FyP5amO9M7w9QupRjt2m0DtrvPHnEFBQEYA4GzMpkmxKtnzx
	 ulNPGVC8JOP0RtWqlF1YKm5IJ8z8LFXzR0widW585TaKknsLSkMZDDBhDnpib8rJQ+A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 163721F000C4;
	Wed, 18 Nov 2026 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007867;
	bh=E9Y6nNGHJugVcqKOZKUfSAKqOS2/UKJtdJBYK5Mn9fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OPjgkS8n9tqZ5ZfFjBCpd70p1avxx2wbj+OOMLczaROYR4/O2O7VfUBkhFW4cGi+5
	 j85+QUZB1pVDg3tPD/RpwNfSHeAvBckt1gXzNlLE2XANjP/no9ctfYwx3ndntXEmYf
	 DxRPfJDs1o7iRWndB/CU9aVsvHXnQEDH9oy/ILwH639lCiahU9WxY3BDuu5ygMCmfa
	 0Q5zklWHnuGAOlngQrB/ZlmzNtwJL9neKgpdgp0icEEYmPOKAIpQtX7e7Vqq++CS8w
	 POURFXEyBU153fyk2FNhKnhj/gQrUzpZoZuO9RLL2jaY+A/KTVvphNAPCAaDUWitR6
	 HTS/v8jRjTZNg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9250A4ADA4;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Wed, 18 Nov 2026 15:17:46 +0200
Subject: [PATCH v7 4/7] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-adis16607-v7-4-707609737691@analog.com>
References: <20261118-adis16607-v7-0-707609737691@analog.com>
In-Reply-To: <20261118-adis16607-v7-0-707609737691@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007863; l=4547;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=dtrcj1XsEm2I9niI4lfK23LNsNQBo2BdJFRP4omBKms=;
 b=DqZhyh7lN/F55QaomC8Nr63XwU4Id44+rP3lUR+pMKj+kdnaWSQQeEMiGQRMgCppcSuszVrrV
 MZUpMjiL2vKCMgcftVGg29+EW3iJBqrz2mc4PvdEREqiS01q2LBsbqq
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 8bit

From: Radu Sabau <radu.sabau@analog.com>

Add device tree bindings for the Analog Devices ADIS16607 Precision
MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
gyroscope, triaxial accelerometer, and temperature sensor, and
communicates over SPI Half-Duplex.

Two variants are supported, adis16607-2 and adis16607-3, differing
only in gyroscope full-scale range (±450°/s and ±2000°/s
respectively).

The binding exposes optional properties for:
  - An external clock for sync mode (falling back to the internal 8 kHz
    clock when absent)
  - A hardware reset GPIO (active low)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 94 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
new file mode 100644
index 000000000000..4545f942365c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
@@ -0,0 +1,94 @@
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
+  The device has five GPIO pins (GPIO0-GPIO4 in the datasheet), each
+  independently selectable for a single fixed function. This binding
+  exposes GPIO0's reset function as reset-gpios; GPIO2's sync function
+  is modeled via the clocks property, and GPIO4's DEV_NOK interrupt via
+  the interrupts property. GPIO3 (data-ready) is required internally
+  regardless of board wiring and isn't exposed. GPIO1 (wake) gates
+  whether the bootloader auto-loads its NVM contents after reset; it
+  defaults to enabled with a weak pull-up, which already gives normal
+  operation with no configuration needed, so it isn't exposed either.
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
+      Optional GPIO for hardware reset, active low. Routes to the
+      device's GPIO0 pin, which can be independently set to the reset
+      function or left idle via an on-chip register.
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
index f53047aa8d3c..d5679e8d0ffd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1792,6 +1792,13 @@ S:	Supported
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


