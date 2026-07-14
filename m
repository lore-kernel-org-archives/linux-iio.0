Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39243551D
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071369; cv=none; b=GOMoZKq7yckK3CAN6qYQECI/UJY4C30nzFzZB3iw0WlEGm6rPrb1kU0lzzY4bk8qPTO9yXbb70/fvzDVe9Aa0UEILNa3Kpmr2UEclN+ooT6ouSjpv0BLsWkNfsik/5P5OnBuY+K9W8eXzl7IdvxbOpwvV6kzWy6DYEGQEKpemvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071369; c=relaxed/simple;
	bh=DvAzEskRo1aaWEFsO8jB+h+KLZgJN9K2o31c8vb8nVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgPt/4UTKPFBG2ha3++fS/eLpWOaHQ7VcA3qEM93Cc6pPazX0G2cclbr5bdfpEHadVAgYyW05Qux1wGxDUwxY4Au9B/Mi+xcHpfIvnHI79QrWcCGpFWFkV/Sz4DEKqR0kxghqM024H8ZE2TwBk8zGwmv1oE2jYD/7IZH+tuNPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FTGRmxLC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FTGRmxLC"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a38d83a480so46601eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071360; x=1784676160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xxnQYwYgvTa5VUQkg3ZK1mdH+XYHmPu09MGH1oXASzg=;
        b=FTGRmxLCKONb0ynn7FICt7ieyapngalRSMOA0yyxpw/OuSsDQ47uWvTd6WRzdAyjGU
         TMmWXJXX4BcQulLvDwrE/cCv/6mUyw1qV4DXWCLE+l91o8zidIybGHyP8CwXoMrKoWh6
         lg0AfNdjR/5YwmTRaxxB8lpUww6dHmWz6tikZWepu61t9OgTrGTCWIzBzKnkVA2JepAo
         r+c2wvCf7ec9sN7Tbe2g9588cGAf/ubfVGbt86/YWOv9UqpPbXcEsiY9Nlno+x+mI4l5
         I36SiIEzTqp9a+voJg2LV8yAECa5cT2xSEQ/5CxBn42aASbxVKII4gxmLNUcQvgi1vdC
         Stqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071360; x=1784676160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxnQYwYgvTa5VUQkg3ZK1mdH+XYHmPu09MGH1oXASzg=;
        b=n1Su9Qg6gyj+6mb+XglvK9Ne3bo+j62dJ30FSYByyPZJsT1FoyprUMJK+BFe4qv9Jh
         ipv6EtmjboJMKYn1Fyhwc8lAlgTLL+8z/Z1BG+LuxEnWD76BvY0pQe7MH1OON4uUyqfQ
         kEhgJJpNzqXu2jxkrii1zWcPoR7Ed/VHE6IbmRzawv1Z2+VXczDtq3bBja1Ch6qWOnpo
         gjwvciunWGPh5j0oYHSZFMF2QvMn3Btw6gwcUDW/aLZIyRMaF57Tkwqe9Y5qQcV6QVkN
         YN+FIb9nIubDUyy06y4fUYbsGLdx9K+bihA9lwe/K9J2ED1NLyqJokTIz53t36O2Scl9
         hmwQ==
X-Forwarded-Encrypted: i=1; AFNElJ83D+d5CtkBo1T2j5d2QcXI32M0nE+bLA7d1eRfZlNlxFuoefC23vWfLR0iOTfugPTuZ5RvxdUZSTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3+EBTjMOWIAW8S5bMXe35C7ZsVx4iOMuKT2YFXPwsHESguRQ
	r4aUZs7sXrojhkNVb2q3eHxbB0+eWTbnGNtPrA1q0vbjhNoQf8TZj6HdgrwE0vdRm0U=
