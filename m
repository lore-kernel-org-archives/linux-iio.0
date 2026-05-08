Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DC3AEF2D
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281929; cv=none; b=Equ83vBs95OP4PU+b51sbiGqaHMdOdtqWDHTW443u0Jgo3xKOizNDKIMEl9lT3vHBPXqWH6IEDaMgLItQ34rjuMYcvNgPIFcm+xcngJkPiLhXKqdKw4qTCmTZmEceai/b+2STmhZapwt7KV9x8NeTS+KVZFRFhZY4uzMo77LJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281929; c=relaxed/simple;
	bh=ma/NAkZ+rfwLaK2OHenM/L32fM1WQAJpctov+P127o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aA6bhSf5lANgc/oJnyQJMA0fcifBKWjpmyh4ohKw2B84KOOoJojDwfejC1tupTKqnknTs/okWp7W1mKmPrl5Wmh0wftlGjJ52cU++dF/wwu57FZmxdvKXTxZ5Lc9oL0rFQl0HtYl3MSelR5vJ7mD6krb5hAxB1PdEn3yKlJcE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3cTgpSR; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3cTgpSR"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c19d23b19so4573961c88.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281927; x=1778886727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX9GSyaDMUxgGyMHB/8S0Aw9E0nie662logf6WxGw94=;
        b=T3cTgpSR8awb7Jt8bxz/un7+JjnAK4TMxBT5uSt/ONuR/sWvunp6T+XOlSiM0dMGFC
         zFS1EjJ89nu+EVPnmYz4HCgZlHc5EjUtFcP/7ETwXDYBGXsL2Gs2AyXivBffDls2wvYj
         9atY/4IeB+Ijxq3OA4TMYO0bP5Ayu+e5fdXho/23dr0fqk2m/jqh9teIDQtKe/oPmgt6
         bgaAB5MVgxAet9ZMrgv21Xl3iWgImmRyWgE6U5EkuZFqTB0S56/TTmBk+MxKEvdM4PE1
         eRd8A+qatyPiyAryTNWCSFmR2jOy4rmwFDE788fQyd2rOwnSehlM1gmYQ4FWv8kmGg29
         XkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281927; x=1778886727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uX9GSyaDMUxgGyMHB/8S0Aw9E0nie662logf6WxGw94=;
        b=IeWXHX/moftRk1KCnnJIKYLdkOb+PCXSKVTVN17BvT1EW70ca7v6N5UJxS0l+WPEel
         XRiO5W1o+GCKvIZ89xwRT9dK5VW82qOJiViM5HDTgYoJFJd5DAbIZyJ6hUCT/jGrcVCY
         IZEVM9mnlMforjRH1CdsKyyxNvhaPVNp12LpyRz5BGkjGLE3vZSFCErHRHuiOigGw6ud
         mzL2DkPapGuaAlGe2WbIy6duFp3vTHZ1wqUab3hMhF1/ZubW2BOl117HTiRwWoKfqaDG
         Sy/PLAUcDHbKdPCZ0ztS6YOLuC4FdQ8TXyhrCzW/AtfsBVvvbFG5Eil7rMXWU/JTWz0r
         lnpw==
X-Forwarded-Encrypted: i=1; AFNElJ/z16PkCFhoI205pvB3vtsKxFFWY9AH90vwEoAmlZPrjJ9NRkxAd78cF0xghpLesXD+SKV83q2yV9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/MImA5Lq89OnTe8ic5hPqGaaMsYaJDVTv5GUIk2I+hU9zBN7
	/zXYmI46UNV2s3l2wjYCE3dY2eGXB2uZAXAk+/d3sLk/YJbw35zWIv7/
X-Gm-Gg: AeBDieu3Rdqf3hsp1PNC/R07bypuc9qoNnI7HciL7mlaWEfam8GeSePmn8/Um8lCEpI
	G2kHz81M1/Q3WpioZHoSmT078K1JC3YXHKOSQw7fPPC06CuMrgeRDkhCF4q5te8vyjFQB55fQ+C
	UQoz/gRMRhFLq0vtJCYb9jGqsx+tgu/h8N//KgWREJfS+dJKBPH1nH7oqNNqC9Bj3XquoTQluOe
	e064N22C+Lv7UBJeMzLM6U6sgEV3TQkQJb7pZ5JmScNOeVRiygkFPumT2DML20N3nPYnEPezpIg
	xL0OyUqujsdeug9yfmNMODPgOwefL4IomHqPNy1FFLCqfeIgLJUKhNDKMKN8LHlPmBb4tE2rCCf
	E/hAqjC91gu+cP9EVw5Uz3Oz2365psQ5KbXUv4nwM/MZocXIPZ4wIffwGABIgK9GXDyB90UzSat
	dHRiU9t7Vt0v99sn3dDE1cH+aL/8VHsPmlBDnqN9L00k+I40Ms0gsPl3w=
X-Received: by 2002:a05:7022:2399:b0:128:d577:dc21 with SMTP id a92af1059eb24-1319cc16e0dmr6472194c88.13.1778281926987;
        Fri, 08 May 2026 16:12:06 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1329fc4bf3fsm972554c88.5.2026.05.08.16.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 16:12:06 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 1/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
Date: Fri,  8 May 2026 23:11:47 +0000
Message-Id: <20260508231147.77044-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508231147.77044-1-dennylin0707@gmail.com>
References: <20260508231147.77044-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding documentation for the Analog Devices
AD7816, AD7817 and AD7818 SPI ADC devices.

The AD7816 provides temperature monitoring only, while the
AD7817 and AD7818 provide analog input channels with an
on-chip temperature sensor.

The devices use control GPIOs for RD/WR and CONVST. BUSY is required for
AD7816 and AD7817 variants.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 000000000000..490e5338d7b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/AD7817/AD7818 ADC
+
+maintainers:
+  - Hungyu Lin <dennylin0707@gmail.com>
+
+description: |
+  Binding for Analog Devices AD7816, AD7817 and AD7818 SPI ADCs
+  with on-chip temperature sensor.
+
+  The AD7816 provides temperature monitoring only.
+  The AD7817 provides up to 4 analog input channels.
+  The AD7818 provides a single analog input channel.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7816
+      - adi,ad7817
+      - adi,ad7818
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Optional interrupt line used by the device.
+
+  rdwr-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RD/WR pin used to control read/write cycles.
+
+  convert-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the CONVST pin used to trigger conversions.
+
+  busy-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the BUSY pin indicating conversion status.
+
+required:
+  - compatible
+  - reg
+  - rdwr-gpios
+  - convert-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7816
+              - adi,ad7817
+    then:
+      required:
+        - busy-gpios
+    else:
+      properties:
+        busy-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gpio0: gpio {
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7816";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        rdwr-gpios = <&gpio0 1 0>;
+        convert-gpios = <&gpio0 2 0>;
+        busy-gpios = <&gpio0 3 0>;
+      };
+    };
-- 
2.34.1

