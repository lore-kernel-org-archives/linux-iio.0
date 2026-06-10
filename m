Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE73FFAC2
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089263; cv=none; b=oZqHWBigoSEIvnVG2hmRo8P4ALYp9NDFf/kuZYBA0ZkALpgdsbk25yY557Z7WePcbxTUJIF6b2rq43Fe2uxNmIp2sWB+n+VtFLVeaQL6JYUumyB69E9xZBpwiHw5dnAVWJkjo3NFQVkvaxR4cBKLmQHiRb3RLnQNItxbwk2YzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089263; c=relaxed/simple;
	bh=+5QjyCIXqoOD2KG8ssN0Jyq+DP5GNSKO2p3MUpiIhNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQTcrYsQiHSWrK4/ocsXwvHoYWT2OIa10cT73HZDJqmc7RjivHOQUq5bZZ3TaJAIUSAbvEu3S6M29GXmXUkA/40PwznVUl2NR/5HaP8tAMlbBBSczDoWbzBb6Hj3GPzdwBMK3DpJ0CkyoX3qbAN9YCotao8su4P1KQ6NQQsMHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlCVovis; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlCVovis"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68cd8dd3so6308124e87.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781089254; x=1781694054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGfk7FpNxoN7FBp84SSHRB57Da80W+DmQSUfqc67OcI=;
        b=JlCVovistxoJxW2gA3gDegF6fJut+KeswT61jekqqDOlxMOiiaKiXc90clDHo2P1r7
         rFVgrkI2uBpYoYN5uYXH3kk8An46hx4XQI+CAK39o5o7LDzCNRRHqKSo5i2sY9md5c9m
         O3xIJ595Ch4ZULM0sSJOxGP9/CsS7ooweYjcOaBsmjIKX8v44P3Czw44oS4oH/0uQ0xM
         JVUd+4cZ0xvng+1yVbmC4fnK5p3SXEo9dYYJflCmfdYl+wL7e50xHiTJMDJpfuzDtShG
         dJduKAVchhhVl+nRSaqOEP65s6Iwjgwaf/7P9r63fUWvBeDExW92jSuQ+ZxoQdYo67Fu
         P5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089254; x=1781694054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGfk7FpNxoN7FBp84SSHRB57Da80W+DmQSUfqc67OcI=;
        b=MY9IoEmhFtoAVsLdXH/gSIqvGhp3McexVDnWQfY4KMSoBgL8Km01Z8w1h29Oh3KlTY
         Yk0AVXNbqfyK2KDJXo75bUcccmy4nQR0YbdDgbztnebCA5ukXthvGyVAONhK2wLnMTx3
         6/dFj3YTURuCwktq3zunOMQsiHGXSAjmoMx0z/nSdcndZY59EUSE7GpFUw3vezHAO+yO
         m3nyH2qf5As+oCgpqyOI1yfgsEEAzVadmreu0MYBCRU+Jl6a38XEb8Iwe27RtE1xjCqs
         jknG3DJEX2zGpXpx6HrMwLZECMHFkx/xLB5dQmFvKv5DBtntJFB8OlglpLeGAbH6Y3EU
         J3Gg==
X-Gm-Message-State: AOJu0YxYfJNmjBUhG5FPz8dAY6VElUB7iKm9jZnr30jkCCN793wp2o+H
	SgfwNpjO6UWcwLCsX+Avl3W/4s8XUhMpotmZszY6lWfg1ePXrto7TnNfGNzP6d18zmk=
