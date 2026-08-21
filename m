Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD5476CDC
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307924; cv=none; b=fRhna/XHmnYFqf1jCMW99jhl/hY3HQtcZ0QG3bo1ma3VMzewQuXQ9hOxETC8US1cgwsIMjGqsssHbY5ZY1FN21WtH/0TcU+oiCLHs/UuwPJVhrEolZxy1RIxfYLADuHpSe+gBKVcnDs31tk6NADb49RYy6hys4StmQH2vvuX7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307924; c=relaxed/simple;
	bh=9gxlDRHqhuwt8FJ/CwukjTyzdPv7n6MCBFsd7dAHKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcQg236QhX4NlDr0YeCcZFiCQOZolBzKGDq3/kpQJ+7+Ipq9oE9V5aOkm7BE9jdCFdKLpprJcgrWcCzfHu8rsGVxu59W+YuTQ6GdMiJ/3OPLzvPSQIHysOYJHpaghAiuiByKOHW1cX9Rr0eH/XdDbedBDmfYJK3v/N6n8RzKPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVbJYFFs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVbJYFFs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499840a2575so4592485e9.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307906; x=1787912706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ht5SF4+wx6Jf8JH+OLs35dYBN3IVS35rx1u5RktbmkM=;
        b=HVbJYFFsfHHdhr9I+hzI1eFyz3vSZWsjDeitoM/gZlePB9MjYHNieWY1PLlH4gMetJ
         pv90BUseyhihDJQpI2gtXDiO0tJnOUp8RrzjjpnsuO8vILUzWirjEZHpdtIYgNzG/FcC
         SRErJE9bsYyJe2C7U2o0DKDg2GJpaL4HJ8sFpSDbKy/kG6TWmz8EmUfUcCgbYaJAq+P/
         06YEKKTTwkEL0Ip1Z0HcVrJh1Kc0gjg6YxM2OpVtQp1ZI7hEGG+IPSRfOOW/v8PQcRN/
         c5KSH2CZ12Z6b9MXlJgWBYOmkGvbxxSGpbLCLmEoPmOslqsYNWYZPSHWBb/OQWe0pDf0
         wIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307906; x=1787912706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ht5SF4+wx6Jf8JH+OLs35dYBN3IVS35rx1u5RktbmkM=;
        b=UhZyTbRynfBn+u9uYHuxvvQ9AG3RETk6RSKMzpm705iLeReljFtf9ur8jeeUFNCUM8
         hAHZaLqrqXM41E1Tsn9WH1EWdmHpBIA9C96Upr+HI+gXhfHLZm5XJeAEc14A32ovK90v
         H/eRxNePQPvDcgCZ1rnQCoNRiRkWJ40H/DLSV+/RMGFGn4YGCA3/4jTppMpvGGF+0vJI
         wkSqryEt5wHfPE6oCJXhSTYthsxuY0d5oDEK0vFCv1S2rrmOUbjSWOm+3UUevf5+HRzK
         4VZA0D+8RmpUXfOrsyA2nQdRZjQv/b7YsiES6eSkZ/IUeSrtEznT88s4zVoIAhO+aodq
         Vt6w==
X-Forwarded-Encrypted: i=1; AHgh+RoMBAG9CErFT6LCJaHDHd8/gcONGlfvpAG1oMk7HeosrSQnPUM4Wn3RiGFRKdZ23J9/OHQFTug+TIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylImSU+1HZflEf7dVLS5mJEWIaVAYRGbml4eFkx0Bp9IbMGJWC
	DbB9npq96pqsY/psHGaZNoqao7zibQ3OIWkpYxOsu0U7G0oqmpUKNETH
X-Gm-Gg: AR+sD11RD9UqKjM92h67XhYwyA+FAi+NStiEdcnWCKgn6rDAU/PTcLGpBUe7sDTzN4o
	/TF9RRmJh2g0WyhQkHKmHpmDfPDNpdlCbX+vKVji51JPnSmP9zGVR/My39bMom+iLV7f3NRbJMB
	JiAvfoMm61QvVUW78r0hvMdEi+2o6cwaAS2ZaWRBZ+EoECs87NlX1ybglwpyebWZEsO/Ldxr9jP
	kI4jbrz2iWjV0MLUlsx1375PTEcYwTzk4XruWesnTosrUw4OHsFViUYSRBSL4qldWYmLhtnve3V
	dRcYXP61m9iLlBgx4aFyu5U6Xe6/6rs6LCshlsPcC96+T9xRX4Vn3irukF/f7ljHuVN7fx9VuTe
	EhhKoycHfwTs2FCFrhCVsIG9QCII+5xceIqVe/kOQmuJNn8G5/DNBaAO8/j+h6zd2Q2KM82pCZ8
	Msj9oaPrClIhHJ4D+4vkoYJ0dC5237w/Rth0crrTB8z14bTgu1b1F15MbA6oSmUHVWjm4UuT5qX
	MCqRhEyEpb34A==
X-Received: by 2002:a05:600c:8b76:b0:499:8c68:a3aa with SMTP id 5b1f17b1804b1-499b8475133mr82881315e9.13.1787307906435;
        Fri, 21 Aug 2026 03:25:06 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:06 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/6] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Fri, 21 Aug 2026 06:24:43 -0400
Message-ID: <20260821102452.37407-2-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821102452.37407-1-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.

Use standard output-range-microvolt and range-sel-gpios properties to
describe the hardware configuration of the R_SEL pin. Ensure mutual
exclusivity using the not/required logic. Additionally, add missing
vlogic-supply, clr-gpios, ldac-gpios and datasheet links, and provide
a complete usage example.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
index 9c2c038683b4..e0123dceaa33 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
@@ -10,8 +10,10 @@ maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
   - Jonathan Cameron <jic23@kernel.org>
 
-description:
+description: |
   High voltage (up to 60V) DACs with temperature sensor alarm function
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5501.pdf
 
 properties:
   compatible:
@@ -27,6 +29,29 @@ properties:
     maxItems: 1
 
   vcc-supply: true
+  vlogic-supply: true
+
+  output-range-microvolt:
+    description: |
+      Specify the channel output full scale range. The R_SEL pin
+      determines if the range is 0-30V or 0-60V.
+    items:
+      - const: 0
+      - enum: [30000000, 60000000]
+    default: [0, 60000000]
+
+  range-sel-gpios:
+    description:
+      GPIO connected to the R_SEL pin to select the output voltage range.
+    maxItems: 1
+
+  clr-gpios:
+    description: GPIO that controls the /CLR pin (active low).
+    maxItems: 1
+
+  ldac-gpios:
+    description: GPIO that controls the /LDAC pin (active low).
+    maxItems: 1
 
 additionalProperties: false
 
@@ -34,9 +59,17 @@ required:
   - compatible
   - reg
 
+allOf:
+  - not:
+      required:
+        - range-sel-gpios
+        - output-range-microvolt
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,6 +78,10 @@ examples:
             compatible = "adi,ad5504";
             vcc-supply = <&dac_vcc>;
             interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
+
+            output-range-microvolt = <0 60000000>;
+            clr-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.55.0

