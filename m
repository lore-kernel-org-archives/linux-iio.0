Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2773B52E1
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284658; cv=none; b=DpkzHYV95L0frfje5ooyfC4D566RCnJQv/JEIoZdR6t+av75qy3A7XlzXu3dwu3wLLca9CBKiLWpxjHONtdGVCWBhzObytnXBmgnt21g5wICH0IZrYLhhL9SdlYnHFBXVoXTUQLZAVVoiGsIzJRptHOrmFg3hduNob06HUdIHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284658; c=relaxed/simple;
	bh=TZ9Eue8DFtaGA9w2JAdQeWItg1bP/LcCHgtVSaqBLuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKwAxg4J4PLSVFDlZxz3hd5GMHdi1uKYGBjGBlNzhW0EY+UAtFpUXUlxX6qjUJqjWnXmdowHl6A19izN05IiCVApOMyeGaH8HOTmpfILchA4FFxuSrweQO9Rd7u662A1TlVzCQCClrvEFzPYWTTOVOw2mwc48tbbimDkw2G4N/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgZh5i4C; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgZh5i4C"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3727292b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284657; x=1777889457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bwygt4arcj06fgeRgeONzkm42+D0jSpsT8L72zAuvOY=;
        b=pgZh5i4CU1iG1mzRYftLj4faa80UuYpeu/87RBdO3kD+41vDcdn0rYeRozanbOIbGg
         wJBorDsVsHNCdfUOfj/Fd4ywBSYfcp5m/dzyEIgYwpEm/dVQ6Qkr9T0mqHJ3Gmm63Rvy
         q6bOWt0rR44DKRLeZuokHGWngVw0xgQUaQ8qNuwzXcYePFHdx5yasXGlAxbKprWvwsHB
         xAuRG4dUNjUTZgT6BGI/jwr+THDJFedQDOZ6j/kdrBKkAA0bGefY9AS570+sfmXeUDao
         29b8idY1MxuEKdbkQWcXjyk0TBrwmgt7aefIlBSZ32hTp7XZsjI6oJ8HnT/wD0udbyXH
         CbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284657; x=1777889457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bwygt4arcj06fgeRgeONzkm42+D0jSpsT8L72zAuvOY=;
        b=fnrbgUp3m6VMU3fJLktmY2HTnM0f0OcNeQJAs80ndouynj5WXVeloT+aAR2VpnhZtb
         mnAs3j6rUg8rFzoNDUE4rafCnndpJJKSeU47PoYUVQS86X/tGygLwPZfPIj/+5mtQRGC
         lVFgjCYgopgSWRjNoaoaeGbzMEGLeI1qnql259zNoHj86Qrpr57Ph7mpZPDqw2fTrg2R
         iZAj0RvUe1oHEyWUzrdqBLKOoSPU2tJdlj2hvyDvLeGnoUDWtCx5/9IjCrri4k7jyPqa
         NPE0Gjp5YVxVvuE/A16Jf03aMPYOpKn+7/RAy4sg5ddqr/UnkI9z2zY2Hqn9bBKPF0SJ
         VDaA==
X-Forwarded-Encrypted: i=1; AFNElJ9n+gv0AMJBdK+lpHIiu5Qx9FasmjBteRnktHOp0rgK2YE1KsYMJ9INOwpTCIW1/EkvkXil3QLAVBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktPJl4D5EAaR6Uc7XucqNLR9CFxjBESYW8y0ANx4ZlpWEFzpA
	jFfpSvuyY/dwi4oCdbFXQoPLeFvAm4exnOT+/OYaoKAr9aclm/sKGfv0
X-Gm-Gg: AeBDiet/OpXS5IDwaSQZRGVIpNvXZ1/m7+4v1HTIHJo7KA1P1jeLzEPrAphNySwvDKg
	9h8lv2USQ7paXSlR/I2X2Qbu3JJKIw7VmXoBYVOqaI8qaUUi2FOFxPDAz8XbV9E6Fegm4nVxSa+
	TZ1XHNe1SAA8F3NHVC/ArdeOfgPG5BuZU03q94x7olI16U6B9Jr2MPru0KBN/9qFsrBWvsM7Sce
	WK8Yzmwb0+Amf0jl/ZR2OV4V9iOZ5crLbdwzRMdTn4JB4+lN0ZE/4cgwcX+Ue7Dp0VXUEcuL9tN
	eDyJQMGg+/70zDyvQ3xOW9zfZhQUBwav3FXpsudphSLIdxMOR6lgB26brTRBqhIgkKUb271Bui2
	pOwbNNW+iRncoBxcbIUVp+79Pl5++zitpJI/ukzEcDpGY+oIA1A2fvCOCqrDxeT9+zv0FLp05lc
	r0C/1w8Hi9WH3e8+JvQRMt4fy/ZEWhEHaFneVxGfA9OLC5W+rbmePUg9pJOEYvGlgu8Co5i4mDp
	rcU0N4Waw+65Dt0D99Q8jtoxuN3VoiYFN7ufy8lomALcC8dlg==
X-Received: by 2002:a05:6a00:2d81:b0:82f:24e:6a48 with SMTP id d2e1a72fcca58-82f8c83059dmr45501815b3a.5.1777284656648;
        Mon, 27 Apr 2026 03:10:56 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d016:e577:22da:dc9:7f6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm39534225b3a.38.2026.04.27.03.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:10:56 -0700 (PDT)
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
Subject: [PATCH v4 5/7] iio: adc: hx711: pass trailing pulse count into hx711_read()
Date: Mon, 27 Apr 2026 15:39:36 +0530
Message-ID: <20260427100950.33936-6-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427100950.33936-1-piyushpatle228@gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing-pulse computation out of hx711_read() and into the
callers. hx711_read() now takes an explicit 'trailing_pulses' parameter
so the HX710B support patch can pass the per-channel count stored in
chan->address without adding a separate code path in hx711_read().

Use scoped loop variables (for (int i = ...) / for (unsigned int i = ...))
to tighten the scope of the loop counters.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v4:
- New patch. Split out from the v3 refactor patch as requested by
  Andy Shevchenko.
---
 drivers/iio/adc/hx711.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 2a6e9645f54d..8e77978f062b 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -155,9 +155,9 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
-static int hx711_read(struct hx711_data *hx711_data)
+static int hx711_read(struct hx711_data *hx711_data, unsigned int trailing_pulses)
 {
-	int i, ret;
+	int ret;
 	int value = 0;
 	int val = gpiod_get_value(hx711_data->gpiod_dout);
 
@@ -165,7 +165,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < 24; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -174,7 +174,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
+	for (unsigned int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
@@ -237,7 +237,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set == 32) {
 			hx711_data->gain_set = hx711_data->gain_chan_a;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -249,7 +250,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set != 32) {
 			hx711_data->gain_set = 32;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -264,8 +266,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 
 static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 {
+	unsigned int trailing_pulses;
 	int ret;
-	int val;
 
 	/*
 	 * hx711_reset() must be called from here
@@ -280,9 +282,8 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 	if (ret < 0)
 		return ret;
 
-	val = hx711_read(hx711_data);
-
-	return val;
+	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+	return hx711_read(hx711_data, trailing_pulses);
 }
 
 static int hx711_read_raw(struct iio_dev *indio_dev,
@@ -349,7 +350,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
 			if (gain != 32)
 				hx711_data->gain_chan_a = gain;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0) {
 				mutex_unlock(&hx711_data->lock);
 				return ret;
-- 
2.43.0