X-Gm-Gg: Acq92OGEaNF6Yq0sukdOgc9G9PtOyI1zltfJmCMc4ed8tU8SosDpLOgo24FxOGzH8TH
	1xzcdEENt32tZ8wNZZ750EgXSaTzXcVot3uzSpYnlkGmnPxiqBMDOO7RjjOfJdYv/PL5NzBPKoG
	eAvkIAJqUcSSEI5x0s0G73oYi4W0KWcHeP0tSRAVBgPqJciBoB90EhndrUXCy0X1CuwB4EebFvk
	qLotCL4+vWEA9GoTbUJcCBVCQG3p0WBMYXmYF5rzAC/A1xllyULMhsYXjBvCJrbzWCJtV1eOc4y
	Xt+0fGx93aN6XaS+llZ5d578nAQnMKvu3gXXjQSzWLf8+d2GFAH+QgmOgkv6GgNIxiKOaVcDMNJ
	8Xcq5AtUws2IrdJnAncRBE9pLcxRgu8oJZ/F158eyUxgPBptaUOCK0vufYGSUMH6Bi//vTNkXSG
	cQsYE4a/XyxH0sfixuzEd5grW+8gyRPdj+t3XhDMvSsn0wYDhk0PNRD7GoP55aqKzlPOAhp1954
	dhwVw==
X-Received: by 2002:a05:6512:804b:b0:5aa:70cc:49ca with SMTP id 2adb3069b0e04-5aa87b88e40mr4978495e87.31.1781089253403;
        Wed, 10 Jun 2026 04:00:53 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc426sm5306867e87.26.2026.06.10.04.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:00:52 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML schema
Date: Wed, 10 Jun 2026 14:00:51 +0300
Message-ID: <20260610110051.1228-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the STMicroelectronics LIS302DL/LIS3LV02D accelerometer device
tree binding from plain text format to YAML schema format.

The binding covers two variants matched via their respective bus drivers:
- SPI: st,lis302dl-spi (drivers/misc/lis3lv02d/lis3lv02d_spi.c)
- I2C: st,lis3lv02d   (drivers/misc/lis3lv02d/lis3lv02d_i2c.c)

Document all vendor-specific properties read by the driver via
of_property_read_*(), including click detection, IRQ routing, free-fall/
wake-up engines, high-pass filtering, axis remapping, output data rate,
and self-test limits.

Also correct the click threshold property names: the driver reads
"st,click-threshold-{x,y,z}" but the old .txt documented them as
"st,click-thresh-{x,y,z}".

Validated with: make dt_binding_check   DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../devicetree/bindings/iio/accel/lis302.txt  | 119 ------
 .../bindings/iio/accel/st,lis302dl.yaml       | 343 ++++++++++++++++++
 2 files changed, 343 insertions(+), 119 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/lis302.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/lis302.txt b/Documentation/devicetree/bindings/iio/accel/lis302.txt
