Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76A3E5A2D
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706304; cv=none; b=ZZGBG30Exp+JkiGneXT7/N5uZq9kMdhje0VUIw61WPLd7ymV/e8S6srWAtUouHFugRNJgxRgfdwTlREyTShSmfxl3zKs4w9rsGFGjeptkgVDQ4lp27zCKS6+AeI4RpK/b9nX+yBNqpDlKD487QaIl7CqRlsdXjRW9X4F8hPABEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706304; c=relaxed/simple;
	bh=fGN8QACq5acyX3/tm53OfWk81sTlEN73wII2m7as1Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e95HlmKpEDPE57lZMBEn1hiTh6oxE9ebLkTTch3XdFJfrhJt/qEfDWpD/Z26mJEwjtmUiUWb3vjBbZwII29ioFSZqhguIscE8cd0tRLMOF4xcWs9vDsh2caD1I0Kloq0hLxHcJoA2fRYhHAzHa+ZcqplxXdetk88mD9snD5J2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlK/JZGf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlK/JZGf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so8543296a91.0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706302; x=1780311102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf9rYDctPN9NDbaPR2RYs1zVFeB2pT+PMnoNRzcUIUM=;
        b=FlK/JZGfALU3zpzsgZQRkL0bE9hcwMEnyz2P/DT0Zl4usRSuQUB0zv6zBy5TpBSwkz
         KcYfshz0A7ctoWjj0Mz4bskHGX3RcIuWYZ/qxlMyFF5tmvK95TAy66xzO6+gudB2yCBR
         q8ZgoTf2OpFaPIF0H4n9s+hnmGV2qoDK3ZTKTMcdz8mgJSPfZtsbTuUjBQDnJszhrDRH
         G/IMtRSOzNCEiOXI8fegkApgiU2mswc6kyX1rG97Mk2tw1HUyez/H4smt3yw1RVgSrp2
         knAykL51LAHCktFnSm9xD2CNExbLnulQTfh+v2hQCStmkuQVc2t1eJhxar8+AAKcORkg
         tGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706302; x=1780311102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yf9rYDctPN9NDbaPR2RYs1zVFeB2pT+PMnoNRzcUIUM=;
        b=mwAYiUcWfmTP86b1Mlu5JOIntvLtDJuKsCJMMjPfmDITBG9FDYvASH1ro1ZJn777/V
         3eOz57adkk0LS80ODhoNGh5yGa5jQS4m0QkBNWhWZ/Sk6KMd0jI+QhZGWJnisAPHhcTs
         ergNdHYxz46EVkUCoiplsFLj1+PDx1Cs5mfueD9+UTz8pof/oUJ1Jhxlqc8ud3fBK2uu
         gwd+idMhauvTypM0rWBUDauIaGceRopJxjgGfocaIf42wWptQzvG8qwmjYCQ8BGxG69i
         r3xpYAEO7s4a8SSYvkpYn9qMb+r/YZG/+dFaexBJNcZSiXpw2I2NMG1RlKKXYflNMaAj
         kRMA==
X-Gm-Message-State: AOJu0Yzf64FAjmBG13n+qJoVNOoWKfbccD5TIxcvCiHwNLF5xAWjp4nk
	VIS86tMh9qazDQaFqb2qYr0+3dl0pV1WHNyatUzkJIJXjWD+7vAwUKR5O9NbE0VO
X-Gm-Gg: Acq92OGqlmaMwTNpZ8R7Azcpq0yE/wm/U52hBhEOtS5OLMcNIPG2Ts6BxRNXJDkAvZj
	UdKMIaZaTRWbs7ekprJ8trfjdbXNQ5lXqoUUtR8t2ocPMNyPBYRnojHmC8xxhYUHLsTRLnzF1ls
	FHcPtqiy+vWlSoujEJm6WLVgy5VCo+uYvgYvE6xnsvJMsxCdkAJI5ZCGYPHrEG2+6X39pQZsYgA
	7w/pP5bid8TRstiQpFnlUrrplrfUkphYPMPkWZ4x5gBvGMr0J+LFzgo9oJRkjQwuTw23i3tcGXX
	ZjQPjwwoo7LZtPjL+FMz15Npyw1COmQrgNW5gnq/CLDTCupIDzsxV1FjGynAESCzG7h/Ln0k5EH
	SwYJtZfInu7Dwwb76oaR3o3GTQcmPOQBYmtwsxWs4pluuPuguzTK6vvMQ6BaIwEeGhDIBSXRrbV
	LEnSwJj3b2MMTCTvSVLXRUk5+pe7kkpSVt8857xgtSvGBGgvlsXpUep5aa1aeEARZofUkPwEqfP
	VFjEO7DrA6RT2ojCGtyGuGIxOElpDsn2kosgfic3A==
X-Received: by 2002:a17:90a:c110:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36a67616959mr14192750a91.23.1779706301802;
        Mon, 25 May 2026 03:51:41 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:51:40 -0700 (PDT)
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
Subject: [PATCH v10 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Mon, 25 May 2026 16:21:17 +0530
Message-ID: <20260525105127.180156-2-piyushpatle228@gmail.com>
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

