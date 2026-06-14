Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E83A6B92
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443153; cv=none; b=NYD+b3+vDnBEld35ZBHiQejKAmAWSJ+o0NSH+SoSMVrLRsVWNmyHhV/XX7ectBDwNiyUwOwMzwz++rFjGOwKwI1r9lk3JaanuQSUBIp9zgO9LqA2Oes+qT1KQBm3P5MwPI9LKOWmgMMjWaun8nMYWK57EAeUIk6g6siPbJYzEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443153; c=relaxed/simple;
	bh=Qp6Lqng68h9dLYwlv1j6HjDqDQFUhvXkpj3LpMbbnVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5PjYDSHlpOO51emGESLjIOEOhCyVehVk6RS+O1ubmGjeyaeVqGnta5WEwmod4y33GNu11TmfyGYbhM9YBx9DwmD+Dix+NBp38ZOoSpfF589NQHPNKUMp+T9iWXN3TWogNNp4M8s/7vVC8tuSKDK2K4VXT6Lb3wcE5daHe4s9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBnNr6JD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBnNr6JD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso21125585e9.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443150; x=1782047950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nmq9I0xcaZ6mibQuOgSq0p08tYtCtOv85qyrVl70DmQ=;
        b=JBnNr6JD37IkXTpWvHAN6LG1fFJ1/1cvpDMxS5wevNcrIl6Vs9MAvuubVMWTpVDj7w
         HX3+X1Bcgjiat0mdar6QVf6vS/HmeO3mglePVvRd6LRTFr1bI/EPMSpH9LQAWI3kTBkr
         qAu0XznKhMGrzF5lRMSh+vbnrW35kG6HD/3Y779Y5PsvMdX099Dd6vKN3sm2gkYcTGTm
         DUfOkd72UrG8QI/FTCXTmQYL/xdXbRcYoxH+QA9j+mkpvoG1Gj74vvxSr3PNt+Q7C3ET
         0oe69J5UyP35eP+k3v4j2BIw+XH7J1d94QnsYwWoonxPUgRThC1C6x4x5oeGuNLQVAaC
         KoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443150; x=1782047950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nmq9I0xcaZ6mibQuOgSq0p08tYtCtOv85qyrVl70DmQ=;
        b=F3mmhxljtFihtXWOjDpSJiFqMUUy8NJQaaXE4Tb9bw5M0g1L/I73pGCCklKN1jkK3c
         3IgOabovpYSpQr99SD67kBdRJQxiNeaISRDGpIHH8lod7ZXQ706UzrGBjZ0hhKSaoLuu
         ELfXbSC/kgopbMfY9QWTkafdsj7kJm4qL2jqMOPAkeqMA1o5ilQ9bXcifHEZeoG4JX38
         PHCXbFqbmRS52NsGEoVcUEFOa0ZgmSaEQAD4iWaWhuyTogyLp5I4/yNq+hqLtc6o85Ac
         FuRdNxJwlfqQRhhAZZfHNELEDEJ56O3QXzGN4z91eC4cNIv9Sz31XR2coA79gOlx93y3
         3aNg==
X-Gm-Message-State: AOJu0Yyj2NMBmoZPQ3vpJhaDolD+Rj720kLKWUtnr8ECHSH4Tiy4Ljg4
	eVhKMcnxRm+WBo44EnbMGx8vdRPymcXZk2kdInLulMFtDRF2MWlSnaMx
X-Gm-Gg: Acq92OHtn/8HgoIq3ngctPlwIS/361swjwizxgNKJwLzABydemaswQVn0Tqv0nFKVtQ
	3xalI8RP2Qp7KwARGzIAgVpVbJueyt59GRf5pwoTDMAqk1mKkn6ZeTQQLYHyqD2aYenzGpl5MVD
	BBRdUfLk2uP4iDzEyi+YOaI3WMYhGMxSNudPASWydLowtlfd3VWi9UPKlWw5n4/kFJJKom2+ThH
	7pUGw+q4+TiFmKe9aywAQhIEsifU3UXBGu3uvHTmZEhZLvvANJtbTGtn3g972aUBAhQl/SRmHYV
	kZ/TYHF78NYEPtx1XO4lGksYyEoTgaHQVzYHwG2UR5XNmNTPP2q1RjCVhK+tk7qATLGZ6aR6iyE
	1oX3uXiINinDGF/dryamxG6a85liLiIoQR0b47jgOEbTmHl306cPYB5tilIeSBoZGzxJkzfnn6U
	kDrSxOHq6FL/nhyBNbmx7wX7nX2NwdmnM0uGOJi1w6En2hUKfdr0cVEuLCwtOR0SsN0zeaWIBda
	xidsawlDeH+ikjZrk0jveqKSFEXaGul8A4XREw6ZbyPWFujKEw21wUOUjdvJu/wAr/yJ2PHbgSf
	CITj3xDFG/UNI0U4wZx7+l3P2njvXt+67Kq/4L4r
