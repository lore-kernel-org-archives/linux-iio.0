Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954832D0D8
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442677; cv=none; b=fD/eQU3SMLoLV0aZQxBuRfYn+3LSB3W4wDeTdlD49Lj++DIEMRwdpixqWF+feIM2sKpS/JE44D7/2CqS+zQmPP1V73lvXJvaB9EKVzb2RjGNR/q1bZfKC3Q1Jh/wu+C7ZjPwAOlKBJ4kwnjJL6lUn9s5Q5hSk5Rdtpd4McRO5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442677; c=relaxed/simple;
	bh=GhI/YB24tQ0bd38mulPo1xH7tdW0RPfUcJg1RDC3ubM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1h8dFh/is9pP6uol1kcg9k2zD1NZJQgxiG3rRoysy9nD2lmBaOyVVxl2Y5yAIzg+36SABUun0kWRLzoGpCMoIxVBLJKDaJrMWF+JQIFh4stQC1AVCkPlJv2Srzi9Tfr/wLjq8ueen8K7ulD8Wy7OMCB//vDylHq1mrZ0qMMzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T03ouMpL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T03ouMpL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso2249976a91.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442675; x=1779047475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwuLsZ0O8eS47ZyHe5+r4pXTo9v5POUb/qJgxIJDhZc=;
        b=T03ouMpLE/AmQxMZDKyuRwzpwk+YIOQ34zTcAEEQRVyHsHwfneg2gXIE/u/1WMX5BB
         Z2OtBnq8v7X8PlITOUg367AVhKqfCsC5KOf5HOCjayKgrw9loqbB+PW1sfo8fqKOK1Q4
         S/9tsgbDUHWv0NZk1r//xIYVmui40u4fE27gGJYSFaLW8dZH4ImRZbfQANqFtn6cq08r
         69ZPGQuGtHIaIDZtvAI2KI5TfhjopCM+xaPDGz4V+3mWqg4d8Rfh0lzLOQvEF/Vlt3Bx
         tUPvgQKZP61mw17oU7ejJlS6/jhXtjskkkuBbFldlOhvMbAVtk+dj+otyf59nljvfTJf
         OeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442675; x=1779047475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwuLsZ0O8eS47ZyHe5+r4pXTo9v5POUb/qJgxIJDhZc=;
        b=lbR07hoevoQEnoGQmYgK8206Yx2i+tHiC7ccUvcjWIqj3yDBJW9gil/8J0kjoJKnlj
         mEBvEj1vf2hX2brvVOawU7OQWIOGprs5lBG2C89rehKdNRM6UJNjr4Fs+jAmInMiZrpz
         icx9Y3chR2BJjlK4XN+t5vjPlNeENqIv5Inj7X1qHVs9LmFVdaPuHBhBmgwIB/SYPeg5
         Cs87poS6ZuZwEHbG3JwEPDHWg447ONCFq+wRpxkiFvSO00J5lC42n9uzwBlHSfgAV4k1
         JlwmzUiRm5Q/vT+hbBoYCj8MTx4mR0Mi0uTmCT/4yfeHBRVqYrVSKO1qi6toovWDhUBB
         i1uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jhF6C0s+knDpaXlSM8awZ3Bn7fhgZn9wAOMi3/KVZTlAj09B+rHy/S00yVzTpO+aRJw4VmpkOEF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyarX3asEcmARYO+q5SR8scAM3VR6n+ByPUlyRx+Mkj5WBlNOez
	/eyW7JB7oGor0GK0l79oShkX1eGK0Q59OMe+SdOXy4gjz0OrNNapmgsm
X-Gm-Gg: Acq92OHU62Ebc59h0aKOpjFwMPBXzZnv9jYEVTA51XwpXTU/I9eHcsl9Jr/6D8LA/QZ
	321QdC+J9UGrkKzoDbcC+EzdmEv5AaMj9ozn95wNSmK+rvnwNyhIePNHyOiKWsfLr5zrpYWTLaN
	w8pfJGhp0VXSltTvFol3KMO7mZfb8yIqA0+iU+XwrbaVDvEazUyI976ee30XirmkfvDf8Fd0FZl
	H+JkXx2mIiiv2YrP6OUAsnN7Ms+OVBOIt60Fa+LxaulVa8VCQpUZvtOB6C4QAD0Y4EzONJkI9jt
	eK1cIIwFQZqT9CBEHfbQ7/RoPganNNFMK3pfM/sEu31+YLhy2a91x8t9qZnATGAEVORt29+fALT
	wLaBlQRzzIvd4VKMd/lbTsd/Mdyj4UgZaOyplzGOnoq8hT/4QhSmTXb7Al79iGbuv/JFr/Mqpq7
	LD1eOQIFh4tavulBTy5hRy5CBX6MaO3DItsHRXiOEiHPAktcE+DHzR4XakOWjBpIT4LToRSLAny
	vScjkbdg22R7lOFT6fDKDr9v19eSp6EMqUDkvIZDFFgTAoHvjxOkJpq19rW
X-Received: by 2002:a17:903:4b0d:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2ba79ad0cd6mr231459655ad.30.1778442675319;
        Sun, 10 May 2026 12:51:15 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:51:14 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Mon, 11 May 2026 01:19:26 +0530
Message-ID: <20260510194947.31997-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510194947.31997-1-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the avia,hx710b compatible and document the HX710B-specific
DVDD and VREF supplies.

Add constraints that forbid HX711-only properties on HX710B nodes and
require vref-supply for HX710B, then add a separate HX710B example.

Keep the existing HX711-only binding extensions in earlier patches so
this change is limited to the new variant.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 .../bindings/iio/adc/avia-hx711.yaml          | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9134bbe41379..b2b5c7bdf05e 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AVIA HX711 ADC chip for weight cells
+title: AVIA HX711 and HX710B ADCs
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -14,9 +14,14 @@ description: |
   differential input channels. Channel A supports gain 64 and 128;
   channel B supports gain 32.
 
+  The HX710B is a 24-bit ADC with fixed gain of 128. One input measures
+  the differential voltage between the two input pins; a second measures
+  the DVDD-AVDD supply voltage difference for battery level detection.
+
 properties:
   compatible:
     enum:
+      - avia,hx710b
       - avia,hx711
 
   sck-gpios:
@@ -44,6 +49,17 @@ properties:
       RATE pin state is determined by the board wiring.
     maxItems: 1
 
+  dvdd-supply:
+    description:
+      Digital supply voltage (DVDD). For the HX710B, DVDD must be
+      greater than or equal to AVDD. When DVDD is a battery rail and
+      AVDD is a regulated supply, one channel monitors the DVDD-AVDD
+      difference for battery level detection.
+
+  vref-supply:
+    description:
+      Reference voltage input (VREF).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -53,6 +69,21 @@ properties:
     maximum: 2500000
     default: 400000
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: avia,hx710b
+    then:
+      properties:
+        vsup-supply: false
+        rate-gpios: false
+      required:
+        - vref-supply
+    else:
+      properties:
+        vref-supply: false
+
 required:
   - compatible
   - sck-gpios
@@ -72,3 +103,12 @@ examples:
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    weight {
+        compatible = "avia,hx710b";
+        sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+        dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        avdd-supply = <&avdd>;
+        vref-supply = <&vref>;
+    };
-- 
2.43.0

