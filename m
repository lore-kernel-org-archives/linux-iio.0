Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465582;
	b=Z8Q713N3MXNVJQyeM7eOcq/LCHucT4DcFCpatE7/FMhuYkVSFLL/pfnqKRa5g8bmZINW
	 eHzrtV+DWxb+WHRUamlOGdJYYz/rZupOn+YjD1zrsp22uyrz7Tv/vDtu9Q35nvdE0FcT2
	 jLn0RZCW242ucYVWifViC3zJo+8szjBWz9klLasKcH7nPACidjGmewtv5AGe2Aoto8WZl
	 JHpAfivjraRpmsAubr88Alm9WKzw0DrkUxyTj+pwXbsZEem8nDI/skwfwWPSVe4IghgYP
	 j83L15NZjYh0OTQrOf3lxYSDDZk1Cnq+DyZFlCiT2GKUNuZghFiXjYNIvEf99hv4C7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
	b=pvckfNaY+Tud+b75f1/tDnN+UaNgionPZwVS3NfwTSxuS84wAiV+QvzvEdcbegynuc1y
	 sI3cgHQcrm20J4apKn5JAANg5PNOQsprWt+H1Ip9NWZ5N89nZZNXCAKaIbnG20DvUHxHv
	 mIy4Sj0JzJiV/bxxDkLAnIq38/ONM9FIn/wvE/KcWWnaCN/WNuej9t67fBcHgYQxZFqUU
	 7LF6bcwy8q7HjGh25uBHDD5wSatp6HaTj5QD/GeUSyd46OpjePh+sR6bigBFUyJo/pLrE
	 UjBetxJ+R/03wNvnAKMA0IDDSu2XiJJIOyfYb9zw/XKsiIHlc68QKWzAw1aEq+JYthQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FysIJprS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15DA606A330
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 20:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15DA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FysIJprS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so35845785e9.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 12:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795465580; x=1796070380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=FysIJprSQoRhm65u/m4uJ97MQ37OW0ApCwYwDghZ70EpscxF+jbQw+BXTVpUXGRSsT
         KQuDWTxeUz8Gy4ES7fNVLKaCGCfqSGP5AFG8t1u1VxSEHlcR2EizPwR3i/Q795lpe/no
         gEoouCw2q+jXoIrf64kAcU09XXCwoSJY3snC2BB4eDNjcCUwUrHUOkkgR2geEBAHNGP+
         Gkd7a4Dr6EUN/nKedhRKsPS7+MlkudrNeAsU9WzJNJeHvFy09E8VL+v5ZEjxGFeBupjo
         kCcJVJWRl2d91lndlhRnXWvOKDEDWIEJq60dqe6W2Xqf1IhENq0qJ6aQKutA8760dwpr
         Vtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465580; x=1796070380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=urch9jA4JsT4L9PI+ngW770YyJgelm77D1XOCDgldxk04TkxAbOWfto+Mf0Ch1Jl5t
         laewf5amzzA2TuljzuJfPOegBpuyKsUhgXqtIEohwV01LZAVUkoVn6CfTuhyjpKp8hTa
         0WsfAG7ygs8nanhasDJRqtghrv6l99R8S1+4WJGYHhtI3zRDuK8ly+/nJLJuvPUBnjOG
         qkHGy4wgY2RAX5uTG4GTpRS2/D1lD2cdi8Y5V+9JuQJt9Zm5Hr2vBDCdysFXRFeRFbjy
         uRKR3Qn0iCgpQ9C6HUrb8vDIZzKBWTruLW4QmRtjq21XL+2ezw8RjOePw8bW7vUUmHXH
         TbQg==
X-Forwarded-Encrypted: i=1; AL+hErFHeoIpXW8WP0i68eoED4+Mkm/Tt/uiAiyA/YuvAcAkYW+Kj/1eC9hIOUjjFGD1vg/27FFpKq3e7jQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZqL+2vCFJ4w+vARRTyavPaDuMKkCzqdXrwzCHuaET7B4Lm0ER
	s2OKfYo1qyJ0/Yhfd5cw+QgXrroAMEuOUnm5NNrRLY6QsuRrdGiYNcrpwQj0+1NS7jk=
