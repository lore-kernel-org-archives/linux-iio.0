Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BF39B97B
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880766; cv=none; b=VdFJPfS18ebYzywU9pD7CLfhlps1WJfyBRuFZZb4CFSnFthjBAd7AkU4+zMwjlbgJmB4LhnjGrNeC+xBNwy8RPQprLCiRhCh3ooRHxqgEw6J0izirzBAklhCxIw1d/WIecZfqpH6ovjf50kYb4t+7j5qRl+7j0bN5cEdY3sASK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880766; c=relaxed/simple;
	bh=0EQVOM5UfQLhGCbzUWEfNLcVwhW6GiAbaiGqT5rlV4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOlH3or12Zir+rt7OIXNxrGG3CMwXGe4fEJc5aVBLx4ZvXIkQbKLTVtGC1XmmKj2pRjo2b0lLmx15knGyWZt943ZxM1J8nyM4g3ILhTqWx/H/L9mFJmvvIsgVL8lJgTqKUbWeUaObmRq5fff5sPnm7IOxJt19yXIxnb7/7vjYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+/KLL9z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+/KLL9z"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c795a47186bso2381928a12.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880763; x=1777485563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftXrLDJi6w7JnF2X+ObW5xlG+z41xv2Ad84lI5gTtk8=;
        b=c+/KLL9zUiz8CPbAnHPZAgbqFclMUpqYAZsIXo4NbXxwxRZu26pm1p4S9q5AqUy+pv
         0ENewM5evP9eHjkvMyk0PE5ZMtCkELXMDSnh0Upgp2+3KmHpT+d1gcz/O9V8kIHAQJ8K
         iSQmJub5V+BI/5Fc2uvBaFFkn8D/R8qdvxEAAIPG6CRA2gLO8h7iZGR9TmnUYtHDtveg
         I0sGrN0qdZoXmizi4jC5PP6PSN2APJ5P6lLHB1uddmgqHyZuVApaJkgRYBeNLBWQ/lnz
         XXyr2LN/NmKvweMZXHE42ZCD5BT0WeFIGo7FZih3HJoyStXMwOGO0JKN8SfmgqZvSoZf
         UV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880763; x=1777485563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftXrLDJi6w7JnF2X+ObW5xlG+z41xv2Ad84lI5gTtk8=;
        b=h9kpG9BjxNNstkyeWxnNs9NTRAvixpypklZGSyCRc5cwR3xonDvPjI2k5EgROzDSei
         yTYieBvJVFMSNDLi0/rzxSVtct4G4mXCCA1SG8qb+ynhEX8Jq+p0NL25kWyReZpkLrf/
         NLveCDfxjx72pKR3EyudUKEFGbfOke0v6lmogauv32YejTGHQ3X83Sg8Pb8lSMLI1S1o
         3F61Yl7JrrzYK52JXmYXPzix702oIHx33S0B5h1SfbiVyYpwrf7z87yju6wZwPQm1TLp
         s2TuppX8cx6ozbdfEUB/1kMogtk8VXcGffyNQr8GeInbQqQhA7IzmZPeBGB8nG5FffyV
         fMyA==
X-Forwarded-Encrypted: i=1; AFNElJ8LUHbkRhs6i292Aof78RblQZOUxhTdHlx4zd0s7cdIxqj62MEPyz0hhx5QvqMmsJ3O0zYA+d/3WOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznV0o+hgObo90aAl4EISSCtbKMFENNFqICaL2+BIxHvcRo5Uw4
	YcNfeTzjvm5R5M6oZflp1FFeUqctpJv5uQq8fmKoJiRDka6r0T+81dhI
X-Gm-Gg: AeBDietWleYvBowo15jGXXG8ukGlNw5EyisG26nvyAhGhbr2oup9e+wh0FpiLOeHDu8
	jLL4+uhb4GhZrrh8JYt6I/iilA3QdMZBRsVGRJ7uCHNdBeOfeVmPUMb0zpR2rIwvDYriLFX4INn
	4HsCJq3/0CJs3KRPDMVASUOEnvOqKcYfv8iUu7xVhLBeMN3x8ZzYRTzs0TjvR20hUDvT0ePP1qu
	/ssovzE48C1fIGtE9b1uNEjUjmHSrUjPgJ8lZGKbqTiiMXVj0Hweo3J9QSYQ/6y2CpOSyPM2Is3
	DfQ3FGrI3azCZV5QaV8eToAcxIjoxlV9mTw1XG+l3aInhQYffEJP3T28y2nsXvN+TKtMCi6gIc1
	stQE5+v3WOAHglyTxY9vJ/ftOjqpauO51FKYvsj8VvTqEEddYXKgrTKFxxUKGXuirvqouX1lRIP
	MHRvo+9kVPk/fR14RfVrnSgIfh7o9yZS8Z0dUd3+BpYlYSYe3sYpvBvIbKQGiwEC3GFfyGYkk56
	oF6wf/4lqJ3oahvqTjVsHjMK+Fm4PUuCKxk5FyoYrCnAc2ywAgI7fRxO+wJHg==
X-Received: by 2002:a05:6a20:3d82:b0:39b:af8e:496f with SMTP id adf61e73a8af0-3a08c910f4dmr20227565637.14.1776880762895;
        Wed, 22 Apr 2026 10:59:22 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:48f3:f940:b423:53fc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cacasm15174361a12.8.2026.04.22.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:59:22 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
Date: Wed, 22 Apr 2026 23:29:08 +0530
Message-ID: <20260422175910.1258579-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422175910.1258579-1-piyushpatle228@gmail.com>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
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
actual purpose: controlling the SCK bit-bang timing.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v3:
- Drop the vref-supply mention from avdd-supply; no such binding
  property exists.
- Drop the clock-frequency sentence that repeated the schema default.
- Restore the example node name to weight.
- Remove the separate HX710B example.

Changes in v2:
- Remove driver implementation details from the description and describe
  hardware behaviour only.
- Drop unrelated punctuation cleanup.
- Add dvdd-supply and vsup-supply optional properties for HX711.
- Add rate-gpios optional property for the HX711 RATE pin and forbid it
  on HX710B.
- Add the allOf if/then block forbidding HX711-only properties on
  HX710B nodes.
- Clarify clock-frequency as SCK bit-bang timing, not a crystal or
  external clock input.
- Sort compatible enum alphabetically.
- Remove redundant example comments.
- Update the HX711 example to exercise rate-gpios.

 .../bindings/iio/adc/avia-hx711.yaml          | 50 +++++++++++++++----
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9c57eb13f892..0c7c5843b8d2 100644
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
@@ -40,13 +40,44 @@ properties:
 
   avdd-supply:
     description:
-      Definition of the regulator used as analog supply
+      Analog supply voltage (AVDD). Also serves as the voltage reference on
+      both chips.
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
+      avoid triggering chip power-down mode.
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
@@ -62,6 +93,7 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.43.0
