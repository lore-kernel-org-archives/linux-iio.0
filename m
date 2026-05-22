Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56203B2D0F
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453268; cv=none; b=q7mjEzhVDsN4BtpWAcZi0Hmmrun80r2dvACQCHKAPPisKMp4g6o8sh9UYSCGLn9H/krDZLcRFAdKSYdz3RGOvlI2IzIE8z6z7HElPE2Sgl2dGwQAHAZHW7sOILXBVAIBlfsvYLbmnFu+MZ647xBk0QJUn1E7M8TjNzpJa6YTM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453268; c=relaxed/simple;
	bh=QTwwIZ3daKW2YIE9q8isjc7HvcH9QXJgTw7t9zS73yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6FVzZcFvhrUbjAb/PDgWFMMboZRwNsPrBCe4DaSlFqInnnH5aRbDkzeQHyozznHlRf/3tjLlJEpV+GyGkZaB5tXyBznE/E2C5ebLTwJ9Xpd8UwBZc32JoaDG8AH8/RDY9hd9iqJOZxyJHp5hf8W/K97YldArnA7O3Iorw4RAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3QwBlgM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3QwBlgM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49040362e4aso12884915e9.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453264; x=1780058064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvWYIXbd/e0R7bVN4oKYfFF/4Yc8ZEWPnmStsVTHPPg=;
        b=n3QwBlgMqQlH5KRyVT79lah5s5g7NEqYYPujrfAHMBZlbHcQ6wFWc1ZUOyA2ATREi2
         NlXugKLLs8P81BUFyx8qO9/2/3+5bp2zPotbYLUAfZIiLOsmFuqcTCg3ZTjOoUvwuTHq
         n8pWNf5KYlblbBa6WPAhM2wnfISKZVxd6FCL+/ijtORG2DmMsO0RMvUwijZ3BucQ8jJR
         ryv2O8hwTyr322L5c26kZpXodDx0r4uVZFt5nCLpnz1XQvub7nQQH4WVR/HIOPjGesa4
         bThmyQSt+FC4d/PPOCNYc6CD0VhhxDx/21Od3mbw7Rt2a/fLin3TLKuUXIkHSWkQcFF4
         eIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453264; x=1780058064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WvWYIXbd/e0R7bVN4oKYfFF/4Yc8ZEWPnmStsVTHPPg=;
        b=cPsO/xDcqPngPbMWgOtW54gZzDMAvs0Gn7HEg0fWhH8xR+EZA/06CTzmTVUCbAg2q0
         nKAaomQud62Bg/hWnB+RBdHrT4xSd+8iF3Qh2BOCnjooQG3jZaUvKlAz7gRlbsa2fVea
         88xynhExrZ32HfSBsszE5269IsvRfGOn4h9BAY8V1xSbwPwPX065eIQDvij0p2+jTlv4
         7bh8UNeo+o0pDRxuwgIK/sbY14vcz7UTnahC2faFLsLXyahlkVYG5ldAwDzZPxbJ2Wmf
         pY0meLyxcLPiiPx80n36JMm2wLECkhW7RCn84C8iY+3DJkJMfSrpjxvC3L6SSRpm9s3w
         OEIw==
X-Forwarded-Encrypted: i=1; AFNElJ/z4EEwvX27+5bssvuAg0NGsFcK0aZq1K7UApCRiY5nZoMBIo2H3QqVOr2II8gPAIkL1ee9dI0bKtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycroYV6dnHFzkJCvawAOeeRbipNW6wHUnufuhX9yLBy+Rbc9Zv
	2JP7W7bNOi7RdEytAxZ4fl6FuD9Dx+3ok9I7hErCk7+t14QpaRj/VpSK
X-Gm-Gg: Acq92OHFcOynwNnS2vSO+CWA1pRUXWqU6Cdhq9a0eGicmn6mYlsGNRZGfITOvN5Q/d5
	d0fFhdLrYH2W4C7pzuqexiooeie8G08xq3KqO27ibVoBYoX5FD9+b5FUjOPTW29iILGER8i51ck
	uS7jXdn+8e2vt9wksIy0IpK0OGnBEba0WLltqQ8q03WzwjFQA5lZ82+sSLGsX2mKWjoxWeSP17S
	XxXSuM991Ul1ccGtt95VcYOVlyqEYAX/k3CTB6HTHmfLBDkMO6jLWUP1/bXKmtoD0RLWrwf6v9T
	JhNEVjFuuKNijxrJZrTQYxLpbl5EyUinw3FFPDBTX8VrfFlTYumXW6nnJF4nA8z7UdiCnof3aw0
	CkOfE4MZeHOpRb5P3QBID2ZTNKPBUFtO7kjhK58jJw1Q+a8ZoqpB02wq8yn1zY44FOrBvieHqH9
	xSbE5IlxcGt5leGJssB5cwpW7WTP9WuyrqzTBnYaogKo+qXWOYzHS4
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr52827045e9.18.1779453263971;
        Fri, 22 May 2026 05:34:23 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:23 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 3/8] iio: tcs3472: convert remaining locking to guard(mutex)
Date: Fri, 22 May 2026 14:34:14 +0200
Message-ID: <20260522123420.45495-4-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert several functions to use guard(mutex)()

This avoids manual unlock calls on each return path, drops the goto
in tcs3472_write_event(), and removes 'ret' variables only needed to
return after the unlock.

While the conversion is in progress, take the opportunity to make a
few small cleanups that guard() enables:

  - In tcs3472_read_event_config(), replace '!!(...)' with
    '(...) ? 1 : 0' for readability.

  - In tcs3472_write_event_config(), tcs3472_powerdown() and
    tcs3472_resume() use an early return on the I2C
    write failure path.

No functional change.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- Drop Suggested-by: Andy (inappropriate tag).
- In read_event_config(): !! -> ? 1 : 0.
- In write_event_config(): early return on I2C error.
- In powerdown() and resume(): early return on I2C error.
- Remove stray blank line in trigger_handler().

 drivers/iio/light/tcs3472.c | 76 ++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 1803bb882804..b31714040a02 100644
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
+	return (data->enable & TCS3472_ENABLE_AIEN) ? 1 : 0;
 }
 
 static int tcs3472_write_event_config(struct iio_dev *indio_dev,
@@ -327,7 +314,7 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 	int ret = 0;
 	u8 enable_old;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	enable_old = data->enable;
 
@@ -339,12 +326,13 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 	if (enable_old != data->enable) {
 		ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 						data->enable);
-		if (ret)
+		if (ret) {
 			data->enable = enable_old;
+			return ret;
+		}
 	}
-	mutex_unlock(&data->lock);
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t tcs3472_event_handler(int irq, void *priv)
@@ -445,16 +433,16 @@ static int tcs3472_powerdown(struct tcs3472_data *data)
 	int ret;
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 					data->enable & ~enable_mask);
-	if (!ret)
-		data->enable &= ~enable_mask;
+	if (ret)
+		return ret;
 
-	mutex_unlock(&data->lock);
+	data->enable &= ~enable_mask;
 
-	return ret;
+	return 0;
 }
 
 static int tcs3472_probe(struct i2c_client *client)
@@ -583,16 +571,16 @@ static int tcs3472_resume(struct device *dev)
 	int ret;
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable | enable_mask);
-	if (!ret)
-		data->enable |= enable_mask;
+	if (ret)
+		return ret;
 
-	mutex_unlock(&data->lock);
+	data->enable |= enable_mask;
 
-	return ret;
+	return 0;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend,
-- 
2.54.0

