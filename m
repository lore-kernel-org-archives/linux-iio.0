Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AE3B6C16
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560875; cv=none; b=UPL/QlfxnDgeTQHvz0ef9ZjtW0jnwW73Je3qW+kPZLciWeOyxpGlYmbLf6X3OIl+8HbKCikGTdz9cR9A3rGpnGcNThFaZ2MgEKS+K6YeaMPlt79ZyrnyUTh8zkknkJ8VXBCzwykTpvkAtiexjiI7dvYSa8wewOsxZVNbNyinUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560875; c=relaxed/simple;
	bh=oB81RdQ3Jp0/L98SYuih+EtVe425Glj6LB4b/2sKKmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIrUcSBasawuZmQE6RaCsRRnOx572FTN217UE/IFnTSYv2n306heHIBQkxs9zfazOgH0G4jQ8pCNQkSvc/hJf8K7uvHSeIE+WqT+n/Isjv0On5yA1mSmkJamr1kgcL1fTTRSDihmHrRgjcRZtrAwsONV0IaaA70UX5Asfxt1UY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=E4BLQ2+L; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="E4BLQ2+L"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44192448b56so1282366fac.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781560873; x=1782165673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCjOZHNaP5yGs5ZTh8/uUhbONHspfiRjpCm/YCT/xlM=;
        b=E4BLQ2+LG6R9lcm4x7i7VPz35mfhvu3JUTm6zEtr9z/rvlv+zX7kgRuO+Sv7rGbJFm
         FeIHykYHa98ecn8QUr5HxLlZ00nKOlJ4kPz0klH75tz9a5pMZ0fbvF8i6ToHvPrRTIB+
         1FBKj24LQ7GvTNEi9NxAvPBtO8rz0RmBVaHIjbL0+VKE7ftiuCVjTFlAonvlCfd25Sip
         ZcokGXLH5l86ZTWRwEUCnGFGgv6QPDHK3vKBnIVzV49bGG8zIh6do36UEKOb07evgk43
         pR4dGRwB7a0k1h6vXilZpRPi+zHMR7hI0QJPCy8lyZXRkI+qn7zouOAjaeSMYhheD0zc
         HeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560873; x=1782165673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cCjOZHNaP5yGs5ZTh8/uUhbONHspfiRjpCm/YCT/xlM=;
        b=NFSCVizK4BbLiWsTAcAnvnfEYr11SJ+nOm7wnEWUnSdX2zC6DFQizRwibDZmP6Q+lw
         3SJt0azWOldzIBHa6mqtXjomXAi+J3D2B3gG0VFIt7rv5c9pvqpT17bKV+bHQ4zGzGf7
         SUNv35BGHQW3NExNJ3DekAOR2uMev8QFNDSDE4hsxZq3oYXlcm3UnkEuT0wLZFFK4llF
         u5sJV1tSgjGeehT/M+ARjx6V6d3tEYXrFOmBL4YuQuzsMHs2CA2d+YzbSdvepZjFR5O0
         PGz1hTpFFFS2KJnQhs9prpusmEFTr1D0PnrzQ3DKeORF0XrIsVGxD1yqj8agWGyglnfA
         vNkA==
X-Forwarded-Encrypted: i=1; AFNElJ+1/H+9l7MxQyzHlm+i8LOAUa1BnNrlx1gISklLO2CE/jhf0liSoC4FQD/nMwttLk8+Ynsn8Zkojlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBikWjTjpC7yN6d1EVtcq6ynHhTi71VqBa01gCf773WbZeSB3U
	v7ebsNAYnTAN7NVX1I0/lzD0Y41UY+EFdhfkNLX3swsW2wN7reYguayf1tCi8YTgYqc=
X-Gm-Gg: Acq92OEqCFixFyutvbTKkIixzMW+WghDPyKcQGTv9Ke5o29gjmvvZ0hSoqURrAWVhT+
	lrG0mxKYRQ4XUDSQQPuKdH/vbLFLjiNJM5XpyHXexQ2krdhh3n9DX0ET0tjCoPO4ZPeO4PkIbuX
	qi/vZ+oq3KcfLHfO5IkSfqlL1Z1V4PMgppQZjWq+NplBV19qGYOGIdc3FsTnw1XIyjwIiXYgkWm
	GrJv//bicgcIG10AEaSwXWXlNWw0E4u8fSC8pV625XXfApZNze0eJ1NruvSorHQWP/SV6v+/0KU
	l6DDyLEVuNwj0grhSrKQooDwOBUXUWksTT6fV1JIjPhkJQqAfkuPLguM7YLlH5r1tahpVCJql0F
	xIYDZgEUxM3tFkWfKU0jb/GNiGtp6hvD/7+kEZ+A7Qgd0MABK3asxEk4EuMJfS/i+M2VdXvWda/
	Q/OHz+ylZsxQYlh+bFdu7dNHpfVEj3aSE8hZvYAWk=
X-Received: by 2002:a05:6870:6c15:b0:442:5f16:ab9 with SMTP id 586e51a60fabf-4426dd5ac69mr11259963fac.12.1781560872545;
        Mon, 15 Jun 2026 15:01:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308fd9221sm826145fac.15.2026.06.15.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:01:12 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 16:59:59 -0500
