Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD27260F
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620837; cv=none; b=DKwSEQh5/PePsW9ZN/4u1VueoPDVkkniavlB4lF2gr5LSkrHM5nxx3/BnavenFcQB7SwxOQYqx+U49t3988MsqqRCV817Fgf2y/+Hca9dDQVEB30Dvd8vNStjl9l1VFohIRrXc4vlw+XKIFgho5Orltgnt8Tmg5N+6AhLOBYNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620837; c=relaxed/simple;
	bh=+a4Fr0IjQQ/CYoI5Eys19WCJe3OBe+8XTQTbWlUDiu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWrbVRxlJYODp5ZOm6Go73f5xQNYMMFC0bEokLSxZrcca+mmelYifkgtKG1DHlFLf7gqL2Af2LZntwBb+fu7GGYN42Cy+9RrtHBKjRN7Q75SBtXCc7FmFwWifN93dhCr1f4+q2d3wlhN6YggsF7oszDPIVWzL4pdxZ6pG/vN5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt9jtqba; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt9jtqba"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so2670970a91.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776620834; x=1777225634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYVJP+gR72z2Eu7RTUx+WXRO3NGvC74i7dV5FetC1js=;
        b=kt9jtqba0YDK8eQJZ644LeKNGQGM+CoNASYy/IQb7n84SxQQliZzn+wxCQrqkUe/D0
         0xVol4t4971oNIxGgDTDH67/ly6UgyLCpDOrSwgaojJXl8nc4qLCubU62yrFIX12I5dM
         +v7ONGElU8jP6xjxd9Mv+CPcRGF9vapfQDdXxTC8EZthApVB0pslPLSZRU7oDIeKEtje
         QsWF+hLG+p9/PVEBWmxKQNr3+UPPc0vKUORMBOrbeTPmLLXCABAjHm6XgAh7e7tF+4x3
         OswvK+X6A3roGXEjmEfY+vEUfZ89kD9eLZX0wn9CkS2SSnuGxAoY/lKnJELjjkpQtG2O
         Kfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776620834; x=1777225634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYVJP+gR72z2Eu7RTUx+WXRO3NGvC74i7dV5FetC1js=;
        b=VUuUXvwv6hIGBwz7JuGShoELRZegYFCWgazVgtp5H4s9EIXzs0A2XtaH2wU+56TR4X
         6P9TOBfrd9ZZw2yTCJ6RikFpDW+gvrn1zl8/618YNF3XkZET8NR0I/5ygicY5Tau+yhY
         wrRCCv5L1859kYRIZwB8CsbjBwrkqVHr6d7eig6+HT3qitsyzZDuiaJ95EDlBiEg43MZ
         IaT86CKuTxHrXAJK/IiteK8E/iZMj16HIksLJQubWfE0PosYyb+qCdwJnP4nBONsN71Y
         c4QlJ2LbgYxfWxVm9kOZ0AHBNX3ZsLwlNPWRawZYG5F62sC9O9mS00U06Ox5RM5T5U8U
         zGsg==
X-Forwarded-Encrypted: i=1; AFNElJ/FxVQkDexxDTApeOSNelieAUaPV/GCpmeppqMgYUHlQ3QD2yPk7JW9+tOdZA59Io884NkG1zBKTc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdDiRPmQQ5qwF5U20P4bET7ozNGoOEexBV8DZbatBlnoWiklf
	1afksazJ5OLX/SLLQQGdyzPAyjPma4rfqCnX6nLJlvsmkM9lFmszk22gfx671R7NrhQ=
X-Gm-Gg: AeBDiesX5jsQ1Ng8PhcVzWQjkucjl1yUXQU4J36jw+Sf2k1DasxETwg8lIYIHaGCDLg
	u+n0X5Q08EDZKSzdLKRH0TpMrVQcyrVd0H7Wm+yicgCGqqAC7EHxWpT7VoYNXLuPAOaBrGXroZA
	NXJTv/gQqi8b55yCvUhgdXFbqCQF4cQbs6MHP6E9l/Y60pGWDdb/RFAse4ae6sitJOQf8r0yEOb
	/FshZs4om5U3/qiPtJHALo3hS5yfVbrLzfxnJFRYT+o8evczLo8ydMHsz1jxCAn2Dv+AT4ON9NI
	OMXu6zcy2Nq5B8bbpeIpFzimayWfOjxBK2zQ7M6edqIfF+8CkazQzEsLNTlDiow01CTXu8nJ6gp
	47xqNEAQ/of03tdSExYn9+gbHoh3yQDa0VScf+E35NldUymw7SOPdR1SS4Re4VjrTBORcXByjFo
	qIz4g5MU78mrMZ4yriH8HKgAelu9ySyakczkTtW56l9+Dh7QI3XfiHvIGez6vxrBQhxbRZ+dgdO
	4svJ94mD4ktnoiVsMRwtmBoR5L3PmTIp4cEOP03PH5bymCujfYsyNiSKydRtQ==
