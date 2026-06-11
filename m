Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A183F7898
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192476; cv=none; b=IUt3pnbD2RjnsEN5CfU5n72mP5Vfwdod3drvds/7qrz/Ri+B/I2oPC+nJmNn2aIYU2RTXFgt8MU33cJb2U4VsiBDGS6c3/IZPcAQ+uNRZNFrfWYKAzrcWgVwrsKp2YZ/vxb8n3ANitEOWPsb+CGyIiezoRUu6cSIVktyRrjlZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192476; c=relaxed/simple;
	bh=sqFNFBXkXek7UEZoG28vWnt30khU1scMPvEGMNp+0IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4Al5AztbMRgmb0CnRQbT0HSpjUMRLYLctV6QL5d8hiVWrduHuqR1Jfx8/f4egXeVQU+7f4a8B24y61Kkr5q/VyLdL76MMUmrvCb9niJwbnLPzCL8i0y7Y1F3XB//FGmsMyGyizWJ16hZjkSHuFUzcs2Pp5hLFZTU9SBr/nGbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KW7zyqy4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW7zyqy4"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3965eab14cfso169761fa.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192471; x=1781797271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbpbOEIKe50enqix894PV3p/ZMGmpyIxZkZ04xwhy2I=;
        b=KW7zyqy4EUm8+I0tCLApX9duVsu08eERTGrx8IbcBcV/TWKOtMIUf2NUm+tSFb8oAG
         e3JAU2ijw+dAhJPGEsLLhLr4EIcrXShiJ+GGMaSVm1Ovc4VSMYHEkTF/O5sC+5skZTGo
         X5Ur1EcmoiedNiXCW8/ZQvvrltEhb9ywqe4YWWtWC0wM0odRzxYCZs+z/A4eh4JagGhh
         S4MgZFlenTVv6aXGUzEsDETM70oVg7jg/fP0ijekHQ3o6Z8a2dWgNURx4199tGxcnd8f
         +PYbkZ7TsWeKpR8wUtd+KHhrWZbI9ux3njPmHGn97Dl8QF1UcnZKzwFavj8S1BROlrtD
         zlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192471; x=1781797271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbpbOEIKe50enqix894PV3p/ZMGmpyIxZkZ04xwhy2I=;
        b=cX3AhElDUXKKt1dhXyq1Ivy/r8I6diAU4FJasP6UjSQ9EJ+FVFYjREkREMDoOuF3e2
         tI86c228ITc5s9oqqvfqckZWDNDDH2A7JxehE6h5fQHnbjgJ1oHcDgM+oy3W6uJGp0Zj
         htia+xUzxc7GaFzqsUxqam+pSo4gWoYPfHLjDG/nMZDsUIPFikHdFVZ37q1F2KNlvNTH
         VGaIh/BXeVM2hBBLE1Zw3HtbbAA5ZWTp2urvUooQDIHnm4wmt1EQ6jqnrrMDmQvGhYYV
         VLjAO3M8oWp7n5IJunQH5Q2tXHyFQUuvpiYi82ztxLVDthcGttSG9WLoadg3KcyJIVcn
         nMtg==
X-Gm-Message-State: AOJu0YyM+duuo27FFkMePaRmIEGXUdsiWOChMGKIgzxBs8/1uR5Rb9sa
	rbXJpvBPn/rRnghNKDBYfV7ij4C/ejlQEsa5ht9RikPcblYIUkm6i7jfmZ2BDFl2t94=
X-Gm-Gg: Acq92OHxmG0dXQ55AauKIqvEA+3FApnA5FJCtONOrlphytj/PblOodbWQaX7OQemzPG
	tyMjfD9jqVN3cNFMBN6DESO7EVCTdT3vNauSzwjqefVklWZctsg6uEhc7N8L5aq9tun61yR3srr
	WgSHeEgm2WuPEaprvMYEpD/8Gon9aEqi8f1Nk1F77rn2DJjACGkye2fR+RILISVb01XtfEnzVNL
	erpL8cHSoA9XVgW/G5ZCxoHj0q4xP0KqsTsXPGZ3rFdOdzNZza4jEULJB0IZ69YtXLtH1bIcdz3
	66g9Kekbwn8yG1313t1DJ8iSNc1pLSiqSrHFurlFSzNtk3XfnX7ZQVQygj02janI9+1Jq/jLtTx
	1LW0QZMmD3VUcLWw2XLGwZIguSHIuttskqTQRCvJM1dlkzp0JFRE/kMqGlol3r3/KVBIHuiaJRx
	M1y3X2+VwuPaTAqHlV4ky3CbuC+oj5WpXUek634TwU4U1RsEZfMEiTFJdkSsvzLhkhir4=
