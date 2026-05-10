Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E03196C7C
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442714; cv=none; b=gwyGHNwT97RxgI2zXy0Ml9II3Thdsj4PYZpBrXJ9QapNVKdlGmsFaes8FZfVWALZiQ/nUosbTlMXCN0oWeXg4GsXR1ULvbBImzrbo8TnFUwbOLXHlqc5bEyHf4wDmdkQpPJ2aLPVjobp3UAkcQvcXaixZ8aRTcLeXejM4eoIJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442714; c=relaxed/simple;
	bh=cr1rruskqrpDMm8vtb6PFZLYjH/f4H9vvTNeJg/pD6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q50ZnDr3llATGlOM7uoovBoAbgAERm74P//m7UYXwTaXjMJ4ykJ0QeO7/R8DdmaKsLwXmxNShn3UxX8wkSBwzXbyZDJ6GH7UEMC4b0wHiwRBbkJrsZkGNUqThX/ITV7ojRY3tEsPmHCTunewT83j9/Kojuun+nWxKvZI8PCrvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXZ4dwtu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXZ4dwtu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bcd3ac3307so168645ad.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442713; x=1779047513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVRBNZkgMu/b9a/cyt6U9gVtDXz/XCuTMVxHEa5XTmA=;
        b=IXZ4dwtudzrd2aNTOYi18P4OOjxYS0kx1KQuu61DtuCaa+5OGa4Pqpud4iwIpjsRD1
         NhNPLcS7IjWSZ3ZKiMMWtc0uUnUFLunnFCmMe3oLKeubPjHnaN/Uh76w2g/B+uEz7udP
         iBPxy7gE5CwOUoWRe7GY6PJbW/jXzt68viHlRkuFT9+EtH6ZYbGOn2zUwfbj4kFitL5G
         wGTuAkeiN+3urvYJkxjtX8muP61ziha3s2JYdgh3qE+YqVbJBvz5ueG2V5Z89kcD1+Zp
         xYPKjDBwTkjshiAUXN9J+RMjuX4M+cppkE/KZ6yRhxMeZ5DBfN6CMvBSMjGKOPcmtncE
         E+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442713; x=1779047513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVRBNZkgMu/b9a/cyt6U9gVtDXz/XCuTMVxHEa5XTmA=;
        b=o63y5ZZEmrjBnVHwYop50WbMNuNEQuazM9nFwEUOuAApbXvaVxwIPGkcJlzLcfk7qj
         r3XxJqWPLan3TUNKm4qyHthr9U8Q2Iy8zwwgLjdLFTmrWYUunx2AYkvZ9aZG0KbxnrYV
         XytQvxn8b1fyA44CnbKtEEb0oFjc0DKBYijM6Sp1vQ4badIy5UNeybCaCzvkBaT8WNWE
         dXFRplVY4DM4COBhm7j+PAybRM3k7jYpu0vik9SYnBk8JvqEZhJKnfPkYJMIwp5bc9BS
         x8Rg5t1rkvYPp8EYEGXD/KZStI9zkoDrQKfWptvwtm0TQsZRTs8lYSnvx5yyLRjVbfLF
         ROkw==
X-Forwarded-Encrypted: i=1; AFNElJ9v/HQcl3EGw8OA9cDPQyxXoKE44aO95vhDc9t9QkFvS5Z9OBqpQ+zK6BcVzHhJordx1esXz1fyPLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtegeUyiPfFcgANfZbVJLSLETk/rzpeM24lw821foraBwT0fh
	7nnH9gmgHz7VtXR1vSGDPgWwhLA10Wz0qFQMOHRmqS6BjWSpM9AO4odp
X-Gm-Gg: Acq92OFRsLclx6QrnbscklhUQ6miw9WkQXGOPFlbFAG61keb8XFa+n6qAiHdnYqDeb4
	sV/aJQuTxUyhZR3mMfqzixz821+NPZ2lyYUnWtQp1qRE1Uad/ZWVXgWIZYsZnHAluOY42qqIW6c
	fupuCMqeVyRwJGBitqlew2BqgwGKwFLU0L+/CtvwDysMwRdVlre8Gi7NXHxPyK9WfCVXiDpKztf
	xSYaEVT2XYpD9qPYC2kp5l9bYfNpShb1Ld3X2IXcGQzv2cGORUqrkP9qHlIWglnnO+0eqCqISBv
	arye68Bv/BvaDLnvN4d/WcJKfRkOcEONsULh4asF87GO0LNgqtbaBM5hYgQ21nh0k04DuO3dYj4
	Zwh+2R8NZUVBvJ24yEuNft3ZWgph2jhGAVAdVCMjOogU6am13TqR21NALd8VTopXZoFQgSwDZwG
	hKGrr83BERsFwynoz+qX2Ea5emrivcM5MKJwTkZ8hZfk+mB7gTyIue94+oJ5KjfLMSW/WLcW85q
	LphyOFxLEbTRqCK6KLev+6yfqw6816KDWBtiNEBiUtSruI9RLxa6Ap74pxd
X-Received: by 2002:a17:903:28c6:b0:2b9:4eaa:7153 with SMTP id d9443c01a7336-2ba79c0b87cmr147797285ad.19.1778442713070;
        Sun, 10 May 2026 12:51:53 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:51:52 -0700 (PDT)
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
Subject: [PATCH v7 07/11] iio: adc: hx711: pass trailing pulse count into hx711_read
Date: Mon, 11 May 2026 01:19:29 +0530
Message-ID: <20260510194947.31997-8-piyushpatle228@gmail.com>
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
index 331d47e1bbc4..24be690c371b 100644
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

