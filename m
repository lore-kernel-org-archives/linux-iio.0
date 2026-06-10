Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E942885A
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104437; cv=none; b=sLS7vOuYy6q5+UxqVzxWenXuCLQLv6wUo/vqqT73qpoQA7YUaNOk0dQDvtC0Drbp5ij/YL0rBc4eHPVEan3EUNn98rJ39lNw2cbtoG6s+bZfH8o7Gs4nWwQ730Idy1itIt3BpSLe+JcstLHmYWfSvEaXNYKQ8qmdmIW/m1LydUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104437; c=relaxed/simple;
	bh=M/5gSjAn+YcjGodamaEuPXWFFEhIJf7ohDvPakJoF90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fnSsb6QaWwQx+ZUcI45UcKUNGhMKFVzPyfEPCeL/iCmj6LElYC+Bf9t6rNxfNW35oPfqxG/HxGE+YDND6PaFB5k5NsaID7ikjUhWwXoR4f5LgJNEiKYAoFoyTeoxqt2Y4jaumYnUnIZ1HoGm8SUAxcGTdghA6HyuUEw4qhRf4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU5f8Jrd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU5f8Jrd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf20f6be6bso54661355ad.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781104434; x=1781709234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P61/w+k7e0xq9IcRaaKdIJbJ/H1LZmJo6tSMLynVjp0=;
        b=UU5f8JrdzgPiMlJquE39bp4KHbDe8oOvpZ/8+l6hRbM3yI8Gvw4ruruaqNWjE+WQ0E
         AufO0I189vVU8qkqh365ZkaxQNMo2THpAum7rku2gImxQCmyDXn3QxwOf2oFWDO3ctx6
         BmXxVDR29uHdgbIi8XwKVNfxMKsbadZFUoMZneby3mMXPBJyh5u0OLa5O2j5aaaeF/K5
         F0IMOTDKVYfth9NTtCTtQQG3+JV3/CkuqKo5z7h1M2YFSwCAZiUo6IBmU6SmD+qy+8J5
         eXiwK4MWWHuonbij+fKQ3FOpittbJA9h03ZsHhjrJwbWQLoZ6Za5gwkBIzciV6U6fyzZ
         I0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104434; x=1781709234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P61/w+k7e0xq9IcRaaKdIJbJ/H1LZmJo6tSMLynVjp0=;
        b=Fz4rIVkhXVOc+fFDa9ZtmvKqucQ/xrkFMaMTjwEgeVYHAOGH7RQThm61XTdosZlC+O
         rAb3jN2JlIW8SnDZcIw5Z0GcHhCkFs6+qso60nDkvH8+9OlkmCBcm7VgzpCqOmFzUjJb
         fuce/6WJ515gli3me0pDaIWmRppd5sS59bZuV99oIjxWCRUuUyaXbKw76Kbq5wZIqOT0
         +EenKmz2786SFVSx7gPSxQSk4v6IrIIsobRhyZX7TJPryC48I4CEHSTNnC2lN6Pn0Z9B
         ckGvC1xtDyWbJASAjGplvox9lYX51tXjPr8B7QVogxX/9M3z6Yox+5/lV9aClwfvZwWQ
         YaIg==
X-Gm-Message-State: AOJu0YxkFsJHYyFv5KvksHAJkeLVzP28HT93yYLUcZPNCE9VZ8LMf/rr
	AY8cjoOGf1J6BYJa/Br81MCWTW/IZwd3rsP0OUNKz8PL59G78zlNY+2g
X-Gm-Gg: Acq92OFoSu+/x9YqxEikgszB98RBLekeAOung4gcPCN3OIPx4as0W9bY6AJroAaDCRO
	nuCGlIN7fn9LmjgPEuxPFr57EgvbTspsKaH6tuOcXGswX88FFQE/5pi0VFWuVrz9ywKq0FZKOzD
	SplKTm4GK8fD21+93hzoUf+WhXvOUr/QrP4phndzkqh9gev4cpRsHJ6BZ7WFnaQu73h1wzM2s+B
	Nf3VnygR49Z7gBt+ddd4TCs3vcqowFf+jlPVlpH7VU0Ja0FU4VMrBbYAddUzSp1MeJzusqfzBRb
	lylqjwKnhlPv0pcZ8eMT4PYP46VLmmL8IY356lKRjScYMyBbWC2y2MpPjPiAEBKhLZhN3W+vXkp
	v7eF+a2/pKkXoqUsh+VbMB3pXwoZHDRemRyrvXiPZ74BNgSLGQLf6qbpQ+8wJIfQi1JB1zmDX2u
	ipIq9vGCtN/xiF7xO+xF1Abrs=
