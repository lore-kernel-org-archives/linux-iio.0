Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574046AEDD
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521488; cv=none; b=C898OgWyTaNbv/g31/oN11t3iG81iP441aTiDe+IM5VSMjQ3sK+VLf3chpOc3U65EQOKltLIoxhF3rLXMk7Ugf1Ss+5bpsZQHWe5c9whjcV8MBpNZs9+un8hhBa0e+l7mRLBCJiJQsDnKI3z395+wAxH7e7DJder8drNgalQvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521488; c=relaxed/simple;
	bh=O6n8bbB8NeQW1Fqvhmlkdl4YSa1LzkkvTTlDYBWDtM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2OJwX4TGAQx7AF6AKj8shSfqK7TkvTLxPcPuZoHxW8GRzpTgTGOe/MykmkaxUEAn1dW8n3kKHp5VX6hjwOUHZ2oRLgajX7PYC7mvqIteGRlnUpMkRbePZ0V5Ni3eiAxrjT2EnO2NwzyoTgJi1F+voQvEDyAQ58E1yJ/xWFPRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdnWIGnn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdnWIGnn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bab2548e8bso21514085ad.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521486; x=1779126286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU5v2vJdNUYCjJPIJ4muUT9VTCLXyhHjccJmI7U6Y+0=;
        b=NdnWIGnn2awYiQyN6LI4ygwGSjnIZ0da88v0vO/SnhMXzB39vTr578rIrtu3+VvJNi
         QTMiYOTvCgsCV+VWhJVXRNms4YkHGor3/bTPdhNwIEH7QAp5zRfjcmKBPzuMVM4dbn5X
         K9QZS3q4JMpHcv3O7PtHNSOmjhRJTWbobZayys/SRtI9y6M4DkT0UpEePAYqHi/k3VpP
         i18H4u6STp6iP3eiy8tomcZ1NRe8e24B5sC//BhYad2rwLOHMBJ9+17RqqYzEpmLrQv5
         9I94sd+uCjbJp6SPFI3tvMYFROWV7spoF9gDGVH+fYEfLccA2MMBqlpAkrSoq95IZpSg
         IdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521486; x=1779126286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SU5v2vJdNUYCjJPIJ4muUT9VTCLXyhHjccJmI7U6Y+0=;
        b=RC+MrvIlBx9HFp0aojqMATEQvQyP413mjFG9jGjGj5T2SQ0DccH9YLjHUY6MeyzfEq
         XCQs31cw6OdGWxAoFbbYrgoulUhyWVCwrDhfl+SxtghMlmRzoKhkQDZ+zAdPJH4YoCig
         2cZIMvf92bWYt6uU+yXg2fDoNlTKrV3H0oF3HxXIOVvQHdyCTMMpjo2IxRTG5XyvnOuX
         N7QcZF/79rfFxrLLlGJx9ruQ7uSV3T1zBBMzMYuimHWfQlvVzP2qPjszX8juybcS+ypx
         BL0X1MscNwH08J+1AhLzdy/PZxOmX3iv5a/f3HQ19xdUiyUea4BkHOFLRxQG7Gckm7mT
         1MpA==
X-Forwarded-Encrypted: i=1; AFNElJ/SGJ47M67tyYSinv74Pgu7UoMa9OacM+XHkK9H57iIHADZNzoCj4ieUB7UmdJdp1ZTJe9sOwSrwaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/GCwzbrp95THrtRfVEDTHBNw7JBtwK7oAFpPwNkt5WQQ07kt
	j9O4FEWsFIk9at0hPTNFXgAYeh5c7OOhLqyCOvBnzuaBON3L4F23Lm6WtcUflQ==
X-Gm-Gg: Acq92OGrK86IlQEG9lOC6M/bV3Q+m7YsGLAvOVNGdm7eg1/XoaLgAE/dY5jjKhoPC9u
	nw0/6PH/T0sFAKwp99PbuNnqWrxA+ngeoki4xmBbyfd9491rT6THDoUTPnW8lHt+oXUIItOSxLr
	811WDqh3CvqkTzjeoX8ZMHwdls6vhcVPQ1c13piFxOD9CJlixXKMzrpwOHu1gCu+rLSvkl+p27n
	xUSzkk4j9wzdI5KEn0jH7dg7g6hcFqkZF0hUieU6dlepElEtSng0/mWqDK8rb01lg9m8K0MkScq
	iC+sgcLcaZvlhPoaBf5+fuJDEBbMhAJW7tHCEPo2v6WhrP97pxFkAleEmMjdVqyzy6DGEQSkgwQ
	bCaSKFafeqgirj5/ZX9GZ2BQlRUbEXUJeKtW5KAgiS2gU8lUiTMO0S4Zo3VlYDTt5O9qCzRpa0i
	NQrSHIyq21Vo4rFjan7ouNftPvwu3tQIdorB8g1DgcUPK6K2e6L90kypgBlR6JHBNYMWSakGtPf
	BDN+f8SLZlkWakI1AIpP813g6GKr2TevTtPjdNrjs9lsMoLVPjftjkswkf/
X-Received: by 2002:a17:903:1aae:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2ba795bdee7mr262936595ad.28.1778521486537;
        Mon, 11 May 2026 10:44:46 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:44:46 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 v8 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Mon, 11 May 2026 23:13:29 +0530
Message-ID: <20260511174342.123820-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511174342.123820-1-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

