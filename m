Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832D477E53
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512588; cv=none; b=DxdAX0W/6zdwByc8J1FkuxUahizK9yoXiqNWv/GY1jZ32wG/tf67fmbJ4OVwGjmbt4036dfveJUKEz89tmLPcGAF9rjOiIQDlwFNOXso4x5lE37zDV6eHfJhQChGGijJGUs3C4ztWipLmp7gQgSIwMChSwR1fFOmFZ7MG2PzvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512588; c=relaxed/simple;
	bh=aTUwaw1cZjKNO7pd1qP0S4T7HG4+2wRyJbUWydgN08M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhJ3sC0QkZ/0UlXPds9u8kInD3jYX9wQq9sO0l3fMXbZKfqKN5D6j7Qf9IDs4iwShn4ke+Z/zqYZHS7o7VNmfBNxfsL5lhJU7gkysBIfYicx7Xfbz7LUrXZT7fcObEpn/YPSpX7V7y+6rNOB3n2oi8qiO8JxWxl4ax7jECYQy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSiEW8bd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSiEW8bd"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0b944f6edso42604955ad.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512586; x=1781117386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4zRyyXIwuf/G23ISEa4BernDl6SyQJXsQmJd0MnDOM=;
        b=nSiEW8bd/+kurQ9McRdcCxFT/fu+6tyHdX8n4y5o6yesGCFGLNsRgGzxNR6QVqeYdX
         BLR1/UJvGtn2UxC3Ne4rnHM7l9aUgB0iMVepd+cUPDK2Fpe8GFjsHUBbje128eTlbBnz
         3C+tKnehPc1AH8JYOGG+gDCSiY0WI+0K5xXEBX0n22tPG9QQ8H954/O1dHtqi088zYu8
         kz+3xN+F1D/xKEehWIRA78gPIACW2sVOE+juei0PoIyVmPcmKH88SwrcUOUhVxTjrwah
         AH8hY29FGdkh+aJEXkfng1jfG0PENceoUVa3oXC8hZ0V1DgfW0oilsct8MT+eIUN/Y8Z
         LWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512586; x=1781117386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4zRyyXIwuf/G23ISEa4BernDl6SyQJXsQmJd0MnDOM=;
        b=Tsi/SO8wk6sFDmss3fxiwe45lrldUtV82xnjwrBL4/z9WgRXlYOWoYX4m+IRVTW247
         Jvdx3eeLbUM8+jKz026dAOssIt1khfqZB3NMDKrrZrOofd9pJhOUyqU0rBXbb1AnJNte
         nGrrPe/9ASaued3QB/QlHFjr0q4PSysPe8RD/YA5jSqtwOP5Bcy1GW74w7K9KKsORIFx
         v3aBSCEeHPvuGKtx5t1J17X3iBU+Qf+aiIRaB5bEseuxtObKG5qfxWhfebIeEQGAeDhN
         ZBWECJPoZRRBZ1ib/aZ1RSnLyu5oP/S6N3PoGh9FV9THh+m9dDGliEqcHa2esdsdzpSJ
         Tpzw==
X-Gm-Message-State: AOJu0YzkfvEr2KvIX9uQXDiUgsmxXscLuroGj7J2p64tM7k+8JIy+ynW
	cmPpF+kyXLpc+dAISQdFIGAeR+DV/1GgFUcNrd1UXpM0a489MT8s7qTqzjF3Hw==
X-Gm-Gg: Acq92OE7Y1n7JKGeCNKFWFzKXGJY1sibLy1adL71JrndVntyifAgJG5tr63SmM6LwM2
	f6Gxfc1Xg0BEwRWZLskAcd2udDoBuqPH/tjLmKu/36i3MvGdbX0+EotnM6teY1cLnyFCyNkW1DE
	VteyK0En++i67YYhB4i8wW6aRS0LgzOxHwZ83jMgbznxcIFnSu7URxQsyqlWkgLdMlq5PiffLMk
	aKKZ5v0T0wvSjX+y7jHxeu554mYroSl1cNSyHrnFdV7b4wc4sMU5wtd//UDUDEYeuBL3T3LFVuw
	Rsx8OrEUQqVciBTCbueKvfj9q0OhFaEe6gmUgBQqZUZJhZFxMhuAix+EKtLHXPLI5VqlvWdI0nP
	VVxAtd+D5MA25x5hWiJkHQ5djxWcu42UpFwNZdg0ZeGSWS5pbLG74c19cD0HEksOP2GWzoUxQ8d
	/k18JtXAAAzbxOUqQd9KlWtPDS+Ho5LzQ8H9sifujWg0W6eyYCnqwuL0PSfDJU/4+A+1IFbtmTw
	3HThIq+GpAFBqc6cDFQaO9c+MvkvPMb+wWiXDM8IKnsW8rn38+/IA==
X-Received: by 2002:a17:903:7c7:b0:2c0:b35d:ed49 with SMTP id d9443c01a7336-2c163a16197mr33072265ad.2.1780512586078;
        Wed, 03 Jun 2026 11:49:46 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:45 -0700 (PDT)
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
Subject: [PATCH v11 07/11] iio: adc: hx711: pass trailing pulse count into hx711_read
Date: Thu,  4 Jun 2026 00:18:55 +0530
Message-ID: <20260603184859.89693-8-piyushpatle228@gmail.com>
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

Move the trailing-pulse selection out of hx711_read() and into its
callers.

This is a preparatory change so later variant-specific code can pass the
per-channel pulse count without adding a separate read path.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 10ccc69f209b..30e1ce321747 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -155,7 +155,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
-static int hx711_read(struct hx711_data *hx711_data)
+static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
@@ -174,7 +174,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
+	for (i = 0; i < trailing_pulses; i++)
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
+	int trailing_pulses;
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

