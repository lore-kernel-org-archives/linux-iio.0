Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7443B480
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699224; cv=none; b=cU4w252IHYhjI3Y0mbRr62IbTFicX9pLgm/1xYafPR1+LDTTNyzAkyv0P4GrSVDOsJfKqoAoAGoEzpn9PUR+rAOBOL4gTGlynKKLD2Oql0Qz9O3Edn7RkVWAGbZLqdCT/Dwju6G3tIcyIV6ImbnhyX7LJqGKhb5RsLeqBDLq+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699224; c=relaxed/simple;
	bh=2kx7pUx9tfhx0zv+z3s5tqYIU5nastRIq2hdNkClcbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M471LRbwbEkB7Plo6ebFQ0Svn85pgQyAreGxfkn67vpdtvwLG29vA2mxQsYq8hePfKvOD9rBNpTfycfN7fd2THStsLRHg58NljkD3x+EWT5DvNrel1RTI0LA0i48nR1SyHNqJy6f/L/VPVMJiS9aDIhinbHPvMicXFVpyAUpl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdUQ00It; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdUQ00It"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aea16460cdso92547e87.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783699214; x=1784304014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ck1r2NVwZBaaF90kGpS5I0sjGQcOnMc2dil2XeQuca4=;
        b=NdUQ00ItTJFLoQvMVM4cKyEK+fN/QABVZxmNwwvr5aHx3TTErJ5rCAxwLILQ1muanx
         0opF1pbL+tbVAGc/qe/kG/iGRGeVxjb8e+EvnknAl8RmjZ9sLcC1s8AWdwLwiDVIen2D
         qG99ztVyZTBpex+/vO/pQp4dosYHWDgTvtYpoy1Zzxb6PuMzdOA5Xjtw99k7jAZX4grX
         cDE040Sr5TREm5nrJruygC/4DrXKTCoj7qyQO0FlHPIYpWdlLhslQB5d3koi2UVplxVF
         lyhjoOLUY+Rj6qX9VYPjrFCwQ99l5l4uNfd/QTF3XZNh6Ne4+r1kw6KEe7EBc8sHeSuF
         /RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699214; x=1784304014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ck1r2NVwZBaaF90kGpS5I0sjGQcOnMc2dil2XeQuca4=;
        b=UPUZGT7PFKilQ2YO75DQEyji8XbUINu6UdiH6SuqPxlDrsgu0u9x/Tu5W7WojvtEkQ
         7wvPuZdYdc2xi0dojSb+wo9czIzL7PJK2tMTxwfIo9jA3HrYON10ixpJs+KR0anfp/P1
         /ln7NDF1n0c++zQdCMbgK8lMZjzOw976coQt55R6STl7o5sJ8R1v1xEgz8G6MyIWYbhg
         ejnDQmUh7juzZqdMORhlkrDFouEyjAY7YG5x/HI8lMconN8dbaZSbQVqtUD7/VdUWSsV
         xcop3SUoPq0gQiQug3A01ziCcCFoBCGFrbxY+EtXXmrX/4uU3PwzJpoUhSqdYHHHOBI7
         dX/A==
X-Forwarded-Encrypted: i=1; AHgh+RoB81PzjRZz7OVQg4l2285L/OQfv41v1MMqaIz/ter5J77DbB8RGL2uh8V8HFN7VmCKW57BPaIRcXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWgj9JuuNtSdnzDuUuM9FVC8pnUAxmEkzha3VE94pfUAcrtFV
	99jyC6S/ZNSIxdHZdU5e9qIUZeZHPcdUqD5QJVo0AjQueOH+K7hwXRXg
X-Gm-Gg: AfdE7ckJjzV4pCbKp1qqo7yru0c8PkfSgezI5AnBED+06vBiW/uNb7eOC4b9uEXuggF
	yDj3t1/e6X55ylXqpcuspvgnXVCAYXLsLxMat0uUqPqyAV3SlOAW+JGFULVYbQqBf/2q+uM7lAL
	fG3Qjwhky7cIlS3chMO/3FMZvjEf5KZsVqkEHaFFoNm+fQQYZsfztM09KNOFVlKqEqeFVIZ7Ayd
	6bvoZY/7Ef8PZPU0VinSCsZbiirpWj1Co2UyJTHAk0GtQSOtUPKoOU93azMdJRiYt10lMuNE5V6
	p3A2oZabDZcmERjcysl0v9XJBwHTOe1tBNQRB2MyMe/5R1lVGf5Z2KGcs3jYKfOqEUOHp0pwNre
	evvJrR9SW8SOF7gstH1L9dnDrUCJwd8HmSGMicEEOi6/idmoXc+cfH9wZpn+UUUWP57nObZ461i
	0My1pxBIwZsUnuhyUj8TaRa5Z0
X-Received: by 2002:a05:6512:12cd:b0:5ae:bce5:70f2 with SMTP id 2adb3069b0e04-5b0115af09amr1756207e87.4.1783699213314;
        Fri, 10 Jul 2026 09:00:13 -0700 (PDT)
Received: from localhost ([5.250.49.195])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca54fddsm708567e87.33.2026.07.10.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:00:12 -0700 (PDT)
From: Taha Narimani <tahanarimani3443@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Taha Narimani <tahanarimani3443@gmail.com>
Subject: [PATCH v3 RFC v3] dt-bindings: iio: adc: add ad7816/7/8 digital temperature sensor / ADC
Date: Fri, 10 Jul 2026 16:00:00 +0000
Message-ID: <20260710160001.29856-1-tahanarimani3443@gmail.com>
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
Changes in v3:
  - Removed redundant conditional check around gpiod_get_value() as suggested by Andy Shevchenko and Dan Carpenter.
  - Switched to dev_err_probe() to avoid deferred probe spamming.
  - Introduced local struct device *dev pointer in probe and kept the GPIO request on a single line for better readability.
  - Added the missing Fixes tag requested by Jonathan Cameron.

 .../bindings/iio/adc/adi,ad7816.yaml          | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 0000000..48563e4
--- /dev/null
Changes in v3:
  - Removed redundant conditional check around gpiod_get_value() as suggested by Andy Shevchenko and Dan Carpenter.
  - Switched to dev_err_probe() to avoid deferred probe spamming.
  - Introduced local struct device *dev pointer in probe and kept the GPIO request on a single line for better readability.
  - Added the missing Fixes tag requested by Jonathan Cameron.

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

