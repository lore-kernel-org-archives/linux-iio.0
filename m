Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4C3CB56D
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899131; cv=none; b=qgRhXc0CD8zAZkhPxD8JWpuz/1eI1ejTNgeqDZLpVUf5wKcFgK52dLHRsBuCoWGh0Z0X4fkM6qt+aXjFLogLe1UEIGb5DevwozWZzx/q88Hx/75anffH2H1w3tulbOPZFrW+EPaTEC7CtWpSFP6wlgGgIbvGuwgXSLSh1zO1HH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899131; c=relaxed/simple;
	bh=DDo13wwLlYbjGc+vmoTMKrXc8Q3Ay18o6BblG/u9PbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrQNkIMBXkt/yoUN09zLR1LhGRjANFacms9Zq7pQ5rsve+hTh6flqgsnc6shRKzudqZ2OPvvPVf4ISUt/fRIsUVmPRuLCq2PfstxuK11PegWZDMF+lO1hrenpGh+33k9Oo6BJuQpP0cE9zUekCgMfwaBxvW0jpF/tTpOAZiwK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbOHUpAT; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbOHUpAT"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c652293bcdso701744e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899123; x=1788503923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbHEcSo0Yi8Hel90njrfpBZZr+GuK02w+zwFa8IkLTQ=;
        b=ZbOHUpATu0ftaVFshrVS57VUljA2YRwYwmDV0pRbt/Kq2vThwN1lZMjiQ1tUX/fAvL
         2SUKmdvNAKq99hyfaYhPFtMqy2h/yAJqEOY38kWtXyc4jXMxNInpPhdvDm9KrkVuuy/n
         7XwKhaiUHPplzuH56CNuZzfRooB/UxjE0pYAreHp5poom+WVHDa2r5Nf/p4SKfDugn23
         H/TumWQtjxHsWjcsFaDpFQ84sZ07mgmpXxZc+M804oohlLq7ZTNjVeVCtlD4WCHgKt/X
         49Lj7jdPZkAnmLGduHIepBcUzf+mcVMfY0AgoEpawwd6CLAGLOoWTZE/3y9orD3gz3vI
         QITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899123; x=1788503923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbHEcSo0Yi8Hel90njrfpBZZr+GuK02w+zwFa8IkLTQ=;
        b=XLoxWjRTemi/sNWbyKPSSAO48u9EVWPbX7paK942Ckgqr3quafBH/Ll1PrVnwHwXJU
         Wcndzk3p/H3RQrgMFpNVj2ge4yg+dX74AHzfkj6ojCb1XqOM8Sxg86vHITC24+YhCigf
         lXF2UznCFY7P7yw3VH2b2Xb74NHRDSVbkY+DokT22BdgabLBX0wU2SDqzCKDKvYzR1mt
         SPcFayjVyi1WKSN8N34z7NTAECOwJwxttdffwVWwpRFlayvunU8BbI7+ol3wZ7LGBDXR
         ZU3H8B3BkSU4hnkOcES9e6z5ApbwNFVujFfCLrHLhG66FUNEFND1gApUuXDLBEPGeGU+
         wUrQ==
X-Forwarded-Encrypted: i=1; AHgh+RojajAk6BwAZfCvSKatCZ/381r3swTvP6iZhyr2lbI79Ov0GEt5vK7lJo1I0F1tAvftIozwJBqYJAo=@vger.kernel.org
X-Gm-Message-State: AFuF++lJoYxaMjUGm7lEOfNMbehrsnoY/ulZPvoTvv49fwiZCZpaXLUa
	8bpEPiWXKQIEP0XINxkbCN6Kg0XVHkztdUQ+Bh9Ek1xXsmYUg5RhYtzH
X-Gm-Gg: AR+sD11G89Szt601ImU+a0DVXNeliuDYOz6nKd2paeovCIgpSnY/OCgZzefzJbEoBBy
	eV1z8OepKGDOawXUqVckgEQ9DJoDfg0heE1XctBCgXJMzPO7HKnPHQ35VAAzc1gg+yFyYtiDkIh
	bKjA/iuCnkTKwrQ7y4IGHy+uQAgxDv22GJ1N/nZ4sNd3w6tHxZqqrKSRRaRTV4GzqidBKNvIYCS
	2Rv3NRn3JP20n7ZhXBtLkYQgxV2ssLf3JCCBSAjSv44f/0hh6qP3vaj2lU2grlpu96jxWArV56X
	qOzdv8/bWjweRyFFYIGoUkNkKEebe4OHDmJWWLgh8fevDQdC4k0haD9MYrzDVUX9nJYgdB/G2Yx
	PaHgGGergrUyHok1MaKwPhXAbTYwkK3RuB63DTHfa83Q875UkXtJnrU9BLiNAWrUxTpcCfGDLJt
	mx+y8OpSqnQPAQ473ssezsGa+QfprAfgr3ROB/rjD6sVwuoQl9CrruphudzaiayNAL
