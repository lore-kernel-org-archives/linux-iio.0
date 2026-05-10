Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C681732
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442611; cv=none; b=HjP/TYge1ie+vE3IXPqRziwbAxjwBD3qAdE2EsqYJt0f/OT1VhrtJ7PAUKvSCiPWvAltusFAsrYYrN3Tc4CzyYRV8lHUzLYGqRmpJCRjp0MPa4480CSGRZwMIkR3a1/rvKDdHKbHhDv6xNj84yBrIdljJkTbcuUz+AlTTPBg+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442611; c=relaxed/simple;
	bh=/YGBE3dVcPNO1qgArbYgXysyeVCHChMgg34LhnuVa8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv0JlLByvkUJiX07aBZSZFwveFacHx2UkAINWqFqaKOY9A4KG63je42YAegLpLKQy0E/ksGToZDaXPMxLczvnVObooWbcrZeWHXKuwSEvVfUGkZRJt55Th2g+PqahpaMM4VNeFWx73+uZ5Br2AIj+II0vYdDzk1tGHZjU4Eloo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE10PFKJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE10PFKJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so33135695ad.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442608; x=1779047408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAPu8zY7K1umMx/3iFtBmWGzNRf6nimLEMSjnAOfuo4=;
        b=cE10PFKJtL+wyXlzm/8SYUyO228sF3CGJokFNiOYRBP6DYo3I+IkLa91a0/XKjRB4i
         y2+CckkIhJLeG8HqYqmKYs0cCZym0eECOejIFa/6bQRo1cdx8sYIycDjv5AdBNJ6Dxdq
         X3TheJXA5bVjMOV9kjO2iEw/8ow8E0ZAWJFg9CXOlE6ScYboJbSa6nx1sJU78mC803Ml
         xqwU/wersHserGf8PaTDx9p0B63qc4196AsZGn1GKaJjBDbdJlUVtbzUdOZMFEhXCoCm
         8rS18IniwHY0oCUrNjVDojqocA5y+rnOIMH8AG3dqNPplU8AO+JvWeL31SJWqzKRoFR8
         /3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442608; x=1779047408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAPu8zY7K1umMx/3iFtBmWGzNRf6nimLEMSjnAOfuo4=;
        b=X47qLYTNvFTGAWFnC8tMS7h35L3WMkvqkM9ao28vFfB/wTgbyqXcQLCNXKAALuYkR7
         UPCHYar2Coaa+wH/hEpidHz9S1eIk3sAXVNnDRGqFvEavcM6f1xlNL7LWl5DfioJdZDa
         NEFCBdat/T4t+OqVYaOenezYUwW7Fu2zUAzdiOJ5+fSIKgJ/H69X2PWscvraqlhQtIyU
         FLVVzpkTD90L+2/FFuKbetnGp1mu3ub0duxUGnf8y/ti7dk6NNDksr4GErlL5w+S6ytM
         7JEab4iDrPuHymruvG/nUGAkB+t7iclq9jC4uRTtPWakeFkWI2aIKdCkeOW8iTE2w7iQ
         Nfjw==
X-Forwarded-Encrypted: i=1; AFNElJ++KYRjU0aMtFq0WZk1IRgRawhdkDr8h8RFkFJrAtBbjU/lIwD0tQX5Hl7UaFgmDe6iOYxymMFOtGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPvblMaT8Duo7g8x6C3LZuTp2DLhD7mk1oTNoQgaPPeH07MjO
	u3d+w670fIHyq+a5BG/I+RdAppN5SzqShgDc9f7clFmKUAi4SwVjn6CF
X-Gm-Gg: Acq92OEvA9sRGbBc0DGYE4xGfulyNAIVhVZUMzhNXlxFVUk544O705wcG46oyMuReRW
	Y2A7Fnruwh1UUoSwJLJrlU6/xQymDWOdtHJ0gUU8uPm3cefKiIN1fJ3h/D3ngzw975X5Ol9a5Tf
	KTR5S9o0U3HNr0SvBbOcx1Bu7yaJv88fvXyKlwKLnLDCVpz+X7SrkHLGAtVygQYdt3x2E+GqieM
	X6G8C/x33wZzyNu9KLi1+UE08soH/u9O5dbVAwrQdFc1+u2VJi7QTUvUxvJFNBa2yaN5yl57sKL
	pxFvrC2oVEk8K1n4uL/GItp8jY3tMhZmBI//OyKybRiHCA25umIikwe2jMsuu3iiqUIDcmNlxHW
	PkSp5LCv5JvNtd4vYfCPlGmPP1opNuNU+MBYorVq41h0NCmwobEQp+4iNStJcvFXr6lKQF5Deb5
	60SAhW+2pdUeLT0zq9ymdjjjY2sLDOgLO5cW+4UkoOBasQIYIZQtplX5gSnqz5U2Z4cMqm/Jbqc
	AmTL2zA+EBplx091OHWrBIcMUvx+FGcD8/hFyujGAHH3W58DsbED2wp+Xlt
X-Received: by 2002:a17:902:d48a:b0:2bc:7d4d:3520 with SMTP id d9443c01a7336-2bc7d4d4085mr76196105ad.40.1778442607979;
        Sun, 10 May 2026 12:50:07 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:50:07 -0700 (PDT)
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
Subject: [PATCH v7 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Mon, 11 May 2026 01:19:23 +0530
Message-ID: <20260510194947.31997-2-piyushpatle228@gmail.com>
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

Rewrite the binding description and property text so it describes the
existing HX711 hardware behavior directly instead of documenting old
driver implementation details.

Also clarify that clock-frequency controls the SCK bit-bang timing.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 .../bindings/iio/adc/avia-hx711.yaml          | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9c57eb13f892..1ea60dff98d5 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -10,14 +10,9 @@ maintainers:
   - Andreas Klinger <ak@it-klinger.de>
 
 description: |
-  Bit-banging driver using two GPIOs:
-  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
-    and up to 3 cycles for selection of the input channel and gain for the
-    next measurement
-  - dout-gpio is the sensor data the sensor responds to the clock
-
-  Specifications about the driver can be found at:
-  http://www.aviaic.com/ENProducts.aspx
+  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
+  differential input channels. Channel A supports gain 64 and 128;
+  channel B supports gain 32.
 
 properties:
   compatible:
@@ -26,23 +21,23 @@ properties:
 
   sck-gpios:
     description:
-      Definition of the GPIO for the clock (output). In the datasheet it is
-      named PD_SCK
+      GPIO for the clock output (PD_SCK in the datasheet).
     maxItems: 1
 
   dout-gpios:
     description:
-      Definition of the GPIO for the data-out sent by the sensor in
-      response to the clock (input).
-      See Documentation/devicetree/bindings/gpio/gpio.txt for information
-      on how to specify a consumer gpio.
+      GPIO for the data output from the sensor (DOUT in the datasheet).
     maxItems: 1
 
   avdd-supply:
     description:
-      Definition of the regulator used as analog supply
+      Analog supply voltage (AVDD).
 
   clock-frequency:
+    description:
+      Controls the SCK bit-bang timing. The value is used to derive the
+      delay between SCK edges; keep the SCK high time below 60 us to
+      avoid triggering chip power-down mode.
     minimum: 20000
     maximum: 2500000
     default: 400000
-- 
2.43.0

