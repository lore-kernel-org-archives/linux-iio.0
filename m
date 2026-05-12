Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889C3A48D7
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625143; cv=none; b=mRmqdJyUOgbBCr20kKkt3Ch6g8xGRBpag4g3FpDUffK8erN0slLOA9UQcW+Aj3Seo4SDafmbpingmyFxN6Z0QFQEK2MlCDVkDqPyBn1rgsGPJjQ3WWhKKYHALr1TkvMJIL3qmzhBmp3j/z+hfjcQgybo7+sByLlC6BJXYSlMpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625143; c=relaxed/simple;
	bh=DNK7inRudWsaUqBHPSR45m/wvD/5KEr6IJFBUid8Gko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJzAva8WV4F53TGT5ijS4HL226p4t/Uo/L4hsGo9nXAU2CgV5K5C0Z68yYYUtDlZWbbIbZlev5jQUG7Ywu54DWE+S9xhG8LHn3HP9Q0W4YE1r564ur+IVoxHAYRZ+ZB6Jq3Wqi4qY61lvxIuVfiKMf9/542iZmQ46cjUjaag1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p73LGHaj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p73LGHaj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso69766435e9.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625140; x=1779229940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETFxcyR7YLkUpkcr49E9UXvV2AmU/9yjySW5RDZ5mvo=;
        b=p73LGHajkupR4I9a0pThFvtyUNijLsFM7EzLu/+M7U3CCiBROw4zXzRL86HShIcO+Y
         tJhu5EXgDygyceYwiMTMGzi+xUKtRMitZXkzBWkgZwfPjXmTjc0qBEGK4Yz+OcnY2/Ll
         svjyviE/zXchPxmoMxe1S2H/zKO0ZSqRYp6qPZ03EE420VXKjsPwukJ/Wjk4Q9fIPn16
         M3WW3IiTOXawOFByKMCcjSLViBHSxMq4wabK5Zn/o09FhUoAdh60sDRLV0BhkBm2KNQY
         puBnP7txNiijTpkK2CtQj2KMVQAznb5A1N07L2h+pLXT6wk/334Pge1SdvQdix1314KP
         jydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625140; x=1779229940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETFxcyR7YLkUpkcr49E9UXvV2AmU/9yjySW5RDZ5mvo=;
        b=cyhNb+RQHikM4hUmUjXqudrp9Xs5YiZ6N2S0vq2dKu+OoyO+6D29FuMvw/0wBzOLEJ
         Uk3DIzyeR4Qex1fMs+2webOnj1BKHC06SDDGjG9U7M5ee+57RAOJa5EWzP7eK/Enm6dJ
         ed+oGribLjlLRWDcn0qGB+9XNAx6/M84fVjkYaKErohtftax0izGSxoKkf8BSV0Rapvd
         wsioszccv/oMpYQpkl8Qb/ZTvXsFIq7edBsAqJ5FQlKJ+ZbPu6hCZu8Jo9bardTZRhLl
         CSXtyDYZSrj1gY9tEpvvJZQAEjCcIB8w+w+FKqBUfSIGFBfsSaviey2kWDNfFgGmAHkN
         200g==
X-Forwarded-Encrypted: i=1; AFNElJ8b4PoB8sD/B8jeG0CTmofw9YjB1aIAYnis4PzRJs/S/+5bWtaHsEuAG46lmRwJaNLXCrYub7uqiKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXeTdvpqVQ6tq52xhKjSK6Y76lRBdbFpGkr40gMwg0elz0VQ7
	Vu3e4bMRVhUFmeQ2nJShLgC6UBEUSpwGR4lkhweF5/7eLY6QcqSK353F
X-Gm-Gg: Acq92OG7TLbm2105F8OB/y/w9WVeJjQzQRRQGiBSgy6Vvknf/wc8o3PTNhA6hLG2tyG
	X54ALtRVJSS/DqpW+F+lALZVCwQbhd9XPh7QG3NUNHzBV7Vb2TuG4A3nNJHJEMdnq/73+eO/86H
	mEhU4vPvH69kq4eEdVM3cuTQ2vufQk2yJPhnBgh4I+UDmityDBT5wcsghbrg9maOGJ3hgyDpP/t
	OgS78ZzUUZzr8dANYRKfvkXCxNaVyGqrqaCcdOhOEVVSnxCYFtoCePAxmLBSNwdtJg2B8/WRPVc
	niKjko9FbcMlx7ZeVB8eVtC1+IX8geRnpRDiG+YRTUQSV33Qig7DpMX94FDnWwSDwiJmGmdh5Kk
	IZYHUe5gk4TbZkL1u0XiR0khy229GhbO1vjRRXwZhCbFPYHYFRmJTqp2GcPz2vEOSgNwv96Z3KD
	mXcVlSYd+mftE9OueQb/x9/Zd1YKnN/e/3wGiLbEChLEt9qeTwqipQJzw=
