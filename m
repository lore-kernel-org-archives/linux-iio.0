Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4939A7FD
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950815; cv=none; b=Cccio4lvJUuK1wb73aTcQ0opOVQtlkNZnG7//wnDLvria0bdp9K2blSTOfP7KcE9T6sm4uFTmrWXQuShKL3q+DdzDPkFfLtr8wl/K0lL/PW4z2FwJb0mwPbhiNr3Axf9DGRgPZTe8f6PRgSYCrsUeW++Tpl++rPzzbG4+vIaGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950815; c=relaxed/simple;
	bh=3sl7Q8RsM38aogZg/TT4Z4kExJczhYLR1lProrBeQrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seA2a0sKa4ABmXvo5cpBYkVfdt/ZiKUVBIkWBjLFqDoC9hamBgVmMoTd5VwPDTNT++usYTnk5H8eDQ5/gzZH7A/4UbxMPEBkXK42ZLgFXcm12CKTGczmPj50gKxUDVmtm2fr3serEmO1miBPk8uWPz6Glsv9LjVt55Y7wrkFQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H98Om4+w; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H98Om4+w"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f053b7b90so3934271b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950812; x=1772555612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUsICOMvXTU5rjy5Y1VVi2FLx1XR69GqWTxj0tN8RHA=;
        b=H98Om4+w6bLK3uD3ZVrwWdQ3qEay3XlobYtVgwH5T7Yu4lVLxx8+rDEruGNBoToH6O
         fI+OU4Wjq0OtJ1WO2lA4aD/iWWeD4roq78mEU+uZ0hgLPMD6dFmLJfu/z4b6U71bZ/Vu
         irFusbeYd0S3addm5Ry40jvbeJWD765RfzedHL/WlukPoIEVovBE/9ms3U8UGtcYCUUl
         NiXgQcigxbAo2I0KkhngRY/6HKQv31S43gblSjsIIfgvOd8GFzxZqWA4MqdVfbpHsg9W
         XLXiyKT4559xLtFILR2jhEgKOk/0g93hLf+q6llWHoM26dSjFkcBf+hgzpCfj9c8PGVE
         0kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950812; x=1772555612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUsICOMvXTU5rjy5Y1VVi2FLx1XR69GqWTxj0tN8RHA=;
        b=K/nhiHwA+G7ZhAtDLGYdf1FrVSxxpxSiE16yE+CBaSnRrrjjpSTkXMlHFoMMRziV44
         uZEMl7RMvjfuKp2JVk5CAvJTqywG/0YHZ3CUX0JYzFO/Px6nV0Ro6uJ0KdE3o+o7lnzT
         aHy1hqZvYw4DcGggI8wZ9ZsX4pL5U36me0LXzQHrOV1XaZo5BjYJBfePu8G1/3+rJanc
         MiXSVLBL1dW34y0LcSqMjm+Nadf3cNiYnmisULA5gXiQAI6NEWJQziAYaCmePOE/KdL0
         ifOIzLi/YH6QyHqRmb8iV8eyPCbHZdfF4MCgxOsNC30SOoGnotXEnE6xvJsuP2M+FDKl
         P2aw==
X-Gm-Message-State: AOJu0YzpNJWOJwz3OhMcFYD6JM4JalIHkdXCLrgy8EDzy4YdxjNaDAWI
	xoTD2hRYbdEIA9AjNw0McgfjPUEyFUmXA/T8GpAxvyEagggJs1PZHKSstOb3TA==
X-Gm-Gg: AZuq6aKX4hkyv/Yl7KaHjK9uESxRHCT0p5fYdkRSp16s5VkUgL9yXVAbvSIJGuV4+jS
	oV058TPawB/Ked1E0GWBaNi5ATwY35QAQmfD93XivOPmeriS4lqGjJFi970siIZv8fzHD+0L5NY
	FmMhG7bpWNQGXGeYoWBu6myT9GS1ajTeKk5a2MhpxzhuNTwFaY1d2YE46Yis0t8TvpXCAfnKJ/y
	/vEnqKPdNRIQC6nknOXr+pxU8idRRD7wZCEwfbUerEIFI+yXa1HyEZEzmbeURjELr+NJKh6+CJk
	EKg6OQURIF2XTcFTKXVLlGsKMF9f3Uynpu1SloCT2nt0+EXvnY3sc/ACDCt0tDLMW4cAwjPnVeG
	lSGceY3rA1tQhuCjtpOIn64JgpGWC6CWbASUExMpkXwJJbJwYgC2mdrbswxLogiBxGbzJyObNbB
	oHgclC6IkdseSYKxYF1VXz
X-Received: by 2002:a05:6808:4fd4:b0:45f:727:8fdf with SMTP id 5614622812f47-4644638d060mr7303360b6e.48.1771950811989;
        Tue, 24 Feb 2026 08:33:31 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0725c4sm11060130a34.25.2026.02.24.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:33:31 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: imu: icm42607: Add devicetree binding
Date: Tue, 24 Feb 2026 10:31:03 -0600
Message-ID: <20260224163109.370930-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224163109.370930-1-macroalpha82@gmail.com>
References: <20260224163109.370930-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add devicetree binding for the Invensense ICM42607 and Invensense
ICM42607P inertial measurement unit. This unit is a combined
accelerometer, gyroscope, and thermometer available via I2C or SPI.

This device is functionally very similar to the icm42600 series with a
very different register layout.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/imu/invensense,icm42607.yaml | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
new file mode 100644
index 000000000000..d783ef063f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/invensense,icm42607.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-42607 Inertial Measurement Unit
+
+description: |
+  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
+  accelerometer.
+
+properties:
+  compatible:
+    enum:
+      - invensense,icm42607
+      - invensense,icm42607p
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+
+  mount-matrix: true
+
+  spi-cpha: true
+  spi-cpol: true
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        icm42607p@68 {
+            compatible = "invensense,icm42607p";
+            reg = <0x68>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        icm42607p@0 {
+            compatible = "invensense,icm42607p";
+            reg = <0>;
+            spi-max-frequency = <24000000>;
+            spi-cpha;
+            spi-cpol;
+            interrupt-parent = <&gpio1>;
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+        };
+    };
-- 
2.43.0

