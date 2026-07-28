Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B713F5BEF
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225570; cv=none; b=HiSCehw+5SDnC8V8cJ8gVgq9+UhiuFI0/3f42qvCEJTofj6a2t56MACjkMpcXbxoMk5HkYwCTZS1w5xoRa1LVC2dKbozdNQNbc0lTyoc62fDWyUQb8MGn84Gf5K31ACsquwG0JI2/pMzfn91S/K1qZKeVCjC50PMEoMTC581AZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225570; c=relaxed/simple;
	bh=UuR898KEiT0etvcWG892aFyNkNw5Im61er1Rzj1xJ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nC2h1SzfKMFNHfLRu0MQ1viACNi4FLa923z66QD2p7ZF2JDwejCTMenUpsMc4Vveqbd24rXkEtXaEnB/7weS7eeoba+B6Ga7bBM/1U023MPfjfrZGY6IPRyQryGF80GlHVm7Z/0UbDqW0P3PaG+iJSRXQGSw619J02bzZDW6MkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW87GPvr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW87GPvr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso44788645ad.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785225568; x=1785830368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vs25IufisVBAoZjBQMlMsFTHa5QxDB91GfGLQ6eBcM=;
        b=LW87GPvr0yWhScQZa+iZ0EiURw5upBoAhNSMTUpJ22MdPi8Oy3TSaz3hltcVfLAn40
         pilZ8H0+CJ7LDKj5GvqDIhBAkfBF6uO/GNWKuHoXdrORLDyIfWk7JuFx4OGwJQA5SNCX
         mlSVVwPnuP4h9Kf+XV6BtVT5S/hESTG4ysW5rFZn2tlpMIqeW9zenbhVBRiiLTKaq/tV
         x9l9o1lPe8kRIHZX6RWH1MVe4BtrC+/A+mHVeelffQS6rgbbUBC0edWXmJmkpI4Sgeej
         DeMLDTSNQXDRW8GtDCZLA0M7VwUxUZVXJldoV2b41cDBGaSG+S4VC6+A48PypB/3xOrb
         FkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785225568; x=1785830368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vs25IufisVBAoZjBQMlMsFTHa5QxDB91GfGLQ6eBcM=;
        b=WYIGq46y5vYi6CfxyV9DTVVVEy4rKJiSU2noZONE/3u72nxm6dicJZ5Vf3A46UYa/x
         wcv1I2WichC7jD+Qr/MbUUU+VaqGl6WjIXWa8fJbVl0PvgaHaX6zG9LGwYLi0xb0TmRk
         S+5AU0XyGSkzGURbQJFnACgE5sZ4wx00fhHqOylvl6aEPAPVugwMYi/xMD84+DArOLmw
         5mxJYU65i7H4RewXY4wvwVZBwjmMxnO6242Yt6RBwthz5ZjOzLYdaNd/KCAkW3DrLxsu
         4xV0gVnWKhSroIn6r6gVJtAJipziyOHRGxMb2MZoSiGjXxclWUY33+j9HzpymYpLEPJu
         CJCQ==
X-Gm-Message-State: AOJu0YyC4mIc3D9vX3Oz9d1sr3fL4HE7n8wn6ZUkQO+3+cpss63TrRje
	x5T3WfTWqooPOGq/YSGRCL7xkH2cUyuX2wFjOfioE6IaEtjUuv2Wlndi
