Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC341246BA7
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203220; cv=none; b=Z8PT3UVVeNwrfiFBz58YowF29AaQjxHHx68dJCRdvjZkCmpqHmJ46AAEgi3usv7nznyb6bc5CbomOCELnF91LxyjkQZKTqlUHdKFEB5KJtpfOunNAb+Ppx2qf5m6Ovt1LOuTyAMEqM7ZgKgar4qeOrhoINUKU0HRSsI2eGVv5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203220; c=relaxed/simple;
	bh=TBLSrqBeZomDV2gMZy7BCzI9rhkp7P+o3Dt33E5ZQvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCiG3s1Y691JId3J6g5AB83VHuhlwd5PXltdOqjdQrD28iPaO0YJ1uWkxfRRn7Ib6Inp185MTGjuUe4ttxoLUF+x5IxprD9yXU4Q1kedRK0itn+70grzSi4vRw8uHpAbYSUs2P5qdLaAOGApvvCBODKmMq6IGWGvTWI0IIW0c7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFPO2+pV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFPO2+pV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79430ef54c3so21927987b3.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771203218; x=1771808018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEPsTH3PriBiWEFGViHWLoH9Qxt8oTMiRXWW0uvcBQY=;
        b=QFPO2+pVWLu2MiHeMqPwcZsvQc81mH6xZsqgW5OwGR+cgYo89ZZMxomYjOXIQnv5/9
         fsMt5y5GB8YDqcmY7O7u37geQcPmLNYUHttscQjSsEtJI7GZc5MME85EfBIQLL+aHy2g
         jhEwELhfF6vI17O5xU1KZdV9428C7BK+bqKiEH6eNOhkkZW16FwDp+vr5nd4n/dIsHdu
         N7Ki2RKqtHAcGgKtthFlWBEJhNWQjXrt/2+G75iAyYax5NMLE5lduCQ5CbHZcPxU3Le1
         Nnkz4431c3205OG0lxz8UJBFFK9owCrPZYTZrWP8DJ1WCD5FHMZWH1f9jQa7tiGM3tji
         rbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203218; x=1771808018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEPsTH3PriBiWEFGViHWLoH9Qxt8oTMiRXWW0uvcBQY=;
        b=p4Kc7nb0q0o8LXUtVM/tyEz9+wNuX56PFYkmLZV2MmgtgLxL+6fiL1HGF6dNCLjb40
         Pj3GZ1GmG1kw63Xb7ig2PDP3hpFt+9BU3oZaJD4aGGcxZvUWzaOohx3ahvljd0MVJTP0
         xyI/Dw56s6mnaQkU0ieywE5a/8Z+EP6sbGRNdhVhHqR33lY9DTn4cIGQqLoMQZc7I7Po
         1TBNuu0PdyoanPK/Jh4T1rVl/HACL0hAHt2YlgymCY54VxQLKGlS676zHIoDFe63szba
         VnzB6UKDhM882pawOoR1mXVdhxLi3czVnykKsFwVCQEkhpdfjkr9k5bfStKzgmcQaBTe
         QMoA==
X-Forwarded-Encrypted: i=1; AJvYcCXAK66u6E3mQtBFHILgG6yGNuzXfdek3gdAO8NStn5CzGA48B8w/RPQvgsHHtu3NTEooWm/RJJ/pCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlgHFrXKsHuxxqZIJC094swg5hji9AN8hMHEnFHkWkyTDfoAJ2
	ycUdyntzHnU8aausWhc99oTgJQnBEyd/9IrP/sz5erXM4/zv2ZpyLCKv
X-Gm-Gg: AZuq6aKkoZ6rfJM8xOn4OCo/jsRovSCqYLl/FnRh644dVnEWUo5XQ6f8hPKVHjFQifW
	4H267xgBd9vnNpcT/6INvCvJptgJv5bmLHiC9VFe93tGCqmyfWajit/zvyKIw+kgQ37Y3Soep4R
	jIp5AWQiShQ+hkqxoZ/cjfNyUkMGpweE6BYAB2L2IxdAhBIOJtx0x+F9+dCJ7q9jepLMGDaKcwl
	KDi90KNcky20TIHjs6xT0G/xQkYZjWu5qhgWVKFns7UN6mKfPauL/Qnps1bSYGI2PTLfdOAXU8E
	AC9IlA4FN7Mbzw+D59PiqLo/3cI8CLA18Y1w7Zh9Vx9YwQwJ158nzeDgamjDC50sjUyx2BJZusv
	F2zmP4WJ/WxXIxKOHVDzxCgWiUyR4wLaKttYRrHunY9quIemF1iux09azEJQ2UtEnssHUTdRMAU
	nc2OJiiw1JZrz+UYKvoltsGRqjm07Df59oeJ2mxcQ1FSZvff0ksSOOnd1dHOnjqNykbm4dgbwSz
	WPa61c0zttJbtBrccwx+vF8VXokcpRyJMiYjFKjI0U=
X-Received: by 2002:a05:690c:1a:b0:796:3c5d:70bf with SMTP id 00721157ae682-797ac5570c3mr48531827b3.29.1771203217683;
        Sun, 15 Feb 2026 16:53:37 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm94797637b3.45.2026.02.15.16.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 16:53:37 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with guard()
Date: Sun, 15 Feb 2026 18:53:16 -0600
Message-ID: <20260216005317.11763-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216005317.11763-1-ethantidmore06@gmail.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
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
v3:
- Use guard() instead of manual locking and unlocking.

 drivers/iio/light/gp2ap020a00f.c | 64 ++++++++++----------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..d1a511ac7690 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -31,6 +31,7 @@
  * the other one.
  */
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -1024,17 +1025,14 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	bool event_en = false;
 	u8 thresh_val_id;
 	u8 thresh_reg_l;
-	int err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
-	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
-		err = -EINVAL;
-		goto error_unlock;
-	}
+	if (thresh_val_id > GP2AP020A00F_THRESH_PH)
+		return -EINVAL;
 
 	switch (thresh_reg_l) {
 	case GP2AP020A00F_TH_L_REG:
@@ -1046,30 +1044,23 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
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
@@ -1081,23 +1072,17 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	u8 thresh_reg_l;
-	int err = IIO_VAL_INT;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 
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
@@ -1165,7 +1150,7 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 	enum gp2ap020a00f_cmd cmd;
 	int err;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1186,8 +1171,6 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 		err = -EINVAL;
 	}
 
-	mutex_unlock(&data->lock);
-
 	return err;
 }
 
@@ -1199,7 +1182,7 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int event_en = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1223,8 +1206,6 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 		break;
 	}
 
-	mutex_unlock(&data->lock);
-
 	return event_en;
 }
 
@@ -1385,7 +1366,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int i, err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/*
 	 * Enable triggers according to the scan_mask. Enabling either
@@ -1413,15 +1394,12 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	if (err < 0)
-		goto error_unlock;
+		return err;
 
 	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data->buffer)
 		err = -ENOMEM;
 
-error_unlock:
-	mutex_unlock(&data->lock);
-
 	return err;
 }
 
@@ -1430,7 +1408,7 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int i, err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	iio_for_each_active_channel(indio_dev, i) {
 		switch (i) {
@@ -1452,8 +1430,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	if (err == 0)
 		kfree(data->buffer);
 
-	mutex_unlock(&data->lock);
-
 	return err;
 }
 
-- 
2.53.0