Subject: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8417; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=oB81RdQ3Jp0/L98SYuih+EtVe425Glj6LB4b/2sKKmU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqMHYMw0A0zsdRToUZqkZNf+N2mSdyJ8YqvF2FN
 M6CdAZp4byJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajB2DAAKCRDCzCAB/wGP
 wAaYB/0WsY8SLzrtkpv7CF6YZ5xKe1xa3c5VA+wGIkrTvV6zkF5gazCkxVOh+arUvubkJ6SbZ5M
 6/5NJD2vP1xTFIOkhSG6SAvy8lJzgILWjInljWrvRVP3uzCyXcOPgAnCtHz2AfgzoQseXBlnIxv
 AGBiuqyaf7uZxqSwsFCgk61pwyOJOai1hDqYhELtfRop5Yjt8PFFmYrzE/GIo88jwcd87ErckAr
 D0ZSuGDCzkBrZ3tOdQ3oVuDDgDiUWBY0F30l4rUlNOARDn3WL546p0dhPquC8rQ174v/RIXqDWa
 6hcAveTFcMgF5XReNqsK96GVBCOt2CsSt+KsL4Wk5925ZvsZ
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
 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
 3 files changed, 242 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
new file mode 100644
index 000000000000..dc7f37cad772
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
@@ -0,0 +1,224 @@
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
+unevaluatedProperties: false
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
+  refp-refn-resistor-ohms:
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
+  ^channel@[0-7]$:
+    $ref: adc.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        maximum: 16 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
+
+      single-channel:
+        maximum: 7
+
+      diff-channels:
+        items:
+          maximum: 7
+
+      bipolar:
+        description:
+          Set this flag if the differential input can be negative.
+
+      excitation-channels:
+        description: AINx pins used as current output.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 2
+        items:
+          maximum: 7
+
+      excitation-current-microamp:
+        description: The current output of the excitation channels in microamps.
+        minimum: 1
+        maximum: 1000
+
+      current-chopping:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          If provided, the two excitation channels are to be used with current
+          chopping enabled.
+
+      ti,vref-source:
+        description: |
+          Indicates the source for the reference voltage for this channel.
+          0 - Internal 2.5V reference
+          1 - Internal 1.25V reference
+          2 - External reference (REFP-REFN)
+          3 - AVDD as reference
+
+          For convenience, macros for these values are available in
+          dt-bindings/iio/adc/ti,ads112c14.h.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 3
+        default: 0
+
+    dependencies:
+      excitation-channels: [ excitation-current-microamp ]
+      excitation-current-microamp: [ excitation-channels ]
+      current-chopping: [ excitation-channels ]
+
+    oneOf:
+      - required: [ single-channel ]
+      - required: [ diff-channels ]
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
+allOf:
+  - oneOf:
+      - required: [ refp-supply ]
+      - required: [ refp-refn-resistor-ohms ]
+      - properties:
+          refp-supply: false
+          refn-supply: false
+          refp-refn-resistor-ohms: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/ti,ads112c14.h>
+
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
+            refp-refn-resistor-ohms = <500>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+              reg = <0>;
+              diff-channels = <1>, <2>;
+              excitation-channels = <0>, <3>;
+              excitation-current-microamp = <500>;
+              current-chopping;
+              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
+              label = "rtd";
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/iio/adc/ti,ads112c14.h>
+
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
+            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation*/
+
+            refp-supply = <&avdd>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+              reg = <0>;
+              diff-channels = <6>, <7>;
+              bipolar;
+              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
+              label = "bridge";
+            };
+
+            channel@1 {
+              reg = <1>;
+              diff-channels = <1>, <2>;
+              ti,vref-source = <ADS112C14_VREF_SOURCE_INTERNAL_2_5V>;
+              label = "thermistor";
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f1caa6e5198b..9ce7c61b0c14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26911,6 +26911,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS112C14 ADC DRIVER
+M:	David Lechner <dlechner@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+F:	include/dt-bindings/iio/adc/ti,ads112c14.h
+
 TI ADS1018 ADC DRIVER
 M:	Kurt Borja <kuurtb@gmail.com>
 L:	linux-iio@vger.kernel.org
diff --git a/include/dt-bindings/iio/adc/ti,ads112c14.h b/include/dt-bindings/iio/adc/ti,ads112c14.h
new file mode 100644
index 000000000000..96906642fe41
--- /dev/null
+++ b/include/dt-bindings/iio/adc/ti,ads112c14.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_TI_ADS112C14_H
+#define _DT_BINDINGS_TI_ADS112C14_H
+
+#define ADS112C14_VREF_SOURCE_INTERNAL_2_5V	0
+#define ADS112C14_VREF_SOURCE_INTERNAL_1_25V	1
+#define ADS112C14_VREF_SOURCE_EXTERNAL		2
+#define ADS112C14_VREF_SOURCE_AVDD		3
+
+#endif /* _DT_BINDINGS_TI_ADS112C14_H */

-- 
2.43.0

