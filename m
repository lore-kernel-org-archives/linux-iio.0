Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F503D1CAC
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615218; cv=none; b=Ztaay4H7xSH/MducKVpswZfHSrFQ0uhVnxJjrc9P4obxPspkbb/feP9yqeCe+ZdET5RkWf9zC8x2Le5RbgMDpMYQx0VIUoKxFj3n+EBjffBGlDlSHGECEUvC9NnnUwEFsqs8zKOR86czRxkYUQMUw0IHIyduoXGmVf5/nBpvJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615218; c=relaxed/simple;
	bh=cPLTMgCebSlD5ocQduzgGTXwXY73WCP33zPg6TlD2Y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gekiDj38NZCU3Cv4UwIkRtLCn+lW+HpzH00g72iMwelJLTUON63osrq721gzdqUycOSLmTlsR20vNhXf6OiazaqRwSIv8rfMIUtDWNvNQtR0nZgNK92Uz70hZ/COl4gBBRzpaq+988Ax8/uIE4Zk5rW8eiSix7oPxTByDm9eXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAxqgKbF; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAxqgKbF"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1127387eec.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615216; x=1792220016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AQ/dnC8lpXunUYSid6MrsSdMamy1xNcdHLhwxbVki1Q=;
        b=ZAxqgKbFXZ7x8so8GuVtzjfDpc7YPfuUsbtq3Ne8yJbshRZ+LyNxZK3PJAWaSjkmfJ
         joo1j81O1+x/mgJhlT6HG1Pp1OHJRHyRIJoXGEbdfLoPEkjRmxbF4EQtW4hf62knZrDq
         nuFjTSR90miO3Ydaz5qDFGdP8QbOVbxm2sRXnnScU3bxCZJenB6TE36Y+rESNyMfitL9
         dUJXL0P+Wg6K1UodMgf1e92kawBH/UmrooZRQEL0zfYWnaqBs3D/+QqK+uFmW5wucMXz
         hM6hRxJLMLN0BLiYL36kF21KRMlVEiEQ0etbNp9HSzrNF40jrdBRPkmH8XlXhNcSM8WH
         efug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615216; x=1792220016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQ/dnC8lpXunUYSid6MrsSdMamy1xNcdHLhwxbVki1Q=;
        b=idD0zYwATPwK4c7mj7Qqx0X4Hs6SdiQp/Z8bLmawisVqeuVQ2uNltaT6egRDjtteGs
         AmnsoCr+nzHLXxlnl98Nj/0+qegeNaMSwCwVX0KENGRrsvkDnRL7TwXIbZX78poxdhXb
         In8YvzjP0mWJecqfvze1wWGI4SyWTq5qLYqq1wpXdH7S6sY7MxGj/Hy7J7PUty+os9n/
         CUCtBo8ENU775qr+d5F+gt2pb0PpO5rRHGogPafxRh4R8GRyFe4txmjNEE2Wl/U0K83c
         cCWAuziJCPiv5SaenCaDzBgLPi/n8UdlRaM1LQMwWK0pRTMzFceYZv37MNw7AbmkaxCZ
         uYsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRkJ+8mWjB7GzOEuS8PzP1fkcTBHpBsBB0ahV+lc+IikZQr04zMHDwnnSnxqpm6k22IZfjt4McHRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTA58mqxGo1DxWBJvL0t5vfrESCLEONieOtPsyUKfY+Bg2fRRn
	OEO4Xl6T4802NTOmkhv8rWwERU9UFHaTAFojiSOCGHUw81wBAlqU7m3W
X-Gm-Gg: AYBFou1/jl8y+G7MV6wA4d66DsWoGCdZHaSgwxtgald2zyQ+lZXBQdfEImhofN3A7tq
	vNTgsInmv+c+w/nDX0VO1CvowefvcnwHXqQ5pV1BLFrYMKeXlgU6fPDWocvmL1/bsupNnNHvULd
	9GdeNfozEwJWky8ahOWQSNVIPOBOB4aPUai+1CA27ZrGOGHqmrsAV8uYofRIt0E/n1zzYDDcdFg
	3ASNdRzT6RTGG6Bo/xWUlyuloMoQg8AYpVYl38WGkLuWA7TubIKyQTmirFdB0WZbdZBJclIFe04
	IZOf2GyGHaZnl9vx5cmc0sprjBacv/cCTM5g3o1lek8mQHLLO6elutu4IV2YlOws9d9nedf1iII
	IHeqtr82cFWWPn5Ad5vcBbdI9Wdwfz6UF7obfeze+uDrxj5oiqxVp/gX7oYDBMHcxHPorAxncYO
	TtRX2CeHM6rweswF6Bd01kEJcPK+K9sbzn8rrgyvWzDHzujNEFqlMUExmIbUDeZtazZKFr2YGez
	B4sviCNHV6gJa1NVWZD7ZPruyrMMZWCMM4+wJhu
X-Received: by 2002:a05:7300:2321:b0:347:8d01:164f with SMTP id 5a478bee46e88-3537e05ff52mr8091847eec.19.1791615215402;
        Fri, 09 Oct 2026 23:53:35 -0700 (PDT)
Received: from [192.168.100.70] (host-200-61-172-117.iplanisp.com.ar. [200.61.172.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm13009650eec.20.2026.10.09.23.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:53:34 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 10 Oct 2026 03:52:41 -0300
Subject: [PATCH v5 02/10] dt-bindings: iio: adc: support the TI ADS126x ADC
 family
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261010-ads126x-v5-2-49e331cb2fed@gmail.com>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
In-Reply-To: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13233; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=cPLTMgCebSlD5ocQduzgGTXwXY73WCP33zPg6TlD2Y0=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFknHzx9GvBXXOOljM4EyY8qM1ZsyC1s/90XMcdkYvPJv
 33PXL3aO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiFzgZGWbI6X7h9f7w6udt
 vfDrDjuTF/Z8+M85ReyHAtfnVdKzm7cy/JW9OXulQeuS49Y5si+5bRblnHG6terd5w/fg3N+G5f
 2FrIAAA==
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 381 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 387 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
new file mode 100644
index 000000000000..d9957aa509d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
@@ -0,0 +1,381 @@
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
+    description:
+      External crystal or clock wired to the XTAL/CLKIN pins. The device
+      automatically detects and switches to it. If not connected, the internal
+      oscillator is used.
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 3
+    description: |
+      The first cell selects between ADC1 (1) and ADC2 (2). The two following
+      cells select the positive and negative inputs respectively:
+        0-9: AIN0-AIN9
+        10: AINCOM
+        11: Temperature sensor monitor
+        12: Analog power supply monitor
+        13: Digital power supply monitor
+        14: TDAC test signal
+      Monitor inputs (11-14) must be selected as both the positive and negative
+      input.
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
+      patternProperties:
+        "^channel@[0-9a-f]+$":
+          properties:
+            reference-sources:
+              minItems: 3
+              maxItems: 3
+              default: [internal-p, internal-n, internal]
+    else:
+      patternProperties:
+        "^channel@[0-9a-f]+$":
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
+            refp3-supply = <&refp3>;
+            refn3-supply = <&refn3>;
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
+                reference-sources = "refp3", "refn3";
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
index 3a2dfd1a4fd8..b9ad0ee57233 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27321,6 +27321,12 @@ S:	Maintained
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

