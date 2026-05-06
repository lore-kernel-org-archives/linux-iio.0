Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BEF2F745E
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101593; cv=none; b=og9VRP1yp7fknAtt95dhLYZhNya4JOPSD+yxJpQHWG58CVgfWEXScjvgueIuJ2pHSwd0TGhKHUyB+DFJiOdighI2qIsRow1+gWlFV1XMW4KRJ3t2hnBgSY8vK4oWPO4fe166OgtaLalyWo06p6GinFdSOa/0+iAOiXfeCCoEmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101593; c=relaxed/simple;
	bh=LReczOUW3RAVeai2AUT8V28pUeZa7u7gZJv5sQUkT0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NC9rISezh1eAxiq0smoDbUNF8ZPB+xAvhuoAEfsp51HNa39qkUlrIKG3d9Rg8q6/AHprM45ZdWc8xqhBUa0S7877VKVqB0ifTkL4T/l+FIGWvZWbpXgKoVMwyxRznob7oB3tLnp5kOf3htqUKNr/8NTF9JHL25VahfiJZx86pvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=VxTjm9fy; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="VxTjm9fy"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5751770a178so60659e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778101589; x=1778706389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9F2I5ypNYXeknVttqMMpqUPLchC2YVo60ECIY3JlnA=;
        b=VxTjm9fyifM8Gm5CPfNvUb9Z+cQ9qFBF3xni1p1xRlGFRkP+ffSg+wr8qeYscl6NMb
         vmTTxNA5tZ2skmmzJMmdXDuKQdQDD1b5GzrLZBkzyVk+xHgVoW2WN5Vn1QwlJ0ybWTvA
         APFQHxTdCrfGi7tfFJnSeozr0ADwLUaGedF6HEMTxuD2pIF8ATaYLGLWaMCMw3hFqnYz
         GmeyxjP+/Zi0JjiC6avaN/lU4ai9Ct2ZI2RfyF/LE7IJmthJWkrz2wo3rwHoGJOqnR88
         A4d8SnAfrHPc1xrFZp6Iiyu2JMHONXDe+VbdPdQQh2oybSFc2b3TX8+Ch3fm0LN7Z65p
         eDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101589; x=1778706389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9F2I5ypNYXeknVttqMMpqUPLchC2YVo60ECIY3JlnA=;
        b=EDvxjQlam1aA5kbW/Vd2e9UhrTwRWCisquzkIsgjrQpsdBvxbxHCjk/yRdC1JQSCuc
         HpoKr5QesXQy4+6wwMZz3v0FWCra7InTbFvc6vZzZ+FQHwgSxkT75KYMBw+hvp6K+21j
         3yYZzxh4Wcj/YZ+O9GXNbwcetngwfu4xEoywsnXRWu0oY5oMbBzwvgcIU/A15uEUDt1T
         91d6+5kIoa9PAPlLPf23CEPmIRbL1PLN0aWdkJd3EjZuIJuAgE2zhBLlXRuD3guXFILO
         4sCXTGctQUwSEkEXKNJVA/iqP8S/xrFcCJ84rx41bFbf9uYbVBgQRQUgA1C2BIhB8qAk
         oxxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Rt/HaumFj+b7h9b6MyEPhao8BSyah9InDRYWHvh5z0GrX5IJHoy8WI5txN3Rx6vKMEj7NNnhJw7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK7Q7T8M58KlQQmF/bf+0LQQwjsgbicN94LkWwbGMHZfODAwD
	J4ao4DAUqfww+z6SzKm19rDVrvXrKZO9Or8VNPEZqDEO3Q6u/an5gFClnT1yQS2SvZpY4bilKhl
	xnThQz94NPg==