X-Received: by 2002:a05:600c:6298:b0:492:348:ba08 with SMTP id 5b1f17b1804b1-4922007d38amr87831995e9.16.1781443150246;
        Sun, 14 Jun 2026 06:19:10 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:09 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:08 +0200
Subject: [PATCH v6 6/8] iio: light: opt3001: move driver to guard(mutex)()
 use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-6-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=4992;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Qp6Lqng68h9dLYwlv1j6HjDqDQFUhvXkpj3LpMbbnVs=;
 b=jnTgMKk8c3jp287NW9q79qHbfKK8GYuT5MDNYBO9BuPXSrj8saEgF5cif1/UcacihxK/UTW6D
 alPjCEtIH4nCuaNK4BOIJ6bXEhquZNd9FMSpfWurThv6lnpSGFDWs9f
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Move driver to use guard(mutex)() macro, to facilitate automatic
locking/unlocking of resources. This modernizes the driver and
improves code style.

While at it, remove unnecessary gotos and return variables.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 61 +++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 80a2ede91272..a4d626006eb3 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -10,6 +10,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
@@ -477,7 +478,6 @@ static int opt3001_read_raw(struct iio_dev *iio,
 			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -485,23 +485,17 @@ static int opt3001_read_raw(struct iio_dev *iio,
 	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = opt3001_get_processed(opt, val, val2);
-		break;
+		return opt3001_get_processed(opt, val, val2);
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = opt3001_get_int_time(opt, val, val2);
-		break;
+		return opt3001_get_int_time(opt, val, val2);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&opt->lock);
-
-	return ret;
 }
 
 static int opt3001_write_raw(struct iio_dev *iio,
@@ -509,7 +503,6 @@ static int opt3001_write_raw(struct iio_dev *iio,
 			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -523,11 +516,9 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (val != 0)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
-	ret = opt3001_set_int_time(opt, val2);
-	mutex_unlock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
-	return ret;
+	return opt3001_set_int_time(opt, val2);
 }
 
 static int opt3001_read_event_value(struct iio_dev *iio,
@@ -538,26 +529,21 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 				    int *val, int *val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret = IIO_VAL_INT_PLUS_MICRO;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
 				   opt->high_thresh_mantissa, val, val2);
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_EV_DIR_FALLING:
 		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
 				   opt->low_thresh_mantissa, val, val2);
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&opt->lock);
-
-	return ret;
 }
 
 static int opt3001_write_event_value(struct iio_dev *iio,
@@ -584,12 +570,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 	if (val < 0)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	ret = opt3001_find_scale(opt, val, val2, &exponent);
 	if (ret < 0) {
 		dev_err(dev, "can't find scale for %d.%06u\n", val, val2);
-		goto err;
+		return ret;
 	}
 
 	whole = opt->chip_info->factor_whole;
@@ -612,20 +598,16 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		opt->low_thresh_exp = exponent;
 		break;
 	default:
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_word_swapped(client, reg, value);
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n", reg);
-		goto err;
+		return ret;
 	}
 
-err:
-	mutex_unlock(&opt->lock);
-
-	return ret;
+	return 0;
 }
 
 static int opt3001_read_event_config(struct iio_dev *iio,
@@ -657,7 +639,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
 		return 0;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
 		: OPT3001_CONFIGURATION_M_SHUTDOWN;
@@ -666,7 +648,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
 	reg = ret;
@@ -676,13 +658,10 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
-err:
-	mutex_unlock(&opt->lock);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_info opt3001_info = {

-- 
2.54.0

