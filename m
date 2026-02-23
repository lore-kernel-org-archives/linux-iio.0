Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B61DF74F
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818042; cv=none; b=pznB1/ZQAAcEEJUFrupLTLVMM/GUWJuh7iEarJdib4KMwtaYIDJNITyt9NAVFHjqiclvOG3GgbnW1bm/SjWyoE+CSZv4+va/GYrJKraw4jstDexTuDmp71rq4wx1F1D4abwPtRKznT6REm9ClAdBYKwpiFvMnMKTPLR9C26Xlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818042; c=relaxed/simple;
	bh=sDWsTv88uNZNG8DVEijwNX9kt3yghprkYLDYfMTz5tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKpQwLhtGZDdEM2paIy8qeVJjTZHCN4xCiEguh4lAF8dVBFt+fatuY3ZZDMU+9lAPgSDhNsIzNaleNnxhXOnP7ywajVTLsG/tjw0UVUElnltlWx2YwklSyZbP3M6ejiG8W3JY7s5ajd8UkaM6ui26GDiLbo8U3geGkjc8+4LVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhueWI/r; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhueWI/r"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7984d31b895so402197b3.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818040; x=1772422840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvozGr4YIm5H0IcWBMJeiTYmTx8u/Ce7mtaZnY7rBfA=;
        b=FhueWI/rfNIfguEf31UPzy0PwNAYmlAPBL+SJoxoTf5+C1OfbNB3X9dmLYmxhFDrlu
         OBIwzsksSEAjMJRZi5DDxKy+otF+nTbzHno0k0YUAL3v+GRvyXoh/k4ynBR7/ZriCzgL
         LrMHN5gFDBtRLJ9AlWWkC1Pd3J1g3OyW8Aaffxp+0SX59rZP47ObDe84VzgGsm+PMH0v
         ftYbGIDTvyX1uIZx7evlI3nfTtD8ivLWIFi9ex3HDVZiVLQGsXw5N0khD8cV6vKuqwcQ
         7sirSbjaXO4Oi0KCJWhM6W3wXjQXj5F1HCix2j/zgWL/OIpTTKZTCzde0meSz0paLrZe
         7xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818040; x=1772422840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CvozGr4YIm5H0IcWBMJeiTYmTx8u/Ce7mtaZnY7rBfA=;
        b=WwIIKR1n+fLFntV7GBVexeL6HXSL/Rnvs7I4ngk2L9KqgMrZpcjFXBs9YGymlPVM/V
         WBlJhlh33MCz4yZa24m/V5Ey5qNUSVXwsmcKghsQ2nlQxncGsa8iyqpchcYzWbrLoBGf
         hJ4sX1I3v6FvQwrSIeGr5WLKb7CrH1akZGfwMuDMJ1MSBL2hwaU686dn5xY4PgA5xB8G
         IAlGbLI76FrsEz6o7AyJh9FyvwpvJRVjrST0SLqFXwLxRmdPwWqdSRPjfq3mj2LWCuNK
         1dHO/4/D8tgRHjhJwBF28sckW71TM/aJnJJ+BnT+FjiaJ9eSRih4qTbvM/OsvVyda5NY
         DK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYtX7dEa17yg2xnpGueAnN2ldYOGCwJrIIyFdKghM5x9G/CPcbTagkWDRimIf6FUYU7VGFxOZaRHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbDhKDApk8582okqjck0d2MizJ/H+YLC+NnEoKiBH3WeoLyBm
	NH9//WAnE8hXb83cTwsdzYaMH/BBr0rzS0/yu+H5Vp7ExiEZIvbFbcv1GFtUx+FetsA=
X-Gm-Gg: ATEYQzylRu2+B/Xig1dPlD6if0EkDuKPrgvGyLFz0KSMzItJLD9SqR8UdFmW2lOEzF1
	nxj416+srnzC9QA6X9VHPsvw9oMlOn8vDb+YIFKoak9Cg1HQfv4jU1jfru3Okz9gHYzj2a91Cfa
	VNGshEQCLUI/uJcxkXhbJDkKpsMeZwbnyf/sj8ubYwIHmCkII16UDRACONidMkE0VB8Ff4iJX5M
	0CV1YKzjzzlWy3fqaj5oBn4b3IqwaS9kcsXIBkZ79Uo3a0wGpo0ykl5j6UIt83Xr0eQp/As8jvy
	yaitCZThjI7vCH8ReW18PD4IkM+0l9htqmGAb6Kz/63FEToCD2uTXdaC2zq8FLCGjklP6QpeRf0
	OHiizTkdpAbjnWqAtsAoPjIkhIjlmBI+JWf9xgwtiE51Uttr0WKbDqXtiyClmdLViU9bGJMZngf
	sQPwvtrEWug0PJI/1NnwMIyalEw2tbAZ1eTg4H2IulF6k9ApSCVUt1m71sN1TXwikWwgU9oL9PQ
	zGEMWdBkP8PYRZwqb24Wwul
X-Received: by 2002:a05:690c:e3e2:b0:794:cf56:5bc2 with SMTP id 00721157ae682-7982916e2dfmr72703637b3.59.1771818040206;
        Sun, 22 Feb 2026 19:40:40 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:40 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 01/10] iio: light: gp2ap020a00f: simplify locking with guard()