X-Gm-Gg: AeBDiesL+qksX0+vTdJ+K/NRaxbs7PYOrSMB3fSrkKwooFd33jUDp8kwRcuXkioZF9T
	xC0/uRP1cRFNq84qrsTSvNFQlwfHHzVPr3mBwvrkil/R4O3nH7SmAlziWXaLT9wym+qgNt1kULe
	I6WY+YyKwQQVHAgCVp6zzrR6tlHs9sslTLAkne90OoOJOs1HtoDqXjy69lC7uX8Uomd0XSRk+Kj
	zHqPhJB8EdOoZ9JuFEzD1ZT6NWNMbRvsyhEiAcb6LBuJBYv9dVK+kuxmLcjluZR4LewXAXnZFC/
	qXbFjHwZ+WdWnq7HHp2Dafz+recLF49oL42zFT56rEE8WBdrNMYJ+BB6iFixstMp7ucum/iVNs1
	dZurWpvBNjnf4UuB1V8UU7xm5hNJ5UngQ+DynKJ9iOPkFnJorQLui40cbF75Fssn8EXMTwfRLAa
	uA5q9xM0U3YnVd/W8=
X-Received: by 2002:a05:6122:d1e:b0:56d:8493:d455 with SMTP id 71dfb90a1353d-575592827d5mr3459485e0c.0.1778101588954;
        Wed, 06 May 2026 14:06:28 -0700 (PDT)
Received: from yukhui ([2804:7f0:74c0:2ec0:c1d1:d825:a2cf:ce06])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc7dd4sm12183264e0c.14.2026.05.06.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:06:28 -0700 (PDT)
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
X-Google-Original-From: Raffael Raiel Trindade
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Raffael Raiel Trindade <raffaelraiel@usp.br>,
	Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4] iio: light: vcnl4000: use lock guard()
Date: Wed,  6 May 2026 18:05:33 -0300
Message-ID: <20260506210616.313636-1-raffaelraiel@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raffael Raiel Trindade <raffaelraiel@usp.br>

Use guard() and scoped_guard() for handling mutex lock instead of manually
locking and unlocking. Remove gotos in error handling logic. This prevents
forgotten locks on early exits.

Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
Co-developed-by: Kim Carvalho <kim.ca@usp.br>
Signed-off-by: Kim Carvalho <kim.ca@usp.br>
---
v4:
 - use guard() and scoped_guard() instead of
   lock() and unlock() in all functions
 - drop ret = -EINVAL initialization

v3:
 - fix indentation problems on line breaks

v2:
 - remove unnecessary ret attributions on non-error logic.
 - remove breaks on switch-case after return

 drivers/iio/light/vcnl4000.c | 148 +++++++++++------------------------
 1 file changed, 45 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c08927e34b4e..d87a95a05329 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -268,46 +269,36 @@ static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
 {
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (en)
 		ret &= ~VCNL4040_ALS_CONF_ALS_SHUTDOWN;
 	else
 		ret |= VCNL4040_ALS_CONF_ALS_SHUTDOWN;
 
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
 }
 
 static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool en)
 {
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (en)
 		ret &= ~VCNL4040_PS_CONF1_PS_SHUTDOWN;
 	else
 		ret |= VCNL4040_PS_CONF1_PS_SHUTDOWN;
 
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
 }
 
 static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
@@ -442,18 +433,18 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	int tries = 20;
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
 					req_mask);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	/* wait for data to become ready */
 	while (tries--) {
 		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
 		if (ret < 0)
-			goto fail;
+			return ret;
 		if (ret & rdy_mask)
 			break;
 		msleep(20); /* measurement takes up to 100 ms */
@@ -462,20 +453,13 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	if (tries < 0) {
 		dev_err(&data->client->dev,
 			"vcnl4000_measure() failed, data not ready\n");
-		ret = -EIO;
-		goto fail;
+		return -EIO;
 	}
 
 	ret = vcnl4000_read_data(data, data_reg, val);
 	if (ret < 0)
-		goto fail;
-
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return 0;
+		return ret;
 
-fail:
-	mutex_unlock(&data->vcnl4000_lock);
 	return ret;
 }
 
