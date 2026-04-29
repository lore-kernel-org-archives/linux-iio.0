Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16833C18E
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441558; cv=none; b=W6eSZ3QVBBnKLJObTykdboOlqK5Un7rgtFA9HsPBpfMzD2NDNpTq3yjWXjWp0UyOenUq7K7yXsnBx7ZmHA4ksMralBE3Agqr5OYrkaipl947ojGHgjKVSHj8D9b+N2SdEU2wDziKQ7438udJZ21ZeXct6xFu/A20FR+ESryJc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441558; c=relaxed/simple;
	bh=GGF3jyUqforepyERRKXlYZGTHXws9eodKpfONNX7jDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYy5nkVheMLIetTeKk8rQAdaSCCBbyzqXwhA8AxerbD91eIvT8zvWqocFlXFFIMBTZ3pxBT+b+YAsPxJuW0U/udm4snCqXBPb7Vjt45jE+LLQQhY3QE++6hCycumIV9Ps+U9iS5QIl/WBKz5EunrK3l3ZtNqlp2G2DjVT/tbU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpjVsjeO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpjVsjeO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so228943a91.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441556; x=1778046356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7hco1kjJGC/g/8N1qIFMmlsaaKm/pe8oI1boZvWXSc=;
        b=lpjVsjeOxzELV4T8c+fcI5WTbkVe25kzs9H7KfetunlqZntW9J0hJB71WnaZT/ettd
         INbbvSt6riqBQiAheiJ28b9YZneEIKbY9i84DnEdUM/rK5OVjeC6sFjYvl1yEYLzZfha
         EO74D7T+bbiqbGtA2xwb/kHG0GatBvRfxWM1VnAN9txaR57Xl+3wsMBua9d+Vx6yxViV
         OS3TjBmbNP8oLSwhZXZs4qGTq7+qBxQp7HUxzIxJ8AROsFNPK15CS4p8nnqRdThvuzuW
         8m0v+ZNotjRuXVnJRdABbjPkMzJAHvHVUPtKlt83IZYkquD82zVdSMHE6sRMRJD51LaV
         BUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441556; x=1778046356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7hco1kjJGC/g/8N1qIFMmlsaaKm/pe8oI1boZvWXSc=;
        b=CkFe8i1SgnmKo+OsBg2S2ljcNEGXvrm+YUp2zduEho9TwdHTSvg2e/h5LnYaLZ+IRm
         K7RTB2UB5AYwXd94up1xWraDahJp+MzE9W//6uidxfEv0VIl6wAoyjBLwt5XGka8gSg/
         fsnABo4Kebup6lYPHaz5FioRwV67EvsOmoTsiLXKvpxlf0RckN/QhllVUPKKcZJuqsBz
         6+waguiEEMl+eM5je2u1tAcV/Gpdmkl3k6SdPpVjrIA1nBsVCWDTrEyrHkRHL0JoaaH5
         eHSxQypTV6q1VLMTkusqOX+5n2ZNqOuoget8h8o2+pgjk0EpWr3uCLGm1dHoFgx4L1lu
         YFeA==
X-Forwarded-Encrypted: i=1; AFNElJ8GxHfehp3rjIU8jg5uy91gMa8qHecdsVaE3FUSOCkuL6EHOy2J4Q9IVXbPajTLrbyAlixJeP+QjAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLSJ/+VH97slylcFd1AXQKk3uo1cY/cJeltmLNioF9FN/i2jV
	zMlE9BtoYXIhtLqehPM/p+i359HVcf+AwlBriIlVL+dgDNSv3L4Ajomn
X-Gm-Gg: AeBDievLLj7pz4VbiAe2lhQFp0VWYxk81fFymIvzZQSQ7s69VX6Syj5nFep5qxB4Y3e
	8Idu38k/b0w6n2BxF9BmFuns8CAj/RJwDIzPHFlbh/XFvASip6PnBhaIjEDQPjPRniX6JkzQ3Dy
	wtsj2wrOrsEfVcMvQLJqpni1POfYX81UkXvcKcnG9jQBpI9zo0SQZmr7vt/TBux26hvW4sXMmHR
	4W3jr7XTx4hG5vV2fRO5xn65y81j0UlfH0nepE3mx+tFbwNx+MqrSBCEdtlZoM5ue6FsYuEBXqM
	uth2pc2b772RW0ESavuOTELvYf2/3odHpMWODOJynJuKXjtGex9Z07bMWYCyu1YEH5Cs3sUTnu5
	+ebx6FsuYNfw29w8MLFQy4dkiHvpOMUK4S1IzVx2lAgT+TA8/02aZBOPs9C68q0alhR/x1K1BHP
	N4HORTBl/e6doel+UksODjngTZb7OvjAalM8fFgQf+4Ala7MrGziG+e44BsJH/l3y6q1Mth77iS
	TcJG1KBG10Ijo078NRtKKL5Wu2aUYvBs/hAWHPbehBa1r+CNw==
X-Received: by 2002:a17:903:2acc:b0:2b2:4fc1:f653 with SMTP id d9443c01a7336-2b98836a261mr15391085ad.3.1777441556448;
        Tue, 28 Apr 2026 22:45:56 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:45:55 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Wed, 29 Apr 2026 11:15:34 +0530
Message-ID: <20260429054544.123862-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
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
Changes in v5:
- New patch split out of the old combined binding update during review.
- Limit this patch to cleanup of the existing HX711 binding text and the
  clock-frequency description.
Changes in v4:
- This cleanup was part of the old combined binding patch.
Changes in v3:
- Restore the example node name to weight and drop the repeated
  clock-frequency default wording in the old combined patch.
Changes in v2:
- Remove driver implementation details from the binding description and
  clarify clock-frequency as SCK bit-bang timing.
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
