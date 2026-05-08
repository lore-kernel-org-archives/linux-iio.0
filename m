Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C43D646C
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271629; cv=none; b=gxbF5GPor3xBD8N4GRvuFLdQ5pa5jH4/94S0uJ1sfhO+zsveg+DRBw2T6XY6ryXgLz5VMye5xDHg+VwSKf4Qr+jdSr+Tqm09TCNTMZsYnh4gACGTMJ2s9EEKvffjgGkSbrmYtzkIcXCLeysmQES7TzuYA5P29icZfI74Qf4InCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271629; c=relaxed/simple;
	bh=LmghrXlejVuFjkVt7r3dzG63P5K2Zl8AJWCbJBK9oD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lXBWCeqUi96f8QiEY7ukTH8GjxX7R5SaEK2b0zJyMUINCGiH1a0YfYw+d4gB3TtQWcqwym9wr5cPp31IvFPRndCkHssCfinG1Lm0SlI1F2L6db4I8P2+6d/vw7uss4INqo8khoyR4j9cBpC6GO75ohgpuiGXt1KN9CwGUfjUPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0hUft39; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0hUft39"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso2459381eec.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778271626; x=1778876426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3Gb1GxweTLqsXFs2C486eIwcICR6sofbRus2hdKldw=;
        b=V0hUft39HINu6/LsdVTHFAPUHg6b88trQ5Hvdm7IvrNOWe28iq6ZyX85nFjGNzQHb+
         xyy+aDRiN0j2vvZf/MmF5VsMsluIHPugzsg3WP1pRsLO0yzEu8k4CkvYu2/2DAZZc+uM
         BK3NShe4bU1tO7zGWlWBq1Odkpipnuwzr9pOdMe7BM8OU5CbbbWRLHDb0gC95w56a/7u
         WOn+TTj0BeWcpKIChBoZjYgS8Tyc+XplYN1PHo4iHjQdOGZcUMck5YtvVXvKTO2cr1PH
         D5XGPXahcpJTHVad3MDFOAhHOUNExcYduw3n5vrqeLGGcRoT5sONkjyMmiwxwck9uGPA
         AhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271626; x=1778876426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Gb1GxweTLqsXFs2C486eIwcICR6sofbRus2hdKldw=;
        b=Myugiq6Ohdfj8KD/x01EeAWPRBxEfnBzhQi5QvNoQYeftvcO3yQ9shwJ+gYH7iWWyk
         zNkZfgBZtveKqagk+tzZtEQO5n/OD7jZAWUwUIO1wEcHlERCIV7jIaSwRMfTrAz2vl6C
         P7TlvCqygPZrQpi7t/PIR4j0fjeFMz7yIOCUgoaf2Ro9q411KhAtTxdhpGR4c5TvXmrt
         PBV6EXhAJIqi54JBgr8PWaSXTK2Bri9hzmV7+XhDvKSrB56CFWOnPa5wi8hPyTUdwN4k
         D+bp8RQG15HqKfaFBHBMZTNJLVqrHSDMDAeps/EEsFJgvtNzCBqnF+qj3rZwZrVoIX7N
         OOGw==
X-Forwarded-Encrypted: i=1; AFNElJ+x9xTwPSl35fS2ik33luRJWafShb4YKGWg8XNOEnbExJLzvKEPqTGoLf3wWAxaNuv3ocwo9TeVv4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/QwUb3CH29wQtNIeUDI5X2Gxuok5Gyk4y87oPzhXe9p3m4rT
	pXps4ui/poghNy+liaP8LZlEmBNP/WRekLe8DcH+j42hFJG/9A1lof8b
X-Gm-Gg: Acq92OEt65emjPJXwtBqQnCnGu3NEO+e2Y+TEvvSuicujtH+TfgpWrndjqz1lJwAlZM
	79bkiitPXIczSoFiX6x2DeA1910NqlKNrk1y6SnzhFsywse28yKG3DSM9UPCl3yG8Bx7MPwQUJe
	wEOsxSAUgROWwAGKBCRPnqP4BoKgaXZK6LEvAH/7N2TinujiZmudxuzsPOwMQSxr3YTstX+2hCo
	K0skW39W//YJyj/A5+mKQE7pB1w/5mbbfNwL88G/2oTwnqHW4Zds+6OjN5YJIKRqqglLW0uuK57
	d556xOyypstidsJAh+dsyTRBO686ts9QZVR5bLM5o8RdVUuimyeujZ88kucwYoiN6i/A4XY9My2
	64SlomU33XIUVoYMUvu6PmDtdSlbWSzoCCnrJCyDHHjPC8gdjLWgUhyS3HeEx7lr0iKEaMy7jSr
	X2jWTCP5Vff/gSy+Ff4wQUzBgJ2gSc8gy4UWDL0/HEQxOIz9MbVy/ltb87K00WnwfUog==
X-Received: by 2002:a05:7300:a2ca:b0:2c4:dd55:ffc1 with SMTP id 5a478bee46e88-2f54889506cmr6215229eec.2.1778271626118;
        Fri, 08 May 2026 13:20:26 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm3762466eec.25.2026.05.08.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:20:25 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
Date: Fri,  8 May 2026 20:20:05 +0000
Message-Id: <20260508202005.76278-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding documentation for the Analog Devices
AD7816, AD7817 and AD7818 SPI ADC devices.

The AD7816 provides temperature monitoring only, while the
AD7817 and AD7818 provide analog input channels with an
on-chip temperature sensor. The devices may use control GPIOs
for RD/WR and CONVST, and optionally BUSY depending on the
device variant.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 000000000000..490e5338d7b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/AD7817/AD7818 ADC
+
+maintainers:
+  - Hungyu Lin <dennylin0707@gmail.com>
+
+description: |
+  Binding for Analog Devices AD7816, AD7817 and AD7818 SPI ADCs
+  with on-chip temperature sensor.
+
+  The AD7816 provides temperature monitoring only.
+  The AD7817 provides up to 4 analog input channels.
+  The AD7818 provides a single analog input channel.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7816
+      - adi,ad7817
+      - adi,ad7818
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Optional interrupt line used by the device.
+
+  rdwr-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RD/WR pin used to control read/write cycles.
+
+  convert-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the CONVST pin used to trigger conversions.
+
+  busy-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the BUSY pin indicating conversion status.
+
+required:
+  - compatible
+  - reg
+  - rdwr-gpios
+  - convert-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7816
+              - adi,ad7817
+    then:
+      required:
+        - busy-gpios
+    else:
+      properties:
+        busy-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gpio0: gpio {
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7816";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        rdwr-gpios = <&gpio0 1 0>;
+        convert-gpios = <&gpio0 2 0>;
+        busy-gpios = <&gpio0 3 0>;
+      };
+    };
-- 
2.34.1

