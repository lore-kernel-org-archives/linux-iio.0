Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE1409617
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723923; cv=none; b=NiBA1RBoKwAuVPE7EwBzmfRKozbf3MUqZbxC2tCuAS6cjFhZddZ+MoEtHT24zo458dOYrvU104MnkKiZS5YfV1XVS959xLCsFQTKmrgxuO1sCO5U39tnj6nHNi/PsXUF31pojLhR8IL7YSf076WHR3mwKdaYbmq+dZ7/GR/DYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723923; c=relaxed/simple;
	bh=J3/qdUa3v4iybQqy0Epz1aQGMaqOS0LO8W7h2HsiRbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVMYJ23atjj0izZ4oDxqCnnmR+LTdAwst4xT+4BFcT9TAXzaYgF1x0qFNO80O+cELI9rZ+rbVzcGNNC1d/TUHvX+/ivKjraZzdFDGdQTHOTQ6aAEjZIl5NEv04FKg3HyCzGjKHVej02/i6HxmDDX/V3BhJweAUNBJBaj5YjTeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=doQqfdjy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="doQqfdjy"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9f5637634so973593a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723918; x=1784328718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+y0rBgM7G+Wc7ACw8ZUZSf7j5cn5UpYz2OGF2cuz18=;
        b=doQqfdjy7zW98nIJk5O4wZa+f6WS+++/Xg9UGqEKGAJMnzVkqmZnb39pLThY9YL49I
         MP2lT6fep1o0hOnCG8xi5UQt0fg10V6N4RzksKdcSqTWCg5y2nXQ8WRmo5IoTVivZnUE
         FzGq3T7FbcX8fTYn+F8IUswWEj3l4o9y5uFa4Z5dx1OpB3GU+3hQLvor7UAUmrue4EB8
         l2kcRhqAfQg8RiSuICe5zUYZ/vlNlF022M2u2ynkZZ3fi2URJmXxF4icGh5Lu3/8pFEg
         +EOMjRDjfKzc+PMAwJX35w96ei8qKkdngkSeaA9Qug9+nvWK2U3eTHvWst84RWQ1EHRk
         jBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723918; x=1784328718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+y0rBgM7G+Wc7ACw8ZUZSf7j5cn5UpYz2OGF2cuz18=;
        b=fae8Q9uSqZEA/PPxze7/YrgR7G8ZlSPoNmaXPEkJcmPQ6vw8YcGicQITrcZdDuF0/r
         CO/QWvKwvdFcMb3TEfMQrfVs0RmuctKxSbK8orE5z8GDqP3z5IHxiyAf5RWYn5YKetNC
         BBHK0AuhrgAhnoion1Kw1xlnkLJ5lvXT37hdjq/gdHcH/x44VdEkZbCj3tBbiB3MDUVx
         +5uMp+9oeTPx2+JAUd4c2oRw29nL6cC/US3rZbzlyjs8iMpM+IxRb8+4rp5ZS4k/tgCa
         5ctxk6MitmtJWf7EPUWy6A35pN/zbd6EcZTcVdCgWJ6Qfo5NAn8avrF3w3OOm38blsyQ
         JHvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VdLl4AZtWKF34HIJAu3ehUEGg71vfmg4r/PogHRRVj9EE3eNTNXkqJe3qNBAfM6M6QBWdHyVrxPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb59OnFpZDqT8FbUdMQvXoGaFmHmhXosqSSTPzw/o4JUzgQiUC
	fQBlsh9kq8qtsXDrvO5Hw3O+pBOvcRI/zeHUBxTWHgXoDsZ5ZhTOsWUuJnDcaPk7PEQ=
X-Gm-Gg: AfdE7cnY+5hMJfaUJB1qYAJixzQqn9CH3LxILrPIipLGLYuA5tR8U/Oa5E6cHWoHlr5
	bTPyBVn0CtSlV9Hoz0XgUt2tuxrHPKXhSY1vKsIOJnkhGhROy+dAM/9Ga2puNo5pyCvyaWrLXqf
	XtlIldA2znkp4fb51Q91wcpeiABlYYT+y89MUAoE/00smQ5+4OlOO9TwepQVrkzMG3lyGZA4BWs
	52gDvVjZQnwy4UJ7IQzNbBtEcAgE0p72XsEPhtYHmIFiHjqZgW4Fit/81dcFElUAJFsGj3fgpgj
	bQxEoyUc2+55oGSLvl36wZZuMmUdZJjLhgqj5d7h+lC8GjkcPmeJdRbacA25Wke6oAngdR10Kg8
	8xkiHAhuXTE0lCpYMkcphwKoViU2a6tF03hX1C50xpxYzmg1sTS3O0Z1ZJNwCAJDdQqfivAFiqG
	9LHCn9YTGD/pxS+rXL
X-Received: by 2002:a05:6830:2b25:b0:7dc:db3c:1d82 with SMTP id 46e09a7af769-7ec0963a968mr512858a34.10.1783723918116;
        Fri, 10 Jul 2026 15:51:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:57 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:38 -0500