X-Received: by 2002:a17:90b:5543:b0:35f:b227:db86 with SMTP id 98e67ed59e1d1-361403af6a5mr11018606a91.2.1776620834377;
        Sun, 19 Apr 2026 10:47:14 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:1c1e:6c93:8067:7dee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fe07c7sm7794875a91.5.2026.04.19.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:47:13 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org,
	ak@it-klinger.de
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
Date: Sun, 19 Apr 2026 23:16:39 +0530
Message-ID: <20260419174654.683692-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419174654.683692-1-piyushpatle228@gmail.com>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HX710B shares the same two-wire interface as the HX711 but differs
in its channel and gain model: gain is fixed at 128 and the number of
trailing PD_SCK pulses selects the input channel rather than the gain.

Add avia,hx710b to the compatible enum. Document the chip differences
in the description and add chip-specific supply properties (dvdd-supply,
vsup-supply) for the HX711, a rate-gpios property for the HX711 RATE
pin, and an allOf constraint that forbids HX711-only properties on
HX710B nodes. Clarify the clock-frequency description to reflect its
actual purpose: controlling the SCK bit-bang timing. Note that AVDD
serves as the voltage reference on both chips so no separate
vref-supply is needed.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v2:
- Remove driver implementation details (bit-banging, channel-selection
  mechanics) from the description; describe hardware behaviour only
- Drop unrelated punctuation cleanup (trailing period on PD_SCK description)
- Add dvdd-supply and vsup-supply optional properties for HX711
- Add rate-gpios optional property for the HX711 RATE pin; forbid it on
  HX710B via the allOf if/then block
- Add note to avdd-supply clarifying it serves as voltage reference on
  both chips (no separate vref-supply needed)
- Add allOf if/then block forbidding HX711-only properties on HX710B
- Fix clock-frequency description to reflect its true purpose (SCK
  bit-bang timing control, not a crystal/external clock frequency)
- Sort compatible enum alphabetically (hx710b before hx711)
- Remove redundant example comments (compatible already identifies part)
- Update HX711 example to exercise the new rate-gpios property

 .../bindings/iio/adc/avia-hx711.yaml          | 61 ++++++++++++++++---
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9c57eb13f892..35ac74a490b1 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -4,24 +4,24 @@
 $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AVIA HX711 ADC chip for weight cells
+title: AVIA HX711 and HX710B ADCs
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
 
 description: |
-  Bit-banging driver using two GPIOs:
-  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
-    and up to 3 cycles for selection of the input channel and gain for the
-    next measurement
-  - dout-gpio is the sensor data the sensor responds to the clock
+  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
+  differential input channels. Channel A supports gain 64 and 128;
+  channel B supports gain 32.
 
-  Specifications about the driver can be found at:
-  http://www.aviaic.com/ENProducts.aspx
+  The HX710B is a 24-bit ADC with fixed gain of 128. Channel 0 is the
+  differential input and channel 1 measures the DVDD-AVDD supply
+  voltage difference.
 
 properties:
   compatible:
     enum:
+      - avia,hx710b
       - avia,hx711
 
   sck-gpios:
@@ -40,13 +40,45 @@ properties:
 
   avdd-supply:
     description:
-      Definition of the regulator used as analog supply
+      Analog supply voltage (AVDD). Also serves as the voltage reference on
+      both chips; no separate vref-supply is required.
+
+  dvdd-supply:
+    description:
+      Digital supply voltage (DVDD). HX711 only.
+
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP). HX711 only.
+
+  rate-gpios:
+    description:
+      GPIO connected to the RATE pin (HX711 only). When driven low the
+      output data rate is 10 SPS; when driven high it is 80 SPS. If
+      omitted the RATE pin state is determined by the board wiring.
+    maxItems: 1
 
   clock-frequency:
+    description:
+      Controls the SCK bit-bang timing. The value is used to derive the
+      delay between SCK edges; keep the SCK high time below 60 us to
+      avoid triggering chip power-down mode. Defaults to 400 kHz if not
+      specified.
     minimum: 20000
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
+        dvdd-supply: false
+        rate-gpios: false
+
 required:
   - compatible
   - sck-gpios
@@ -58,10 +90,19 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    weight {
+    weight0 {
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    weight1 {
+        compatible = "avia,hx710b";
+        sck-gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
+        dout-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+        avdd-supply = <&avdd>;
+    };
-- 
2.43.0