X-Gm-Gg: AR+sD10a9YBhKXGda/a2lOdvbSnoQ/fASeGncaNPpfEGr6AELAHLakpREYaSuyRNs5Y
	KNNuEMsVXqY95QXaztA2wVGC4SgBGeNw1tL15WRjJnJxVgcQMRIfiiiF5fRL0KtPssuMSxyFt+6
	kvQNTTI3ne2zzB09lnekm2K2fjHF0xvj90pT+VPXhl0na/w6kUdP5iPktBMfj4qM1F01bPGlW8/
	G6a0Z78fHjkcjy6jKx8ftIB9MfRCPxWVzMrcxx4TaJxwCPEELvhkuYj+ZtET0JaMuuy2IrPalVW
	Tp5Ae+dCAxtyyE/kUeoDwbumoaK0yJlhgugEMhQ0TmkBn8G4S+fLY0d3ahT8Ec36tK9P/xur09l
	GZv/CpdiGyi+f3mMFl4irPiuBxid6B0hXhBo7F7/+8uKRQZxWlyD/Q/jOdk2zfkLjDutIIOHtWg
	fzmbgexk3dMZAJtkIt7IqdSCk40jMKrTpnymJ/1a1Ktw==
X-Received: by 2002:a17:902:ecd2:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2d015b15c5dmr16733285ad.9.1785225568379;
        Tue, 28 Jul 2026 00:59:28 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d81csm47543915ad.80.2026.07.28.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:59:27 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 28 Jul 2026 16:01:17 +0800
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding for
 ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ti-ads112c04-driver-v1-1-475efe4e2b78@gmail.com>
References: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
In-Reply-To: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=UuR898KEiT0etvcWG892aFyNkNw5Im61er1Rzj1xJ3o=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqaGHQ5+GCOE3CGZtxx5Pll7ZTJq0JJQH64iIPa
 HQPAPxgNXOJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCamhh0AAKCRClg0K3CVbE
 gWnwB/9wmEDxNIAoEoyp9+ZgJj5Ve+wzwQ8HwUld7kUzHq/+kvWnQ3H/U0xHZqLUuR8HKDCY6GZ
 0NnpiMFlF4sNxE8xo4d/zlgo2ntckoB2usFQej1k98Ii+pavh7QdltPhDEMwu3TEL9Z8AwnvfP4
 aD0uq8g/YVxwUII8SdIUc3ER7kh4P+uX74mAKE0tLqLL6sUKJd/9HuQlVVFCIlBSm8bavFRZAwx
 sKnIsYqHq+pVOClyAUYrDcmknUSRwBprYLUlTzEU3t5Ivt8Kv+XUpHilakD8jegW4WcE+vCw8M/
 27cEnXqK6kxSW5XYLM4Ih25c/w9uMWF270LpIdvHCWU52sIs
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add device tree binding documentation for Texas Instruments ADS112C04
I2C Analog-to-Digital Converters.

These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
interface, programmable gain amplifier (PGA), and data-ready (DRDY)
interrupt output.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
new file mode 100644
index 000000000000..55842fca1215
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads112c04.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS112C04 ADC
+
+maintainers:
+  - Kyle Hsieh <kylehsieh1995@gmail.com>
+
+description: |
+  The ADS112C04 (16-bit) are precision analog-to-digital converters (ADCs)
+  with an I2C interface. They feature a flexible input multiplexer, a
+  low-noise programmable gain amplifier (PGA), two programmable excitation
+  current sources, a voltage reference, and a precision temperature sensor.
+
+properties:
+  compatible:
+    enum:
+      - ti,ads112c04
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Data ready (DRDY) interrupt output. It is asserted low when a new
+      conversion is ready.
+
+  "#io-channel-cells":
+    const: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RESET pin. Active low.
+
+  avdd-supply:
+    description: Analog power supply (AVDD).
+
+  dvdd-supply:
+    description: Digital power supply (DVDD).
+
+  vref-supply:
+    description: External reference power supply (connected to REFP/REFN).
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@40 {
+            compatible = "ti,ads112c04";
+            reg = <0x40>;
+            interrupt-parent = <&gpio>;
+            interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+            #io-channel-cells = <1>;
+            reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&vdd_3v3_reg>;
+            dvdd-supply = <&vdd_3v3_reg>;
+            vref-supply = <&vref_reg>;
+        };
+    };
+...

-- 
2.34.1

