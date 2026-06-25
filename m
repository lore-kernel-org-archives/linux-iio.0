Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473D3793BB
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424575; cv=none; b=Kemb9lDOrcqSSyvbKL+g7P2TRJz+fh3/40YgNpuOy6lQydyM5hcJFKVXBEM2N/mxIvwYnGtPCrS9o9BsIaBfuQaYJy3Bq44HGBPthZAcpW7YJlwqn3YTc0TVZARlzMt+BQ66zgwWZexgqBskVq62ukj28GhvO2fXNSsb9btWAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424575; c=relaxed/simple;
	bh=WDnJgFcGj7tkuSDmYs4ARqdWRhRSS/LSEyAFaHzI02E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ytw1zSRqnwY5vxTpemEDCk30GCY/6jS83PwT1Wb98PfwGgduBGsC+5TP4MFII3QBQrTgC1gx693jMI34fvldq9EtwZYuvteCntArlfkNq1BUMlESWgMGf+onFbCAha8GwyqdNOFu5DZep9jfXmPy2ycpr/pvsaw+ycNHRAGCCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oqRNPnV1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oqRNPnV1"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e951b9524fso212521a34.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424572; x=1783029372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JgY6HeMCs9/NoxVUc198N36V9+4YODWXDSePw08kYM=;
        b=oqRNPnV1pFoUTFcbeecB0MUqunLuYCQtcuXmiV0aJNjLpqcrtKGotoIvfmGxFzwedF
         TEx1BftP7u708ORQ3adnBGCFU6N3vMrrEkjbjEBRY/wsyMMiE/DZdmxUuBAl+N5v1qE0
         8F7sIwWcWtVRvpHu79FOpOusbvQeZpenvFzRhRrUL1N94tT0KoABn8LfyClh/VUNd1nA
         m2BYQKKzpGAf+95wukKF0EIS7wDqpkvCi+hRfD1xtVDUziDhx92aSIg7bYE4DYJdKmir
         FZd+5ojuGYl7MJzFdAw9gqR5nr20AYEn7tDBzt9+Fahqsk9f4AcuPZvWxItqO8W5hNoC
         lPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424572; x=1783029372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0JgY6HeMCs9/NoxVUc198N36V9+4YODWXDSePw08kYM=;
        b=c0X+qnIHc6K+jcx3FiYNaLp5Jny/8hXHwlMAJS+4/1Buf+vNQ5JNwPfZPHBI1KPjzN
         z1Q+VYQZR8rbL0mXSjQXEMiMbHTMustq0+JJovxhEdP/BlMv24D7nDI8spLD+iIkefMZ
         ULxbCAUaZB66RG3H1Dh1D3vL6jufKA8S1bXb1tj+TApYUHn1VrIkhyHWEyzZU1hadxXF
         ued9ACzkvtPy+/xZO/w/ioyoF69ffze6VjkCHKYqVmwpt6zZC7DNcg9nfb9DVefAXa3P
         t2RdWNIskn+z7qCg+CZ/3dODlgjovflu5zpUcTUzAzVaNyc2stwS2xM8DZBjayg6FYa8
         XgPA==
X-Forwarded-Encrypted: i=1; AFNElJ8b9Xu+Y8dmiNQx3wb6lrqbnGsqoEB6HI1Ip3HPpYMMl7YGD+GMbC/THZJDT9MDd1ZVycKwkAeTpyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIWQnJhvovsB4YNA7ZXURezhVWJp8+b9LYrNFtS60YWHowC6H
	sm5XNqHqkARfS3C3csvzK/IKPZInO/8bdnZhZhPJx+PBt1xS++ubUrTVbGyRsiGL/6Q=
X-Gm-Gg: AfdE7clY5H0Ce/Wff0gIhROrHstVXa3eP6GeX4L6N/3rCBZzizksi+WKEuJqkNL3TPj
	u9zUsj89yvgg/VzklGop2tPMOCXfyYZxLPYNHpi1clDy5WrdVcvAOWDy/yqRYql7XORDShWhQh9
	02ab02zh23REbj0MDSjrgldrin4V4Ah9mwsJ0TPK/j7KLmtQn27lJnRCztfrh/zAsEWe4AsP3tq
	ObmNORq+VM/CmTF8/xLBbE4JOGXL/LlgdbvPDXnEwfFTVGAx6f2MTl6R6RH7BY+ulVjtsYh5gBN
	L+6iag23E7PRcqrKCZ9HY5CaXliawKsR2JhreV2rVnL1FKapkHvs/KR+Gqjakqr7xu9ilY5+oAz
	kaZpKTQ+HB5IkVdRnosnqFK7AO2kscOjMY45wPlXQTiR0YARtcjVw29vZ7X4E8QsR/MQ1B1IVG1
	y7G5GrNRd7VRgozgpdxA==
X-Received: by 2002:a05:6830:6017:b0:7e6:fab4:4f5f with SMTP id 46e09a7af769-7e99c4e575emr3763424a34.15.1782424571730;
        Thu, 25 Jun 2026 14:56:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:11 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 25 Jun 2026 16:55:07 -0500
Subject: [PATCH v2 5/8] dt-bindings: iio: adc: add ti,ads122c14
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7480; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=WDnJgFcGj7tkuSDmYs4ARqdWRhRSS/LSEyAFaHzI02E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaPdwSKfe5i+gPlW4pWBbuJqJaTLaVqNNR8dW
 6AKSSbeTr+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2j3QAKCRDCzCAB/wGP
 wI99B/0Qf8RfXwxc2y+2Ylbj+YpKrZz5etCNF1rl0mN8KKA/fer0JMWdsiDejVr24cWiYy6oQ7A
 8KQFJ/H7rul2uHw32nEDsugr9I4OdwhNff0HlyH0NUPMA3fYsDCjV17mtd4R1sfVvMpP2wkI8WS
 Oi9ym+tTfIQbk850FDu3aEPaonktIduoI3rYPYq8Ijg/hu02lNeOLJQ9SLFpx8gzmemRXM+ayxv
 uzXkbNv6NIEtyUfenx1WG0wGuVRW8CNwA2zjJYvOqR0kEaHhMH0Mcz3Oeb0HXZZQIhlxsvtkAFC
 KIbhtaM77/sdh3CngtGTmHiY1p6JeYIMsMm3Gh0dVT24SQ3a
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

v2 changes:
* Added ti, vendor prefix when appropriate.
* Others are now standardized properties from adc.yaml.
* Moved top-level unevaluatedProperties.
* Fixed some issues with the channel@ matching and reg property.
* Dropped description on bipolar property.
* Renamed currnet-chopping to input-channel-rotation.
* Drop header file and use string enum instead for reference-sources.
* Added burn-out-current-nanoamp property.
* Drop allOf: and just use oneOf: directly.
* Fix inconsistent indentation in the examples.
---
 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 205 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 211 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
new file mode 100644
index 000000000000..59ee4d652a08
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
@@ -0,0 +1,205 @@
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
+  ^channel@[0-7a-f]$:
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
+      input-channel-rotation: true
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
+        enum: [200, 1000, 10000]
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
+                input-channel-rotation;
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
+            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation*/
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
index 895a87b571c3..0ac9f44c7096 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26935,6 +26935,12 @@ S:	Maintained
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

