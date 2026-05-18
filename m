Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628339D6D4
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141775; cv=none; b=Mhum2KEjXQg760YYzyOd903M2hkAoV3EfzgZAid6rkTNSCPYpsaQc32JgfkFAnLzmE2Z79N7l6ixgLSv72Tu6fdGIV05nrg/r/jtuIGZ9QCDmSS5SLvWCMVgVdjdpNv0CVTpCyJuq5GpB87pnIhc9k5UzjMqIniNzDo9qpwGcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141775; c=relaxed/simple;
	bh=58hXK3+jjxdURzdM62kYNdhGnylmydkjDZ6DhB7yRAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceXodY5Kp3Sg+6yip6UqYoGfTk008AKzDGDkNyRI7RmdODc4kJ1D7b8h5EhqmAmEZlG18f1BCW+JmB1x5Jq6BJFnFurryu2W1ogXFhP6huS6E8bsiwEwKMq2fgM7cIbomc0CgaWH239FgR7A4zNrCWJYfjeU80b0kvBkTweyBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxX/gfG0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxX/gfG0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso1329293b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141774; x=1779746574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ3L7gIVtDuWxh9a4b/o7Up/IHdND0VWYFyTOBzXy1Q=;
        b=sxX/gfG0UoxLsEk/xjAuUpaTiWBqzm/ajeS08EpqCK1mXtqtV45s2C8xd92M7TlEij
         HMErpGKYd5+YGfGCLU0fdbAJzCil9heEPubQqASmpZ18srp1H2HBJlMqbdAN+sa23eUX
         gZ8JG+hV5ve0nz63Mu3+lzYtorDd4rt2pDLe5WqyrQKEqgV7FIWkXzi1mviXgn+yxBRD
         0nWTitswxb1/RDPycnsOevI4UBMlY9F15VW7pypya68OeglDcTl2DV0idxymhmnzYWgM
         MnDDS/fzPd+FGevLXGBs9waUP9VAPSPHfPIBMSNolGY39CHcSniijOdgVPctm9oeeWTf
         YIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141774; x=1779746574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZ3L7gIVtDuWxh9a4b/o7Up/IHdND0VWYFyTOBzXy1Q=;
        b=Khg5jUcRXSFQ33FEVspU+543FdIzBGcb5cdzPzIlrO1zdpvqHWLj+9ZcT1a+nCjccD
         Qceb6EEuE6DF7JdfaEBYT6TYSu2WoUyseZV8Nw5X/HupztbU6x8BPxR2LmTLIKTKTVtp
         NYknqyFpNKlGGO/OtfkreTHvg+26kBWpJ8hzv6wYlEEqJ4mWKYUO9m5fdmdFJmDdIE3o
         WuY+uJpwD7rh8U8lmNgg5aQ78nst48s1HzfUfdrp+KrddL8vOGhGVS7/iV75KRrfYkTS
         pE4qUDEfb6lO86uTEbNJbKzZrrUMC/4XKvVZSZc1qIhNVr2xJZZIPOuxoR2ST8xCjqLA
         eBjw==
X-Gm-Message-State: AOJu0Yy38+ih2SVzJBv/5Rq4zQ+ujkiV/U+snce/9IlZfFBoZkuqHQq+
	l71Xsb6vZQRhJvNo1+dGM0BVrTs3DhmfQ4CfrrKBh0IuJdxNOUU803TNAc530Q==
X-Gm-Gg: Acq92OFnnFVVvCixFQkEnIjASO9epT5iwPnkpGF2sA3Lj7cNlRBIxQYKefGhzXwQh3Z
	eommeFDZe4r02Iezsrc4vDXgpCqAI0J7hG58YNL/dWGZQk/9D6scfYk71yF5pvhcshSEyLQu6Hy
	c/YxIkyaNBHH75cC1451VHW4JVhFDRHYoR4mCI+c1ybotWmI2zJMVs4v1bSY7393b60Llv1IH0S
	knOoHv1+oD4jhJ+OWYjTzTSZpE4XQXW6vVY+iCCz1M9vobZztnRxSCSN185ZP19Ra/qBJIxp+6f
	6eUDDPypgqCrJCnKh8pMMxGE09HS0I3f6qCrg643one7bRiuPi2fIquPTn7oWJQhBvBqqBiCLe8
	us7JtkzJUz+Rhl/pMz3GLppBq27V4EeWCbzYQPX9MmIXD2Fa8eiN1jnmq+Mbj92UbEBN92NQzpo
	NI1v7F/Qm5+xCpydFFStAJ25DrT5AlriPnf9sSZ8U4f7src3LoWUfb3ecDCa4sA3bPLz3CUnsah
	LcIBO53SnMrg5ocLORf4bexYxHpPRtXPmGivL0LEwB1AC4YjfyuXLv+imXu
X-Received: by 2002:a05:6a00:14c4:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-83f33c9570fmr13371904b3a.21.1779141773709;
        Mon, 18 May 2026 15:02:53 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:02:53 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Tue, 19 May 2026 03:32:20 +0530
Message-ID: <20260518220228.63322-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
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

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes from v8:
  - Dropped the trailing sentence "Keep the existing HX711-only binding
    extensions in earlier patches so this change is limited to the new
    variant." from the commit message.  The earlier patches in this
    series extend the shared top-level binding (VSUP, RATE GPIO, etc.)
    which are valid for both chips; there are no HX711-only binding
    extensions kept separate from this patch.

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

