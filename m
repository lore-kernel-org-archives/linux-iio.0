Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747823;
	b=UwnYl3gHwQFVuZ/mtK8gEeveQmTZhqnKsiMkNtwBBPHR0EoKFn1KOPsiQyIf/RaXmEmV
	 9WqV09b6ALa9exwdvfn5n+BW+2VoCUO1R3OWnjcFl5n6xDCq3szQ/1qtBihtzWWuOIFQ5
	 3c1HV+gShtBgYPFXCH09njXXz4ea22iltCAvG09waZQ5AFYudmXBqJwGkw7ccYft5gMg9
	 pcRxeM47k0+UR+6gzNW8u9weYNfwlFFhHhBDUTbx4dthN9JvYFI14s4SxVKJgIHcRrjPe
	 ihzV4SaiNdmdc40zXcDkn29z1V4Fm4mExaYqbVZdEc7+nNsDuDzXOywFw7a7eEvkd/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747823;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zoE5MU6/Q2Y799SulvDdtXvIf+blCTDBCGWCArCbVZg=;
	b=lIpfeQX9guKFII7WRgUSd6q9560eabIpgQfP2nFFicsPhX0zYKGBEhIm6SKavLzaQ8sk
	 4YPM2KPDxAUzLMfmLBKp9Yt1/rQRDfyyR01K+xSPPTReAgpPkiB4cAIDWggp7irkTj69y
	 7eO59Wa7Z7LmC7trgYhFw/GbWRSMS+w+Q7CWb5IHzaZXHpx5Ady9/nOWlhftzYnSuEF0v
	 XoD+xkIZuK0+6lglkg/5v2CCNjSLG2KsXuumT6h6D3tAlov9QiCw6fBEKwfhHGqFMsQj8
	 JW1GDcsG3fDj3B0HRd5GhcN2Frw0mxcN9fYvimAdQ8jzGg1X9MC9SZkdM4/WuCeXa/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=injYxqcM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAF606A331;
	Fri, 23 Oct 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=injYxqcM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792747823;
	b=fkIpXUF2SYzRnclRTWcTJHHMXPXnx77kyMLaG5zPI+LqDJ5tIKaE4xBydeFS0DdgFO4R
	 mj2zVg6aC4WSLb2wdkybPRo/NI7UTedubR5PEIv2/zBEG2YeK78sklSvwoBUND0/NN0Z1
	 zDwwVLfpOS6PQuWFU4YIRShtPhjv3DB/qjQ/uCKFTu4QXs4kEKwNd+3d/1uMcLPGhVcsm
	 xumsEcDYHqRd4+wCTHCPpaYYuUc6sD2xfMFfOCgWAzXY8HgG0quKFiCcUjxLnp4LPu4kv
	 FWsmfXsCFqolzjR0AFzhbyAz9q+2Otq35gd1OicMoeWwbvMlDx5uY+KvRIUXg9xkb6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747823;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zoE5MU6/Q2Y799SulvDdtXvIf+blCTDBCGWCArCbVZg=;
	b=fdPxS7HlXHQwrHx0WvzXPX1S8XDuwLpQKrmW7h5Yi8QorrtdU8XsYf3poVXeVprmG8A1
	 lTaneVv/mCx2jLpFeDSpSuUGTjP0pVsgtZxk0OAVga1xzFxKwqdhTTKSq+n8TqmQJ7Ok9
	 oj1O5EHgzv950CaktzJ7a4/jG3mKa6Gv8bWKbfnTivdRFQWHAr5O9MeLL39YZ7aMA4Ewp
	 tjXC7z0srVAXoYCajuvd3BWpK4Srq1Dqi5gQ4m7M4av8FVWc9nXnsQCXT8FDxB+irG1+u
	 ANK/ssZGMRcK84/NNo2mdIcexYA6hx/fUEBxRUqEU+UdvWR6E3prZcH8SfGHWojETHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D96BA1F031E2;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747823;
	bh=zoE5MU6/Q2Y799SulvDdtXvIf+blCTDBCGWCArCbVZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=injYxqcM5Mqh69ZM9bDkaeD2mIYreaFxuCu6mF+u5mLBhk8EzyS/683HK3ZlZkluB
	 m8XAH4bAi9UflnRJPrPhhuJwA7x0rcsuj9CvL8nOzrqiKJ5XstLz96cZ6KZSFLIDsl
	 kqNOJpc9BTXVRPSzTpIZKEAeoD6k+W2RhWTfDlmam6JPvDffOXWkMY+NpksnwZuh2e
	 HrmE7E1i7DYFpSsdVWMAB28llL+nnjn5RikSjrLb3gr4HhvFKy56kpdzsNOSm3WZXb
	 v5h7NegdRlhAZcPiCVbwZ2Ue0DyZVBYkrQ5HzzqPkH+GRY36HqjYm216gnSTzrutL8
	 EeseC+gbArpqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6144E44464;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 23 Oct 2026 12:30:21 +0300
Subject: [PATCH v4 4/8] dt-bindings: iio: imu: Add bindings for ADI
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
Message-Id: <20261023-adis16607-v4-4-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
In-Reply-To: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792747820; l=4494;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=eNbuHMKunrd8JuH6y864PXmgiiZ07gAmsjBjr3dOpoE=;
 b=qaPRfXUxqaD6HMx/QOp0CpvlT6JCjQOnM2KvxCbaY64NHop2cA8g/1wDWoDWpaZcI11+SaQE9
 rqwAjcIyCWZBVWNEDEePRb2KB/b2lOmylGL+XHaboTLtbes7EiMuRm0
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