Subject: [PATCH v3 5/8] dt-bindings: iio: adc: add ti,ads122c14
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7704; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=J3/qdUa3v4iybQqy0Epz1aQGMaqOS0LO8W7h2HsiRbw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXdldumgGjL809zKRfzKpI/0jN0xeRmfjyzkP
 LRZql+yjNqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3ZQAKCRDCzCAB/wGP
 wFNeB/9f+ybfT/pS/Rn9lqhLkGZGd4nuux76m/TDx0/zGe0ew1/jXoMNrNzkON/1ZdPPNhWLwzM
 VgtqEP8xjQNdrDBCdYPseZE2a1hjTJ/W9/P8pI1TYCo2BfFp/BuNkiZm+4GjFt1spItJWmjb1P1
 z5u/oqjAtp7K5dpdGEs8JMjD2KUg7hDKPrTQ5V/Gw6bASHgmZIbKiGrlXJSKrNnrgwJJxlMyFwR
 ty+HHJ1z+kyJpHXy7LronbVcbmvF9pSHez4VMQlqb2Xaw9NucY2/qd5W7UhRUnz9MQc2wPt1KTE
 vDUCDV0+2BCPo7UCRvJBctvfJdfz/r6sS7D0AmB0AqaHu6FD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new bindings for ti,ads122c14 and similar devices.

This is an ADC that is primarily intended for use with temperature
sensors. There are a few unusual properties because of this. In
particular, the reference voltage source and current output requirements
can be different for each measurement, so these are included in the
channel bindings.

The REFP/REFN reference voltage is usually just connected to a resistor
that is being driven by the ADC's current outputs, so there is special
property for this case rather than requiring a regulator to be defined
to represent that.

ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
have preferred an enum of strings).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Fixed channel@ pattern.
* Adapted to input-chopping property rename.
* Made sure to use items: on array properties.
* Added reg to required list.
* Fixed missing space in example comment.

v2 changes:
* Added ti, vendor prefix when appropriate.
* Others are now standardized properties from adc.yaml.
* Moved top-level unevaluatedProperties.
* Fixed some issues with the channel@ matching and reg property.
* Dropped description on bipolar property.
* Renamed current-chopping to input-channel-rotation.
* Drop header file and use string enum instead for reference-sources.
* Added burn-out-current-nanoamp property.
* Drop allOf: and just use oneOf: directly.
* Fix inconsistent indentation in the examples.
---
 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 207 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 213 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
new file mode 100644
index 000000000000..a2ee473c8e61
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' ADS112C14 and similar ADC chips
+
+description: |
+  Supports the following Texas Instruments' ADC chips:
+  - ADS112C14 (16-bit)
+  - ADS122C14 (24-bit)
+
+  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
+
+  These chips are primarily designed for use with temperature sensors such as
+  RTDs and thermocouples. The channel bindings reflect this in that each channel
+  represents the conditions required to make a measurement rather than strictly
+  just the physical input channels.
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,ads112c14
+      - ti,ads122c14
+
+  reg:
+    items:
+      - minimum: 0x40
+        maximum: 0x47
+
+  clocks:
+    maxItems: 1
+    description: Optional external clock connected to GPIO3 pin.
+
+  avdd-supply: true
+  dvdd-supply: true
+
+  refp-supply: true
+  refn-supply: true
+
+  ti,refp-refn-resistor-ohms:
+    description:
+      The resistance of the external resistor between REFP and REFN when using
+      resistor bridge driven by current outputs for RTD measurements.
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: FAULT interrupt (GPIO2 pin)
+      - description: DRDY interrupt (GPIO3 pin)
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [fault, drdy]
+
+  gpio-controller: true
+  '#gpio-cells':
+    const: 2
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  ^channel@[0-9a-f]$:
+    $ref: adc.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        items:
+          - maximum: 15 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
+
+      single-channel:
+        maximum: 7
+
+      diff-channels:
+        items:
+          maximum: 7
+
+      bipolar: true
+
+      input-chopping: true
+
+      excitation-channels:
+        maxItems: 2
+        items:
+          maximum: 7
+
+      excitation-current-nanoamp:
+        maxItems: 2
+        items:
+          enum: [1000, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000,
+                 90000, 100000, 200000, 300000, 400000, 500000, 600000, 700000,
+                 800000, 900000, 1000000]
+
+      burn-out-current-nanoamp:
+        items:
+          - enum: [200, 1000, 10000]
+
+      reference-sources:
+        items:
+          - enum: [internal-2.5v, internal-1.25v, external, avdd]
+            default: internal-2.5v
+
+    dependencies:
+      excitation-channels: [ excitation-current-nanoamp ]
+      excitation-current-nanoamp: [ excitation-channels ]
+
+    oneOf:
+      - required: [ single-channel ]
+      - required: [ diff-channels ]
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+
+dependencies:
+  refn-supply: [ refp-supply ]
+
+oneOf:
+  - required: [ refp-supply ]
+  - required: [ "ti,refp-refn-resistor-ohms" ]
+  - properties:
+      refp-supply: false
+      refn-supply: false
+      ti,refp-refn-resistor-ohms: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@40 {
+            compatible = "ti,ads112c14";
+            reg = <0x40>;
+
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+
+            /* 3-Wire RTD: Two IDACs, One Measurement (AIN1-AIN2) */
+
+            ti,refp-refn-resistor-ohms = <500>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <1>, <2>;
+                input-chopping;
+                excitation-channels = <0>, <3>;
+                excitation-current-nanoamp = <500000>, <500000>;
+                reference-sources = "external";
+                label = "rtd";
+            };
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@40 {
+            compatible = "ti,ads112c14";
+            reg = <0x40>;
+
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+
+            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation */
+
+            refp-supply = <&avdd>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <6>, <7>;
+                bipolar;
+                reference-sources = "external";
+                label = "bridge";
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <1>, <2>;
+                reference-sources = "internal-2.5v";
+                label = "thermistor";
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..3e114e0c9c5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26958,6 +26958,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS112C14 ADC DRIVER
+M:	David Lechner <dlechner@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+
 TI ADS1018 ADC DRIVER
 M:	Kurt Borja <kuurtb@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

