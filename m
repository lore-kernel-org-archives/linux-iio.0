Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8034D926
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947303; cv=none; b=rZpPSuX1vXLGA0Hiv8Pq9E11pSYxJ4iBaYKj7CIwdTRuMW/pyBhVJkEJPO09xmqJBbwPz5fEjO6sC/usZavGj5x5wzzOlzFk3kKyYqagg3vf6Rl0iv5npw2Hv5HjY9XNwh8QhcfLb3fBRE/jMJ0P2Te21VC0dBHqtx9bA9Mu8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947303; c=relaxed/simple;
	bh=4EjM03UFJMwqRWaq7ljPoN1VcURwDrGCpwR4elzGh/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ6nR0p1Fr6R+sGLpCPUvhIx5hDSr6uNwIK66in4LIQ/sj42I3Hm1jLh8JFLd4fUcUjl1d2I5hWYYPitOiutDFAZRK9Erg414X5JFgK2odc88OdR5DWMO0+SZWNcNOJ3X9YPOWqdyrEz2zrZqeCCKly/g/wqK1c2TDAsNvSwXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a9296b3926so10243205ad.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 12:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773947301; x=1774552101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Po+4YFI6AAfzY+YOM5ZAkfP6UA8LeTc7pa82LaIBMFc=;
        b=aOrpr7XLaNAo0mrm97Oc88vyNaQeJTNu0mNepnhVfs0Uyln2oz8usXGz/AcFX2nnqb
         BM3oS7NLYEiP+9I8jAgGuMu/vdbG2nga6ae3q8NHRGz6CuxiAJAGxbFs3F7pCUHpHeZG
         G+HVqvCrClFpoUyLTx3nxSOKDrYe+GK+X8zUc0n6wcIRiD3thNyduRPBBLQxj95EHNqN
         tAj3ICvBE+vxbCWBeK99HkoKhhM1v7u4Bs8CPmM75F9MzgRh6f5sQ+T187uzHVmF5ryY
         xbrOUoaQyaaTvWymTeH2mxo75ufrrYW8AuhQ0ML7OzS77JzKaSbsDADwCqW6z/+lj1aT
         5svA==
X-Gm-Message-State: AOJu0YwhNeEdafv/InVnU/HQEyszFm+7HnA8rpcKZWvm+yH+iBd5XGXV
	FzQR1zqpUn16ZMhHSM1xmX+yJSy20sbmjKepx0gUrWRHRa5QsljcRy3SYnK0e8DIpr8=
X-Gm-Gg: ATEYQzxJqBZRGnRqd/zrKIB0m9MeYQgNaTIRK8qHAzDfmpZFe/v8yOWj87SgDFsKZ5O
	pKoEN3mxu0bXs9dqgr3l1BZKW7s9GZEsV+SiW//BkS+xamPBQgNDA25A9HD3Dy9qlWZeJrbBLBP
	je7+Fh0yBuSGwgnJJaSDZeUYJmKoZdk6h7M7TA3qTRaYL4TiHnqnm3vAFBN9Cvw0hCfGDtMJKKc
	a/Skl+wRLeXLGboghM57tkisLVrrl97dsUd8lkapUmCfHYaj4/4Bu61Nhn1qHMJhuTVa0I+WeWg
	DdpgVWtGG9llwBSaAjKqFtHy7SnHzXzAJsr5ad7ZFB1UpI78XOJZ31ZMdgZDuXSRBrXn/rNYs/f
	J8Sldcr+iwapl4mmOQZz82bD6e1TWj3xXleJYvjWxuKS7U7aShEFR/SJdPCZUgWmhB15P6GWT8C
	z3IAqHmOKVgmZ0zVeQ62w8HPSStqrgqtfOBK5lu8hKwcl4zXZB2WJIn7N/dfu5fMnIMseiCiBoC
	RDu/pjx0HpOQby8sFcS/UnWId8C
X-Received: by 2002:a17:902:d510:b0:2b0:4eeb:f810 with SMTP id d9443c01a7336-2b082769d79mr3545765ad.31.1773947300517;
        Thu, 19 Mar 2026 12:08:20 -0700 (PDT)
Received: from archlinux.www.tp-link.com ([103.135.252.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e603b2asm68665345ad.55.2026.03.19.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:08:20 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Fri, 20 Mar 2026 01:07:13 +0600
Message-ID: <20260319190738.151614-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319190738.151614-1-email@sirat.me>
References: <20260319190738.151614-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the STMicroelectronics
VL53L1X Time-of-Flight ranging sensor connected via I2C.

Signed-off-by: Siratul Islam <email@sirat.me>
---
 .../bindings/iio/proximity/st,vl53l0x.yaml      | 17 +++++++++++++----
 MAINTAINERS                                     |  6 ++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 322befc41de6..de09f709850d 100644
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
@@ -21,12 +24,17 @@ properties:
 
   reset-gpios:
     maxItems: 1
+    description:
+      Phandle to the XSHUT GPIO. Used for hardware reset.
 
-  vdd-supply: true
+  vdd-supply:
+    description:
+      Phandle to the vdd input voltage. This is physically required for operation.
 
 required:
   - compatible
   - reg
+  - vdd-supply
 
 additionalProperties: false
 
@@ -38,8 +46,9 @@ examples:
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

