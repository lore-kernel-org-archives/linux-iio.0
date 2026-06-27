Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581C391E51
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782554138; cv=none; b=gs7tY2J9XO7h5cDyMpuxFEdFl4IArC6PC85O7SX8yhPblOKL+ocv1gUUSZXf6Z4fq9WCX7ghmNyVTBJ6B0BGSLilMPwbZ/781dunngbhlPjb7zaFK0aYQnOOwoA0lNTSAiXkNA2FHzLxw70z89L94/gYbNIOS74Wu/ROv6mz0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782554138; c=relaxed/simple;
	bh=jlgT/MtCdgpOB9fnTVDheobw7Szom3eMO6EOHqMHlYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOY31DfoKrtqG+/v5bT1oWwiqZWcjM0DB2MeieLFY8Xaa4ArLvzw1jElrK4SBJM7IN4V5pnGsEJVnYPLsqdZ1nIpzqZnb4smO/p48DY6bCa4jSW16GOpU0zdW+1I/zkmMQ4A97Wg/M+NPJKhxvE4RjfSRqAsNjGvIAd88XBRW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgqsmZZz; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgqsmZZz"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13986d61b4eso4499482c88.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782554135; x=1783158935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqu3QtC3YcpovTQzC1UYwE9fiAF/VlH+zBm0B1Wqv6o=;
        b=dgqsmZZzdxkLcrOiYgGp2nIHRGBsZByMzce2vvIUaRNciFtJuomrfYMRjnemYmN/J7
         CCy+xonv4yUkftAezMAuNI3c9kT5c9Tf92fHX4H3NQWnGXdzRmf7Ew03huWLZ8AoFVUr
         +x2CpAmM1UTEPRQO1VQZzDqiqim0HOlDEC1UOuuOsmK1NvnbttSBAQ/pcy++9BJcwvye
         3jxdZgV2kTmXa2qiOCpRlTPy3grvHzvyhxY2ojJqhwTZFvhFzs2wa8ky9d5p+b+Yd5Hh
         5VbGl8M8V79IMcfrBS+mp2PO8WSdrE7MyOK99nQ7dcPDeHJCy5wbMGhAcZrdY+2lJo8+
         mORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782554135; x=1783158935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iqu3QtC3YcpovTQzC1UYwE9fiAF/VlH+zBm0B1Wqv6o=;
        b=FAadey9bkPpcaBF0VHts3BtOsXMYl+B/gr2vVgwtaWHJ7n26YvHn3wr//fpYYoGs6e
         jZN1e0mwnPu6HiZbRnLI2b1ooqD+Nkzr0ILeWsSFimztsWxwNhxG1dTclTKU26VWjDrz
         ZVbeKYcK1swQ6cQPxU1YZeVxqEPlo70kJ1plpI9AZe5YeUvqdmsiOhBG39ClK5UowOOm
         lu/ec5HVpYefWKMs2fzy+MreAjgmhR5BK17doSehAtFsNV31h3+Rsue8PO3NuSFXLzTe
         9lwZWUjOZaltAZYy9obVz39+Nq9nhVi+axPs3cwJrYL9pqzcJ/jkB10JjwCJ9YDOF6gI
         j5MQ==
X-Gm-Message-State: AOJu0Yylge1GO5QIQeJrYyOH9aWkPjknLngi7oSfZi98im/sqKChZU5n
	yomWPgCvjDMkxyWV/eBImhdfSH6vKNsLBH/cvyhP0GK1niEmo/qSBR5RIlYFbrmbFw==
X-Gm-Gg: AfdE7cnZh+zBV7WuC5WptAV2vC87xgFxcm2Sf2ZSQCmmkzGeNHsDeKQt3YfdAmXkbCp
	27rVRRtJlQB+S7MXTxBtTbz0AkzBvHi0e2J13xQ2c7YnZrxGDqn1rDWAPd8ZX3yTlAA4zWeLV14
	41xNhN7qeDlTlN7VOwY7CMeHCB15NzHF1ekmM/DF2kGGR9oGcFmO3th06kHqRYTZbRDqB2QbNwn
	Vgfcp0j2WAiHeVO823A+p/tiSJUut159i6W0N6aDnBWBAOXJB8tl3ScweFPrcoA90oHYRdUFTT3
	A5cKM8l3tYSR7zcszNtYq6BFtgLQ3NppohavyOsxdflzXxlqjOXCHCz3J7/kETkTFWelPt9JQoQ
	bRHkdhS4t639VIZygq2t4g/HfBiszIo3j0OPrAWiLhpkhHl8QohiF/bovDjgLCV+Fg/xjoM2qqX
	ztztyObKQjfwyMHkA3qgGh/X55PODGn6YKJyGuuZAgL8xaSG8fbgYm
X-Received: by 2002:a05:7022:41a6:b0:128:d4be:7438 with SMTP id a92af1059eb24-139eb3f6ec2mr2858883c88.30.1782554134995;
        Sat, 27 Jun 2026 02:55:34 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.116])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e4c33af7sm12886141c88.5.2026.06.27.02.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 02:55:33 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: magnetometer: add Melexis MLX90393
Date: Sat, 27 Jun 2026 15:25:18 +0530
Message-Id: <20260627095519.8377-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260627095519.8377-1-nikhilgtr@gmail.com>
References: <20260627095519.8377-1-nikhilgtr@gmail.com>
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
 .../iio/magnetometer/melexis,mlx90393.yaml    | 63 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
new file mode 100644
index 000000000000..91e984827786
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
@@ -0,0 +1,63 @@
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
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
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
+  - vdd-supply
+  - vddio-supply
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
+
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..469ae3f9aa0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15501,6 +15501,12 @@ F:	Documentation/scsi/megaraid.rst
 F:	drivers/scsi/megaraid.*
 F:	drivers/scsi/megaraid/
 
+MELEXIS MLX90393 MAGNETOMETER DRIVER
+M:	Nikhil Gautam <nikhilgtr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
+
 MELEXIS MLX90614 DRIVER
 M:	Crt Mori <cmo@melexis.com>
 L:	linux-iio@vger.kernel.org
-- 
2.39.5

