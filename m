Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0F392806
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908131; cv=none; b=gd9V1r/ttCdLY+o2hWHRWaJp+E2Q/xurHt9k5bkndZBkgnSYw8WLA9IKiIIc6eR9+OcmWw8+sCiZqwmjApH4JfYQHIXHpfKWuBfpkB6Jg152TgllPJsj0gcofI6f9Ds86kTovC2raQ3zWNN5oyKxaEKwpJ0kU+VCLDzpUIcg0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908131; c=relaxed/simple;
	bh=j33YZ6CfweNN6iiskAYLb8a1L781jvQcgyuM6dGuVh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jjfe5f/A0+Sum2nof9WKfOz27VXOcFypdoK55Wxs8gysJULPrxWCXrrvsTXc2QvcOGtpDwl3oJjuPV10+gZkRQb+BwJT2uu6aIzkXmQCH7+ufpbD9VpXdPQDL30jDyFYgDqD/3gmpqr/0J8/w2HjAzI6Z2IZOeTPyO9zvXhVQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNfvtXeA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNfvtXeA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so8081435ad.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785908130; x=1786512930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNE+4b0/cY6qO/wMLz1H6Q1CQk2R0SO7Rau9LTG2NX4=;
        b=NNfvtXeABZlbWjhLmRR28slZesuXNf1sRyoUTGpt65NQodyNo2Vk7GI+b0ZUPaML0a
         leQiCAeY8ryvIgFn5HJ5HNp7oK8RjTg10xqBCbZg6arQ16wgIch8Uj0zgpN+gIyQc6DW
         4UAhzfzHUVroZKtSPvCFeNzsUGMZ8YxktnNUER5AudEQfkCVEKeNGAvmVfCO3zE611qF
         TgfSegrWv9xUv9gwGE9HcIK5FpQxa6owR5n7i5CR0SzQaQnjP85u1T+5wWJr+/7fPU0p
         KUXgvIDEc/MDuLYcp0DdwW56Res0EnPbbuhxl56tV2HtDSwaNtlWfdhKnxKld20Ouqt/
         KdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908130; x=1786512930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNE+4b0/cY6qO/wMLz1H6Q1CQk2R0SO7Rau9LTG2NX4=;
        b=S8XA9ttz/bk7o9wf7vj3PAb0pCxcFFu03lPDA75eYyBjXadxMw2uk113b4wEU4XlKn
         WFj0Mlhzhrl1YQJuXoVeg1R4isErv2FbwDgktgPsJE53jhgQqmAjjhqH4El0uwYEFO0M
         Q98thYiXub4GoKPdVtV3jQAgP/b25phDJzBhaoaQ3dXK34rGn/PEpj0/eV+TYCoyoInn
         6vfYJFtcDjGbmfWkAAofIIeerr+I5NwAYT6KIzETb1W2wNEyHPM69qscBD6YlHLoaM8b
         0Q01UwvFRb09kvGiLln9uLVxGA8FDqEAbYfvckkdEiLeh+wtWmUhBO/T8Jd0jKmJ0pXH
         JnEQ==
X-Gm-Message-State: AOJu0YwkfFYNR8HyRlgpuytP66lwZq4fUpYSnDbH7RzljEz0aNhHVo6F
	QI//gCDocrw05ME8rhCh7UVfW3y4GEvWtLitvb+8ALXRkPh1nhj/4KhxhEzacYAV
X-Gm-Gg: AR+sD12UuE95vnFRmpJOXokhT3R1LVviE+3ef+AHEhiDZLsG2nIBSDgA8X3w43aldjL
	gX4qhpfAqzxUfA7ow8feORQ7sGbrzsAG4EVbwFGZVhsCwfjuNzuvh0ST15xKI0mTzrMYltfRpVC
	knfvcgGhDOzmgoy7dnvo7ceZhEFYf94D24KU3cEJKyOcOQ8si5aNhXwHi7GiFvdtkfv4gFwlKar
	qBRB2pSS/4iKSDzKkFHYpl/vJ1a2xklgEvYnyM0qNoPD+WJyGFR3YVy+9TP7ulEXoAeTVIhdbTE
	8LDmcxgLZDiDkMidibXdMaCejOh9XwuIH2JMqSA6H9wO/t/CueZWerYbQ+vyWOrm7SXfJHdKku/
	R8yYGtNjXUckxMcXujrAi16y7UN5YlJxIwqgocQf2a8C8slH9owXuXmu5dTd5/nHi3bRDOlqAzR
	+kQAiysCSN6Rrn6UbNI3NqlESalVyPnlal+TVoj1NiLQSHydb5xDblth2imavLgDtOwBGz90Dxu
	7kNPbyjRCt3JPp1UhwSJctIJTPI
