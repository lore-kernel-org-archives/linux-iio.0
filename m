Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76745106F
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512557; cv=none; b=HBrtJ2qF8YxeELhBX9+Hu78awlfEZgGyLRxPyw420vx2+xojKhtsJ9jeyFBXt0eBC6UC6DlqEiz+R2ERSYxxiDIjMO2H5zchSHxE9EESb5PBp1VNbFJuCf4eWn86ooDp5s0GN+d5jNAp1qe7VPNZ4DuMH+RG8A9V66qEb1jqvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512557; c=relaxed/simple;
	bh=fGN8QACq5acyX3/tm53OfWk81sTlEN73wII2m7as1Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdjM8TEqojDD4DAbWwJ0sNMxJHvw8DiAqEsq0qYWubR/XHMcCwr9Glub/FSn57veUBfvFWsV27ME97wZTGY2jTwNAGUQeHEv5wVNn/e/C9XQA1eyw7XYts8fWcxm1KtorZFiCl952TNBqQwEHaAx2qSzmmI2EW2VBt2yQOEftGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2LfR414; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2LfR414"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2d792c8so27727315ad.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512554; x=1781117354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf9rYDctPN9NDbaPR2RYs1zVFeB2pT+PMnoNRzcUIUM=;
        b=Z2LfR4145JMTATunS7NAGFCT4P/81X6vTim35taRggW3hfGB8i/QwDpeSj7yPLStmt
         GjE/OTMt8LFHl8LypTPtlVazbNRblCcMXmvbkkoRHQkm1IuFTLab+EN/qgDoLrON5d6b
         kEra20z5xnL9tSE4PHqsUiDB+5AbwaTMgI2tOaoyTakppd4gup+q6+WL/399c0Wk9Zr7
         ffYQ6Sitd6kI0UKp4Q98T32Cxgyv/vF6XFhwXWi4enSrZ531w1ff6rhwCi0QQ8lwO3RT
         f+cfazEmJI7ZCklNL2L/jc5PYiWsqFV/CsgPsy1QiB1V1Uz1msLdaUW/fVIZ256lLFfN
         yQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512554; x=1781117354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yf9rYDctPN9NDbaPR2RYs1zVFeB2pT+PMnoNRzcUIUM=;
        b=YCtaN1bCyr54/eUWFPpsD44fXAhv/0+Fe253tJadbgUADg7YD6Efv2zrxYhPYYQCsl
         ZoZZBEow4NM/V/DXdynS+2tnpXVgodmNO11rojEyLNQXD6RwK0VBSy7X4TcuGlyC6hBk
         dABG7ppmR+t9o8zpfLp4FAeDZZMxZTVEdz+jr3hcGRGwCSUyohaogxeE333Nybly2H5b
         GozEArUj8BioNNcEdq69XAds04x1BhyfdHEMvdKagffWThdtmsvSfYzWYiHaGjbckAKY
         BUMWdAP92TbaEkE+8zSD6Befk3NzCKu2pPyLrc7r+FkTpZPzVOrbiDRBcdlcL9yf7M1F
         poAQ==
X-Gm-Message-State: AOJu0Yww5GzMTZ+qW0MSv1unlkuGPNEc/3Ku/JoMJtWijMkExE9nbY9i
	sls88S/zyy+dAefDiOFB/FdrDI6GMPZinnhMUruPLdbQMefj+EQH7f41y2S9Ww==
X-Gm-Gg: Acq92OHIcp6E/bYZBmUoS2VReWiidUEw9LlcbNSz9jTz3+Eqf8rygyo33qV2YWSZwLP
	fpjkNEW4L0cpEjU0AbXTENTFMBzlPUJiQmqgtGgTwnRReGzJRets3/PA1T5oix+VG5I/HYtxxVF
	80HSVvvtnvMkc+UcSWHCM6ViCKUVRx/RJb4L4Rtgr35DDEz0QOGz1zDbz4aO2lPGcsWCdM2Q0KK
	M052NB9DiccA4FJ3HAt8eOJh/li7EsnsYI1HOIA0HrF/h5/8QiIWT1qcU+SvIgdB2959YPNjvb3
	ht6xgSiP11RXMC+J2DFWLS5oTndbQ5bE1MiTbzhidt/FatDYu3GuE8jRW6bmsNwC5wrz6WJ4dxU
	vSzlvWcXWO7+jqIknLwcQX/fqM2If5lCkFtTvms12XBqsJooAgEkp7/uMKsA5GleDTPUuCW8Zl7
	aWy/N0z5P6baUX4pAWAkpen7IG0drA+XZhq4fUNrFnpiI3lJV3PW9hqyqx/KwHIbJuw+dssYV5N
	mgl5q4mJtnQcYkC887h0xkOTfzQGxSfzGk2a9XBEHOs5tEyGeliPDi+oML+qX6M
X-Received: by 2002:a17:903:3c6c:b0:2bf:800:19f8 with SMTP id d9443c01a7336-2c163a3f9cbmr57906695ad.17.1780512553868;
        Wed, 03 Jun 2026 11:49:13 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:13 -0700 (PDT)
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
Subject: [PATCH v11 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Thu,  4 Jun 2026 00:18:49 +0530
Message-ID: <20260603184859.89693-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