X-Received: by 2002:a2e:ad0a:0:b0:396:73ed:695d with SMTP id 38308e7fff4ca-3991a062724mr9900261fa.11.1781192470662;
        Thu, 11 Jun 2026 08:41:10 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991ac81488sm5994641fa.1.2026.06.11.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:41:10 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: iio: accel: convert lis302 binding to YAML schema (v2)
Date: Thu, 11 Jun 2026 18:41:05 +0300
Message-ID: <20260611154105.3727-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260611154105.3727-1-shofiqtest@gmail.com>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the plain text lis302.txt with a YAML schema for the
LIS302DL/LIS3LV02D accelerometer family.

Key changes from v1:
- Add a prominent WARNING in the description that this is a legacy
  binding and must not be copied for new devices
- Add st,lis302dl compatible (used by Nokia N900 / omap3-n900.dts)
  in addition to st,lis302dl-spi and st,lis3lv02d
- Document both supply naming conventions: Vdd-supply/Vdd_IO-supply
  (legacy uppercase, used by most boards) and vdd-supply/vddio-supply
  (modern lowercase, used by Nokia N900)
- Add mount-matrix support (used by Nokia N900)
- Add self-test limit properties st,min-limit-x/y/z and
  st,max-limit-x/y/z (these legitimately belong in DT as they
  encode per-board hardware tolerances)
- Mark all click/irq/wakeup/filter properties as deprecated=true.
  They configure run-time driver behaviour, not hardware, and should
  not appear in DT for new boards
- Add st,click-thresh-x/y/z as deprecated with an explicit note that
  this is a misspelling present in several upstream boards; the driver
  reads st,click-threshold-x/y/z and never reads the short form
- Remove driver path reference from description
- Use schema constraints (minimum/maximum) for axis remapping range
- Remove Jonathan Cameron as maintainer; use Linus Walleij who
  already maintains the related st,st-sensors binding
- Use example based on actual upstream board (Nokia N900)