X-Gm-Gg: AfdE7cnlH9ybC8BA0w+BF8ZxQga1kScoeMRT/9Akr3aIdqa1ftGbh7ct7h98B4tuC34
	ALCfE+04ywCtdJaca/YyI/Lu+ZCcNKVM9lgKkSaDXwgN+A2AgvYWRUL3CoBnnT5Bb01FhfPdxMW
	95DZQAqHanHk/8bW7JFB9NsDgWmgOOH2hF6p8psr4JuZuiDFHD1UH/I8N6wePuJQ4mTqUZH3+Sq
	jpbGoL8BfPnJUsSUFe3Q4ronbVllK85N3N7GyYB3kJ96HPTnIoujLrptkqhKOxrFBTlVqdiWR99
	MjDeP+WnKJKxmpDfMGvJgrXp6tMangCH2b6y198E3PfRat4mYALExScKxIYWuNM7srWjeeLfvA8
	UTlL5RBr3Zjiun0FG7HJHXWmK6SQuhJOwn6tm3xl98CZRiU6VoEWQS/AY//FaAIHkzM0czcIzmU
	lgK5qz9IS22mpof3qy/w==
X-Received: by 2002:a05:6820:1523:b0:6a3:7d24:7b8e with SMTP id 006d021491bc7-6a39be98f17mr6727379eaf.26.1784071359711;
        Tue, 14 Jul 2026 16:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:39 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:27 -0500
Subject: [PATCH v4 5/8] dt-bindings: iio: adc: add ti,ads122c14
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-5-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8142; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=DvAzEskRo1aaWEFsO8jB+h+KLZgJN9K2o31c8vb8nVY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsSXGmO/U5APL7Ozla3yhc1sehpA7CK0qiDuv
 xYsCq/bYMmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbElwAKCRDCzCAB/wGP
 wLzDB/9b8aaiepGdXU3qE+lvEXPfXdcSDNxVb3DgYzl46oFrgYKoA5k097841RT2epE7opNK8Sd
 5d/bpdp+gN62C4dNGNOIjn7Z4NyETV9AIbfkmbYKJ9R+tnHOTMbSKjoVq4CSL4/MWz/fDFvBfgU
 58MgZDtEoPGvU92PNkE0sHBwyTrqF5Hdebv3iDgP2qEQbMCQ5aNBOjCMDfG86L7pFHIcpM/iSHT
 UIjVx6r+MPvm4QdtZEoRVHNJi1SExQeEpr4Lvu+aCUQC5BME/xv9qgaNGcy5gKI/RImAZ1XsYxY
 kRLmlCap9tsHlGz8dfcffcLs8kSvHZH+6yyEkx511OxyBM5E
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new bindings for ti,ads122c14 and similar devices.

This is an ADC that is primarily intended for use with resistive sensors
(RTD, thermocouple, Wheatstone bridge, etc.). There are a few unusual
properties because of this. In particular, the reference voltage source
and current output requirements can be different for each measurement,
so these are included in the channel bindings.

The REFP/REFN reference voltage is usually just connected to a resistor
that is being driven by the ADC's current outputs, so there is special
property for this case rather than requiring a regulator to be defined
to represent that.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v4 changes:
* Generalize temperature sensors to resistive sensors in commit message
  and bindings description.
* Remove leftover paragraph from v1 in commit message.
* Added if to make clocks and drdy interrupts mutually exclusive.

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
 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 217 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 223 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
new file mode 100644
index 000000000000..b11359c9955e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
@@ -0,0 +1,217 @@
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
+  These chips are primarily designed for use with resistive sensors such as
+  RTDs, thermocouples, Wheatstone bridges, etc. The channel bindings reflect
+  this in that each channel represents the conditions required to make a
+  measurement rather than strictly just the physical input channels.
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
+      - description: /FAULT interrupt (GPIO2 pin)
+      - description: /DRDY interrupt (GPIO3 pin)
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
+# /DRDY out and CLK in use the same AIN7/GPIO3 pin.
+if:
+  properties:
+    interrupt-names:
+      contains:
+        const: drdy
+then:
+  properties:
+    clocks: false
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

