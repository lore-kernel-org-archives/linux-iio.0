Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684135FF6B
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470026; cv=none; b=e0s+Nr7OxmpfNck+GREGQ1ppp6Gy98vPFR6iWJhe7k+3+4k6TMFRqDb7UH/UPiH2r5H4dn006i/oae7hlxRkVJOMVJHQA47Bq8+m0qU+Jbhqk2QX6Z9x52w6pSTy2gON+Z23Sg43GmQw+V5zpttVs5PwtAes7o3IUrWt07zzVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470026; c=relaxed/simple;
	bh=8R2nRMTpNx0hPRXdARFDfIVrrrQqtMRyhIM/X1ptw4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnMlJ70Vlh+bmximDWyaSQY/5/aMJ1+bjglT3nHxV67BnfYfisKV9urrNRtJl8WWCgy58/7yt79O2ZChowHUX6Hfpq5lo+1iQ+Sgs1LUCKMw924+Q441OXtHC/qfQhLU3zFxFSz0TjENJT734asf4ecGbQF77YqpmiSPB1F0Vmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35b98def50bso189244a91.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 13:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470025; x=1775074825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQv+ZppFPPLtEPidAQ+20u5P3TvQUDZOQRWkCdljIik=;
        b=LD10v6owdT4EeQM3IwdC60CpQdYf0ebWv/Y+wW5xX655z2pFrr/7WwuxFW17wK7XFd
         Rr1xpG8T3JdphBIYvTM+cw0Y2f9odBmz83jcIuFRCjFwf6Jh/HrJ5vePF4S+7CYQZH9K
         0MXYHKz35INOfie8AxJj6aG7bt6TDwJ2vwv30s0tgkSVMPA+RK/XFXLp3PvFoFRwPpzn
         3uG/ZTB/jjVZ/70oNMxFrhKd4jG/mEfF8R4HOjpxaZhtrC9OKsiS0R0JpHDaozw8VmE3
         4qNSz5MLU34BrOtPKdzqQsKFoXlttYstNRwAuLAF9cJIz8mSTSmfUOoC7hILrlhBIbxG
         B6+A==
X-Gm-Message-State: AOJu0YzVGeGfNreV/cmeqqKSn3nlS3zm2MVWeOCHCPl8V/eIS9thOPrE
	36TopPooQPnVcN7jHXghNP2hB1LtRw6+PRocexlqWAoFxQqiM9o44v8dmkPYiDPHpUg=
X-Gm-Gg: ATEYQzww0RFUZxZ/H0tJ2ubH9nAwo1krdhka82HBycSluPWVI5BUctwJTUajhN3gGsd
	2QJTMulfbof+/RzIqx4oT/eyCH8IT8zTeIKJQkrrO84Z4QvESEJ0fJloo51VLQZTuwJsdJvFigV
	ktHWZUkMmWFhnFBW4a89iNds3/mAyKlbnjMRncI1ip9D5M0mrkCaWKjGX+r+v9SUBnf7LsrMhfs
	wQb4BJl6yd3LAYDjOekb67jUtGOu8wms94ubbQnTozSKrM9i8igbqV0LLdZMxMAjpSoTsR9Fl8a
	/WfLJR8pOwI+zpSxv6reA0WDfFkcuvGUR+uWrRtegp9BjGwkDKMrm8s5G+mvb+BAPiRfTA5a6Xl
	oZzT+gczHSp86/pDGrRJVkSYmYxiRMUG4Egh0GwI5h6wPXm2OitBMKWF3SlHZfUHNLWz5kH+Z8n
	rdwzgfB5ZkaSGFWyOBzBAj3FYxvjKYOO3FmVA7n0A3M/AagL2zj1Z2BlAol3Afn0Gy10JH5YwTO
	c1TYiWmF3hQq6vKEMrIzFu1
X-Received: by 2002:a17:90b:540f:b0:356:1db4:8fe5 with SMTP id 98e67ed59e1d1-35c0ddaa5admr4243177a91.29.1774470024544;
        Wed, 25 Mar 2026 13:20:24 -0700 (PDT)
Received: from archlinux.www.tp-link.com ([103.135.252.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm280511a12.21.2026.03.25.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:20:24 -0700 (PDT)
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
Subject: [PATCH v8 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Thu, 26 Mar 2026 02:19:41 +0600
Message-ID: <20260325202005.29822-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325202005.29822-1-email@sirat.me>
References: <20260325202005.29822-1-email@sirat.me>
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
 .../bindings/iio/proximity/st,vl53l0x.yaml    | 24 ++++++++++++++++---
 MAINTAINERS                                   |  6 +++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 322befc41de6..9adb9b13ccc5 100644
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
@@ -21,6 +24,8 @@ properties:
 
   reset-gpios:
     maxItems: 1
+    description:
+      Phandle to the XSHUT GPIO. Used for hardware reset.
 
   vdd-supply: true
 
@@ -28,6 +33,18 @@ required:
   - compatible
   - reg
 
+# vdd-supply is not made globally required to maintain backwards compatibility
+# with existing st,vl53l0x devicetrees that do not specify it.
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,vl53l1x
+    then:
+      required:
+        - vdd-supply
+
 additionalProperties: false
 
 examples:
@@ -38,8 +55,9 @@ examples:
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

