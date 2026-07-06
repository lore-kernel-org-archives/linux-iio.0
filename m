Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2B43E9FB
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377581; cv=none; b=Tnuxr0M/S9wssTn+gxk3cl6qshhGKiqwIQ4Bjn552EIhYF1vvDMMS81+xzvA0lMfriw56rft2awNu0JzrliPQapfZlXBR/X32qxv2CNQAA4JJVNi8JCNdwKHBgi1VcSn+apVEulzdBakSEbEBwcnZ+/W9G6VOO0hxqpTeQZql0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377581; c=relaxed/simple;
	bh=t/lScOB7CpFSN+BBpWau0Y34mVwtawmhNWrHgcJiZHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITMUl27LWPmNEaTKaOP7Ue0bdGkhv0VbWwyqKTRJDF8HlbFTA+faZisi8sWeGDwBpxnYcwjlE81V5lLCo6+8+UD5wbNB3/4w0imJMcoVVOKVTB/xPlJ0AbWYRYINn4MkAfs7oKfB3U4ObiCEBI43BCP9LNFka35Oi67V5fY9LJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axBEjrOA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axBEjrOA"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39af87c4589so32015081fa.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783377578; x=1783982378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWfH/GxGUXWLsJ6S744tEAlMTJ0a2RTRBnRY+9o/Ybw=;
        b=axBEjrOArXL1gQPAvRXL3kEZfzjMKdnPuqwLPwpldKM/HFilwa2bIiSTKaTz/+H2EP
         vdS6Mi6rldCUsxh1GbmcUVvI5dzqM3759M5blz+N0W3EbIj8bjjB9wT/M/RfCTTorjOI
         //FgmdQ8EZWZj2V8zHbVnld/j+1wzqZdWpjk73k2jXfcBY9E9Np+L43w1QPJ54nTEUvz
         zVGBFzDRaE+EnOZnU2KnIp695xhp8I8IHvWRoWvhPBzn7mumEoZG6/bMUF3qyLKBHM6Q
         IKk4tbf8VVulwkJCHqoONJ8I7OOiUS305O3DrQUaacjO+DcOgnfFW6iAAbqPcAc/4FLU
         9yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377578; x=1783982378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWfH/GxGUXWLsJ6S744tEAlMTJ0a2RTRBnRY+9o/Ybw=;
        b=slTARIGSD4mesN/E/HzED5+tzDqlL7YhaMA1RZ3NboLNI55z8q6KNEtJkIaGE1HBiQ
         Fc+2m2j22QFitm3T1KfWtbjFrh7A+5ZEViOvJ+1A7prCpNELlCMwBhkrOetboc01k8Lz
         cNdesMHOxJG44zyPyUvpxwA5CGcG2UBzuJLpHhtMEGjhYNd+tSb/fg7JdtlxLQmAubhZ
         +AOELF7SMzVKBIacOFFflqSxezt48fXba1a/UQXo1ALkaJRx8pZ0SJp2BxgQkzoR8XZa
         itySytWkzgZU1CqY1N/iMx9cR3xi7WeTys10aSLlbe1CcuQHeTycYuI8dl6JsdyBh6ZV
         0ymQ==
X-Gm-Message-State: AOJu0YwsFepzmLcb1TGYZ7d1WdQMUPbTSmMTEyhn7uyN0gJGGAV4hQXc
	e1sUzOgWaTQ9IHrx3wwzOyMGeWmU+FOq0CuEgwRyViqWFO2XWIRPAeVI
X-Gm-Gg: AfdE7ck+vsb+Sv1dr0G+RWQiftZV0avosvOZnkjgQwB6H18DUz1ab7FfaR7GgaiEZv3
	EGNd4ymE7bFfLg2JKn/EvfnQeaJBmW3oCXt+Aa66rho9ac/NPxmq3+Ty8YTSsI3wI8Exfq0sV8+
	Q78kB0zDsJdDSsaQN0MMwcGksI3+YkWrWwdNdvpFAuq19VL+aC+QTYn8d87a1/rC08ht+4p+Rpa
	m0Eqa2NgauC9BdhUWugNaTAaBT6h+0V5k1TwVCzFPm1mdqOg0YmrNCtSb2aIwxi3SVEvwZNSNK2
	KXCitkXsDA2Yx/Btv9Lp6p5NxWnwrW+Tt8nT4gKk8oZ+xALpIua8FqaS+r57+sbIdWOO6/sQOq1
	HELhN0lRfnY0eok0/MLhn9X3IagmvllMldeiVZB/8Fb8D0NNKWnnWFuAfXNQ+Wb2fJ1ICfuzGwL
	MzuXJYRLEXyNqrOrQ8rX0SEJiOPzYu6/O7hrQD9fV1Xsd1cA==
X-Received: by 2002:a2e:a312:0:b0:39b:35bd:e708 with SMTP id 38308e7fff4ca-39c5fd6fd45mr4667841fa.1.1783377577629;
        Mon, 06 Jul 2026 15:39:37 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c6631e1ebsm965691fa.42.2026.07.06.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:39:35 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 v7 1/3] dt-bindings: iio: health: add adi,max86150
Date: Tue,  7 Jul 2026 01:39:28 +0300
Message-ID: <20260706223930.1807714-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260706223930.1807714-1-shofiqtest@gmail.com>
References: <20260706223930.1807714-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding schema for the Analog Devices MAX86150
integrated ECG and PPG biosensor.

The device exposes two PPG channels (Red LED and IR LED) and one ECG
channel over I2C, with a 32-entry hardware FIFO and an active-low
interrupt.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/health/adi,max86150.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
new file mode 100644
index 0000000000000..b0ae7d2ecfcec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/adi,max86150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX86150 ECG and PPG Biosensor
+
+maintainers:
+  - Md Shofiqul Islam <shofiqtest@gmail.com>
+
+description: |
+  The MAX86150 is an integrated biosensor that combines two
+  photoplethysmography (PPG) channels (Red LED and IR LED) and one
+  electrocardiogram (ECG) channel for biopotential recording. Samples
+  are buffered in a 32-entry hardware FIFO with a configurable
+  almost-full interrupt.
+
+  Datasheet:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
+
+properties:
+  compatible:
+    const: adi,max86150
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt line, asserted when the FIFO almost-full threshold is
+      reached.
+
+  vdd-supply:
+    description: VDD power supply (1.8 V).
+
+  vled-supply:
+    description: VLED LED anode supply (3.3 V to 5 V).
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vled-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        heart-rate@5e {
+            compatible = "adi,max86150";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&vdd_1v8>;
+            vled-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.51.1

