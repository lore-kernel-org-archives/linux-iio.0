Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325B40D565
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041679; cv=none; b=GXv+MXtwV8pQr2dAqKBjIJ91uimhFTFIaNJQwsE8JdL2rNq1mgCAb4Z2Tm5N3I5weU+3MPsAPAjnltTGFaTdcfjW1NkAAF+vIaf7TQbaD1JvK4dQRVYaI4u4XAc+vYgpaGtpB3RPACWdE623Tf1OC3cpooQ1Q3FTIZgK4QR70nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041679; c=relaxed/simple;
	bh=+5QjyCIXqoOD2KG8ssN0Jyq+DP5GNSKO2p3MUpiIhNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRzaT/6Lc/yyaQyXPh2zSDD6WP+89zn+BGQSYJtvx++VK41TW9WSvkoq36xHs+DS6BTlR0vhC29HO5WqnWAiHg2BQb68WuYQniRXTOFYGHIFBx6IGXP+JWA0/zu43ApsXXWn++1WYlXTWlI7sZUA/f86HEHxttrh2nd9qQhNBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv2/jfWs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv2/jfWs"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396bed274b9so53037181fa.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781041676; x=1781646476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGfk7FpNxoN7FBp84SSHRB57Da80W+DmQSUfqc67OcI=;
        b=dv2/jfWsvb15/hf3xKi2QrRmRrerH/U0NTNK2NzlMJF78h5VU26SgQvyOEqO63Lpt/
         UaHTVZEIcmujvI0/8NiAVEXjxDSIf3x/qXfO2nw8KlkDS+B2Ra+K2L7lspJ++P0o78J3
         qzbL1KnOT2lLdvaH5sV8txWkfe4T13oKIzckqqozG0DSFd8njIPW5dQoaieWdWpH+yXl
         wRRAyhldhhsR3glHMtAZSaOJRRKroZmJ1w5dBAWqRgrOpCnTUZ3tnq/1U5y8A+VGfW72
         6oq2TbtSXT5/+yd8YR9+1Z6U2bOkzB62i/1S7YSc6B9Kl6f3GBmuOHKGqkJU7JIMaQAn
         rLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041676; x=1781646476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGfk7FpNxoN7FBp84SSHRB57Da80W+DmQSUfqc67OcI=;
        b=QHQYx+07FjabpUHaoZups8WE+ruA55C+cky2HUZx99yrNQCCJ4LsnsE4QLW05pGVI6
         OnB8jeg3FlpcZ6+vsd9GwH+RcErd8gseXsfkmAD6cTEXokYMF72dstxgJK6/cUSBcmkQ
         naZP2L6qMmw3WQ1fKXlTmkYik+fxaTzYcsJzSW2uiHG+42jsfN11iHDOZLpBT/HjXniW
         M/E4ZCKHHhnddMPqsBUjCOIL0vHN136adH9GiOd5/7zH2Vv1dK8Jg3SQp3DI768monHj
         KJjKgu2fcK9bcKnsECZLIDnV+vYCA/+rn4BlzDdBXfxIi2HzqL+/IaoX7O/+Era8UMUf
         jROQ==
X-Gm-Message-State: AOJu0Yw9MRG9867sCFvdnvb4S6oQkrUNkwLEgRdFeSm4hlhWqitZRahS
	caKTWNNlwdZa2KW6FEMiXn1lEwV+RInvKnQlvBxNtnskzLSR//9DuB/tsdHu198v
X-Gm-Gg: Acq92OEwUtZ2bwuwPeq9m1TMWrPAAZANdd9qRdaD97JaJwLH108gsjJ2yVVUdsCu/eN
	ZC4zU5mGmVlsJRqGiorU02fXjDyu2lXwTVCU4Ho/EgimclLEEOC2MYSVEUIxEglVboHPPI55Hn0
	i6cTo0felisAvlvumbvEnKlPnLR5grGJJAQsV8/8ykN5erQrt4d/5fYwLtktu/pF6Dn86WYT9mr
	Q1FTaXn/at9/DS5oJLM2p59uY3jw6o5lH4BdvomWEL6NCtgzIdji55oCODaWJrfGwc9T+CAsSFy
	K+WCPPi7p+xQe6CQ9pW8iHu5cS6b7sr22Ul4vyWbg41EDA0dKbDPSg2nJTJ+Twomam9Afznix5B
	zXRFpPA331e218Zi5SQ/Z/tBhYHEca/9pVMjfcu0qXpVP5SHoFvbKb8uf89MrUaZkj+6tC5ZljH
	MwCyrGLQAXwzwuvo1bkCVUwQ4s0TBMPESUfpORjEd+z4R+7M3P8nklvjJxs253PN5YW9A=
X-Received: by 2002:a05:651c:220e:b0:393:903c:2258 with SMTP id 38308e7fff4ca-396d08e3ff4mr64729811fa.16.1781041675533;
        Tue, 09 Jun 2026 14:47:55 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07aa0csm57996191fa.10.2026.06.09.14.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:47:55 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML schema
Date: Wed, 10 Jun 2026 00:47:53 +0300
Message-ID: <20260609214753.4479-1-shofiqtest@gmail.com>
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

