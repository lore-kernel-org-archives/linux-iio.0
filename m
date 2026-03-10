Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303F3D47CF
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164928; cv=none; b=pcUMGbNX6lTeAHvS/2nPJFfRP96ZllfxMY0MEC1aFLKA2aXC11Gn1XZDogm6jIkCeKQXtWW265nIjyv3en1zxtRqrOgbaBiA7QjQRxlkbSOGydMPyK5EQn46zjJzqm7cplVDwTdErld+JF5S16a30xOv94pBleDegSwADyMt6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164928; c=relaxed/simple;
	bh=VjZb4CmtSrNzb1/U1B1dWD1qOFRyAd66jrWJtqkQxBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQFHFRjpmO6uJg7l49ivJpfY1/CP+vK/HrOl884BCZ1H0Su2iAbujMG8XKwhzVW3n6aRgH+MbQkmw98Pifvd+L6jfMWN12XR2QF5+a2fvr/cxWrCbsxlfKTrxU5nb+WpgF+BpsJ3c5jITUNW3yh/hRh6M63VNJsFiT0zM7osp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsoEibyd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsoEibyd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso10563565f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164925; x=1773769725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHmODBhrZ3/O5W8NLFv7PZ5NCYcz6FiT2g9bwdQa078=;
        b=IsoEibyd6eSYCJTRF57S9KTAT1VtbsolYEiJ9aSmQ6AajwMQ0NyJeuCWi4vwxymHgA
         G0a3E6BLdlPVuDDHNjjYih9s52bOyaMFRB/p1sgu04K/YClI+vwB1R6Db+PigLKgFs3M
         0gbwTSQAweOVrUbqPaZstRe9DZfd/gl4hSbZnUlLDlQltfRFf+jUnEG8HJFbvQ0K4n0F
         D2QlJQG8kQkgXKqaxMbc3LrfHElZ3q25NW/rRsZG3FlaAC9cyVbD2oR/Re1rrP7uDPFf
         b8d1fm9jiDf12iZMJ7f64kHl3ZlEA+f9mfcxlWtdIqA7rQd+RFpWNN5TAK8h1Fiska+0
         Yhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164925; x=1773769725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHmODBhrZ3/O5W8NLFv7PZ5NCYcz6FiT2g9bwdQa078=;
        b=U/GkNy8sFkwAkQWWKHt3iSK4b7k/aYRn/+V4DJQAI3FzbrpXwzo4C4Co6rWEXAySdz
         HlCbpiAyrXRkYjTzlVRb6vROMXIhwCxNAY3ylt+OBlJlVc4MNfln+QshO/N68QCPRjHN
         W4HrKKDzu/5DgtH0PgCpK49tyh/JEe2iRp3ZZOsxKifmf/AbRjRb/jAH12cGeh609yQ4
         75JL5Fk4Uzi9XzSbGpxBbht34jPTV2O2OeNtvMT19KIwxowwurC4DoyZC86cauEkVcxh
         6yMeqAAjk2yFWLOqVLNiPSBG96/hUs+g90hkFECAlZQurkWA1dtPau9AlP4g5+GkZTj9
         6tXg==
X-Forwarded-Encrypted: i=1; AJvYcCVmhDIwrQkI5qw/SBXsSTNIufrAJCcIhcMGhL8KEBNGYlJCD0vH8rjsJvbXHGhTMj+5ZER0rckgOaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXuJ5P9qxRmR5Z2CdHQdoaIbEpUAIaOqm5A1mDjVdd+EHvU4a
	C4W729prsGIURFCL8iqs3YCeA3WNHI/g2+9C4vEsHGWWP+J2NDKq5Chl
X-Gm-Gg: ATEYQzw1ethr4n55SxkfKXj1uy9WVQca598MUX/7Zy0PshVEkrxK00gY3fWLKUoy0B1
	sqoJpJfoZ3M1O7wnjJHb9iypHd+lN9FMc2vyncqxLHd38yXGRDAWiLlMHA6vtI5qgR0cL3BB/rF
	TIGw3Y2hYkWhp1YjyxM3WXwKLFS0TFC4juJdfymIDk3T5FytE3ioXyBdEAvZ1hYdm299dcAwUfA
	JxfcPMrMB52/YfEXEgiE9L8QeTVhKCwJDbEoyLx8lhq2ppUlSLWb//bDiKgSp2MTDki6qH4tHQS
	RbJwBOWLKSB9PY4nmXRGFofc9gU0Qg1MYgBCO+eEFiKUayKvOWlsGw9eJCFZZTuFxQnnBiRhMMN
	ruq3zZhsFZIvtag9EhHQS11CCH3X7CDc/8AHW1hnlY78gArCvO1dMsIwAAnpT3jaAmgxaMliFKK
	nkzkJPBn2UBTRnKjR+3etUIVKK1WBGOxgsN6l1HbmcJCMRnI0Bv+SE+WjEaA==
X-Received: by 2002:a5d:5d02:0:b0:439:b886:20da with SMTP id ffacd0b85a97d-439da656ee9mr27128512f8f.17.1773164925101;
        Tue, 10 Mar 2026 10:48:45 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm42986166f8f.32.2026.03.10.10.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:48:44 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Tue, 10 Mar 2026 17:48:31 +0000
Message-ID: <20260310174835.24209-2-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310174835.24209-1-0rayn.dev@gmail.com>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
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
vlogic-supply, clear-gpios, ldac-gpios and datasheet links, and provide
a complete usage example.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
index 9c2c038683b4..c0b2d470949a 100644
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
@@ -27,16 +29,48 @@ properties:
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
+  clear-gpios:
+    description: GPIO that controls the /CLR pin (active low).
+    maxItems: 1
+
+  ldac-gpios:
+    description: GPIO that controls the /LDAC pin (active low).
+    maxItems: 1
 
 additionalProperties: false
 
 required:
   - compatible
   - reg
+  - vcc-supply
+
+allOf:
+  - not:
+      required:
+        - range-sel-gpios
+        - output-range-microvolt
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,6 +79,10 @@ examples:
             compatible = "adi,ad5504";
             vcc-supply = <&dac_vcc>;
             interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
+
+            output-range-microvolt = <0 60000000>;
+            clear-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.47.3

