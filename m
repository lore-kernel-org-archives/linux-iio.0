Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055432F742
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187050; cv=none; b=Ubf4vVsogCm+3VwCthBsDKwNJX6PYt3ZDgAUmivmdIyy1TdCzBwlp1uqkUzd3yMCj7MJlqXthz2OzOzS9G9dBZZk17p1tFp7TbsF1DUxD7ErV6cXGMM77BjU28bteHgvadUZZ1LpsRJ79OIez2g7bWJ24JLQHTCS+ZUnRO1Rs+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187050; c=relaxed/simple;
	bh=AOxnWcfWeesRJ4bFE8C5mp3XzQPiFrCWQ1jQQ3BS+ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMqttvKvVFQTAYVKX9OGhE3NgbEhtKnvpvyQP1IDLDGsKyZDjMEdbqM7D6yF0Yte1lEwb0K81H2GzMyuB2/kZkm1fA1tpUfbbQGKf8K+VE5X6tNG3f7g4YK4VZtVFkAO0frQVIzeuC8oB9exLo7VZgAwnBPNaArIf/UUiATzDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXqR7u58; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXqR7u58"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so965912f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778187047; x=1778791847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y481mY9CQVhRv3fozlAOGsM8mhraJQWHsP9dPteZdbU=;
        b=VXqR7u5896SP44j0c0CXEBPBtTqYNFFViBQUItnKSq5SLZKbb8docDm0BR/N3tWNDW
         D3EkmWk9f5GKh3+tGsUKoGxfzdpC79k1G3+l54pRjnWP8nYaqb/S2cBqwM1AAfxUg/Yf
         o1DcbugFtsgocDiPzqV718luq02rDbpR/D+HrUQil9v7qROhuG6EzGzMmWAaPgCiXsxx
         YiXKMQtFiS6tBTP/1VpvL0hpgm1dZOI4XWPiKGLsjBO+p0nZmor1cfzymbtTMLRugMqb
         J9BLRNrhZmIivdzX6n8ykKC+ZdvnHmvOOF+8WCzgcEHHSOjknEF1A0oz87a2rreVYEwX
         Edug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187047; x=1778791847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y481mY9CQVhRv3fozlAOGsM8mhraJQWHsP9dPteZdbU=;
        b=ThXf7/Up225Wr81DR94Q7lhlGrnBGmlGKCAi82gB/FhbLbNNlnzn6VEOY2n/TlpgYP
         JHSG7lhBdTKJca5TX/GjQUdsNAPxmk4ye2G/6c2TKHoNH4TVhQfkGWS+oRnTvcb0wfVe
         5zJbJxFIGImNRSjGyPz9KRCW5hZly4AoDD3gi0yIln4R1m/zJwpKicb/9VmO3LaNNlV2
         UGG85bI2fFhObFaMdcHzZkvqIHilfGBwO68mVmQNyOHes3pmEmy4/34KOiYf9xiEv/bg
         vr+m14Qu6LoWRyBTWv15qx8ZCwyZmurGIAod8XX4JicTUX6D3ThIXAOyIuOS3NE7JjAv
         xf1w==
X-Gm-Message-State: AOJu0Yw45oL+JpvjOh4TUE8qNs0RQXA5AaEtDsIFAkxukGCYAGzGa9hB
	3YCzS9hyell7r2hdz2JBoz42mBZ9wCzzqy07bEBUgmY9rhXafGPzmJepJy9Lk0jO
X-Gm-Gg: Acq92OGRN/acaML8Vl9q3696bGsGZFf/I+ERwEuGV1G4bpqWhUGaEel2S8kDia9//BP
	uFjn1uXmcE5KAsnVq06soyemBqph/sEIS+eT0/DUq+4OO5JmmYXSm8TpAmwJWHok1y5yU1Ow5cD
	rt4TJSGWkdTTecJHzCLhZAwkVxembxO9IWfm873H8OztO7c7bT6qQ3ncdEV8LvvF5s75R97hi1I
	t0pklqZBkcB/orhX4/MVmVUDx1tBxiLdht1b1l+lFTBLjPFSiZtzaaLLCd4FKvYBk53kuncY9Wn
	isHgF82u0o6k2vDwZOKhrA6tILsdLKxsOuO86+pJTFlhpBrnAJCVcP+zKwyd5M1HSrDTFOcqTKN
	w4qkhf8fH2Bhir84oNeeDipuJW00tzN+a4hKECgSj5xdQuSj+x31A4JcMPgi3O/BRtyNGjTrZD5
	GuqdSrJ8AnTPzX6ACSurS4vuzEpGF0pJ5S6og+/fAueZdEk3Huz7NF/RfyFs2prwq0xjwAABXwe
	lL1GL16zuuUWDs9/uw=
X-Received: by 2002:a05:6000:144b:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-4515ce1bd58mr15451559f8f.24.1778187047042;
        Thu, 07 May 2026 13:50:47 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454175f59a5sm1401635f8f.32.2026.05.07.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:50:46 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
Date: Thu,  7 May 2026 20:50:31 +0000
Message-ID: <20260507205033.951990-2-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Devicetree binding for the MEMSIC MMC5983MA 3-axis
magnetometer.

MMC5983MA is not register-compatible with the existing MEMSIC
magnetometer drivers. It has a different register map, 18-bit output
data format, and I2C/SPI transport support.

Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
---
 .../iio/magnetometer/memsic,mmc5983.yaml      | 65 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
new file mode 100644
index 000000000000..e144b4d9b0ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5983.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MEMSIC MMC5983MA 3-axis magnetic sensor
+
+maintainers:
+  - Vladislav Kulikov <vlad.kulikov.c@gmail.com>
+
+properties:
+  compatible:
+    const: memsic,mmc5983
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the digital interface and INT pin
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example for I2C
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@30 {
+            compatible = "memsic,mmc5983";
+            reg = <0x30>;
+            vdd-supply = <&vdd_3v3_reg>;
+            vddio-supply = <&vdd_3v3_reg>;
+        };
+    };
+  - |
+    // Example for SPI
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@0 {
+            compatible = "memsic,mmc5983";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            vdd-supply = <&vdd_3v3_reg>;
+            vddio-supply = <&vdd_3v3_reg>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..952fbf3020a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17170,6 +17170,12 @@ F:	drivers/mtd/
 F:	include/linux/mtd/
 F:	include/uapi/mtd/
 
+MEMSIC MMC5983 MAGNETOMETER DRIVER
+M:	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
+
 MEN A21 WATCHDOG DRIVER
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
 L:	linux-watchdog@vger.kernel.org
-- 
2.43.0

