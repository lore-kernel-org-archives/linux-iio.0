Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0E4ADD85
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526711; cv=none; b=UF8Jgkb+ig7A4ICipHa0zU7MIBQYxxNsyNUn133NXJQ0fU3VeziGvwdx0Lkz8Wr01oeyJXZYYfjfXoZIocN+iTpM3GfE40zzcWJrYcuTrZVm1SRgeCBpSyFJv1aKBWog0qMViWU0Fxs3xKzN9+QtDbdZYX4yjT3vkQhpJCzsAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526711; c=relaxed/simple;
	bh=0gia/RMbzCkzlAa4V6/Iz/DeCuBc+phgrBlK70Ot/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIV+UsNYpGrTGvpoSiBAqqaHR7EI/PSAmXFWHmOPHsGPqW+neMnb+psx3MzTHoInJut07jbY6U91YplTg/lBw6A3owKnTOyKMVFG4bgXYqUpd6u6mqZg9gHDCqnak4JZ0ayBut/keGmzfNSbeRjGKz/Czp7hhbSRahbirEVlUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua2YFeMT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua2YFeMT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891f625344so44855905e9.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778526709; x=1779131509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sGdjD/CZ83xlAQBQK80MN5eYGa/z/UivuVQPrkpVWk=;
        b=Ua2YFeMTNc7Jw4p7bM/jGoPx2ab7dvThx11DXea80hPyjWxOhwk3iLBYEFPS47WsPK
         N/YY/rl7syE5xYmGQtLSRITy6jXBZeNdbPft6do9SLvOj6JjDqpLkrqywwYTMdTKVVHx
         OPwAkZkwZUeRAWSkoWNIjge1+HIZOB4vzTDh5STj+xTWXgoL8cPVgZ9CnXr9uJKEVWyE
         UA/ZLIxcMS9fVyStEWa4uk1EUMUlZBUnK6CCYKtCRiiNz6Dv+yJ6iceni1eQauLd7Vmo
         FLAg+w8o/OmAyq9voVz54PrQJopZfXkaymS/sw9lDJgL0LITdXHETboflWeQHv5rlUV0
         akjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526709; x=1779131509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2sGdjD/CZ83xlAQBQK80MN5eYGa/z/UivuVQPrkpVWk=;
        b=AQNFRdcHvnfa6t/QQakCK3J2+ZgiqSeoF4aHHchxAAww4eyRaNWZ725vmytfAS2PGI
         QgXKK7pQSX/d2Ux8PqUjaTUhWnTDk0IIik6K4drgYN2d9llsLoFSNxUCjiI/V99OcuIY
         z1xl6Yidwvxw2e+B6jp03R5RKsXwvhtKErPB19AICCQqZSb42cxBOnEtTVSQiQTH0MBz
         uG12KX7UxvOjeoMBa01wOlqxz/d9QmbSv1dhUpFi9R8ahncp0NHKxjgQzIF3C9X4BMPI
         GZF8co0jGcBkyWoQSPTV5LGGY3DpX53EKH+Jr0GGmh28dyo/QpIZgdWCej78vuu2FP6M
         GsiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CbBtFmT6wBSy9Jv16xC5ubOWhSng4pnyoCcTO/zYesS5xFuJdvvePI+v8yzt1Bf6Z3aZcZgJgwL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/EGVm+UbKLpWPmMo/eMai6NunlQy0B62INnA1NET5QZB1RXX
	QkZyUEfzVVr3oMMmQwRCd+m9JutOuK5WghDywTX0TafsQapp30A/yanq
X-Gm-Gg: Acq92OG8bz4gYownc0zwAIrrE2AcdtzvznLfRtsJNBjklexEXClC+wLWkibS//KxBup
	m2yeBWf0a6Wkj/AIDHVul3z3Bf4zcvsDIYtFqQHPedAHBKc9pNJmhPB84d0CuCSyZevMykQYPdw
	E1rm7HyBtcm1lhU60TdA2H0ffgTi9p8OdEOH1rCKT/UAn3yJ0LQ6Q179fOZ8atpGtuNZ3cpwcnQ
	rv32T42Rgq5+/3nv1LOAoYfbXJUp7B0+vGyCGM/oaTusXPhaNAYttbeNK6uCxnDVOhjer+veT7a
	0jBlgV1P4TZL2Bx55KpZTjJID6w6Rnoc9kxeBRt9KRTyqi0Ux1sGrQklgq4IMkKBO9vOHBw/iFc
	xeafzIy67NJAnCUHTVTfqRxZRynXI8xWRnSo910py4RZaWsmxt98T/Jaek11DnJK+Me+kGhBu52
	UWqAIVbiQxHm1Ui3Cvc4pUR0RmBKy9QRzaFBVRvXR7qCHm1qcZLsKgUPAepx9KW45Z4u4Tkjlgx
	fS6VMwJ
X-Received: by 2002:a05:600c:5813:b0:48e:6be6:168d with SMTP id 5b1f17b1804b1-48e8e1f63a7mr9087595e9.8.1778526708702;
        Mon, 11 May 2026 12:11:48 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm28541785f8f.8.2026.05.11.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:11:48 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
Date: Mon, 11 May 2026 19:11:34 +0000
Message-ID: <20260511191135.36691-2-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511191135.36691-1-vlad.kulikov.c@gmail.com>
References: <20260511191135.36691-1-vlad.kulikov.c@gmail.com>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
---
 .../iio/magnetometer/memsic,mmc5983.yaml      | 63 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
new file mode 100644
index 000000000000..4a4df6bb70fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
@@ -0,0 +1,63 @@
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