Date: Sun, 22 Feb 2026 21:40:11 -0600
Message-ID: <20260223034020.27625-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the guard() cleanup handler to manage the device lock.
This simplifies the code by removing the need for manual unlocking
and goto error handling paths.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- Integrate with Andy Shevchenko's cleanups.
v4:
- No change.
v3:
- No change.
v2:
- Make this a series and include guard() macro as suggested by Jonathan
  Cameron.

 drivers/iio/light/gp2ap020a00f.c | 110 ++++++++++---------------------
 1 file changed, 35 insertions(+), 75 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..7cee15db3a1a 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -31,6 +31,7 @@
  * the other one.
  */
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -1024,17 +1025,13 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	bool event_en = false;
 	u8 thresh_val_id;
 	u8 thresh_reg_l;
-	int err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
-
-	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
-		err = -EINVAL;
-		goto error_unlock;
-	}
+	if (thresh_val_id > GP2AP020A00F_THRESH_PH)
+		return -EINVAL;
 
 	switch (thresh_reg_l) {
 	case GP2AP020A00F_TH_L_REG:
@@ -1046,30 +1043,23 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 							&data->flags);
 		break;
 	case GP2AP020A00F_PH_L_REG:
-		if (val == 0) {
-			err = -EINVAL;
-			goto error_unlock;
-		}
+		if (val == 0)
+			return -EINVAL;
+
 		event_en = test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV,
 							&data->flags);
 		break;
 	case GP2AP020A00F_PL_L_REG:
-		if (val == 0) {
-			err = -EINVAL;
-			goto error_unlock;
-		}
+		if (val == 0)
+			return -EINVAL;
+
 		event_en = test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV,
 							&data->flags);
 		break;
 	}
 
 	data->thresh_val[thresh_val_id] = val;
-	err =  gp2ap020a00f_write_event_threshold(data, thresh_val_id,
-							event_en);
-error_unlock:
-	mutex_unlock(&data->lock);
-
-	return err;
+	return gp2ap020a00f_write_event_threshold(data, thresh_val_id, event_en);
 }
 
 static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
@@ -1081,23 +1071,16 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	u8 thresh_reg_l;
-	int err = IIO_VAL_INT;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
-
-	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
-		err = -EINVAL;
-		goto error_unlock;
-	}
+	if (thresh_reg_l > GP2AP020A00F_PH_L_REG)
+		return -EINVAL;
 
 	*val = data->thresh_val[GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l)];
 
-error_unlock:
-	mutex_unlock(&data->lock);
-
-	return err;
+	return IIO_VAL_INT;
 }
 
 static int gp2ap020a00f_write_prox_event_config(struct iio_dev *indio_dev,
@@ -1163,32 +1146,25 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	enum gp2ap020a00f_cmd cmd;
-	int err;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
-		err = gp2ap020a00f_write_prox_event_config(indio_dev, state);
-		break;
+		return gp2ap020a00f_write_prox_event_config(indio_dev, state);
 	case IIO_LIGHT:
 		if (dir == IIO_EV_DIR_RISING) {
 			cmd = state ? GP2AP020A00F_CMD_ALS_HIGH_EV_EN :
 				      GP2AP020A00F_CMD_ALS_HIGH_EV_DIS;
-			err = gp2ap020a00f_exec_cmd(data, cmd);
+			return gp2ap020a00f_exec_cmd(data, cmd);
 		} else {
 			cmd = state ? GP2AP020A00F_CMD_ALS_LOW_EV_EN :
 				      GP2AP020A00F_CMD_ALS_LOW_EV_DIS;
-			err = gp2ap020a00f_exec_cmd(data, cmd);
+			return gp2ap020a00f_exec_cmd(data, cmd);
 		}
-		break;
 	default:
-		err = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-
-	return err;
 }
 
 static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
@@ -1197,35 +1173,23 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 					   enum iio_event_direction dir)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int event_en = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
 		if (dir == IIO_EV_DIR_RISING)
-			event_en = test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV,
-								&data->flags);
+			return test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV, &data->flags);
 		else
-			event_en = test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV,
-								&data->flags);
-		break;
+			return test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV, &data->flags);
 	case IIO_LIGHT:
 		if (dir == IIO_EV_DIR_RISING)
-			event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV,
-								&data->flags);
+			return test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags);
 		else
-			event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV,
-								&data->flags);
-		break;
+			return test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags);
 	default:
-		event_en = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-
-	return event_en;
 }
 
 static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
@@ -1385,7 +1349,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int i, err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/*
 	 * Enable triggers according to the scan_mask. Enabling either
@@ -1413,16 +1377,13 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	if (err < 0)
-		goto error_unlock;
+		return err;
 
 	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data->buffer)
-		err = -ENOMEM;
-
-error_unlock:
-	mutex_unlock(&data->lock);
+		return -ENOMEM;
 
-	return err;
+	return 0;
 }
 
 static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
@@ -1430,7 +1391,7 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int i, err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	iio_for_each_active_channel(indio_dev, i) {
 		switch (i) {
@@ -1449,12 +1410,11 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 		}
 	}
 
-	if (err == 0)
-		kfree(data->buffer);
-
-	mutex_unlock(&data->lock);
+	if (err)
+		return err;
 
-	return err;
+	kfree(data->buffer);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
-- 
2.53.0