X-Gm-Gg: AZFdTZczJXIvUnbJNUR+ZmMiY/++hh+bJfAusKEAN1SO2F8tFOvjQTdOWDd5fa6u2iD
	4BpnNPc80Z1AXxaqlgxQnSTFaGVlU+bkKB7bd6pFZFnS5HsOrlIN4p6XW5QnKn9KWUi38hg32Xe
	QpAz4BNSd8a8E0EeYkyFhZbpRd+Gc5NZhOHrbtY+fSwcrEGEQKIDUrkjUoOG8/8thEYtdiAR+/O
	ulu8Pob81At6yUC9xE/NcXYykUVPcwJBpccg4dsDu6BhSVmLPmm8UpXcq17Lh/5mBfZD3lC4u5I
	DqcVX34uyRrPx+6hH644VlYOBFD8PGEXia8x8UIo6qDN9SNRRz7c+JevDv/UeJq875Wy4f8F3mc
	X3AR+Aeh47c34oCughtaVakNeoApD0p86KFYtXG640LgghGI+4jqFRaQy8yoTMt3V8EQskfsDZC
	rMixw9DV6otmQYcd8aqMGASzbMgrQZFUFkCwMxEukOee1xWGI9mGZdqIDzgYk/AOzT2iKRHhgo6
	5q4dRJ5BZWEQ1/S6Xmmx34Xgl/B7J8MCOpXhe5Z2xqIEAz7AMdvKt69ZbcrH8BAgbCTqzxRlu34
	MudNgEL1uynxBcm1Mg7OVL/NDcaI/iFPdLXFGhUXh73Qcs/ieUvAAMgLnuJIvh1baWWX8G8UU/Q
	1PQFahDN2Kzw=
X-Received: by 2002:a05:600c:848a:b0:4a2:1960:6fa with SMTP id 5b1f17b1804b1-4bb887fb678mr249466655e9.4.1795465580088;
        Mon, 23 Nov 2026 12:26:20 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm20108713f8f.46.2026.11.23.12.26.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 12:26:19 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
Date: Mon, 23 Nov 2026 21:26:12 +0100
Message-ID: <20261123202616.17334-2-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123202616.17334-1-gerard@teslabs.com>
References: <20261123202616.17334-1-gerard@teslabs.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC5603NJ and MMC5633NJL are listed in trivial-devices.yaml, which
allows no properties besides the register address and interrupts.
Boards need to describe how the sensor is oriented, and the supply it
runs from, which is often switched on wearables.

Give them a binding of their own, covering both the I2C and I3C
connections of the MMC5633NJL.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 2 files changed, 61 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml
new file mode 100644
index 000000000000..423b8ecbb9e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5633.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MEMSIC MMC5603 and MMC5633 3-axis magnetic sensors
+
+maintainers:
+  - Gerard Marull-Paretas <gerard@teslabs.com>
+
+description:
+  The MMC5603NJ is connected over I2C, the MMC5633NJL over I2C or I3C.
+
+properties:
+  compatible:
+    enum:
+      - memsic,mmc5603
+      - memsic,mmc5633
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  mount-matrix:
+    description: An optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@30 {
+            compatible = "memsic,mmc5603";
+            reg = <0x30>;
+            vdd-supply = <&vdd_1v8>;
+            mount-matrix = "-1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "-1";
+        };
+    };
+
+  - |
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        magnetometer@30,4a20000f000 {
+            compatible = "memsic,mmc5633";
+            reg = <0x30 0x4a2 0xf000>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a8b2b9deade4..523c205c0880 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -261,10 +261,6 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
-            # MEMSIC 3-axis magnetometer
-          - memsic,mmc5603
-            # MEMSIC 3-axis magnetometer (Support I3C HDR)
-          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer
-- 
2.45.2