@@ -486,16 +470,14 @@ static int vcnl4200_measure(struct vcnl4000_data *data,
 	s64 delta;
 	ktime_t next_measurement;
 
-	mutex_lock(&chan->lock);
-
-	next_measurement = ktime_add(chan->last_measurement,
-			chan->sampling_rate);
-	delta = ktime_us_delta(next_measurement, ktime_get());
-	if (delta > 0)
-		usleep_range(delta, delta + 500);
-	chan->last_measurement = ktime_get();
-
-	mutex_unlock(&chan->lock);
+	scoped_guard(mutex, &chan->lock) {
+		next_measurement = ktime_add(chan->last_measurement,
+				chan->sampling_rate);
+		delta = ktime_us_delta(next_measurement, ktime_get());
+		if (delta > 0)
+			usleep_range(delta, delta + 500);
+		chan->last_measurement = ktime_get();
+	}
 
 	ret = i2c_smbus_read_word_data(data->client, chan->reg);
 	if (ret < 0)
@@ -606,21 +588,15 @@ static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
 			 (*data->chip_spec->als_it_times)[0][1]),
 			 val);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_ALS_CONF_IT, i);
 	regval |= (ret & ~VCNL4040_ALS_CONF_IT);
-	ret = i2c_smbus_write_word_data(data->client,
-					VCNL4200_AL_CONF,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, regval);
 }
 
 static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
@@ -660,20 +636,15 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 
 	data->vcnl4200_ps.sampling_rate = ktime_set(0, val * 60 * NSEC_PER_USEC);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	regval = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
 	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-					regval);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, regval);
 }
 
 static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
@@ -721,20 +692,15 @@ static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, in
 			break;
 	}
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_ALS_CONF_PERS, i);
 	regval |= (ret & ~VCNL4040_ALS_CONF_PERS);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, regval);
 }
 
 static ssize_t vcnl4040_read_ps_period(struct vcnl4000_data *data, int *val, int *val2)
@@ -783,20 +749,15 @@ static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int
 		}
 	}
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_CONF1_PS_PERS, i);
 	regval |= (ret & ~VCNL4040_CONF1_PS_PERS);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, regval);
 }
 
 static ssize_t vcnl4040_read_ps_oversampling_ratio(struct vcnl4000_data *data, int *val)
@@ -830,20 +791,15 @@ static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data,
 	if (i >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
 		return -EINVAL;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_PS_CONF3_MPS, i);
 	regval |= (ret & ~VCNL4040_PS_CONF3_MPS);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3, regval);
 }
 
 static ssize_t vcnl4040_read_ps_calibbias(struct vcnl4000_data *data, int *val, int *val2)
@@ -878,20 +834,15 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
 	if (i >= ARRAY_SIZE(vcnl4040_ps_calibbias_ua))
 		return -EINVAL;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = (ret & ~VCNL4040_PS_MS_LED_I);
 	regval |= FIELD_PREP(VCNL4040_PS_MS_LED_I, i);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3, regval);
 }
 
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
@@ -1476,17 +1427,17 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 				       enum iio_event_direction dir,
 				       bool state)
 {
-	int ret = -EINVAL;
+	int ret;
 	u16 val, mask;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	switch (chan->type) {
 	case IIO_LIGHT:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		mask = VCNL4040_ALS_CONF_INT_EN;
 		if (state)
@@ -1495,13 +1446,11 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 			val = (ret & ~mask);
 
 		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
-						val);
-		break;
+		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
 	case IIO_PROXIMITY:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		if (dir == IIO_EV_DIR_RISING)
 			mask = VCNL4040_PS_IF_AWAY;
@@ -1511,17 +1460,10 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 		val = state ? (ret | mask) : (ret & ~mask);
 
 		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-						val);
-		break;
+		return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
 	default:
-		break;
+		return -EINVAL;
 	}
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return ret;
 }
 
 static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
-- 
2.51.0

