Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09433F594
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798521; cv=none; b=NJ2J32LjAx3QzZ2QFtpxcUPlB1h/5hmv88aTQLHcwxl4lgl0Cv1zFMYDlGI/LIScLrBtnMAGHSN0Ed6B31LKjF70bsuipY19knM6NxDzVOtSAfZNuDe9Frzn5s0TbncSZjEXFy+VuVf/htqWvssCamHRwVt7BAqJDZGOCl0f6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798521; c=relaxed/simple;
	bh=hh25ZcMawAMaZgtcoqBh/Oh0rfApbALMpsiRJY/c4+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKzlCXquivJPh1GqEsRmIJULxcTEehlP12xxqvrTVq8p9D4vUICpxDsrXFiXsNSEyzZWqSv2YG6AXEMPJSzg0gPQ0wm4qdaqNB/l4vRZVTlmEMXe18eJDQfmgfasqeV/lin5RfI/JYgNx00lXq+JLIvDyJ5Jw355bWYBhFLoPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYUa2gS5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYUa2gS5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37c8e7c8185so680734a91.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798520; x=1782403320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjlV8ezwd9YEOGNjCjdtiP5gyg2Bzh5OdyGQbImHytM=;
        b=MYUa2gS567cG53I6u5bKvfqLKgyLJHDfgAru/utOF485Alo8rAGIBdOeSQMOk/NxLS
         n1I5rLDJBAi2Hyxqk6jofBw+iGh6MzA/ZVYgHben/xAQR1oi657GS9taeLznUbA9ZB43
         NxzKddyRLs3cH5NoJNz6wurAVToNZfH6aKeGmcpxGWR/Z6Jo6W4DxyEJK6OuCXew2TD3
         67ItkMlzePuvfSFOYj0ZY7EadmSyUjmztvJhWyX10A96xEXL7WrU2iC7odG4smk+h5/4
         pwwG8XH/HR99/+6bf4pz9GTj3iEGanN+TWOVOteEWW1FbWu5zxW+F7W65j4GceEu+ZZH
         awUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798520; x=1782403320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjlV8ezwd9YEOGNjCjdtiP5gyg2Bzh5OdyGQbImHytM=;
        b=fzBv2dSGfG5o6T+fN+MQfu+T40ZtTBqDVhXV45sqHGJ0o2VlDJ52zF4MajQgSx8Avr
         q25BkiFGY4x3WR5Mg7LtO2WMK6Owmk5UXMaSg5LAq6tmxCW/0bWi31PUA7FtG1pClulK
         x0vngn10PyyBGd7G9gc9dAl9Tm+yuBpZFXrIqeYGmtIQrOJoR/7O75ioSV9Cxa3t6//b
         yHJbhYBoFvnybDmBDLMB5gpaD7udjpV3WdFtvqticAtT4oTce3niB0Tjkzg7WQL0JzYl
         Rug7WELUaHzg00P/M34Qw3aN93KC3T57yvzoCqD4vfkR2iU2BxfmZJ7bqjRQ6nPRfUNk
         p95g==
X-Gm-Message-State: AOJu0YyhSi8QjPq/0VF1/qc0TNzbLru1oYYoVt2Wgj5bmJnGnmSsBYm3
	lHcS0A7WEc+y1uEwZzmqaidmBsqDbBbzquIi6bUYl7MCjNhq/uPTMW6obGWj6MOWFg==
X-Gm-Gg: AfdE7clLH3OdeaQtLJomR21KJHHF6aOH03d6dPDiHiDAlAN8gnZi06XjotZLpb6BLdf
	9/heflgo3LYja6wwP3enN/Woem5OxGqngr/lNSY+MyAZymJiIfo/jPnngvsI12N6GVu8F6YmOdN
	o591e7YxgEI1F12RQi9+Y2CmlZr48BEGDummvomGyXyEOkLvtInb6xrlMmPGJPqgd5sTwCsJmz8
	Ert25/I/zz8GT7hjzexznWIKBO+LeDMWTGHiuL8bHwq1AvLGPJigbF80tfu75GxelvUTx6BZJfv
	5hCBb+E+gQ1YKm+5q1N3NLhQcHzVucN/ZI87hTWx0C81M190pN/vEaqE/Ucg1ghJF5vTePCsaST
	Sr8izQ2WY5ZHFtTBEGkg62RA+z1gzemjBEKCIpnQ7ih8ar7850A/nommozma/vWXcPOAtuWzK6T
	CoO1QWhkpYsk75CRfS+H74dtbDyQpIymH6lkVaSy4cWt4aaPHPZob1
X-Received: by 2002:a17:90b:274d:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-37d15e8b6bcmr6649a91.19.1781798519763;
        Thu, 18 Jun 2026 09:01:59 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15361af5sm53807a91.4.2026.06.18.09.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:01:58 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add Melexis MLX90393
Date: Thu, 18 Jun 2026 21:31:40 +0530
Message-Id: <20260618160141.11409-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260618160141.11409-1-nikhilgtr@gmail.com>
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for the Melexis MLX90393
3-axis magnetometer and temperature sensor.

The device supports magnetic field and temperature
measurements over I2C and SPI interfaces.

This initial binding documents the I2C interface.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 .../iio/magnetometer/melexis,mlx90393.yaml    | 55 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
new file mode 100644
index 000000000000..79e7e4a124b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/melexis,mlx90393.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90393 magnetometer sensor
+
+maintainers:
+  - Nikhil Gautam <nikhilgtr@gmail.com>
+
+description:
+  Melexis MLX90393 3-axis magnetometer and temperature sensor.
+
+properties:
+  compatible:
+    const: melexis,mlx90393
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  trigger-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@c {
+            compatible = "melexis,mlx90393";
+            reg = <0x0c>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+
+            trigger-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..e9ddcd12feb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24926,6 +24926,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
 F:	drivers/iio/magnetometer/tmag5273.c
 
+MELEXIS MLX90393 MAGNETOMETER DRIVER
+M:	Nikhil Gautam <nikhilgtr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
+
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.39.5