X-Received: by 2002:a05:6122:9001:b0:5c6:7f44:b001 with SMTP id 71dfb90a1353d-5c680967056mr2104219e0c.0.1787899122940;
        Thu, 27 Aug 2026 23:38:42 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:42 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Aug 2026 01:38:17 -0500
Subject: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x ADC
 family
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
In-Reply-To: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12770; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=DDo13wwLlYbjGc+vmoTMKrXc8Q3Ay18o6BblG/u9PbA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdd7sqJ1hvVd+1nN9pvPXmsoEpA4vq/xzR2pPcXxtk
 ejaP+xLO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAi75cz/E9T1Amct+/um/lu
 6/rVc99f6DZyDvyZf/FRz0u21+6WfncZ/uk/61i/tlA6QFqx6ib32VcKOx/p7H30feWHyXwpsy7
 UpHACAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
integrated PGA, internal reference, excitation and burn-out current
sources for sensor biasing and diagnostics. The ADS1263 is compatible
with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
channel (ADC1) cross-checking measurements, system background
measurements, or temperature compensation of the primary sensor.

Both parts can configure per-channel voltage reference source,
excitation current sources (IDAC), plus input and IDAC chopping for
offset and IDAC mismatch cancellation. This lets the device drive and
ratiometrically measure RTDs and other resistive sensors.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 376 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 382 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
new file mode 100644
index 000000000000..7e26572388e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
@@ -0,0 +1,376 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1262/ADS1263 analog to digital converter
+
+maintainers:
+  - Kurt Borja <kuurtb@gmail.com>
+
+description: |
+  The ADS1262 and ADS1263 are 38.4-kSPS, delta-sigma (ΔΣ) ADCs with an
+  integrated PGA, reference, and internal fault monitors. The ADS1263 integrates
+  an auxiliary, 24-bit, ΔΣ ADC intended for background measurements.
+
+  Datasheets:
+    - ADS126x: https://www.ti.com/lit/ds/symlink/ads1262.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,ads1262
+      - items:
+          - const: ti,ads1263
+          - const: ti,ads1262
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 8000000
+
+  spi-cpha: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: Data ready (DRDY) interrupt lines.
+
+  interrupt-names:
+    description:
+      The data ready (DRDY) signal has two independent interrupt lines. A
+      dedicated DRDY pin and a pin shared with the serial interface MISO pin,
+      which is called DOUT/DRDY.
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [drdy, doutdrdy]
+
+  start-gpios:
+    description: Start conversion control.
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  dvdd-supply:
+    description: Digital power supply.
+
+  avdd-supply:
+    description:
+      Analog power supply. In bipolar supply configurations, the reported
+      voltage should be in reference to DGND.
+
+  avss-supply:
+    description:
+      Negative analog power supply for bipolar configurations. AVSS can only be
+      at or below the ground reference (DGND). If not described, AVSS is assumed
+      to be connected to ground (0V).
+
+  clocks:
+    maxItems: 1
+
+  '#io-channel-cells':
+    minimum: 1
+    maximum: 2
+    description: |
+      The first cell selects the channel by its reg. The second cell selects
+      between the main ADC (ADC1) and the auxiliary ADC (ADC2) as follows:
+        0: ADC1
+        1: ADC2
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+  regulators:
+    type: object
+    description:
+      List of regulators provided by this chip.
+
+    properties:
+      vbias:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        description:
+          Level-shift voltage output on the AINCOM pin. Its output is the
+          mid-voltage of the analog supply, (AVDD + AVSS) / 2, and is used to
+          shift floating sensors to within the ADC input range.
+        unevaluatedProperties: false
+
+      refout:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        description:
+          Buffered internal voltage reference output on the REFOUT pin.
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+patternProperties:
+  "^ain([0-9]|com)-supply$":
+    description:
+      Common-mode voltage supply connected to AIN<N> or AINCOM.
+
+  "^refp[1-3]-supply$":
+    description:
+      Positive voltage reference connected to REFP1 (AIN0), REFP2 (AIN2) or
+      REFP3 (AIN4). If this regulator is not described and a channel selects
+      it as a reference source, then it's assumed to be connected to ground
+      (0V).
+
+  "^refn[1-3]-supply$":
+    description:
+      Negative voltage reference connected to REFN1 (AIN1), REFN2 (AIN3) or
+      REFN3 (AIN5). If this regulator is not described and a channel selects
+      it as a reference source, then it's assumed to be connected to ground
+      (0V).
+
+  "^ti,refp[1-3]-refn[1-3]-resistor-ohms$":
+    description:
+      Magnitude of the external reference resistor connected between REFP<N>
+      and REFN<M>. In ratiometric configurations, such as RTD measurements, the
+      IDAC excitation current returns through this resistor, generating the
+      reference voltage for the conversion.
+
+  "^channel@[0-9a-f]+$":
+    $ref: /schemas/iio/adc/adc.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+
+      single-channel:
+        minimum: 0
+        maximum: 10
+
+      common-mode-channel:
+        minimum: 0
+        maximum: 10
+        default: 10
+
+      diff-channels:
+        items:
+          minimum: 0
+          maximum: 10
+
+      input-chopping: true
+
+      reference-sources:
+        minItems: 2
+        description:
+          Indicates the reference sources for this channel. The first and second
+          items are the positive (REFP) and negative (REFN) sources of the main
+          ADC (ADC1). The third item is the reference source of the secondary
+          ADC (ADC2) and must always have a positive differential voltage.
+        items:
+          - enum: [internal-p, refp1, refp2, refp3, avdd]
+          - enum: [internal-n, refn1, refn2, refn3, avss]
+          - enum: [internal, refp1-refn1, refp2-refn2, refp3-refn3, avdd-avss]
+
+      ti,reference-reversal:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Indicates that the ADC1 (this has no effect on ADC2) reference voltage
+          for this channel has negative polarity and thus should be internally
+          reversed.
+
+      excitation-channels:
+        minItems: 1
+        maxItems: 2
+        description:
+          Selects the pins for the IDAC sources from 0 (AIN0) to 10 (AINCOM).
+          The first value corresponds to IDAC1 and the second to IDAC2.
+        items:
+          minimum: 0
+          maximum: 10
+
+      excitation-current-nanoamp:
+        minItems: 1
+        maxItems: 2
+        description:
+          The first value corresponds to IDAC1 and the second to IDAC2.
+        items:
+          enum: [50000, 100000, 250000, 500000, 750000, 1000000, 1500000,
+                 2000000, 2500000, 3000000]
+
+      excitation-current-chopping: true
+
+      burn-out-current-nanoamp:
+        description:
+          Selects current magnitude for the sensor bias current source.
+        enum: [500, 2000, 10000, 50000, 200000]
+
+      ti,burn-out-resistor:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Instead of a fixed current, the sensor bias (burn-out) current source
+          can be pulled using an internal 10 MΩ resistor.
+
+      ti,burn-out-polarity:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The sensor bias can be configured to either pull-up or pull-down mode.
+          In pull-up mode, the current flows into the positive input and flows
+          out of the negative input. In pull-down mode, the polarities are
+          reversed.
+        enum: [pull-up, pull-down]
+        default: pull-up
+
+    dependencies:
+      excitation-channels: [excitation-current-nanoamp]
+      excitation-current-nanoamp: [excitation-channels]
+      burn-out-current-nanoamp:
+        not:
+          required:
+            - ti,burn-out-resistor
+
+    required:
+      - reg
+
+    allOf:
+      - if:
+          properties:
+            excitation-channels:
+              maxItems: 1
+          required:
+            - excitation-channels
+        then:
+          properties:
+            excitation-current-nanoamp:
+              maxItems: 1
+        else:
+          properties:
+            excitation-current-nanoamp:
+              minItems: 2
+
+    oneOf:
+      - required: [single-channel]
+      - required: [diff-channels]
+
+dependencies:
+  interrupts: [interrupt-names]
+  interrupts-extended: [interrupt-names]
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - avdd-supply
+  - dvdd-supply
+  - '#address-cells'
+  - '#size-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads1263
+    then:
+      properties:
+        '#io-channel-cells':
+          minimum: 1
+          maximum: 2
+      patternProperties:
+        "^channel@[0-9]+$":
+          properties:
+            reference-sources:
+              minItems: 3
+              maxItems: 3
+              default: [internal-p, internal-n, internal]
+    else:
+      properties:
+        '#io-channel-cells':
+          const: 1
+      patternProperties:
+        "^channel@[0-9]+$":
+          properties:
+            reference-sources:
+              minItems: 2
+              maxItems: 2
+              default: [internal-p, internal-n]
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
+            compatible = "ti,ads1262";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "drdy";
+
+            /* Typical common mode voltage configuration */
+            aincom-supply = <&ads1262_vbias>;
+
+            regulators {
+                ads1262_vbias: vbias { };
+            };
+
+            channel@0 {
+                reg = <0>;
+                single-channel = <0>;
+                /* The VBIAS is enabled on pin 10 (AINCOM) */
+                common-mode-channel = <10>;
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1263", "ti,ads1262";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "drdy";
+
+            ti,refp2-refn2-resistor-ohms = <3520>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <4 5>;
+                reference-sources = "refp2", "refn2", "refp2-refn2";
+                excitation-channels = <1 6>;
+                excitation-current-nanoamp = <500000 500000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f3be900e5b9d..7593e33c5346 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27019,6 +27019,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
 F:	drivers/iio/adc/ti-ads1018.c
 
+TI ADS1262 ADC DRIVER
+M:	Kurt Borja <kuurtb@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org

-- 
2.55.0