X-Received: by 2002:a17:903:2348:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2c1ee755854mr292480485ad.20.1781104433672;
        Wed, 10 Jun 2026 08:13:53 -0700 (PDT)
Received: from ltu.. ([171.245.6.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm254066195ad.80.2026.06.10.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:13:53 -0700 (PDT)
From: Nguyen Minh Tien <zizuzacker@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	zizuzacker@gmail.com
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1220
Date: Wed, 10 Jun 2026 22:13:41 +0700
Message-Id: <20260610151342.44274-2-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610151342.44274-1-zizuzacker@gmail.com>
References: <20260610151342.44274-1-zizuzacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1220 is a 24-bit, 2-kSPS, 4-channel delta-sigma ADC from Texas
Instruments with an SPI (mode 1) interface, a programmable gain amplifier,
an internal 2.048V reference and a dedicated DRDY data-ready output.

Add a device tree binding describing the SPI device and its per-input
channel child nodes (single-ended AINx or the multiplexer's differential
pairs), the optional external/AVDD reference selection and the DRDY
interrupt.

Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
---
 .../bindings/iio/adc/ti,ads1220.yaml          | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
new file mode 100644
index 000000000..1fedffc2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1220.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS1220 ADC
+
+maintainers:
+  - Nguyen Minh Tien <zizuzacker@gmail.com>
+
+description:
+  The TI ADS1220 is a precision 24-bit, 2-kSPS, delta-sigma ADC with an SPI
+  (mode 1) interface. It provides two differential or four single-ended inputs
+  through a multiplexer, a programmable gain amplifier (gain 1 to 128), an
+  internal 2.048V reference and oscillator, two programmable excitation current
+  sources and a 50/60Hz rejection filter. A dedicated DRDY output signals when a
+  new conversion result is available.
+
+properties:
+  compatible:
+    const: ti,ads1220
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  interrupts:
+    description: DRDY pin, signals that a new conversion result is ready.
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply (AVDD/AVSS).
+
+  dvdd-supply:
+    description: Digital power supply (DVDD/DGND).
+
+  vref-supply:
+    description:
+      External reference voltage (REFP0/REFN0). If omitted, the internal
+      2.048V reference is used unless ti,vref-avdd is set.
+
+  ti,vref-avdd:
+    type: boolean
+    description:
+      Use the analog supply (AVDD/AVSS) as the conversion reference instead of
+      the internal 2.048V reference. Suited to ratiometric single-supply
+      measurements (for example a potentiometer wired across AVDD), giving a
+      full 0..AVDD input range without an external reference. Ignored when
+      vref-supply is present.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - avdd-supply
+  - dvdd-supply
+
+patternProperties:
+  "^channel@[0-6]$":
+    $ref: adc.yaml
+    type: object
+    description: Represents one ADC input configuration (channel).
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 6
+
+      diff-channels:
+        description:
+          Differential input pair routable by the ADS1220 multiplexer.
+        oneOf:
+          - items: [const: 0, const: 1]
+          - items: [const: 0, const: 2]
+          - items: [const: 0, const: 3]
+          - items: [const: 1, const: 2]
+          - items: [const: 1, const: 3]
+          - items: [const: 2, const: 3]
+          - items: [const: 1, const: 0]
+          - items: [const: 3, const: 2]
+
+      single-channel:
+        description:
+          Single-ended input channel AINx measured against AVSS.
+        minimum: 0
+        maximum: 3
+
+    oneOf:
+      - required: [diff-channels]
+      - required: [single-channel]
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1220";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            spi-cpha;
+            interrupt-parent = <&pio>;
+            interrupts = <4 4 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&reg_vcc3v3>;
+            dvdd-supply = <&reg_vcc3v3>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            channel@0 {
+                reg = <0>;
+                single-channel = <0>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <0 1>;
+            };
+        };
+    };
+...
-- 
2.34.1