Boards using this as primary binding:
  st,lis302dl:     omap3-n900.dts
  st,lis3lv02d:    omap3-n950-n9.dtsi, am335x-pepper.dts
  st,lis302dl-spi: pxa300-raumfeld-controller.dts

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../devicetree/bindings/iio/accel/lis302.txt  | 119 -------
 .../bindings/iio/accel/st,lis302dl.yaml       | 320 ++++++++++++++++++
 2 files changed, 320 insertions(+), 119 deletions(-)
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
index 000000000000..8a19aa108521
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
@@ -0,0 +1,320 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/st,lis302dl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics LIS302DL/LIS3LV02D 3-Axis Accelerometer (Legacy Binding)
+
+description: |
+  WARNING: This is a legacy binding for hardware that predates modern DT
+  practices. It is documented as-found in upstream board files. Do NOT use
+  this as a template for new drivers or bindings.
+
+  The driver lives in drivers/misc/lis3lv02d, not in IIO. Many properties
+  listed here represent run-time driver configuration that would normally not
+  appear in device tree. They are documented here only because existing
+  upstream board DTS files use them.
+
+  Compatibles st,lis302dl-spi and st,lis3lv02d were previously listed as
+  deprecated in st,st-sensors.yaml. They are moved here with their actual
+  hardware configuration so validation works correctly.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: I2C variant (original part)
+        const: st,lis302dl
+      - description: I2C variant (larger range)
+        const: st,lis3lv02d
+      - description: SPI variant; including the bus type in the compatible
+          string is a legacy naming error, do not copy for new bindings
+        const: st,lis302dl-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  Vdd-supply:
+    description: Main power supply (legacy uppercase name used by most boards).
+
+  Vdd_IO-supply:
+    description: I/O power supply (legacy uppercase name used by most boards).
+
+  vdd-supply:
+    description: Main power supply (modern lowercase name, used by omap3-n900).
+
+  vddio-supply:
+    description: I/O power supply (modern lowercase name, used by omap3-n900).
+
+  mount-matrix:
+    description: 3x3 mounting rotation matrix.
+
+  st,min-limit-x:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Minimum acceptable self-test delta for X axis.
+
+  st,min-limit-y:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Minimum acceptable self-test delta for Y axis.
+
+  st,min-limit-z:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Minimum acceptable self-test delta for Z axis.
+
+  st,max-limit-x:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Maximum acceptable self-test delta for X axis.
+
+  st,max-limit-y:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Maximum acceptable self-test delta for Y axis.
+
+  st,max-limit-z:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Maximum acceptable self-test delta for Z axis.
+
+  # The following properties configure run-time driver behaviour and do not
+  # describe hardware. They are deprecated. Documented here only so that
+  # existing upstream board DTS files pass dt_binding_check.
+
+  st,click-single-x:
+    type: boolean
+    deprecated: true
+    description: Enable single-click detection on X axis.
+
+  st,click-single-y:
+    type: boolean
+    deprecated: true
+    description: Enable single-click detection on Y axis.
+
+  st,click-single-z:
+    type: boolean
+    deprecated: true
+    description: Enable single-click detection on Z axis.
+
+  st,click-threshold-x:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: Click threshold X axis. Driver default is used if absent.
+
+  st,click-threshold-y:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: Click threshold Y axis. Driver default is used if absent.
+
+  st,click-threshold-z:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: Click threshold Z axis. Driver default is used if absent.
+
+  st,click-thresh-x:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: |
+      Misspelling of st,click-threshold-x present in several upstream board
+      files. The driver does not read this property; it is silently ignored.
+      Documented here only to avoid dt_binding_check failures on those boards.
+
+  st,click-thresh-y:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: See st,click-thresh-x.
+
+  st,click-thresh-z:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: See st,click-thresh-x.
+
+  st,click-time-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: Click time limit in 0.5ms steps (0-127).
+
+  st,click-latency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description: Click latency in 1ms steps (0-255).
+
+  st,click-window:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+
+  st,irq1-click:
+    type: boolean
+    deprecated: true
+  st,irq2-click:
+    type: boolean
+    deprecated: true
+  st,irq1-ff-wu-1:
+    type: boolean
+    deprecated: true
+  st,irq1-ff-wu-2:
+    type: boolean
+    deprecated: true
+  st,irq2-ff-wu-1:
+    type: boolean
+    deprecated: true
+  st,irq2-ff-wu-2:
+    type: boolean
+    deprecated: true
+  st,irq1-data-ready:
+    type: boolean
+    deprecated: true
+  st,irq2-data-ready:
+    type: boolean
+    deprecated: true
+  st,irq1-disable:
+    type: boolean
+    deprecated: true
+  st,irq2-disable:
+    type: boolean
+    deprecated: true
+  st,irq-open-drain:
+    type: boolean
+    deprecated: true
+  st,irq-active-low:
+    type: boolean
+    deprecated: true
+
+  st,wakeup-x-lo:
+    type: boolean
+    deprecated: true
+  st,wakeup-x-hi:
+    type: boolean
+    deprecated: true
+  st,wakeup-y-lo:
+    type: boolean
+    deprecated: true
+  st,wakeup-y-hi:
+    type: boolean
+    deprecated: true
+  st,wakeup-z-lo:
+    type: boolean
+    deprecated: true
+  st,wakeup-z-hi:
+    type: boolean
+    deprecated: true
+  st,wakeup-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+
+  st,wakeup2-x-lo:
+    type: boolean
+    deprecated: true
+  st,wakeup2-x-hi:
+    type: boolean
+    deprecated: true
+  st,wakeup2-y-lo:
+    type: boolean
+    deprecated: true
+  st,wakeup2-y-hi:
+    type: boolean
+    deprecated: true
+  st,wakeup2-z-lo:
+    type: boolean
+    deprecated: true
+  st,wakeup2-z-hi:
+    type: boolean
+    deprecated: true
+  st,wakeup2-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+
+  st,wu-duration-1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+  st,wu-duration-2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+
+  st,highpass-cutoff-hz:
+    enum: [1, 2, 4, 8]
+    deprecated: true
+  st,hipass1-disable:
+    type: boolean
+    deprecated: true
+  st,hipass2-disable:
+    type: boolean
+    deprecated: true
+
+  st,default-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+
+  st,axis-x:
+    $ref: /schemas/types.yaml#/definitions/int32
+    minimum: -3
+    maximum: 3
+    deprecated: true
+    description: Axis remapping. Replaced by mount-matrix.
+
+  st,axis-y:
+    $ref: /schemas/types.yaml#/definitions/int32
+    minimum: -3
+    maximum: 3
+    deprecated: true
+    description: Axis remapping. Replaced by mount-matrix.
+
+  st,axis-z:
+    $ref: /schemas/types.yaml#/definitions/int32
+    minimum: -3
+    maximum: 3
+    deprecated: true
+    description: Axis remapping. Replaced by mount-matrix.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@1d {
+            compatible = "st,lis302dl";
+            reg = <0x1d>;
+            vdd-supply = <&vaux1>;
+            vddio-supply = <&vio>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <21 IRQ_TYPE_EDGE_RISING>,
+                         <20 IRQ_TYPE_EDGE_RISING>;
+            mount-matrix = "-1", "0", "0",
+                            "0", "1", "0",
+                            "0", "0", "-1";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@1 {
+            compatible = "st,lis302dl-spi";
+            reg = <1>;
+            spi-max-frequency = <1000000>;
+            interrupt-parent = <&gpio>;
+            interrupts = <104 IRQ_TYPE_EDGE_FALLING>;
+            st,click-single-x;
+            st,click-single-y;
+            st,click-single-z;
+            st,irq1-click;
+            st,irq2-click;
+        };
+    };
+...
-- 
2.51.1