deleted file mode 100644
index 457539647f36..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/lis302.txt
+++ /dev/null
@@ -1,119 +0,0 @@
-LIS302 accelerometer devicetree bindings
-
-This device is matched via its bus drivers, and has a number of properties
-that apply in on the generic device (independent from the bus).
-
-
-Required properties for the SPI bindings:
- - compatible: 		should be set to "st,lis3lv02d-spi"
- - reg:			the chipselect index
- - spi-max-frequency:	maximal bus speed, should be set to 1000000 unless
-			constrained by external circuitry
- - interrupts:		the interrupt generated by the device
-
-Required properties for the I2C bindings:
- - compatible:		should be set to "st,lis3lv02d"
- - reg:			i2c slave address
- - Vdd-supply:		The input supply for Vdd
- - Vdd_IO-supply:	The input supply for Vdd_IO
-
-
-Optional properties for all bus drivers:
-
- - st,click-single-{x,y,z}:	if present, tells the device to issue an
-				interrupt on single click events on the
-				x/y/z axis.
- - st,click-double-{x,y,z}:	if present, tells the device to issue an
-				interrupt on double click events on the
-				x/y/z axis.
- - st,click-thresh-{x,y,z}:	set the x/y/z axis threshold
- - st,click-click-time-limit:	click time limit, from 0 to 127.5msec
-				with step of 0.5 msec
- - st,click-latency:		click latency, from 0 to 255 msec with
-				step of 1 msec.
- - st,click-window:		click window, from 0 to 255 msec with
-				step of 1 msec.
- - st,irq{1,2}-disable:		disable IRQ 1/2
- - st,irq{1,2}-ff-wu-1:		raise IRQ 1/2 on FF_WU_1 condition
- - st,irq{1,2}-ff-wu-2:		raise IRQ 1/2 on FF_WU_2 condition
- - st,irq{1,2}-data-ready:	raise IRQ 1/2 on data ready condition
- - st,irq{1,2}-click:		raise IRQ 1/2 on click condition
- - st,irq-open-drain:		consider IRQ lines open-drain
- - st,irq-active-low:		make IRQ lines active low
- - st,wu-duration-1:		duration register for Free-Fall/Wake-Up
-				interrupt 1
- - st,wu-duration-2:		duration register for Free-Fall/Wake-Up
-				interrupt 2
- - st,wakeup-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
-				upper/lower limit
- - st,wakeup-threshold:		set wakeup threshold
- - st,wakeup2-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
-				upper/lower limit for second wakeup
-				engine.
- - st,wakeup2-threshold:	set wakeup threshold for second wakeup
-				engine.
- - st,highpass-cutoff-hz=:	1, 2, 4 or 8 for 1Hz, 2Hz, 4Hz or 8Hz of
-				highpass cut-off frequency
- - st,hipass{1,2}-disable:	disable highpass 1/2.
- - st,default-rate=:		set the default rate
- - st,axis-{x,y,z}=:		set the axis to map to the three coordinates.
-				Negative values can be used for inverted axis.
- - st,{min,max}-limit-{x,y,z}	set the min/max limits for x/y/z axis
-				(used by self-test)
-
-
-Example for a SPI device node:
-
-	accelerometer@0 {
-		compatible = "st,lis302dl-spi";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		interrupt-parent = <&gpio>;
-		interrupts = <104 0>;
-
-		st,click-single-x;
-		st,click-single-y;
-		st,click-single-z;
-		st,click-thresh-x = <10>;
-		st,click-thresh-y = <10>;
-		st,click-thresh-z = <10>;
-		st,irq1-click;
-		st,irq2-click;
-		st,wakeup-x-lo;
-		st,wakeup-x-hi;
-		st,wakeup-y-lo;
-		st,wakeup-y-hi;
-		st,wakeup-z-lo;
-		st,wakeup-z-hi;
-	};
-
-Example for a I2C device node:
-
-	lis331dlh: accelerometer@18 {
-		compatible = "st,lis331dlh", "st,lis3lv02d";
-		reg = <0x18>;
-		Vdd-supply = <&lis3_reg>;
-		Vdd_IO-supply = <&lis3_reg>;
-
-		st,click-single-x;
-		st,click-single-y;
-		st,click-single-z;
-		st,click-thresh-x = <10>;
-		st,click-thresh-y = <10>;
-		st,click-thresh-z = <10>;
-		st,irq1-click;
-		st,irq2-click;
-		st,wakeup-x-lo;
-		st,wakeup-x-hi;
-		st,wakeup-y-lo;
-		st,wakeup-y-hi;
-		st,wakeup-z-lo;
-		st,wakeup-z-hi;
-		st,min-limit-x = <120>;
-		st,min-limit-y = <120>;
-		st,min-limit-z = <140>;
-		st,max-limit-x = <550>;
-		st,max-limit-y = <550>;
-		st,max-limit-z = <750>;
-	};
-
diff --git a/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
new file mode 100644
index 000000000000..befc419f7f39
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
@@ -0,0 +1,343 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/st,lis302dl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics LIS302DL/LIS3LV02D 3-Axis Accelerometer
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  STMicroelectronics LIS302DL (SPI) and LIS3LV02D (I2C) 3-axis MEMS
+  accelerometers. Supports click detection, free-fall/wake-up interrupts,
+  high-pass filtering, axis remapping, and self-test functions.
+
+  Driver located at drivers/misc/lis3lv02d/.
+
+properties:
+  compatible:
+    enum:
+      - st,lis302dl-spi
+      - st,lis3lv02d
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  Vdd-supply:
+    description: Main power supply regulator (I2C variant).
+
+  Vdd_IO-supply:
+    description: I/O power supply regulator (I2C variant).
+
+  st,click-single-x:
+    type: boolean
+    description: Enable single-click detection on X axis.
+
+  st,click-double-x:
+    type: boolean
+    description: Enable double-click detection on X axis.
+
+  st,click-single-y:
+    type: boolean
+    description: Enable single-click detection on Y axis.
+
+  st,click-double-y:
+    type: boolean
+    description: Enable double-click detection on Y axis.
+
+  st,click-single-z:
+    type: boolean
+    description: Enable single-click detection on Z axis.
+
+  st,click-double-z:
+    type: boolean
+    description: Enable double-click detection on Z axis.
+
+  st,click-threshold-x:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Click detection threshold for X axis.
+
+  st,click-threshold-y:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Click detection threshold for Y axis.
+
+  st,click-threshold-z:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Click detection threshold for Z axis.
+
+  st,click-time-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Click time limit, 0 to 127.5 ms in 0.5 ms steps.
+
+  st,click-latency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Click latency, 0 to 255 ms in 1 ms steps.
+
+  st,click-window:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Click window, 0 to 255 ms in 1 ms steps.
+
+  st,irq1-disable:
+    type: boolean
+    description: Disable IRQ1 pin.
+
+  st,irq1-ff-wu-1:
+    type: boolean
+    description: Route free-fall/wake-up 1 event to IRQ1 pin.
+
+  st,irq1-ff-wu-2:
+    type: boolean
+    description: Route free-fall/wake-up 2 event to IRQ1 pin.
+
+  st,irq1-data-ready:
+    type: boolean
+    description: Route data-ready event to IRQ1 pin.
+
+  st,irq1-click:
+    type: boolean
+    description: Route click event to IRQ1 pin.
+
+  st,irq2-disable:
+    type: boolean
+    description: Disable IRQ2 pin.
+
+  st,irq2-ff-wu-1:
+    type: boolean
+    description: Route free-fall/wake-up 1 event to IRQ2 pin.
+
+  st,irq2-ff-wu-2:
+    type: boolean
+    description: Route free-fall/wake-up 2 event to IRQ2 pin.
+
+  st,irq2-data-ready:
+    type: boolean
+    description: Route data-ready event to IRQ2 pin.
+
+  st,irq2-click:
+    type: boolean
+    description: Route click event to IRQ2 pin.
+
+  st,irq-open-drain:
+    type: boolean
+    description: Configure IRQ lines as open-drain.
+
+  st,irq-active-low:
+    type: boolean
+    description: Configure IRQ lines as active-low.
+
+  st,wu-duration-1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Duration register for free-fall/wake-up interrupt 1.
+
+  st,wu-duration-2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Duration register for free-fall/wake-up interrupt 2.
+
+  st,wakeup-x-lo:
+    type: boolean
+    description: Enable wake-up on X axis lower threshold crossing.
+
+  st,wakeup-x-hi:
+    type: boolean
+    description: Enable wake-up on X axis upper threshold crossing.
+
+  st,wakeup-y-lo:
+    type: boolean
+    description: Enable wake-up on Y axis lower threshold crossing.
+
+  st,wakeup-y-hi:
+    type: boolean
+    description: Enable wake-up on Y axis upper threshold crossing.
+
+  st,wakeup-z-lo:
+    type: boolean
+    description: Enable wake-up on Z axis lower threshold crossing.
+
+  st,wakeup-z-hi:
+    type: boolean
+    description: Enable wake-up on Z axis upper threshold crossing.
+
+  st,wakeup-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Threshold for wake-up engine 1.
+
+  st,wakeup2-x-lo:
+    type: boolean
+    description: Enable wake-up engine 2 on X axis lower threshold.
+
+  st,wakeup2-x-hi:
+    type: boolean
+    description: Enable wake-up engine 2 on X axis upper threshold.
+
+  st,wakeup2-y-lo:
+    type: boolean
+    description: Enable wake-up engine 2 on Y axis lower threshold.
+
+  st,wakeup2-y-hi:
+    type: boolean
+    description: Enable wake-up engine 2 on Y axis upper threshold.
+
+  st,wakeup2-z-lo:
+    type: boolean
+    description: Enable wake-up engine 2 on Z axis lower threshold.
+
+  st,wakeup2-z-hi:
+    type: boolean
+    description: Enable wake-up engine 2 on Z axis upper threshold.
+
+  st,wakeup2-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Threshold for wake-up engine 2.
+
+  st,highpass-cutoff-hz:
+    enum: [1, 2, 4, 8]
+    description: High-pass filter cut-off frequency in Hz.
+
+  st,hipass1-disable:
+    type: boolean
+    description: Disable high-pass filter 1.
+
+  st,hipass2-disable:
+    type: boolean
+    description: Disable high-pass filter 2.
+
+  st,axis-x:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: |
+      Map physical X axis. Negative values invert the direction.
+      Valid range -3 to 3, excluding 0.
+
+  st,axis-y:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: |
+      Map physical Y axis. Negative values invert the direction.
+      Valid range -3 to 3, excluding 0.
+
+  st,axis-z:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: |
+      Map physical Z axis. Negative values invert the direction.
+      Valid range -3 to 3, excluding 0.
+
+  st,default-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Default output data rate in Hz.
+
+  st,min-limit-x:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Minimum self-test limit for X axis.
+
+  st,min-limit-y:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Minimum self-test limit for Y axis.
+
+  st,min-limit-z:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Minimum self-test limit for Z axis.
+
+  st,max-limit-x:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Maximum self-test limit for X axis.
+
+  st,max-limit-y:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Maximum self-test limit for Y axis.
+
+  st,max-limit-z:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Maximum self-test limit for Z axis.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - st,lis302dl-spi
+    then:
+      required:
+        - spi-max-frequency
+        - interrupts
+  - if:
+      properties:
+        compatible:
+          enum:
+            - st,lis3lv02d
+    then:
+      required:
+        - Vdd-supply
+        - Vdd_IO-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@0 {
+            compatible = "st,lis302dl-spi";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            interrupt-parent = <&gpio>;
+            interrupts = <104 IRQ_TYPE_EDGE_RISING>;
+            st,click-single-x;
+            st,click-single-y;
+            st,click-single-z;
+            st,click-threshold-x = <10>;
+            st,click-threshold-y = <10>;
+            st,click-threshold-z = <10>;
+            st,irq1-click;
+            st,irq2-click;
+            st,wakeup-x-lo;
+            st,wakeup-x-hi;
+            st,wakeup-y-lo;
+            st,wakeup-y-hi;
+            st,wakeup-z-lo;
+            st,wakeup-z-hi;
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@18 {
+            compatible = "st,lis3lv02d";
+            reg = <0x18>;
+            Vdd-supply = <&lis3_reg>;
+            Vdd_IO-supply = <&lis3_reg>;
+            st,click-single-x;
+            st,click-single-y;
+            st,click-single-z;
+            st,click-threshold-x = <10>;
+            st,click-threshold-y = <10>;
+            st,click-threshold-z = <10>;
+            st,irq1-click;
+            st,irq2-click;
+            st,wakeup-x-lo;
+            st,wakeup-x-hi;
+            st,wakeup-y-lo;
+            st,wakeup-y-hi;
+            st,wakeup-z-lo;
+            st,wakeup-z-hi;
+            st,min-limit-x = <120>;
+            st,min-limit-y = <120>;
+            st,min-limit-z = <140>;
+            st,max-limit-x = <550>;
+            st,max-limit-y = <550>;
+            st,max-limit-z = <750>;
+        };
+    };
+...
-- 
2.51.1

