Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4834D38B
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160369; cv=none; b=BdqNUf55drRiETzXOkdxK3W2QlRS3pFLAlBI4+jYTu1icCjHHuRcpOxWRZ/GAOFqJDUEjGbIm5Bo5gRjkRc+wdj1MD79dbYxiHOqRuSXCfOR0Cg9mKKygXT355aqcfOgJJbdhPboVC3HtrnfFj9polKZUTrHxp1BsjEwmS52FEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160369; c=relaxed/simple;
	bh=eGB/cwwbuh9IlCcizGluwEjKXLvPqu2ERSXjTiVEsfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3xERp5WI7dwpAqZVMBZv69Ny+28+wx+bU2WBH0TEBNz/fS7HqAiuxVzFS08csnakgQDcZVO8/m5VbVD5PLDuwiLeVCVAndhkWrZHU4TIlh57mtNoRuLxSEXeiJb2lG3a7LUVvAIwlZtzG4OrlsJqO3HHocEop6n4fJSmKRIdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPXO11JI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPXO11JI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8772a67bcso1401219e87.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780160367; x=1780765167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AAtURkroLRkzkcXaL+/FSHOD+1VAnPoKiBj2776wxI=;
        b=RPXO11JIvLcMn09HFCul2p3AKVs210bZFumyfz0MKZPfGppinxVC44cdH0oP3pMAlX
         f6pN4+knD2eh009ConaAvnulXcX4bgRSZ3iQuNrJPazLL0QtCgg5Onjs494yQqoOzRL0
         +khodBd53pXTWHOpE2fN/ZoYgXiwpQlU19kcMVdo3qKZu1yZu+bG1R96kaXUtO8tEjhR
         cSqrcWeJ2cO49O+3Ib+t9kD6SvKKexRhWj4fbGaMS79KqVK+c3VVXY+1HuNJf+eZAXId
         tR1m0DpvWgKZzFTQFH449c8xEt/NFwUz/GeTxZzgKvENTnM8q4NoBVOwyvWhPXlQjhew
         Xp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780160367; x=1780765167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AAtURkroLRkzkcXaL+/FSHOD+1VAnPoKiBj2776wxI=;
        b=IV3IIUgxC6JJqCBzvBhQ69Xkp7t4AhB3z6WvaqT/doOPlMYze1KQ5H/ez6JM/hEn0S
         3vyHL4O5WFjU4NXS/wm6XOTdfB0cR9PA13EyTyMzyhZkcozqV6AN+uepcHXMScIltQy8
         Mat+jENt0xDdrfwGxd+OMKJGVSKrjk6X3o5y25ruGhV++jZkx7ZHU8pup9TUxt5NQo5f
         ZxiQltTk1+NrXau9N9ROHdJLdaa77OI2+EZYQZazAL3w8fa8FSSTJ+xvu0KEVUtHw7Yd
         obIaosTKUL23rcX5jA/M+5AvIRozDiVYS7swXzzNNqn+ClbeReSKlZ0P+EfFw+rHW6lr
         Hg7g==
X-Gm-Message-State: AOJu0YyuD3sSYJFVwg+ysxP8B7XkgHlStvM3nsJSImaoummivfhXND6d
	mHe3GxRcLWkOMh55ZucYkEmPqTYKr7BmB78PLWEcAQpWJK2JVJ0YFejQJhOOrnPOXRF67A==
X-Gm-Gg: Acq92OE3rP3F9XQQMFoqHSpOmrYDBQBp/7MDlB8GFX2Dyn72U47W47+RREpdFGKECFw
	oDo2M9sxIMq4Xmyu//rHQbfAYDHcke3Ojaw6dWOZ/eFSFkd/G5w3OACRER+WoyTOeUflgitpeSJ
	aqceliuJTFi4VO3A/SBJ71ODBy60i1OcgEg58JFxBTuXXVXsJaXeNLDm53SzcJneUsCszrPp3vc
	0RvQV0EG/xjW7EpgXbKFxQWXXFGtKesEDEUTaynPlgUhAinYM7LMkXmQ91SFO+EbxNKGWcScs8+
	Gua4pT0HOpMLaPMsn5XrvFSFswZBvN1EfgkN3YEg+0xs9fQ7cZuatFF1T1wLAtDQoTjtczvizAS
	DvP29+f2+kOclaJU+FL0IV6z38MVrNTwKB1l/nxZsi4U6dIlsgvdujr/nueFSqrRqdwQK7NIdNS
	tLX34NBmfRTEZQPD91uGZsjXvnWN0AHw3hKvzSCs55m9Pr3g==
X-Received: by 2002:a05:6512:689:b0:5aa:5bb7:ad7f with SMTP id 2adb3069b0e04-5aa6092a6d4mr649904e87.7.1780160366346;
        Sat, 30 May 2026 09:59:26 -0700 (PDT)
Received: from localhost ([5.124.164.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b793fd2sm1105140e87.76.2026.05.30.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:59:25 -0700 (PDT)
From: Taha Narimani <tahanarimani3443@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taha Narimani <tahanarimani3443@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 RFC v3] dt-bindings: iio: adc: add ad7816/7/8 digital temperature sensor / ADC
Date: Sat, 30 May 2026 16:59:15 +0000
Message-ID: <20260530165917.55767-1-tahanarimani3443@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Analog Devices AD7816, AD7817, and AD7818 digital
temperature sensor and ADC bindings in YAML format.

Please note that the driver for this device is currently in drivers/staging.
This patch is sent as an RFC to clean up and standardize the device tree
bindings prior to any major driver refactoring.

While reviewing the AD7816/7/8 datasheet to correctly document the properties,
it was noted that the current staging driver attempts to request a 'busy' GPIO
for both AD7816 and AD7817. However, the AD7816 is an 8-pin device and does
not possess a BUSY pin (only the 16-pin AD7817 has it). Therefore, in this
binding, busy-gpios is strictly limited to adi,ad7817.

This resolves the checkpatch.pl warnings regarding undocumented DT
compatible strings.

Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 0000000..48563e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/7/8 digital temperature sensor / ADC
+
+maintainers:
+  - Taha Narimani <tahanarimani3443@gmail.com>
+
+description: |
+  Analog Devices AD7816, AD7817, and AD7818 10-Bit general purpose ADC and
+  temperature sensor. The device communicates via an SPI interface.
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
+  spi-max-frequency:
+    maximum: 12500000
+
+  vdd-supply:
+    description: Main power supply.
+
+  vref-supply:
+    description: |
+      Optional external reference voltage supply. If not provided, the
+      internal reference is used. Applicable for AD7816 and AD7817.
+
+  rdwr-gpios:
+    maxItems: 1
+    description: GPIO connected to the RD/WR pin.
+
+  convert-gpios:
+    maxItems: 1
+    description: GPIO connected to the CONVST (Convert Start) pin.
+
+  busy-gpios:
+    maxItems: 1
+    description: GPIO connected to the BUSY pin. Only applicable for AD7817.
+
+  interrupts:
+    maxItems: 1
+    description: OTI (Over Temperature Indicator) interrupt. Active low.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - rdwr-gpios
+  - convert-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7817
+    then:
+      required:
+        - busy-gpios
+    else:
+      properties:
+        busy-gpios: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7818
+    then:
+      properties:
+        vref-supply: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7817";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            vdd-supply = <&vcc>;
+            vref-supply = <&vref>;
+            rdwr-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+            convert-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+            busy-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+            interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-parent = <&gpio>;
+        };
+    };
-- 
2.53.0

