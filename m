Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85920E702
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368808; cv=none; b=cIGNd90xa4w1Fa3p6Pbl7L99Y76+sgCQQ8kNOeYhykf9iZG01HAlF539llH1IXlEqxSJ7wDWlXS5AjiaAG1RTwG1WfACqAF6PR3RE6V3dRJBFAK/d1SyGql9A/fWpLqLyGhWiRo/zplf6lqUmfHHDH5hnxdbcU/QdfhKd0oCnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368808; c=relaxed/simple;
	bh=e66JuePu6a7ir1WWhyQtl3ZGTZL5+1V6njZ2rqbUywc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VssbrN4M6AGgxvTJaqTq8eJE89UNadCjmm8BCbbSgJ0HUZkQ07V9NP8O89XGBlGXx9jzM9nnaGw7XEsDYJJ4D6ytvlocX36jZMvIj4zWP7dbq9TAXusvlgY79moJHp4l44dyZdIxrONK3+AIzZynUwJ+rEC8Fs0KvJbI391A1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO55MSCD; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO55MSCD"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3859320eec.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792368806; x=1792973606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WlauIIya78Tvj2uup0SeYB78dPiKQXeWRQRrva/Ygkc=;
        b=nO55MSCD7GC2M+W8Eh2huDAZJeUUZO/Sqdy20+9LBoi4SRGuSM/pqymETCpPJe0DTw
         Dj2KFXmV+/dyvMORjLYQaM4v23QLXj4aTcoBUSO0qyyNEcUzaK89hPFHdAZKheXaU1A/
         3ndUHhDUja3JaZltacKbgkdylUnC9iWYaMojJuwwLfO5WSDTpKBeuCvuoYTk660x1DOQ
         vJ9jTVRAt1ZECynH+0PHJM3Ei3EjdMcXRp9lx5lh+gbxOzM71OURmlxw3eRi2rRna65Y
         gecWkG4tjXa+QNu7wPHN48vi+bpmTskLt3A2njxspIA5QixPsCmVTEe0IFjW7QvNhtip
         g6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368806; x=1792973606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WlauIIya78Tvj2uup0SeYB78dPiKQXeWRQRrva/Ygkc=;
        b=qlkQgSYLXthgptuzEftxqA9u8ZAAW8IHYAyGcqbPOUfZVijMVa/3+8NMdOThPyYh6I
         CKbd0HpzQHrIfuVqshOKtTX+/7BWWasln5hIy91ENJoQPVkEGFGk7G0G3ElbM2GDTVA5
         vKMkXIOn7Q7jJirsbBzeI0m59SI8/nZmXwdiKPcK8vM3qPVo419KzBmB1lR4Fes6JJ+Q
         Y52dqCfdph94vLfpUVHHSC3QA+338zpN+kTq7KyU4JFSObIpr8bJXpap+s9LlhtXcJmW
         Cy5TT5ZrXW9N07uWcblrnSFnI1q77wo5pLlLPBtzCoxgIBTfV1WOp/IiXwjGHVn7Pq/E
         fPjA==
X-Forwarded-Encrypted: i=1; AKwUvBzNkv5O61PQqW3Q55OAj/hae7ZLgNeZSghLKXkWUIdPNj+QZUCLu1lTwoUxcnD7JwQXb99W0YdsltU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeb8Y3lG6AdhjcU8OYMQaumcmIOALiBiCWhrDLp2NJGeygLpL8
	2ZTAyqxjMiGMxwkjfCEn6W11k7L99qT0FZ1ze7eM4KSekPxjU7wEK4v5
X-Gm-Gg: AYBFou3UnEtqdDvhgBN5cV9+xCrDrucuAlZLSiP79e1Z3h2Rtn5bY2STD99f4AlHPfY
	QshUVPgr06CE1noQjgpGdRBti5R+unyo/0LIs9BIVuh1ARqIrXuoN6zd0grTDPofdtYAkNBz+z+
	ARTlVm1Y5qgJXU2U2vfeIB2/6bS4oKGN95V3IHqj91DTG1Q9pjCml7Q0q5aMTP1v3Bp7Fe/venJ
	faBJKQq3h24WosZw5Nmj9GUbLzcNLqA8vVrx8mMS/Nnz6/B+OVgrekrf1ZpkHgQS7wbijmRt/8Z
	VrL3+ZkAXDgONa8y0gxPnk5IYIk3fSp5xHu4Vu0tadmBWhxqBPFkfibnwnDnhhmcLGwXtGPNrjv
	TnIkCO9fXYO8PO7IU4OXY5y7JszYIXs+nSW44Q+0UNLlmQdqUsyYn1gpYuGibZ+raYeASOkDm1n
	wPxKZIkE3E5G/Z9nyQzmY5EixRORuHpTAuRkoP4Q6G1aBthvamH9Dgek4npKj+NhnlMjHTUqw6d
	pTtiXPWEpJsCu8OfKVpFg8=
X-Received: by 2002:a05:7300:ce0d:b0:34c:5831:8a19 with SMTP id 5a478bee46e88-361a361222emr7829098eec.40.1792368805870;
        Sun, 18 Oct 2026 17:13:25 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:9a49:ae2e:1b25:b04a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082f7f6e0sm30631371eec.27.2026.10.18.17.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:13:25 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephan Costa Barros <stephanbrrs8@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: add TI ADS1299