X-Received: by 2002:a05:600c:154a:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48fce9da5e0mr508025e9.18.1778625140226;
        Tue, 12 May 2026 15:32:20 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm47377375e9.1.2026.05.12.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:32:19 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 2/5] iio: light: tcs3472: convert remaining locking to guard(mutex)
Date: Wed, 13 May 2026 00:32:12 +0200
Message-ID: <20260512223215.25596-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512223215.25596-1-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the locking in tcs3472_read_event(), tcs3472_write_event(),
tcs3472_read_event_config(), tcs3472_write_event_config(),
tcs3472_powerdown() and tcs3472_resume() to use guard(mutex)
instead of explicit mutex_lock()/mutex_unlock() pairs.

This avoids manual unlock calls on each return path, drops the goto
in tcs3472_write_event(), and removes 'ret' variables only needed to
return after the unlock.

No functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v2:
(Suggested by Andy)
- Moved earlier in the series to avoid introducing manual locking in the devm
  patch that would then be converted here.
- Dropped "found by code inspection" (this is a cleanup, not a bug)
- Test details moved to cover letter

 drivers/iio/light/tcs3472.c | 59 +++++++++++++------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 9b0f64cd9c50..4fd4fd74d0d6 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -13,6 +13,7 @@
  * TODO: wait time
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -220,32 +221,24 @@ static int tcs3472_read_event(struct iio_dev *indio_dev,
 	int *val2)
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
-	int ret;
 	unsigned int period;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		*val = (dir == IIO_EV_DIR_RISING) ?
 			data->high_thresh : data->low_thresh;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_EV_INFO_PERIOD:
 		period = (256 - data->atime) * 2400 *
 			tcs3472_intr_pers[data->apers];
 		*val = period / USEC_PER_SEC;
 		*val2 = period % USEC_PER_SEC;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int tcs3472_write_event(struct iio_dev *indio_dev,
@@ -259,7 +252,8 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 	int period;
 	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		switch (dir) {
@@ -270,18 +264,18 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 			command = TCS3472_AILT;
 			break;
 		default:
-			ret = -EINVAL;
-			goto error;
+			return -EINVAL;
 		}
 		ret = i2c_smbus_write_word_data(data->client, command, val);
 		if (ret)
-			goto error;
+			return ret;
 
 		if (dir == IIO_EV_DIR_RISING)
 			data->high_thresh = val;
 		else
 			data->low_thresh = val;
-		break;
+
+		return 0;
 	case IIO_EV_INFO_PERIOD:
 		period = val * USEC_PER_SEC + val2;
 		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
@@ -291,18 +285,14 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 		}
 		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
 		if (ret)
-			goto error;
+			return ret;
 
 		data->apers = i;
-		break;
+
+		return 0;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-error:
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int tcs3472_read_event_config(struct iio_dev *indio_dev,
@@ -310,13 +300,10 @@ static int tcs3472_read_event_config(struct iio_dev *indio_dev,
 	enum iio_event_direction dir)
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = !!(data->enable & TCS3472_ENABLE_AIEN);
-	mutex_unlock(&data->lock);
+	guard(mutex)(&data->lock);
 
-	return ret;
+	return !!(data->enable & TCS3472_ENABLE_AIEN);
 }
 
 static int tcs3472_write_event_config(struct iio_dev *indio_dev,
@@ -327,7 +314,7 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 	int ret = 0;
 	u8 enable_old;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	enable_old = data->enable;
 
@@ -342,7 +329,6 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 		if (ret)
 			data->enable = enable_old;
 	}
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -379,6 +365,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 	} scan = { };
 
 	int ret = tcs3472_req_data(data);
+
 	if (ret < 0)
 		goto done;
 
@@ -544,15 +531,13 @@ static int tcs3472_powerdown(struct tcs3472_data *data)
 	int ret;
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable & ~enable_mask);
 	if (!ret)
 		data->enable &= ~enable_mask;
 
-	mutex_unlock(&data->lock);
-
 	return ret;
 }
 
@@ -581,15 +566,13 @@ static int tcs3472_resume(struct device *dev)
 	int ret;
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable | enable_mask);
 	if (!ret)
 		data->enable |= enable_mask;
 
-	mutex_unlock(&data->lock);
-
 	return ret;
 }
 
-- 
2.54.0

