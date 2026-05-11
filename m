Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19A4657FA
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521442; cv=none; b=MZdyveKjimXr548Ini5B5ERdSkUeq03uNUsPgF5psIzsrYm433M0iB7k2b9iUUEgQCDsR61snffbFEATJE8sL35n3k3nA9NtvgB3USUt0yWzS+ieQpdga2h6sAtfkPVubwIGURRyCrWnx53z4o9Y09WV5Mx9QM9vMCmGuMvZW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521442; c=relaxed/simple;
	bh=fGN8QACq5acyX3/tm53OfWk81sTlEN73wII2m7as1Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnrMHSQd1a+5OigE/FVL12rgzNfgvct7uKBPlZbcHy9aLBR3anu1i9LgiKdMVU19ZhFDjDpXL8uwgI/+4vU4wzRwfLDhaL2n65voS7pBHDN0jD9uwZvXaHPECfGJB5pJ0wawD9vv2PvH1S8gjfjWgPwYm4aD3s3EYlCgB4+hRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOmB2kfY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOmB2kfY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba4efedbeaso33003675ad.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521441; x=1779126241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf9rYDctPN9NDbaPR2RYs1zVFeB2pT+PMnoNRzcUIUM=;
        b=HOmB2kfY+aJKm+zAEs2E0bkKsHaWEtpH4mMPS/+/W3VTKEjQxqKNq9wmKqJXbglFEx
         +AaxZuc0t+PI7KN2iJkqRx3rq6YPciOI+Mk5VE9zfJlY9EmYarjN0UpJJgRcxkOxj1JX
         Uq78eqU0ihNCLHMV/nHDGoTyXfgrq2gKRX5S3F5pvem22rxDLavy7ENqW7AEQFZQghfg
         LpDR2Q/j3VdzjTJwI+XwNB9X2DcEeynxC+YitafF1iCNrmWpaBRsqHsXUWA0dBLOqh5g
         6sXGLXj31F+RKlzx/IYRk3vR0RgJZu9nE28jjeY6aUk2h6YMY3MjcrHNWmC5aWe3oKxq
         G5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521441; x=1779126241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yf9rYDctPN9NDbaPR2RYs1zVFeB2pT+PMnoNRzcUIUM=;
        b=ackdUAzBYTM82h516TNGG3Rw/I/1vREdNabfQo41QaZI3OHYGbslRlFdK57Who4lhd
         TS21ay1CNZhPjigf/EGM4c7Q031AGEOpDwfplJWDoqRu5dCkkXkO04HUW8g6DM9WtVgE
         m50OWkSw5WFzD02hiE/LZ4eikZKj6tNCY8ytKcy9nkCD7iBJ0XqGC/5x3+uv2Vh+SuUC
         8uR+k/QHIVxVTk8bA6zUDqP8YTwIcnzyg/jZ3C0IHdEZaRCdElTGWJk8oV0sIL3JFOkC
         KPQv1YeSiibtqFYiwtPpO06p3g6h/QqcMRZ2S95BxAMOcdSyWJabqO6+dQvDYba4U04z
         m7OA==
X-Forwarded-Encrypted: i=1; AFNElJ+eBJruQD70moyi8ppPwv6H4x69va5nSpIhoqI1mYiv9+rhg+fcj9dTOou1grh2W4CMWud7s5WD7OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykh518buX15HWI4A7R5Zv1GMDw+HUwy6nuQBMNZGfpuiyaYuZS
	T9qPsMgpriE6YORQPbDyF0B+mCDLzVUANkFULKxFv78C2Jxsmq3Kt+3y
X-Gm-Gg: Acq92OEOvx8G+EfHT3LkLvEle4eanZ9d844cZCq77WNs7iRf+y65/Usqriaq3r++4Xu
	7Lf6sCVPWvOSQO5+F6pXYhbTVqH9V2WkCg0heu/08QRXAEDjEixaGHPUcSLZMMd0SMCy8gHBwr4
	dVfnXKZf2/+1VoDF7BNFM9QCWAJ6nLk3vTwcHc8doxZcs93h8SuXjUlzfcPiuBD8sHX3f/y4PXp
	5Erl5lHb7nhSqnRVLcSNYyMAHvhMDKPuFhbOQYHkGNAwwHAw8/rV3wBDZMTAYss9IBLCtfWE0dL
	dY/hYjZbFSri+Qa2uk5w/4OWeqNFZFtv9O1ldYf54MJe3nWNveaQgLmG9ocYcxeQ18/ADyWR7e3
	HNFYthHZ0Tk6SCKoBINhSEl3UQP4jDu1VJaI38j1u84xOn6mpYQWMhjAqZsu/d91NfFCpXGEv4S
	CHD/ZJ62HCiU89yBShWPtT6oPO1QQukPVCQfczZyJtijVzoXcysn7Ey98p7nbdwUcLcVuDHBY0+
	XVWp0yCXhlqo0/g2LWtUKl7JJIaZGnFc34419H58ycwbf149ecO+6TbHAcAfmZ4k95c/5E=
X-Received: by 2002:a17:902:e986:b0:2ba:df8c:11d3 with SMTP id d9443c01a7336-2badf8c1b77mr138761745ad.32.1778521440783;
        Mon, 11 May 2026 10:44:00 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:44:00 -0700 (PDT)
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
Subject: [PATCH v8 v8 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Mon, 11 May 2026 23:13:26 +0530
Message-ID: <20260511174342.123820-2-piyushpatle228@gmail.com>
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