Date: Sun, 18 Oct 2026 21:12:46 -0300
Message-ID: <20261019001247.483005-2-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019001247.483005-1-stephanbrrs8@gmail.com>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1299 is an 8-channel, 24-bit, simultaneous-sampling biopotential
(EEG) analog front-end with an SPI interface. The ADS1299-6 and ADS1299-4
are the same part with six and four channels.

One converter can drive its clock out of its CLK pin to the others
(#clock-cells), and converters sharing a chip select in daisy-chain mode
are described as one node with #daisy-chained-devices.

Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
---
 .../bindings/iio/adc/ti,ads1299.yaml          | 221 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
new file mode 100644
index 000000000..a8966cd07
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
@@ -0,0 +1,221 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1299.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS1299 biopotential analog front-end
+
+maintainers:
+  - Stephan Costa Barros <stephanbrrs8@gmail.com>
+
+description: |
+  Texas Instruments ADS1299 family: low-noise, 24-bit, simultaneous-sampling
+  biopotential (EEG) analog front-ends with an SPI interface. The ADS1299 has
+  eight channels, the ADS1299-6 six and the ADS1299-4 four.
+
+  Each channel has its own programmable gain amplifier and a multiplexer that
+  can select the electrode inputs, a shorted input, the internal test signal,
+  the supply or the temperature sensor. The part also provides lead-off
+  detection and a bias drive amplifier for the driven reference electrode.
+
+  The converter signals a completed conversion on its DRDY output and is read
+  over SPI in mode 1 (CPOL=0, CPHA=1).
+
+  Several converters can share one SPI bus in two ways. In cascaded mode each
+  has its own chip select and its own node; one of them can drive its internal
+  oscillator out of its CLK pin (#clock-cells) for the others to use as their
+  external clock. In daisy-chain mode they share the chip select and DIN, the
+  DOUT of each one feeds the DAISY_IN of the one before it, and the chain is a
+  single node with #daisy-chained-devices. A daisy chain shares DIN, so every
+  register write reaches every device: the devices run with one configuration
+  and from one external clock, and the bias drive amplifier cannot be used.
+
+  https://www.ti.com/lit/gpn/ads1299
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1299
+      - ti,ads1299-4
+      - ti,ads1299-6
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      The DRDY output of the converter, asserted low when a conversion is
+      ready to be read.
+
+  reset-gpios:
+    maxItems: 1
+    description: The active-low RESET input of the converter.
+
+  powerdown-gpios:
+    maxItems: 1
+    description:
+      The active-low PWDN input.
+
+  clocks:
+    maxItems: 1
+    description:
+      External clock on the CLK pin, used when the CLKSEL pin selects an
+      external clock. Omit when the part runs from its internal oscillator.
+
+  clock-names:
+    const: clk
+
+  '#clock-cells':
+    const: 0
+    description:
+      The CLK pin as a clock output, for a part whose CLKSEL pin selects the
+      internal oscillator.
+
+  clock-output-names:
+    maxItems: 1
+
+  gpio-controller:
+    description:
+      GPIO1 to GPIO4 are wired for use as general-purpose pins. Omit when they
+      are tied to DGND, as the datasheet asks of unused ones, so that no pin
+      tied to ground can be driven as an output.
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 4
+
+  '#daisy-chained-devices':
+    description:
+      Number of converters in the daisy chain, all of the type the compatible
+      names. Their channels are reported in chain order, the device whose DOUT
+      reaches the host first.
+    minimum: 1
+    maximum: 8
+    default: 1
+
+  avdd-supply:
+    description: Analog supply.
+
+  dvdd-supply:
+    description: Digital supply.
+
+  vref-supply:
+    description:
+      External voltage reference on VREFP. Omit to use the internal 4.5 V
+      reference.
+
+  biasref-supply:
+    description:
+      External voltage on the BIASREF pin, the reference of the bias drive
+      amplifier. Omit to have the part generate (AVDD + AVSS) / 2.
+
+  spi-cpha: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - spi-cpha
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      required:
+        - '#clock-cells'
+    then:
+      properties:
+        clocks: false
+  - if:
+      required:
+        - '#daisy-chained-devices'
+      properties:
+        '#daisy-chained-devices':
+          minimum: 2
+    then:
+      required:
+        - clocks
+      properties:
+        '#clock-cells': false
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
+            compatible = "ti,ads1299";
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+            powerdown-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&reg_avdd>;
+            dvdd-supply = <&reg_dvdd>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-line-names = "ADC_GPIO1", "ADC_GPIO2", "", "STATUS_LED";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    /* Cascaded: the first converter clocks the second */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc0: adc@0 {
+            compatible = "ti,ads1299";
+            reg = <0>;
+            spi-cpha;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&reg_avdd>;
+            #clock-cells = <0>;
+        };
+
+        adc@1 {
+            compatible = "ti,ads1299";
+            reg = <1>;
+            spi-cpha;
+            interrupt-parent = <&gpio1>;
+            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&reg_avdd>;
+            clocks = <&adc0>;
+            clock-names = "clk";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    /* Daisy chain: three converters, 24 channels, one chip select */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1299";
+            reg = <0>;
+            spi-cpha;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&reg_avdd>;
+            clocks = <&osc_2048k>;
+            clock-names = "clk";
+            #daisy-chained-devices = <3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 52024397d..b4a8e4573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27370,6 +27370,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
 F:	drivers/iio/adc/ti-ads1018.c
 
+TI ADS1299 ADC DRIVER
+M:	Stephan Costa Barros <stephanbrrs8@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0

