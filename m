Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D75340416
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466597; cv=none; b=YpucfAtKR5nfy9Q+Fr/fYGAStJpZ/OH7Sw4Rb4DH/ekw/RBZhllcUqxof67GDfF5h6MlfevsFtm7WfVDkr9gZlpiakAH1Yam1QTMf+egrVKEEuuic6xrzaUcRnpT1BV3EQOJdkKakKlvYzVJCFeTWoOfF2vyfpZbpOZx18eDu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466597; c=relaxed/simple;
	bh=LcqvqDicat0vXhksaxom6+76R/Ncodzz/8ncb7yIbcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LirQBgnXncF/H4/AzVY7bm2hJ+i3L+73ihiuzpdG+F6fvGAXYlCIKDsECY5ky/DQ1rNqB9TRdAjxWRIHYdnwDcdD59FpnjHbcUafi70WbSCCC1QFQNit3GELOSywqSLUDjch7L+3Cn7zsxX9CJ3qzz+5zOcXAOe6DfFPEwLPWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+BlYMSt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+BlYMSt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so4920615ad.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785466595; x=1786071395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSWuvcMxwkUJprNTcD6VGu4kWLqx+IgwY+r+QhfQlFk=;
        b=H+BlYMStn4fiXVN/rwb3LR6mHhaIMF/QP8uWRjJ7yftrogyiZSdHcsJQAKrTbdNOnQ
         TdIuopbX0CK6uaE4x0LjNw7Mawhe8Y7U7jeyySG/w5v0dBSTIjiCvTJ034dWNr7nNmOE
         VR/TgYTaRx4OeR2yIqLZohaezSEmEJrMurqLBN1Noi5mU5+gxiTmd8JTpTQPQRRFQ6Pr
         HmB3X3TmjxAfPg4pc2GpTecBP5jEEBRDFfICdJgZMs/Jz/4CJWbr39YOWyPumDdNdsP7
         rkgN1AryYahrOJ2H0hw717R3mVZVc3VQguY75dFyaH1TEk+volPI11MAu3iOwSGh//bz
         w/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785466595; x=1786071395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSWuvcMxwkUJprNTcD6VGu4kWLqx+IgwY+r+QhfQlFk=;
        b=spHAQtd/88VGAk+7yx/MPbtjQzsHvjGiw7/4jeYjg866qza6ztpi68NLINKbUoSiQ3
         B8J3LgN0KqUD8wxyGtVlPVAKf7qYHVS8bvU0z9hHKDGWtYxZBi8w3rir/AhmOUg5Yzyp
         cgPAl3Js2B636n40kish1cuGV4SndhmZoGXjM3hUiM4wAVHL9DfVeQBV2DyMK86ryTie
         XVG8/hsLLuQrY7wW2K+bdpdNj54wntBlFDOpN+5k1gXVl5+kEcXf6RzUc5lxezd8nBcj
         9DO2WioP6SNKg8Y/IiD3Maq02NdCzF5MSfEFCFzWbQnbJcI9zhAquvN0bjYZsOcy1nod
         DU4g==
X-Gm-Message-State: AOJu0Yzrob2XXby9eQuwSctFIIiU4ExE52yQu8LX39MEhz7EDs0DjdJU
	T/F76w4sIaHiUA6Vntt3++QxQ0Ht3rWfMeeuDybnzW6HB4u7QrFHXIyU
X-Gm-Gg: AR+sD10DTLg24ued9kEvuHM/svQ+vFu1SeK0PJc/Y6axgb5epyeIRxqxB6ynIvmb4VT
	fItMdJqppvAJpc6INRzGowFoAmiHS/ZNhgdscNfKLpXf6NIyjrcA8xhnFhb76pOOBp4HtHREeeB
	GuisPyBV4SXr4AFdhbhWGUa1xMSfvXJqDB28TcF8b/XsuVQaDAzinOgaKXDOvOTpje1OsI1SNKc
	45EdOC6w1MUHeBo2u5Ic1VfTbbh9mLfiKQustEBVRnAkVZ+zBMwUZlxH2qbS/aToFcDa95226a6
	hMKSh3d/GCPDmDTYH+JPYqnlT6UiHpZkiQme7+x/bsjQ5eX+9VYGKcOSmBUlvma973fL8syqUB3
	BmKaW0K7UrSs0HrPwyIftHuXJ2AQd08O1k7ZhZwNdwd1mpR9Uva/INZUF/8DuPnMK5Xuqi56FhV
	J1el0YTNFDaY7WeIcDMmlN4+7QD1Y9dPLNNn/7a4uwUSKU3ww8/aGxq/prvstetgjlZoQXDvtmj
	90jqk/NESM3HGC38GxLVyW7vRzy
X-Received: by 2002:a17:903:4b07:b0:2ca:ce92:6e44 with SMTP id d9443c01a7336-2d046d6f447mr4579835ad.8.1785466594777;
        Thu, 30 Jul 2026 19:56:34 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0478d9da2sm753915ad.7.2026.07.30.19.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:56:33 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 31 Jul 2026 10:58:24 +0800
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com>
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
In-Reply-To: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=LcqvqDicat0vXhksaxom6+76R/Ncodzz/8ncb7yIbcY=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqbA9T3k3f6Or3ytV4rC5Tm5NkqqJ146X15FqU9
 tJzZgGxkAGJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCamwPUwAKCRClg0K3CVbE
 gQtdCACyf6cNl/cGrDb95aK3b4U2tBvCgDvE6PA/loOgf15yzvVvSh6wqsdsE1itgSjPvfeDuhl
 KpQ6/CgEiIB9P5AXgqR45QO7nhdf8klSlT/OfZ5czeQ+vC64Kc22UOEHM8wrWs40UezcIYfPyur
 6e387SydKx1fVYT1jUTuk52SywGIu+UKHD6LEsaEVRXZQJ3g9SspVJJm3kP1yvywS4BIOTeBAx6
 yWVZprafrieiskCnahHRgu695PRay963xJP46A8yNxlqjlv5gVarb9jNak0z5gdLdMYxjHWnYJ0
 slzgEwHj8sv0qHLzjvvwXEvTXDkX9+t6QZ2EtsiwSl0iVV3A
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
 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
new file mode 100644
index 000000000000..6a5ffda84b80
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
@@ -0,0 +1,122 @@
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Resistance of the external resistor between REFP and REFN.
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    $ref: adc.yaml
+    unevaluatedProperties: false
+    properties:
+      reg:
+        items:
+          - maximum: 15
+
+      single-channel:
+        maximum: 3
+
+      diff-channels:
+        items:
+          maximum: 3
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
+  - required: [ refp-supply ]
+  - required: [ "ti,refp-refn-resistor-ohms" ]
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

