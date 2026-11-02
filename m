Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611544;
	b=uPy0RAvOUEwx/oVabaom/xoWOdaaCwiPlrMKXuhdS7pWK21C4oC7Ch8VmviQxriIi8ZN
	 CeVwDe2ohSI4iBTMN9k7H/D5rOrjQ1h43nnltTTOuQod+9qS/LiP25+ms7FYkJlSuIlCp
	 KeywpFvgpqEc5S2pF23dbRzv/gxBWG7++UgIrcT3oV7BQuEEzsHtQcdStlFUCrMUWesiO
	 xhg1kFbIr0JMLkDzKpPhgYvHIsHPc/ok8Cd9H4aDgjPDqL5wPYubzhB2DIBHyqc6907Qe
	 yjyoQK5WdroSsSkMUCrjy3Vz8lPwgTwrqUOLlaEMo3cPw+Ba69wM6aaHxQwZ/WjCF3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611544;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dAmi6q14Q9gImkHuQ9LuZnCLdziGrzGFmzUubLStCYY=;
	b=pAsVX689xSvuiE25GuO1zxTxQQkcOSxejQwOPCMhyUnSQfVk+9WWC/lpW9MY4jjc6gYE
	 3YQgB+h3H9rKvfx7e2uRl/R3IqXozfNN93ix9wMzQXwp9coRdeI5bE4w/NJZ0z1Gx/sZH
	 UwA6H+ddDCLddkPlJUunZsXciaGr7oonvJX7fq+BM5HeS7kBmoDE2f3cDi5QAJOWoMdiS
	 VezKWBHwWBjHjep9R+Na0Uu7kpCMOwPHYp+2q+ovi/wm0w5Ee+TOAMd+9FQMGyEin69xw
	 PXs/av33a+p+aNsK5fnEkOdMdCOgSSUOeMC+hCfgbf3Eavzd1s+DAbBbgevuudZ/nHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guaT2B5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A060A3801;
	Mon,  2 Nov 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guaT2B5J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793611543;
	b=WX+vd4COkM/6deKjgHKH3MiLP/NKcZsvooHtZvU05qOqsSGH4X6ANAJwnEuAER0hIz5N
	 OfqLMUSt4DbsuCV++HBpHRgky3G8/Dp55CITD2j4UgSYkXiShkXZFTi9kJ9u4AQN6lBYg
	 8T+QKuNwovHF0kJA7FDfJE7fCODkAI073nb8LnUCpH1pB76vCTi462EaDr0EoVpHTDkml
	 LnVbGujq0u4dSPrD7UHlesOKE5zdYWFX0t0xEJGZV6xoWwE2dmU2/jU9McvhtIEPo1SSL
	 12ktsgtZntciAWPHkRINXZ3KQAkqlWEDQQ0GE45TTswqGYBZPqY2ajRdio2r2Kutykg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611543;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dAmi6q14Q9gImkHuQ9LuZnCLdziGrzGFmzUubLStCYY=;
	b=Mvxc09KvlbesRE+6KtfuoIxuNCb2k30N2aAdCldX0jFQRhKT8JFJI8EQGGOxbzckT0qB
	 0fR9VW74EIsw0IydniXdqvLQnL2T/eK+uRvx84yGoAQKpEDczWryBXXtzZHmauM2Bs622
	 sKjSvkpEwlG6rUTLf2lZ70Ua3Vmdek3+Ztf94rZg/aIcQcuyYAt1xBnOfZukoxZp4+rqQ
	 35BpO2DWSY9Ao8hf/N7eRzpbV+phrODZeWcT68esFjDcSO2WCdvxddYCGvVKdLmOPowDh
	 UYne3gnxZPrqpLjTDdZ+90BPd9tydqg6QSqbuNUPSXTK47Cy6VU3v3w5QgkxLQsKWFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4C1571F00A25;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611543;
	bh=dAmi6q14Q9gImkHuQ9LuZnCLdziGrzGFmzUubLStCYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=guaT2B5J3dJAbDuwzbaS6N5FP7GqU0we5/GmOR1jfkwOkpqSKm4tfQIaEpGQT4Zlo
	 vfYDCWV3g04zINAOQay/mgRzOjfo2jleKQIiGADkEH37MkZ+U9GjFu0ymSKelOSxdd
	 mF/J5Yvq4z7YXr+fvvMBRVHvp6HfkQca9TEJjkWFodogzALsessbt7QmGDdIDKvm/h
	 xC55RGqMU8pmJXQUNORPj4FpCCHs6gH+LkreSZ5Ta/OB5wYZBGBZ2XbIK1DvMjkzNc
	 KBOOci83sDur3p7oAP1l3kfwiUNAAEmxFiNhDxvZBqR5p5GeHkqGQwK9xTsEdtlHwX
	 Dy8KSKJ9nU9Yw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D24A846449;
	Mon,  2 Nov 2026 09:25:40 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 11:25:40 +0200
Subject: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
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
Message-Id: <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
In-Reply-To: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793611539; l=4444;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=SAtl7dLGUqcgnJ9wSgDpOErMnjHQjhHS0GOiEvJSp/U=;
 b=N1Ieq1xugQ9fMbqx2H94p0OiSk/pgVVVw5eyP9QZQMHS6RH9q95IlqXdD4tm1AXfCoDSOYC6s
 +pqBevb7g8tAxHKDHcyZN5YKe4DjNhSa+712Qc8qTCb+0YoKlsP4p5I
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


