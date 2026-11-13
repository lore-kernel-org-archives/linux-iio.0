Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794573215;
	b=dSN9ZzNHpFqryWrMfQzn1gq6ssuyPsHpLAADnNuUHoIHVAZlBDNb15zFDaQd/nudcpWs
	 eaAIQaBq3YbFJCQYCiOsq/1Yn9dRUIy1yoFiMQEgnrfaIixp/gdAOh0GIS2rpLRCea7sU
	 XvIBRxj2Plq0xhhU0SVQ0ykEp9xhSOvRVw0+Bf9U4ktIo5nuFK0Z8S65/kgDZLcRTGxQ8
	 Fr9R1GeaoYY9QEhHx5z3hI2rjjEEkS2F90g46bXHoO33KTYvbeCpF3rUqtb/sefKsWQXn
	 T0Vd6Qx7NYxMDRl0Ffdp0AxR6VVC0vd7ZYoreQ4V1fco5ja4gZnIIv7eWq+EdIaGYtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573215;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E9Y6nNGHJugVcqKOZKUfSAKqOS2/UKJtdJBYK5Mn9fs=;
	b=kR062LgqA+KAJbbaoec9oCzF01KCRnTCwumt7Ty9GiKtq6dz4dtAmVCgkM12iumfODHt
	 kaTorrbsRSu7PywAObomb0o0kKuB1sAWY9d/q5w6xvJKW4VKBR8Q2dwSa+TBXJjkL5s+4
	 kjsyVp7yWrrXS2Wg0ZkAlniXNrfRC/M91C84/75Xytq6w1UgOzDgp0nPRNBQAWwAKNUIX
	 lXn2gAY7uz3jTahoJRpMs58xx4reFEIHEtcwGKfZLVFe9UaDZjg3Txo6G7/HuJgcaw2wx
	 jIjGheB5MzYcCBpMHwnFDWZeTINoWaAHvlhOisxz0rTLuOBt+3EjeAPerXirdK8T5XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs+Z6x+7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D49606A332;
	Fri, 13 Nov 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs+Z6x+7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794573215;
	b=Mji3ln+wkTmpKB/3GThsSNjGEZQlKH8OrMGkQsmB6EzU88ZxE4Xxhk6DgR3AbZorhuZz
	 SmX3LuoqAGidvmcFLNr879/yZHClqOQqaT4TW6oYRTteLikRhQFwmtvgQPFx7Ix2hqPbl
	 mNTVdId0p2POglS4XMa20YFmMidKDMmbckvvEWOjgyc0g6EQI+01wJ6QRXNbgEJghjt07
	 5G5NxDvervVNpgqecFQVYL7XblRl7NbF2xiw1D07DGFOZ7CteFURM+ks0Qrs4grUqy0eF
	 WugoWclF4LnLz7a3h+ZRBPM5nXWblJDmrAhGwWNLyv5daWP1lvgtCvGlL1rpSY/N4VQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794573215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E9Y6nNGHJugVcqKOZKUfSAKqOS2/UKJtdJBYK5Mn9fs=;
	b=FDiibBdF8lZsz734h0coispxqXFJejGXMww1rkNyDjjmq6nMNhXqxtrsrnCbtA0LQQ4O
	 jeh4/yj6Ykzq2hFM6fKWH1633Lgyyoj9YjhvDArouu1w+7LKs1Eyxe0xgXuV3KyXTqBmU
	 E5TCGd9l7EW/c9otW902gTr5kHFiw6VcFGCIsT9KKcAoJfT2YyNWIOQKmLBkTHwYINdTX
	 LSkNOjQdasmTYyNQOHBhcdeDV+2I4P80YEhk34NcTTJ5VKru4Q8jxj/QmCJFkan9y+87N
	 3RS/l5as5Z+lXGXq/fmEgRsEHjBhWLkYfDeS76bWuztFPSW62RiTLQC1PzsW1dFG6hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3093A1F000C8;
	Fri, 13 Nov 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573215;
	bh=E9Y6nNGHJugVcqKOZKUfSAKqOS2/UKJtdJBYK5Mn9fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hs+Z6x+7hKRRTWjf1q9izoLRD6iWGP2AtlXjv43o+GmmkN59QGhK5fmY+4ni2lgWH
	 MvXneUXOJTj2P3ohG+tDwsJG586izZC33kmno/kt9CiLjdEIiOvQ473KEANbbj0Uph
	 e02VfB958oScF8ywfHrRn13kgt9MDGtSLMNxmLJ+/mG2cvPxaS0iBnPFfJlg6KFsXq
	 d0whgZw336DARlMG021hDEaKLz22qkwS79qtL0CD7C3MjROQWXMbfxWY/G5H6uknpt
	 Al78o5FrtCQ++GMljGedoU9KLwLP11HmMscKxaG2D6hK5KoBcq0QmJsu+uFLY80P4f
	 70BJg6JRG6xQg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B5E50477A0;
	Fri, 13 Nov 2026 12:33:33 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Nov 2026 14:33:34 +0200
Subject: [PATCH v6 4/8] dt-bindings: iio: imu: Add bindings for ADI
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
Message-Id: <20261113-adis16607-v6-4-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
In-Reply-To: <20261113-adis16607-v6-0-3f678719942a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794573212; l=4547;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=dtrcj1XsEm2I9niI4lfK23LNsNQBo2BdJFRP4omBKms=;
 b=zf8uk9ZGlBtTtamRvSMSz++PrVfQbZ8jWk+J3gI53Bd1T9mtSuGbpnKOKIfmVfhvodV6IsRZH
 w1XUuIlvRJhDlT8E8jwM4r1yl/Fr7yKDGiFXHJ9zblYwdrcGrRTa7NJ
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


