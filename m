Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24265414A03
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336982; cv=none; b=CGnsk2I9WAlCUdSDEKniYsr/PISudtalpA/D5O1DupSuDnenQ5LDVI0wgrWfX+G7qHSoCdksvnIhxPavAfzv3F6vd90V4cGWuMbCWHrvrKRlnT1rirCe7Ll1E44A1W03PR+CGbMQVIoxryC6NBTmd4wGCLwmloTZPskLLfjHdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336982; c=relaxed/simple;
	bh=QDRVjB4HZ70FEs/QMPBY9c0fBa2UP+YqZYCpZasSGL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiFSYe5A6nJyl+k6zfe6Y1lUkRpiokdeM2w6pnB6oZbaRJfWdEjmm3IS5nF9jzFhi7+7p68X7VZibnqEG3WUmhbaDEvdxRD3sP2ANVmzEFkyakG24eQaBU41VIXhyIwZuPVF7d20gSM9hKH6vBeICF8uN2WgOxTVB1sytuUyhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7zaHziD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7zaHziD"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso2730429e87.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783336977; x=1783941777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed9ukgB6xPMCIt8931WcmNMakWcSxdHQ3v+EgGRXQK0=;
        b=V7zaHziDjuma/lpYVF0UA1gWok9xUiKIHpOg7nJ7/8VmMAucaHD1TdqojJHhXxgzXq
         pzrDxM1YKrDB5Y18PadmhEx0+xQK/muWxspHzPatL5sOg88Qp0PM1TxpjZJA6atqXwAQ
         /rx6xYZEav+EtUFRCG8iyvyGNGyAM+ONKWP+AKDUK1Ap8P3VHU5Nn1uY6iVthc1FNuOe
         CAQKEvdKMSxa7hUDJHEa5RRks+hJP5upq50SDafYlXAnT+90nEEJ68lssVRB4qyAgCPM
         TbBDVIbOzWUNH7kWa/TZq9rEBB29DWXoQsVs+fucq4pc+sxLuHASZpmtTpaRioFyazTI
         R7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336977; x=1783941777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ed9ukgB6xPMCIt8931WcmNMakWcSxdHQ3v+EgGRXQK0=;
        b=lEh417GDwsIz/orcVRGhLqHSnx36KBLa5hwFjsspHXWj+XkUL+fFo7EFEgXuR55xVO
         DuuxR5QIAKNgpRyEqe+WAyaii+6bpLsSKJHjCaGrqAen4jxWuTkWDhnkGH+YvDSxjm6+
         AZR6Z4jgUkzDJFLF1WliFBt4nrlcYtLTtbvjv6YSqPBJJkdE6GNtHt3evUgNeGSaKfqs
         ny4dyvfydmIV1JLGCYw7LXlIEbFBIhNh3yxzDl9BZalD6MuIZflvSwFleCY6fjL34/aQ
         KRCm5mxG7R5nhiOhhf3k5lcBLNFpFcZRKChUVab9eAviyHAIVa69KrbWeorLzNyruhiu
         pl6Q==
X-Gm-Message-State: AOJu0YyYe8hrgcClX/Nw3Y2fSeWNSaOaxeyIMdWgb2N2sbiq8XSvGgne
	cGFWbzr3Gbq6kKIQXm/IK718K12PBcgu3+8D+LxBU8QUGNlJyFErJJziyDWQDAn38+GU+w==
X-Gm-Gg: AfdE7ck9AU6dnXAX+6OZH2k54mUAP9zPIsi2ZRGhaaH/dt8af3ahm35vm7v8sI2qlqd
	ZcsUWoyws3p5YDgK/IWydOTQHR//AgCto13DpNyV/reuAc9SZwmKqugbR26mxHwmRHOS2iz99y6
	j5pCOpThrGcsB87RW4NCBwEQ/4Mq0dx0Mc2mL4UF089ifeRFAYuX66VHuk1DTXYX+DD25rqHFOR
	Mdc8bnDmt1Kby3eSYj831dpM5HlWE033yp4T9Z+3nJE0gJHbhuUHHFdGwqZRml6LtpnDMu/3qLO
	/4WwGLNwf8LTeNJaUNlYUcP1wFLM2BcTPvHCmviPV+XEGjO/kVQWC1V8EHkWKibn1bWoJKCeLDN
	Fai3ZDn2tzf4ySQpSLUey9CTELLv0w/a9PohTe8p/9fJmjqgYOkJXHk5Gfr6LRnJwHkqG6SOxOE
	IKcQSll+mYGLTJ6HOTOMYZ5WmBdiudv6kZM+amWptEHoTvKQ==
X-Received: by 2002:a05:6512:3f1a:b0:5ae:b2cf:8204 with SMTP id 2adb3069b0e04-5aed508fa09mr1703531e87.2.1783336976545;
        Mon, 06 Jul 2026 04:22:56 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a22sm2739145e87.72.2026.07.06.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:22:56 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v6 1/3] dt-bindings: iio: health: add adi,max86150
Date: Mon,  6 Jul 2026 14:22:52 +0300
Message-ID: <20260706112254.1262002-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260706112254.1262002-1-shofiqtest@gmail.com>
References: <20260623140730.12574-1-shofiqtest@gmail.com>
 <20260706112254.1262002-1-shofiqtest@gmail.com>
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
 .../bindings/iio/health/adi,max86150.yaml     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
new file mode 100644
index 0000000000000..daa15b0e287f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
@@ -0,0 +1,70 @@
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
+  vref-supply:
+    description: ECG reference voltage supply.
+
+  vled-supply:
+    description: VLED LED anode supply.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vref-supply
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
+            vref-supply = <&vdd_1v8>;
+            vled-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.51.1

