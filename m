Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A628375F81
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117650; cv=none; b=kS0lTnV2NxdS2t83lTaCwO3e1Ma1i34wvZmtsiRhXj2J5lN6tlNcfJK4aby8N6kc9MDZ+/g8XJvPUeEDkX92zCcvKeQehUm+OIHQNrT6n1UUXi4cHmbZKjBtMthpZUUI8SbbusP3Uk36X2oJ2h/sNRbjrWAeLr3UFrkeWFwtKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117650; c=relaxed/simple;
	bh=l0Sk2ShyS10/CMZ6Y9UFyNVPGKv48bgWgstDnMtnGiA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHWRJUIDOoMPi3+xxfypwfwrbWo6697jm+0cs2sJCYDDSgTXI1YHuL8+Wl5siiyzzstPS+hLY1msAspMtt/UOk4rWEgqjGYOnD+V8sr7D0PNRBdU1JIwuEnDzJhW6xNSrj2pDFj6XYSAIOiTQ6+Sv4duWqJbAkYAz4/kyZ5NzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdVX52Vv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdVX52Vv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-912575fa768so463555685a.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117647; x=1779722447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUhUIAdzDSOyS8J9byt38ZO1lGApTw9uIarN9cEc3TI=;
        b=RdVX52VvSWGbgWUvgYLwpTqPbpuAlk+m+8J8935aHP1qHftR4TK/HK4+Fvf+/DBo+t
         sGKPu35scVqQn1grUcLeDUItLwwHgZL7HOHD0KuHozWW0gzAyOgjaXR/ptcYBfya3C0I
         xC131QhHW+An/QJoEPaTJ4NQzsmIf8CJZlydf2gX7RpXFVTqQX1cMJQoKZJkO+F7HDDC
         Csx2XB7xaYKYT02Q4PTUiuM0VwEDA2Dbe0YbR2R3dAR4TJ8t+JMBz2c19JhogvLYBib8
         IiRzeWA9XnyvBPBFJ/QF4HqxNn9wxUH2fXmmiHDNj8cwW0tFTGFihSsmpozZ+/YCgva/
         KeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117647; x=1779722447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUhUIAdzDSOyS8J9byt38ZO1lGApTw9uIarN9cEc3TI=;
        b=Q4cWkAo3HL/g3l4x2PxosqM63nGsF8RcVpXAyOoA5MuYtOwvYh3NLPX2rRzOa92/Ti
         GYKh59gP0bFmUfNLRSagzyNPW1NTn5dw5yXU8jdjRa39U14bch5P8zpsSyTBALiK6JCS
         k06UGZjYD6DFSyDIOt1LX/4m+dKJEX1rultrOlz59GsklkC/952mRAzJ0avcGYdHu0sK
         e/P5MKe/M+PCoWw2/G+FrgWV7/wWOAV5kJzFTZZ8T0JjlMwFhrj7BcDmqcqvdx5yRFwv
         84d0jubUlmfZZY3SFMvRpkEbFqhGLSvaihVdeIIafdljDCjzzDr+e4xL5SNg84ua9/Fz
         JVTQ==
X-Gm-Message-State: AOJu0YwdqA7FtvmS1dAY9xO/uDbWaM/zGssvECdb31WG0gIlULpIfjjP
	00c1FLU4vHMJiUiev5f7kGW8gIO4Qs4wf8ed6AJfTTKb+Y9YySU2iYa5sFn1rVuJjCg=
X-Gm-Gg: Acq92OG7UPNsKJ1jPnewxDjH7gloXtNKS1WadZ147eYclRwl3J+vdmQgyeYLqGkFclC
	8j/vmSMcEltJSs6MJDadoAW2k5sViffBs6M6dGoEzbP4wW4B1ZHPuFQS1lCxmzfKF3CjkhyqjEL
	3g8e6VCHcrAKg34/A84fwabiYvacYu7PI0ns12EDfJRpL0rKTp+u//sjkYkOq4X0g45kJ2705Kh
	Rc85MoHVJM1bn5NqyrWuQ94TyFdFTw1oXUnWmkUUGDEeQSzYTpu/EILuDBwGbQPtMgBnukiz8D8
	+mEBdPXuUBkVxYM7xfmdbFhO1zCVW2mkprg2I9EoXw+zl7ksdda3Y08bJrnn7vUYo/8/br19U8p
	QKoI/Ubrh+56F3PxNi40fFkn4HvaAcb7JUUF9xII2dl/7SeWRAgpnTqVCMtOpzI816JfphBMl7V
	zgv4kDnBkDNg1vBf+CyM/JAQwV6N+xQxVk
X-Received: by 2002:a05:620a:2943:b0:8cd:8fc7:831f with SMTP id af79cd13be357-911ce71af7amr2494410585a.56.1779117647010;
        Mon, 18 May 2026 08:20:47 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc8408f1sm1524241185a.24.2026.05.18.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:20:46 -0700 (PDT)
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Google-Original-From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Mon, 18 May 2026 12:21:01 -0300
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: [PATCH v1 1/4] dt-bindings: iio: adc: Add ltc2378
Message-ID: <cf404216011b6972519436c63fcc7c4e2c883c54.1779117444.git.marcelo.schmitt1@gmail.com>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779117444.git.marcelo.schmitt1@gmail.com>

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Document how to describe LTC2378-20 and similar ADCs in device tree.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ltc2378.yaml         | 131 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
new file mode 100644
index 000000000000..56e59bcd7306
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2378 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices LTC2378 series of ADCs.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - adi,ltc2338-18
+          - adi,ltc2369-18
+          - adi,ltc2370-16
+          - adi,ltc2379-18
+          - adi,ltc2380-16
+      - items:
+          - enum:
+              - adi,ltc2364-18
+              - adi,ltc2364-16 # fallback compatible
+      - items:
+          - enum:
+              - adi,ltc2367-18
+              - adi,ltc2367-16 # fallback compatible
+      - items:
+          - enum:
+              - adi,ltc2368-18
+              - adi,ltc2368-16 # fallback compatible
+      - items:
+          - enum:
+              - adi,ltc2376-18
+              - adi,ltc2376-20
+              - adi,ltc2376-16 # fallback compatible
+      - items:
+          - enum:
+              - adi,ltc2377-18
+              - adi,ltc2377-20
+              - adi,ltc2377-16 # fallback compatible
+      - items:
+          - enum:
+              - adi,ltc2378-18
+              - adi,ltc2378-20
+              - adi,ltc2378-16 # fallback compatible
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 100000000
+
+  vdd-supply:
+    description: A 2.5V supply that powers the chip (VDD).
+
+  ovdd-supply:
+    description:
+      A 1.71V to 5.25V supply that sets the logic level for digital interface.
+
+  ref-supply:
+    description:
+      A 2.5V to 5.1V supply for the reference input (REF).
+
+  cnv-gpios:
+    description:
+      When provided, this property indicates the GPIO that is connected to the
+      CNV pin.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt for signaling the completion of conversion results. The active
+      low signal provided on the BUSY pin asserts when ADC conversions finish.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - ovdd-supply
+  - ref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ltc2378-20";
+            reg = <0>;
+            spi-max-frequency = <71000000>;
+            vdd-supply = <&supply_2_5V>;
+            ovdd-supply = <&supply_3_3V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0de74503df08..768f56eea476 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15195,6 +15195,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2378 IIO ADC DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
+
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Kim Seer Paller <kimseer.paller@analog.com>
-- 
2.53.0

