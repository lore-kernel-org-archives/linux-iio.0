Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98435AC12
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420408; cv=none; b=XfechMs2viaNGe79T8+35iT5Lhj8yCxWQaFhYqMcrbYeM0PWLOCJayP+wNNxHAGT4ZcQmTVNSFK8RUcH2uucr33PlQ+9cvkrlt97ofsWsPcpcjaW9xEu7PurPmrHrrkX2WtV7asYrjJWmHkWmqzKL2/p//jOubbt8zdwWjABG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420408; c=relaxed/simple;
	bh=M6krZqWk+1xRZ1+XHAx11ZNWOnRIL7gAft8MYXY7kBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ufn9OqW2zqv2HXJJx7YAQAu9ArJ408PaUD/Osw4BWOP6Gzj+2wgA9225sCxTKqWVV7yqgz+ArvXMVPIECoOGEIC8dpf8th7LGzdP521ygUogkBvzwo1KUUnF4ZZEqGfIeN2gNnC5UD/wXz9zRowtML77GCOdSa+CHdR9h5/9X6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso403957a91.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 23:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420404; x=1775025204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8q7m09ueuFwbYZwgVeKygswhkm7TJMTHIOKO/qEEZyc=;
        b=iJZrnhQUk/dfOO78M1IRksE5SeQEjshYV2pHDWU5mA0oa+6o65/JdahUS4z/AAMo5v
         OufDeslw4TZ8QwGKHrvLEhu8JL8YWRD/tErs2r6kwC40E6VpQNp+6Ux8rPZG8y9Sp6we
         SrzLK0FOu49IUL6OfF/UN5T1b+CAS3+ZtWbwJto6Z/OpbJ/SLY2khEqZmsynw0A7awG0
         wnvuYIdfiJxa6u0km0JtvtOYUdq1fECpnB/QoO5XDo1v/YiEvZyM6zk/y8GXY9ro6DWr
         CRgJz74pNFphMs9q2Wv7+4nckm9HfX2xhK3XvKXR8sxvAsmlEkDa8MM9/90KQtGUmzED
         GOsA==
X-Gm-Message-State: AOJu0YyVqBVXqmoTWA3TSVJW0J+Tb6J8vqa5ViqIdkDEhjTnrQ7Ak309
	uNvRNUsP/te0Mqf+7o/h8gf0eqnRINzAa3AhwtFAM3R2T7n9Zy78pSvYCQJY1/2qLA8=
X-Gm-Gg: ATEYQzxBdEupnqsB1Ul1gf1h9cXHuFJn2KhGnedtSE+2d4u9dijZ0Uz2BCdl1kLsuIE
	ZdbQK2GlOC1/+Q9g1HTo7/ltvOW94PCfA35KeMe2uIARi828x+/arbLUT/UShezePzVUJRumdQU
	dvMRcl5uTGjQJHRrYiy2o9hliA0P+4JXiSHhocIcMEYYYzeBq14Kn16ihcHNN+h9iAv0lAFczFP
	MBfDASESRKjkdweSapwDStNjRlf2fgJAG52i8+tbZmvaNr28CFxHOmVmxrIV5R1XyPtsSnobmA8
	wVZaUqI15eAc5Eodbkz9ZRBWnWAuV5koBL7vYXfiJwALYkKEOAy1KANKg6/yauFQZe0TmlC3OVP
	Yr9g8aFuw83OvH5k5+XRN3yGq9Yfg5DyhzIUdOFde1R+BXjSHQ6rTxZP013SyRTIg09loXgpZPs
	IpFd9/2d4P38xIKN+Dfqu45QLQX8iTux3iKXkgrQDOui7d+0UQ7O4n3t/haAwLWxSa2dM4neEXy
	9iWUK0=
X-Received: by 2002:a17:90b:4ccc:b0:35b:e962:11e0 with SMTP id 98e67ed59e1d1-35c007f4eb4mr5369874a91.8.1774420404401;
        Tue, 24 Mar 2026 23:33:24 -0700 (PDT)
Received: from archlinux ([103.135.252.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0e954ba9sm526854a91.5.2026.03.24.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:33:24 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v7 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Wed, 25 Mar 2026 12:32:22 +0600
Message-ID: <20260325063254.18062-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325063254.18062-1-email@sirat.me>
References: <20260325063254.18062-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the STMicroelectronics
VL53L1X Time-of-Flight ranging sensor connected via I2C.

Make vdd-supply required. The device requires power to operate
and the property should have been required from the start.

Signed-off-by: Siratul Islam <email@sirat.me>
---
 .../bindings/iio/proximity/st,vl53l0x.yaml          | 13 ++++++++++---
 MAINTAINERS                                         |  6 ++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 322befc41de6..09102310abc3 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -4,14 +4,17 @@
 $id: http://devicetree.org/schemas/iio/proximity/st,vl53l0x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ST VL53L0X ToF ranging sensor
+title: ST VL53L0X/VL53L1X ToF ranging sensor
 
 maintainers:
   - Song Qiang <songqiang1304521@gmail.com>
+  - Siratul Islam <email@sirat.me>
 
 properties:
   compatible:
-    const: st,vl53l0x
+    enum:
+      - st,vl53l0x
+      - st,vl53l1x
 
   reg:
     maxItems: 1
@@ -21,12 +24,15 @@ properties:
 
   reset-gpios:
     maxItems: 1
+    description:
+      Phandle to the XSHUT GPIO. Used for hardware reset.
 
   vdd-supply: true
 
 required:
   - compatible
   - reg
+  - vdd-supply
 
 additionalProperties: false
 
@@ -38,8 +44,9 @@ examples:
         #size-cells = <0>;
 
         proximity@29 {
-            compatible = "st,vl53l0x";
+            compatible = "st,vl53l1x";
             reg = <0x29>;
+            vdd-supply = <&reg_3v3>;
             interrupt-parent = <&gpio>;
             interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
         };
diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..a142a97be4cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25093,6 +25093,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
+ST VL53L1X ToF RANGER(I2C) IIO DRIVER
+M:	Siratul Islam <email@sirat.me>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Sasha Levin <sashal@kernel.org>
-- 
2.53.0