X-Received: by 2002:a17:903:245:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d0ca7aea8cmr41389385ad.8.1785908129743;
        Tue, 04 Aug 2026 22:35:29 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm14307245ad.64.2026.08.04.22.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:35:29 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 05 Aug 2026 13:38:20 +0800
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com>
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
In-Reply-To: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4388;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=j33YZ6CfweNN6iiskAYLb8a1L781jvQcgyuM6dGuVh0=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqcsxNtFIVsPYwl01+sisYtA9hsX6zcsHULxjdP
 tAVoxJTnw2JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCanLMTQAKCRClg0K3CVbE
 gTSgB/9zrSTVPQrZRhQcdxl3WpBFrlJatlJYeeHWVcq3u49ZhHJayV3cfuK0y//zvq8b6RdXIy1
 ZHtIp/4HklBEk+PzOB5JjfNpJ/EvKEqjyOVL0ykmB4M8UhxXYeIifSMl7V5e7Bt0MNbMK4vghS0
 QVKXGW7ckeki+9Eu9HubbLiqj4RubSOGsFDjoymW7h4JWSssbiekVIKjLWn27NDaT0OtxNCmqg3
 i6OeblihpoTT17YrEKakFiwNKD2liM7Z473S5HT6FRi6Nvmwet6xt3kDWJkWnuWNF4iABzmU0Ic
 Naq0SpVeNmw9BpbaWWsIp3sS/9yuXZWmp2AITYAPj+gFBAnt
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add device tree binding documentation for Texas Instruments ADS112C04
I2C Analog-to-Digital Converters.

These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
interface, programmable gain amplifier (PGA), and data-ready (DRDY)
interrupt output.

The binding uses child nodes to dynamically define the connected
single-ended or differential channels.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
new file mode 100644
index 000000000000..ff079bb5b3dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
@@ -0,0 +1,146 @@
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
+description:
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
+    description: Data ready (DRDY) interrupt output.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to the RESET pin. Active low.
+
+  avdd-supply: true
+  dvdd-supply: true
+
+  refp-supply: true
+  refn-supply: true
+
+  ti,refp-refn-resistor-ohms:
+    description: Resistance of the external resistor between REFP and REFN.
+
+patternProperties:
+  "^channel@[0-9a-b]$":
+    $ref: adc.yaml
+    unevaluatedProperties: false
+    properties:
+      reg:
+        items:
+          - maximum: 11
+
+      single-channel:
+        maximum: 3
+
+      diff-channels:
+        items:
+          maximum: 3
+
+      excitation-channels:
+        maxItems: 2
+        items:
+          maximum: 3
+
+      excitation-current-nanoamp:
+        maxItems: 2
+        items:
+          enum: [10000, 50000, 100000, 250000, 500000, 1000000, 1500000]
+
+      burn-out-current-nanoamp:
+        items:
+          - enum: [10000]
+
+      reference-sources:
+        items:
+          - enum: [internal-2.048v, external, avdd]
+            default: internal-2.048v
+
+    dependencies:
+      excitation-channels: [ excitation-current-nanoamp ]
+      excitation-current-nanoamp: [ excitation-channels ]
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
+oneOf:
+  - required:
+      - refp-supply
+  - required:
+      - ti,refp-refn-resistor-ohms
+  - properties:
+      refp-supply: false
+      refn-supply: false
+      ti,refp-refn-resistor-ohms: false
+
+unevaluatedProperties: false
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
+
+            reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&vdd_3v3_reg>;
+            dvdd-supply = <&vdd_3v3_reg>;
+            refp-supply = <&vref_reg>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0>, <1>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                single-channel = <2>;
+            };
+        };
+    };

-- 
2.34.1

