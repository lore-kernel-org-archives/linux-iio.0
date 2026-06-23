Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7C395DA9
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245493; cv=none; b=OVHQpWntYhfBhtZxeLXyqSxgJvg1pwjRAv1Ejhk1ViK7CvEYd2YB3dNJD/y1CTF7VM6vxFQPKjt9m2955A+8RDB/pKww3pI1ZSNeWvfZcyJMSh4js3SmbQXiETSQ/WA0jvNdwAHjNhv7zitiVxhnjdOA6JckEqXYNvpJYkFy5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245493; c=relaxed/simple;
	bh=9ZJTV3Tr7gPHN2x9nrz/v/mE3v7g4ksoIWC4RjqyP0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbjGg6V6/ozFvkE6EHItW8UEw5esAQ4HxK/jpdVe5y+PA0dMaqHjqBaORU1MHgZbcL03Ng828eAZU9BgyWbxv85RcPe9T+/6Dgf7mkRXVehgza3RmW3xOvOG8F5Mnwfp+LjXa/HPY3eMILSVC1Eqtzl8Ko0jH/LMK3bb8foJowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpRwqLj9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpRwqLj9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so233098e87.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782245490; x=1782850290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rc26whbZ5CV6ed5f60gmU1ifWX890ncOq/U9UyLKHc=;
        b=mpRwqLj9ccn7VtPX/NNZB3Ym19kXT0NVvCRxKgzDNxRBnrbcbfI76Yf8WBHEW5k5gK
         7rGLH9PhviQPyyJfl5360JIu+frqybVcmQ9iqiGCoJUYfuZQ0d3nkXnq937oatmqEkgZ
         m/uM+lrvtSWiak8SgPuycgD9M5cer73jo2wDyZGsOvJ434QG5YpYAmUbVnutLIiZsncq
         waK3f89DnjTfMK1apfSXH18gQPUQzbCf5pIEstfWsiDfuHAWtSbUl/2ZpHsxZAY9IeDh
         m/hmhjkKUkYJjmaDbgcECvMPLnSRZuypUSEcOFEdPxYIGpC8S14KmbGx3z2eZ7fO18sY
         WfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245490; x=1782850290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rc26whbZ5CV6ed5f60gmU1ifWX890ncOq/U9UyLKHc=;
        b=faSBR1x/SYXTAFtzYgPffi8MAyZF1g10TSeMi5wyqrHnU6Qr87oM0zX4w0DmSXb4BS
         ideCJuYWw+Kwc8zqCN2MSDQIhBniF/8A3li9X8ws4WfxX9kFW82mGT63zVaVyO1kfOmN
         P/5+C6QKMr96/8hGYCtFzResawINZvVkjDYXoo6JV2s+aiRegqgxCyACG2LsOGWsVpaA
         74xL77FernQymZH5FblSDY6ReWTnjMPDIA1cVo4QcQRuz7ZbtUfQvkzaXGZYB3/eV6L2
         +5mp5VHEQANlAy8RYjGo4gEzibN4QVgWhujXepFq0RJPcZG6c8ebWGnaqpsBu9TmBeta
         bJ7w==
X-Gm-Message-State: AOJu0YzeadlBqbpfSLTeGxtKFJSgct0b+0b2iuVpvRCo1aV9F+cRA5kr
	2/UzudRpVv7FO4+H+0uWJs3wDf6aHWJpi98NIZB6YNeN5MRfofWtOHrej6XH8qgicsayxg==
X-Gm-Gg: AfdE7cmW4qV6WhPwUEwN23xq5ZY65jGe8IIkeD6gsm0POVxqqrK+EReNXR0vVrDRusq
	utyx8rW3A/A/XAVGJq6RyRTb3fjcQveQUOJdWiv07CRIX8gWeiP1KQ2VS65AfVPWiaR4BD/wrik
	0EK6uX3iusXRok26kphB/M2l2H95CBPpK+GrD8hBxqw0+hULcpI2HbpZcxyVGRgQ2cpJgNLnzBB
	LNiSpmfHv+1FDU/7xt9abiNnoCz+WDcMDfAqxDfnC/C0hgYM4JS+RVHtUgD2u80aKCDhiUBxpLq
	XhVvlJktqnIRaHckhu7InU2XneXLKRnFqtY3BIMkSIR/QbbpKohLr9P8+V/7F96FWSXakJHA4Bp
	ICFZ9mVkKspFBluDAFZ4iZa3ui4ofJ6t8JiRJXR6Xj0Bk7vr09btGtFjw50d+3PMxeQj2YiVjjC
	7ElcWzmG/U8UlKr7ZBSnNIVAKBHuPdCra93ZKQ7Ea2/TOK8g==
X-Received: by 2002:a05:6512:3513:b0:5ad:4ced:9c9f with SMTP id 2adb3069b0e04-5ae9d5ad154mr8361e87.39.1782245489596;
        Tue, 23 Jun 2026 13:11:29 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551082sm1063392e87.26.2026.06.23.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:11:29 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	conor@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: iio: health: add adi,max86150
Date: Tue, 23 Jun 2026 23:11:21 +0300
Message-ID: <20260623201124.18271-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623201124.18271-1-shofiqtest@gmail.com>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
 <20260623201124.18271-1-shofiqtest@gmail.com>
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
 .../bindings/iio/health/adi,max86150.yaml     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
new file mode 100644
index 000000000000..c191f4f1525b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
@@ -0,0 +1,78 @@
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
+  The MAX86150 is an integrated biosensor SoC that combines:
+    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
+      for heart rate and blood-oxygen saturation (SpO2) measurement.
+    - One ECG (electrocardiogram) channel for biopotential recording.
+
+  The device communicates over I2C at up to 400 kHz and raises an
+  active-low interrupt when the 32-entry hardware FIFO reaches its
+  configurable almost-full threshold.
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
+    description: |
+      Active-low interrupt line.  Asserted when the FIFO almost-full
+      threshold is reached or when a new PPG sample is ready.
+
+  vdd-supply:
+    description: Digital core power supply (1.8 V).
+
+  avdd-supply:
+    description: Analog core power supply (1.8 V).
+
+  vref-supply:
+    description: ECG reference voltage supply.
+
+  leds-supply:
+    description: LED anode supply, typically 3.3 V.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - avdd-supply
+  - vref-supply
+  - leds-supply
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
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_1v8>;
+            avdd-supply = <&vdd_1v8>;
+            vref-supply = <&vdd_1v8>;
+            leds-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.51.1

