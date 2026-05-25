Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187E3E5A2D
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706320; cv=none; b=sJMFhZCwMEUtgKqbiP5QzeCBgru5H7XaMvsl6b4ryEwnXpefQa2YZuOz2RKhTLktSGa2ZpgpAhkFttpJF6vrC6gZOWuF57upLJ2MHSXVf0c8gZvQ+BHMMk1m5WPVnlrCmtxc+FGqkjgYo2bRILUaOHk8fpuc299653KNQEGNODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706320; c=relaxed/simple;
	bh=cyVQaYp09rTmHhwDXV8k3udRvnCCwyJNeI/CPfraGR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGjyQ4M6AScq3xfbDlapQRRiT3IadyJ6bc/L0R8x3S/oNoG6L0QI0gvrCLwej1iCh6DsOzyKqUdTbEaHHSrCTnjC40w0Zocd3FUN+Q9vBiFAY/29aXXg0ys7qK1YG2VaJc7NlklQrd9AECVK8+Gv0vfLfBBSoBwLsrKYGzXHKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNSQTEA8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNSQTEA8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367d88b9940so6331519a91.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706318; x=1780311118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe8F6BBtHSCnTWy+Jvz/dHP4g87OMQse/dKMPfWduuM=;
        b=HNSQTEA83vAbmYa3Rrb7a5PmFxk7zZjcLnVRf1b9QTyHAcZSfRLHbCr3vWC/+2A4VF
         YZswYOQxFXAQFGMHuncE09wm1QJO7gRlbe/TaMtf469igwnSdBo1lWEivP4owpjV8BOy
         JhHfl2IOAyV8++2Cf0M6PQY544QkAD0gCCVZe2Pj7qWTvOpmlxdN/Qqhc95aLbUOkL/n
         mK7ndxW4b/QqtIKXkmXC7n9cPuJhsEGp/cdtM+ZYzJkyQSM6zwgkPhdXEhF0HBzZES5/
         eWBJq7ABOIdEjFNSEj+84/9MC6iORvOtwimMbV/4+jqZpUGA05YEB5i03x0zcvQcAGX2
         IlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706319; x=1780311119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xe8F6BBtHSCnTWy+Jvz/dHP4g87OMQse/dKMPfWduuM=;
        b=gzxPLkFPhvQB9irXnHpmzB0ej7kh5oFaqNzySgx8TfsKS/uBtbewQoDrPypv7Sc8jb
         +1M18QEQdRuoasFw5pUfezVymvu5TgVmcB8BA07MNrfeqrmnF09dsUheUlWylluF2f2i
         m6FAlovCDWAtzK7oh3/t2rmVSpfKJagptFN6GRVjKKYonp6Pvw2UjqMy30lm5NfINRAK
         4TNywP3XvF3aDw+sm7/hblSIiylbQbfDgimQW3nBp9hFJVZSU+nvQCGWuL9UjTA9dCdx
         S93aCfvgSxv1RljCiNE10JVzwv5kU7nzLBFxxkKOZRm2gj3S9+9uQSFQNS2lcW3wBTRn
         qhjQ==
X-Gm-Message-State: AOJu0YxWGpsfMIZEK9CxcrG/M2czAFN7PQw0Ro6nY4XaArRFST/dsm8H
	inv7El/R/2+JNpAikoHy+kqcJilv2Hs104RfLUFcwb2AsVp+ABkkiJZgdo7l71Ys
X-Gm-Gg: Acq92OFvc/e5DVgbsFdOkM+iZNtrG4a1ODUc/X9POEOrFjNbSfpZEk+EBEG5SJQ/u25
	2SSTZCXcIosJ849Zm6zvKeGyEJklVw8gZ4F+C0umiesmF5ouZg+SG9kn4UDmVJZ6xs5XxRl4Wc7
	rR+LzSkLb+Gs04+NGXCIdxI56g68qW6kYW0d9oxpiqgPWWLQ7HOVYIq1pJsB4xTs5fcP1e0IfJf
	EZTEUrHePrVREAGlFkg8mp7nAfZlU+xQjPgl/dWU2+rIDEWpuKHHV32yyaZd0q7y+P0rAztOnaN
	wa7W6Lht4I5QwcV3PMdPCYZ1bPFQNyNAq1rsRdEg0L416UVR5rXxV4vigJyU9g9QlhjbPkivmfv
	BBAjr6N48q+myccUq0vEfvb01K7HA871jTRc1P5pohXgIDZye/skHG6fU5YluHcDFaOfXbHKuug
	wLEW/Q7IFH/2UaUBuyIbakoIsJMvvLfOhF/gHdYxCLpp1r0Q0/9cy1/vAiXnrcvlpP2p4AJ4IxQ
	js20mcUqZmLtZEPzyhDYoZKUR6q7j/c2jiHEePoZg==
X-Received: by 2002:a17:90b:3887:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-36a6787b0dcmr13675423a91.23.1779706318473;
        Mon, 25 May 2026 03:51:58 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:51:57 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Mon, 25 May 2026 16:21:20 +0530
Message-ID: <20260525105127.180156-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
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
 .../bindings/iio/adc/avia-hx711.yaml          | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 099235b5fd54..f0aeb15e9eb9 100644
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
@@ -53,6 +58,10 @@ properties:
       RATE pin state is determined by the board wiring.
     maxItems: 1
 
+  vref-supply:
+    description:
+      Reference voltage input (VREF).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -62,6 +71,21 @@ properties:
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
@@ -81,3 +105,12 @@ examples:
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

