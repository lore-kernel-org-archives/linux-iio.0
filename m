Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A83AEF26
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810211; cv=none; b=PnhvA+wS8MBMl26PvE73NeG1GA1pn4bDFV1/QTSMD/osfm2mKXMlpWB/CQIUuNAy+KeQLhsel8cOUXpTgU6ywQSt0vc+SU/ygIUT3Zj/Ot6Akuwx44yiw4jViwTev3zF39QHWubDGIXanAws0rIn41ECeYECWoB8ikByJNu1aAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810211; c=relaxed/simple;
	bh=YzJ8RosHX05iVdAZ2STTIxyp1FpJncO7Lahr+HQeVvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMx/56cG82whwTkdHAASkwulz9ERp/l30bEEKTW+5i9RuhmvgvYqswEmq49q2X41xabtWw/n2XlEbhVbMOhFk04KXdJ5X+gf0oABg6mOK3HoQQk32fo7Ur69FhIfoApvAePtxJWklSj57E1SEo9lDBsRyoeSZ3rECU1kBOTWt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvDW7+kv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvDW7+kv"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-836ebdeb969so57422b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810209; x=1778415009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sJO8jnVqdesIsdCxc3bQ/uGr2AUdTF8/iD//ahP/KE=;
        b=MvDW7+kv/+2iWgcBQCZYvyM0ys2Q1/2G4/elB7Tfspjnw3xvmt1rn6/TasaaloDBia
         nwavCzR9mx5u4XqMXSH+ThUfFYrzc7XwkTAq+cm8+MK6ozuvN1P/DzZrxpQ6vLplAAeQ
         NJ+MNnms1rLRk5GfzNvUuRucDYM30J5l3paonr9CZD9NsBDyxM/akWK+q4trlIydfxGF
         +cz1lPXatZfb/vkFjDvrC+P/GG5OGnDK16f+H61GEvn/Zv3iIrfE93huG8HvDQ/dPThX
         qpZWyVM6eyWcY57ZF6EDDeQHQ4hnhIyy2+cdKcbuVXLQHTUHg5MRnk8Er/ONVSRtAhjz
         +lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810209; x=1778415009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0sJO8jnVqdesIsdCxc3bQ/uGr2AUdTF8/iD//ahP/KE=;
        b=hl/df60w3FvsyTYBDqFSdIIdE5doda+rbhmwcDQY094eFsTKSVs/MaCjrySRx/uX9g
         9aYjeubS+mhBaSp5NYoQuTB2iJ+xj5HMMiyw0RZiBGnM4j7SUqWFYr5bhD2apMTA2xbn
         McQ65G2m07+FQzJe49P9GAqzSgpdf3ms6LmNf48ylPqJ7xx+jDBL23oZe1rCSDrdvY7d
         +MQKl/jGYlndRD05v7aFkkiBjXttnzsFxqQ1MLQEGYOTs+st7mvuxCHXLfs5rRtlN4o5
         so8pOKptqiuteUqUnmaUoHR8h1qVsqlYK9uWU2CgzK9Qm+1PbdQln0t1emZSaq9LLdwZ
         VxMA==
X-Forwarded-Encrypted: i=1; AFNElJ/VtKpsCjc1hKrYQqlpaTfEXoTr3WSYDYVsiyX5vB+7Y8d+ydheNyLeJ/9XOcNIBKcOk0vEX2/M4HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcENxbQ6rb9NXKKQgzLbZEnZ9pQQBJ6D5XfiJh7RF6ZH1ts9r
	uv5ihxDUd25iHtR9D5dbQrqVtQ6ktRHJX3oqyMTOGpSCtP14LMYW74v0
X-Gm-Gg: AeBDieueXcri004Gj+CIwYf82iScnif2b+02Yld72VF/hmCxpsNkS24bzONC2JcZteU
	meldGFubwXAiCTFeKcXZIWIkuMM8H7QMTbuKuCfyeyzzqY0ipp+DT1om4Ljxgk3z945fOgyZ1Gm
	G/lZug2uHmEEGSISp5USflrB+uYIBNSHeyWJXy45WAVnEllJqXv8/qTlpFvkmhcvts2faGifKFW
	fYY+qXozyJndXYjOwdOPRzokvQRKAPnHDcs9mDTZG6XlZ8N/oFR5eTRPEAISHsTC9bUa7+l/Skp
	WPcJmndsWMUib9/+ZCOtPqexuURI/AVSxyToOYT7lkQr/LwcmH4IrG0AJuisnyqYGTw1Hgs61N1
	B4yGgrZ1xZ7GY6nHW9tJ09iu6VnlYMw80kWYg4Sp8cMIqRKWUEBg5Iu6jbqdR4m1N+gQj3buCcK
	BCUaC7Q4Idc7vc1FsRLiQ36MVYZjqL3XOoNCOvUYCT/s+cQRhIYT2RAIYiqNrwbjMtoT1P46nul
	Kd7fiVc3O9nzoapDRiep7RCXQQ2BgGgyEFrYLexpe9jP3n0WMJx82cFftYgM1x1QwfkwdM=
X-Received: by 2002:a05:6a00:302a:b0:82f:316:31f6 with SMTP id d2e1a72fcca58-8352d202921mr5662327b3a.26.1777810209269;
        Sun, 03 May 2026 05:10:09 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:08 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Sun,  3 May 2026 17:39:30 +0530
Message-ID: <20260503120949.80292-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
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

