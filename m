Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1441F4180
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900868; cv=none; b=dV5z24/X1ALPYW4FBZ/W5oegKZpOIDuG/4aBsXhYIgwoLKYqcPkzW8alMc18NSHXi+K4aJ5uqu0tq4HmdnYb0We6C748gss/fY3qY25lAIk5hlOt46ON8HcVQgfjP6vWYNosS+8CO0wtiCt1BQB7aO+QGzObkH3DmM0dtXkxMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900868; c=relaxed/simple;
	bh=mDLoFnMQGHrV8oAIHwyEtD5zBQKYR5P0vpUAevxmWYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRFYtm9kgpWqjUlhtW1Fg3gyBUDXO8hFmi1AiG2Xlgx6ENqwSufqBOsQwXqeFiikpb2Bksm4UoBJXf6OoJTIwDN4lmIIL7lXsXtUk03lKX7JcWHnZjuuGKFcEUI75fW1T6MYIQ4eXysfQJlC5ajV4z/rBC5Jw+T3EGxJzNKNaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz8vI7S9; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz8vI7S9"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7eb85fb81so4833377a34.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900866; x=1775505666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYmk7Juh371mJLYlWmXpOsfmVRoJgbYF90ddSYIGfYY=;
        b=Rz8vI7S9/KCtPPvs2zzdQnMPnTScpcBdsYkCeOCFdZ3uVXm28D9ZjqLBJtJBWdBGa/
         g7KlNfXTOUMb5Uj0k6uJB71s0K96XdE8x5lSOJ+IE/efZCe9rXfzsJNH3KnyZyc89orD
         7/P1BCL1O2eKJMFZ5Yrj4J4AxcuPyTnC+DHEJpc3gVXj1n2dr2RiPsGaD0gTLFtFxoqx
         6fq0KCM8dLqATjOB8bdTLmxyn0R7o6Vy4jS+yk6nEbsTKpf57G/B6tFZUqliO0mVPRYX
         eh/UyBgNzxa//HawF9aRL/RYT0u1eS1DP8A5xfd/aCfrzgSSq3mzEjXHGMm9qdKvTGeE
         /OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900866; x=1775505666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYmk7Juh371mJLYlWmXpOsfmVRoJgbYF90ddSYIGfYY=;
        b=f7GguaHj6KWZX8gk4w63JuWLHTfVLRBgM2hwY9VmWnBa9qh7cDKXYsXv5RPqYhs567
         T5ezM3lIkk/357naXwBVrnZTCdkKauZVM5Cuc9FAcjVwThY+rFw8nPa/wiGL/l7THhuQ
         CNBewtnK+VhS3+FXQ7oSR5NPcp+AuSHemBwCyZOOQYlF79Aa/RA8r7Iki9qR4MdEn3/M
         385S1CFTgsX3qQuwhOCVHao/jhwWis+nu2UFly3WFfUpN9Fwc5VIl4LpSdnJnUpgLaA/
         D0Ei+I6CvV2u5/yHdKGKDBUDCtxhCEoMCmYUZdR+WYKx9iMe2txWxEXrNrdhFhmNb8J3
         ieMQ==
X-Gm-Message-State: AOJu0YxhmHk7eixVxApRTjtlVlN3pCaWEwbR8UAaZPlZ9sg63vDmhXmx
	aIi3SOi5ThYQUG6KC+VJqucG+Q6z39oHPPDGof2TUYLU9LaJD/FJb/uaEaBA84MP
X-Gm-Gg: ATEYQzyq5UMgm7mHuPGWgwwXT0LXLwuSKbooFeEvITrdWD25sDl6MmNztL9e81JP0Vw
	A8+7D312hndVWjjZjmmay8Bp2h2T0YigkRgAd+FuCVsJ+X3p8d7zIBT2ZBmjqn3BKRdljxo5jy3
	uGhrEDdhZUHhZnYQtMGYpQyJ/Yg5BOCNokvexzraXmNJU5rXSha5zkW2iEpOgG1M5cn3FFWunkV
	ixXMUkOhVPEqZoHHGPXAbkG3QhPx+NwvO9+8qYOpF4qef0YkzTL/FgeI6UjrfPkhZddgT7MSJzq
	Dh7v7vxO9nmJm6tHhe+hBlpabQtwj7M/Y8DVg0pZDN3ms9X5aDmwNHwXzng9HSAHlFWUbzUuJx2
	OaaFSR7u2QFNLuaZCs2fYjNn6aUdJv8wxQic0YLnKBvX0tRDBPrlo8WLmvlXFC5Q7uYMXzbGDW+
	P5lDNCRaOe0IHRPOKjgtT2
X-Received: by 2002:a05:6830:6ad3:b0:7d7:ecf8:6b with SMTP id 46e09a7af769-7d9fad90512mr8299965a34.2.1774900866434;
        Mon, 30 Mar 2026 13:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm6601068a34.2.2026.03.30.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:01:05 -0700 (PDT)
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
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 1/9] dt-bindings: iio: imu: icm42607: Add devicetree binding
Date: Mon, 30 Mar 2026 14:58:45 -0500
Message-ID: <20260330195853.392877-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330195853.392877-1-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
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
 .../bindings/iio/imu/invensense,icm42607.yaml | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
new file mode 100644
index 000000000000..bbacdee5b906
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/invensense,icm42607.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-42607 Inertial Measurement Unit
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
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

