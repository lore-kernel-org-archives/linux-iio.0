Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F02222A9
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531960; cv=none; b=AAgY9J5ePZQ5npgdrKp4ZsjFILPmPqgK1N8Q0FfykOrgkSXZtOSsGkMdrmuJsEyVPNVKkHF+fY6r4aQhjE7JtE3exBg1mT41AdFYLHG2YAj2cuC83IYU56+V6lcVMWdL5zZCguPpkedb0tvr9V6aoPsv4hdHJHQFEkD/XKelK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531960; c=relaxed/simple;
	bh=AmWEh6daW1VQAeTy8GGtceY6duADadqAiHNIJMFUJhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acX40AgORiY0KObbT1JcPA2XWOg5Fdmybp1geQ0yQLlFpctJ+/KkyToOIkorzzvGoSqzzuSqC2/9tUfZiKElY8/Y3x5LZOgmbAMbYZk1NMc1DezI1UbIfbWtt+dceUUmjadpNfsly9EhL2pXZwN/aZuSItgvwdeWYA3ERn7PAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT1G/fsZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT1G/fsZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82735a41920so691036b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531958; x=1777136758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JodRHsR4G0nSxaXov0yHPNIAP1IY9vLGIzz8YV/oYk=;
        b=UT1G/fsZNeA2W7gxFGrWJibzmtl+9tvigOJUdw69RYWg/r3b8TidIRMi+MQMKLKWAd
         RRy9N9l5+k/z/CNOkbJ1hFw6pwDuwWqTWibgVoUMKCsIjDIZvbQr7/KYeN/AXSsURvMZ
         eEj3i5KSw3GM0oJf6YCKHL9+1BZVmNYTuuRjHJrK13gvuyUZzaaDpAinnyZjjiLowPIw
         LhPfuvfirUZmMx4HcpTNWkrCOmrmpq5BfkvlvqOoetbA1/rcRAyL7mGdB/N4lH0MRUMb
         /yAGlhPXoRanwC98L3xbSg2UT801yUAO61LCGF8faLCezF8hUy084U3+ujeboNUEPZAt
         4WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531958; x=1777136758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JodRHsR4G0nSxaXov0yHPNIAP1IY9vLGIzz8YV/oYk=;
        b=iCEpklbBiVJqRj7dOJ9rv08ApPMWrldh137LxwF4q1IckzareYKe2iUS2PeisLG4Iq
         VWIOS//iqzLQQFE3Lr3vpgO+ULnJTNpjdJX5+cuPEc6VT529CUQju3KtK3p5oTUyGe1h
         zRGw1YYqB4rMQcrOZ86z/Qwi899wLbIDAS92zDLJ0S8MZ71weQCUkLhKUhg88NsMP/HV
         1+SEU2twtFoX2zhTOEQ1fdP9g5TZ5i7g8OfuWv1vYICo5R7Mj2IWdX6kGchb22amtAI0
         0xkZ9mlgXdr+EnN4hKWa111LHduUEfmEy5OnzInHJDt/Wf4AOl7piNwJsS5PPLIJl0nz
         9auQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jJDBehxkSm61Cje+/vfptCEw8Cuf2QFkjNyBm2TcGz/GxQDf6XWR9nh2PbLUcb4nEh0+MfY4+dyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpzkacrAYvOdm25PCrdOSIO90fCHZk1vSU3dl5XO7BBj8ipu3
	i8b02L3NcE20SoB0cuZ2h6hXTNJx3dpp41VfJ2AzPyANUZxSwrmImVMc
X-Gm-Gg: AeBDievZZJ66OnRtxlgMCcHw0Q8rT52d7pIFNacYgw0aQYWxJ2lyNyOx6L+Be1zQTks
	dD03DSAQCXYLgNFMY62d9isdpOUag4opT7YSM/XJIKoDTPWaAU4tkHRFUOvVNt3sNj0cnAMYRdP
	YY8T8n/1ix4S9HyqDhxa5QLePA42cjDDbxHADNWnVPkDoIeryjrJKHoM2m6cNwKZnfQNxsbfrP8
	CrH9CfUtVwYTMZhAyt4ywyUoYVWhnSh5bODWuaNZSzw48x4ZmT2/akF9c7AbBGjxxubfrUix1ue
	pBPDo1qPJ/4rNQkb4Hde4qFXFPfx59irqY0mLncj8EdH2+kOwH5ZnOEq7qtQDDeplebrkueRRnW
	S0+5ACcdT16NWAuYVXG/Yq+o5jgCi4OE/UzZBlCAIvif8RPQJmmsFyU8a2lMDPyokfFPH9MVGsH
	7ECR39I+3EAWF9To1kJcmbvQSBrLZcARu2MWWhbfVMNyTYT1DRoD1z6mh580TEkFxxNP1D6fQ+I
	xmbBqLUMXypFqy61oh8onE1wjlOPy57X6qYE61SZksqWm4bE1zJewtCxQjZ9g==
X-Received: by 2002:a05:6a00:21d3:b0:82a:6de8:fa50 with SMTP id d2e1a72fcca58-82f8c82eac0mr7759057b3a.18.1776531958135;
        Sat, 18 Apr 2026 10:05:58 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d016:3ec3:66e6:8cde:aa47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe40dasm5435965b3a.40.2026.04.18.10.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:05:57 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
Date: Sat, 18 Apr 2026 22:35:41 +0530
Message-ID: <20260418170549.312446-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the HX710B compatible to the binding and describe the variant-specific
channel and gain model.

Also add an example node for HX710B so the schema covers both supported
parts.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 .../bindings/iio/adc/avia-hx711.yaml          | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9c57eb13f892..19318c4dd994 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AVIA HX711 ADC chip for weight cells
+title: AVIA HX711 and HX710B ADCs
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -12,9 +12,19 @@ maintainers:
 description: |
   Bit-banging driver using two GPIOs:
   - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
-    and up to 3 cycles for selection of the input channel and gain for the
-    next measurement
-  - dout-gpio is the sensor data the sensor responds to the clock
+    and 1 to 3 additional cycles for selection of the input channel and gain
+    for the next measurement
+  - dout-gpio is the sensor data output the sensor drives in response to
+    the clock
+
+  HX711: 24-bit ADC with selectable gain (32/64/128) and two differential
+  input channels. Channel A supports gain 64 and 128; channel B supports
+  gain 32.
+
+  HX710B: 24-bit ADC with fixed gain of 128. Channel 0 is the differential
+  input and channel 1 measures the DVDD-AVDD supply voltage difference.
+  Channel selection for the next conversion is controlled by the number of
+  trailing PD_SCK pulses.
 
   Specifications about the driver can be found at:
   http://www.aviaic.com/ENProducts.aspx
@@ -23,11 +33,12 @@ properties:
   compatible:
     enum:
       - avia,hx711
+      - avia,hx710b
 
   sck-gpios:
     description:
       Definition of the GPIO for the clock (output). In the datasheet it is
-      named PD_SCK
+      named PD_SCK.
     maxItems: 1
 
   dout-gpios:
@@ -43,6 +54,9 @@ properties:
       Definition of the regulator used as analog supply
 
   clock-frequency:
+    description:
+      Bit-bang clock frequency on PD_SCK. Keep the PD_SCK high time below
+      the chip power-down threshold.
     minimum: 20000
     maximum: 2500000
     default: 400000
@@ -58,10 +72,20 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    weight {
+    /* HX711 example */
+    weight0 {
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    /* HX710B example */
+    weight1 {
+        compatible = "avia,hx710b";
+        sck-gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
+        dout-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+        avdd-supply = <&avdd>;
+    };
-- 
2.43.0

