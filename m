Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722353A16A8
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137431; cv=none; b=GqJu3ZqgObZW/cMTHO/fNO0JYWR+wnOIFLrC0TClY03YccgJHNic9Hv1nKbBpAO/N0RjXrFPIVxM+UTIXWBDw+PyNVgz8k9IdLSKUjqG1m1touEXipqpmG/kMRbf8FViUD4iWCWjEY1PZGIiiQXEp9A7jRmkJIEFsZmJDA8l7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137431; c=relaxed/simple;
	bh=q6AP/YsSB67RKFNzB+JOGdIx8KZjL239X/sjIyTEFz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0dCLZYa2sUxwJEVksrdIIpHLBVSV5C18EvUaW6ey+3xXYmm7hMqIMcLI4vSUF6FBgjZT1qj7CUwuqlWFeWX85veSCTlAZ7/TxcDHwFZu0JjlPprHbMnrF6kmBnOYDWBWFXo2xrTDsrxG9XLRe364+IOMTJbunRVmScJ8C/9Duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBRnBaiN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBRnBaiN"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa61284d58so64897e87.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780137424; x=1780742224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXi4/WHWZV2Am5IoWUT5fE2KIh0QxaqAle3LaIVXAnY=;
        b=XBRnBaiNSq00EZZDAhmMcJXn4/H68bcY059lRezWu7Rqpfz31BigecBmg6my6yti+/
         Y0NfMFGGpbc9I4/PYo2vykUYpKYKPg14pV+/MFqyti8qHeXnXI4jGwx6yAXK2AdC8RRt
         MvkSw6EttKaygHVdLj01tKnifLbGPlnJ+RVSuV/NRkBEyqOt3laMVrVFagEpngXUWvPb
         jTYLQy/lteRW0bKbRnaSmtIilyxw7LXCzIrryFfpLv4ke05i/mLsu4qb09cfM2G8QHQD
         vzcF9Ak33+3sqIohRPZgNxws6tRq2kvAYdEoGH9NOUFar+dW1fbUzFfArCQSlovvWe2K
         CQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780137424; x=1780742224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXi4/WHWZV2Am5IoWUT5fE2KIh0QxaqAle3LaIVXAnY=;
        b=OOw7d6pEvavbIFhKtTgFy0+dbHilIt5NAaDpF6+BdOlqeEnvClbs3fb9tAy36OreSS
         89fUWy6gCYbsticHPrIAAEcns3r8WX6ZG+ZCpGohcbyyA0btj7k6gmczlro124+YLtij
         bVLBtLNkVLB0130Mi06ibpG04DipFR8adMG8/3tf/rX/VtNjtOmg/YpWz2OeBMZ7gMyS
         iAjJaejOS3Hhf4J5sCECnW0NxhPXfBswhrOI4q+4Dna7o2FjCGuGu13CahkPw6JGkN8v
         EYjq9gkyWkCgjj+1iFBrWiz/Wz8bWkAQthFocz9WzPlkgf8/2T2bXdyMSPaHfJNcAU3R
         JfLw==
X-Gm-Message-State: AOJu0YzoadWx8oZKuzTrOW3/0whSY2eJChW0v48OhDg+gcu1RYpOiL6X
	WtGVD5Ux8CzdWYQ3QzsdnuVczLPAhqNXoetul/Z4vo9FPxDPzMkxLKKi
X-Gm-Gg: Acq92OEwkvQbAmHznr4X4RscbHInjdjQojNStsHh9bpwQv6kE0+oq5Ip9Tqqiu4T0kw
	8L/f/BNzB0SYP69ShfX4+K7Adm4Q+htfAFHIBuuO+gdOo06tgkoAsTjmTnWKIn3NUuoRr6cRu+x
	qsoVF8aiGMDmHFRCCtObya9zpSp4AmIhBjAsfJR9Vcvc/ugAm/3CljDYJLQqa7FoPA8ruMFf2Rl
	atwLanjCcRbAFQm8QOm0PCc3qn/iTPoCN2nY5xYtdsXvjJehnGFdrYX+KDuIDYrvLuFTS50xYHH
	t9C1YXgRbzBRN6h7jAXnGUv93idkcg3LtzoMovKrhIQuf7blf/FQdcaFd3si7bCVNroT+yuuZsI
	tiwIx8iGXNT3EE3nopaWB3B+Zo6KXdn2Q650r10aP03da/J3ho7qdAcPiKdIq9gHz5GdbVgz/Yx
	nGygbF2wwqelz0oKHsi6CXAIIGbmGUM9vVYBJZtAGaqmb32A==
X-Received: by 2002:a05:6512:33ce:b0:5aa:635f:7c08 with SMTP id 2adb3069b0e04-5aa635f7d4cmr211707e87.7.1780137424193;
        Sat, 30 May 2026 03:37:04 -0700 (PDT)
Received: from localhost ([5.123.41.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b787b7bsm909472e87.57.2026.05.30.03.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:37:03 -0700 (PDT)
From: Taha Narimani <tahanarimani3443@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taha Narimani <tahanarimani3443@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt-bindings: iio: adc: Add schema for AD7816/7/8 digital temperature sensor
Date: Sat, 30 May 2026 13:31:24 +0000
Message-ID: <20260530133126.54460-1-tahanarimani3443@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Analog Devices AD7816, AD7817, and AD7818 digital
temperature sensor and ADC bindings in YAML format.

This resolves the checkpatch.pl warnings regarding undocumented DT
compatible strings for 'adi,ad7816', 'adi,ad7817', and 'adi,ad7818'.

Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 0000000..7f6a3e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/7/8 digital temperature sensor and ADC
+
+maintainers:
+  - Taha Narimani <tahanarimani3443@gmail.com>
+
+description: |
+  Analog Devices AD7816, AD7817, and AD7818 10-Bit temperature sensor and ADC.
+  The device communicates via an SPI interface.
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
+  spi-max-frequency: true
+
+  rdwr-gpios:
+    maxItems: 1
+    description: GPIO connected to the RD/WR pin.
+
+  convert-gpios:
+    maxItems: 1
+    description: GPIO connected to the CONVST (Convert Start) pin.
+
+  busy-gpios:
+    maxItems: 1
+    description: GPIO connected to the BUSY pin. Only applicable for AD7816 and AD7817.
+
+  interrupts:
+    maxItems: 1
+    description: OTI (Over Temperature Indicator) interrupt.
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
+            compatible = "adi,ad7816";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            rdwr-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+            convert-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+            busy-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+            interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-parent = <&gpio>;
+        };
+    };
-- 
2.53.0

