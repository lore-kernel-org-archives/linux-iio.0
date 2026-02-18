Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D542E8DEB
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389470; cv=none; b=Un//TQNoip57PMxhsgi2d99mrKJ+ITL0SlXMJWatcMAQBiKwKao6xp92wjF90InlPxIdnjXwOhALSLsr1Vdr1ewbCewCgv7+o3utU13SdjBh5lt6K6gkZ3AKU1zyJJbfX88MqG9sE8GY0R/qPsznusJaGm845QDkz+Xszm6pPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389470; c=relaxed/simple;
	bh=//HHuTCerFcSwwiBqOvc0pkJJAPvk1SqJGx0RZE0gZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpZp8X1JXZb7NxwSd7tE5uzwJbnl2EfLXJBff7U5bENQz7sgim6eG/SkmJ6XFGCHjl4hNdDjMLjhVC0LAMLsMh2Oa4Nvkue4h97QsgbI9Q94DTRv8ghSH7pGWN0cz2K35vHe8Q7N/gewxTeqM9h/xK9OR3QIaTqMnA8/mK/Qqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxz0hrhT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxz0hrhT"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794fe16d032so40776107b3.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389468; x=1771994268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbCY9XCvRZytZp9MDEYN7XDbxm37YVD92nmqKbkfDRs=;
        b=Cxz0hrhT5bSD4YYpkEJnQGgg8IHpKKIA2q9vD4xzE2vadvbb42wHnK5opQlh2WzcDF
         sWuPe7+pyi2DWTbdOzGyBcjWYBtf6AQV7Zqz/tU3euGN/J9Ur222trEk+vR0CC3dwY8x
         2B2TJjMxMS+mIVnvnPUsoQ3pQIl02to1suau8gzxi3p6lsgz3bZ7iO3urevjyZXaC80a
         oNxJOJEnhgb6xDT9YuaOJ5kgn2BT97fi0GIc2zD4b8VxcoaQxcUln4r1AEpgX37uk1qd
         yDvuR1YTU7XJZ7tp+NZ1czcHBp82u1K4kD4cCrLI/h10kJyCvNtfgGMrau/4QE1cOkKu
         d2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389468; x=1771994268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbCY9XCvRZytZp9MDEYN7XDbxm37YVD92nmqKbkfDRs=;
        b=ZkD36FzaAqmsyxTQBHPplv/DsnUDTPXLl3FQtJ0IkJEUYis+ehNHOxnZdGusCFsuI/
         hQoVPUK6R2+JhwILe7udV9LNVCG/vSdHVNGTmJd3kbw0WnTY/bqGJj9o5Rm193olbYwu
         6u0zIQ2BzooOM00ToESO8T3uImv8ZunHz4mjjeZnYnlymlhFRvvAxzMlAN8jW6t6FP3X
         WRAlmKROwmxUFv0DVSl7+IZl1Y+011wgzT63apxtmazUkcn8KDbu4iTiCLH6ilYDNJjI
         skckBz5ILxHCdFqAYUgemCluoHG4gvKPK4dvNyFIgXFzmbhV7TLtz60LhPqO3znoTJIQ
         0dYA==
X-Forwarded-Encrypted: i=1; AJvYcCXOyKEAMJikk4soXVAGww4s6YtP+xNDf1d0FX5JbG+GnBRF3b8DjVujfngts+X74RNjtAAKzpr4aPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPDrp8BdAERHX1RAG8yci3Ldr/77MGiLvpWRD8zR1damUqgFa
	4cESe9IljB0R55AaqXQzAqej/3NLoBVvEtNmf/n8jxDO2LGunv498gZb
X-Gm-Gg: AZuq6aKxV4p22SrR5jhPOoCd7t7SaU3XiOdylojDmM+dz3ej1kAAC+iG6zcdrB+gH1a
	aTGodM6ipQhhga28ZVOChC3WuQlKX5aQA9FX7zUJWgFvOpS+zrOJGclDoVl6dP+xQ6VeFyZ1Nbc
	94tiYSBcqImyPa504Y49nmGGmdxXG9bIOoQl4aibw1LmyArwQjxrYILnUhgtMBaPOUV0rzutp9F
	zKDn5Rg7CuRs1QyIQP2aqFJzYcTOpQzv60dHEubW2TlPQdBexzVOmzH/i10z7mNi3b30DS31h4o
	NNY/ay9h0s1MLNG8oESboohJNii2e15JLFwmB2zPb/b89jGBwCXZXnBrVXIDLcbuxjSOBi6SSOv
	mSmplIPWMmoHAsxQ9ZT35h0SOj8woXIaJI53WqRKP4GGj5xtU6Md+El4KO7V+rVwuTAxYEOImYz
	G7hK+KuuRZt8iJeb6LLUS4bsZmSN3Wn9OsaejplHu375nPwJ5uBkLxmTbNfJk6JmSUhg9s2LALX
	ehMTRXtKztz3xOSxF8bHx8qShrX9VQQ1QSm/jJc0Yk=
X-Received: by 2002:a05:690c:6e11:b0:796:4bae:934b with SMTP id 00721157ae682-797f73f2bf8mr4193407b3.63.1771389468094;
        Tue, 17 Feb 2026 20:37:48 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:47 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 1/9] iio: light: gp2ap020a00f: simplify locking with guard()
Date: Tue, 17 Feb 2026 22:37:20 -0600
Message-ID: <20260218043728.609659-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
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
v4:
- Remove whitespace between assignment and check.
v3:
- Remove Fixes: tag.
- Added Smatch warning.
v2:
- Fixed gp2ap020a00f_get_thresh_reg() parameter alignment.
- Removed unneeded whitespace between assignment and check.

 drivers/iio/light/gp2ap020a00f.c | 66 ++++++++++----------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..91fdcb980111 100644
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
@@ -1165,7 +1148,7 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 	enum gp2ap020a00f_cmd cmd;
 	int err;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1186,8 +1169,6 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 		err = -EINVAL;
 	}
 
-	mutex_unlock(&data->lock);
-
 	return err;
 }
 
@@ -1199,7 +1180,7 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int event_en = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1223,8 +1204,6 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 		break;
 	}
 
-	mutex_unlock(&data->lock);
-
 	return event_en;
 }
 
@@ -1385,7 +1364,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int i, err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/*
 	 * Enable triggers according to the scan_mask. Enabling either
@@ -1413,15 +1392,12 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
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
 
@@ -1430,7 +1406,7 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int i, err = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	iio_for_each_active_channel(indio_dev, i) {
 		switch (i) {
@@ -1452,8 +1428,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	if (err == 0)
 		kfree(data->buffer);
 
-	mutex_unlock(&data->lock);
-
 	return err;
 }
 
-- 
2.53.0

