Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFF32AAA8
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508069; cv=none; b=BXPvOpXTInDrUPmG4gg+LBhJ/9O4DIcEiopP8Tu+OKvzYycRIb/oKuyemWtHgMJNR9HgBWBnJqkJwsrdVtyrUY8qVkqm0QvVv89/KsnGbvVeNVquj/uxcHUgc+07+i0j1oyLhPMlR9j0A86qT1XHFj9ge4ppZofcUQ1scGE50RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508069; c=relaxed/simple;
	bh=8HKw6n+cbamGQ4Fh1uNgeACj3DQHV9YloVHoTMkY6gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOemlbOTLmP64EIzgYhbgY+NBLiVUc4eanwp1fP3AJVB8GztBc+ZScmFb2sHGvWnjlrKp+XzV884Bu7E6QgBI9tHqb/5HW3/KoCimTVLCk/wrO2zDlItNNRVlQ7/Sz2e5UEYI8asg+bafjjDPV2mnf3AqqYjgOgFJw3JpICG+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHeUZUR4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHeUZUR4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1697217a91.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508068; x=1774112868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywcmhQpDRW7pbrfJlNQkDkYjY/lD8dZ1Tgs0xdfUCKs=;
        b=cHeUZUR4CI3R9WscDvbjO/FD66Xzdl3cT8ZSWX87J+qpBhDX/muWLSZJjsPEuScFXK
         h0AqChsDIxfwsIz3+jv9xmDXyGmPLWLftQaMYuEbkcEm91YgI2a9yrMKgG+ebYoALbOO
         GkrVbMWCXvzI7PnPP4AOJ/aVz0uF/TrPrRAHnvnjVXDreZTXQbHIsxIOS1KrQ6Ko8iMq
         hEU7CPdF97twGVE8S0wWnZdZRTjq9nt6k6FVqJyDxyg+y8h4na5luYlGhZ5GBxjJQSGd
         Vkak6dYZAxZE7RzSdrSNRPjo+cxmGDQbGstdKt9/jT8TJp8RGMFut9CeVL8jeZ0JUZeE
         1CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508068; x=1774112868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ywcmhQpDRW7pbrfJlNQkDkYjY/lD8dZ1Tgs0xdfUCKs=;
        b=GGJtndACYnK23VxYf1M03IJjogQINZRrwQAvUISvDv7IE3ByPpdB6A0Z7kZNfiKnKa
         6n8KYFTHNYhh3Rqei5SlLTkLH4o1IBuuxzNRRPx3vPeHd8EbNG31nsUcuqFwWwtv3E9a
         hqMG34ptFgNar36kOX5B4u8R8/JBESKzJByFDlKK77lA3aX19/lByGu9blwj/DWhQn6A
         4OWp3QJSeqlX2r5vsMlbboNsF8eNPlOYcF4roWpjJw/VyQSl9/bL5YcLAYgGJSi1noov
         JoNBdfMZ5ViC2g3pQorpBDsKp/H3DkdW0dxFSZ1wCJjwDPMO2OaKECo8stDGNX7YqGmJ
         i4WQ==
X-Gm-Message-State: AOJu0Yy2ZqKVsoWDk8jwP0FiSA3T5yFfzXA0fqTQjW5tBlEFeo6Bui9P
	mw/YolrnVJ1V30IQDuS74xUNeLG205gTGZjU926bcVueFs9Js5nZj0vL
X-Gm-Gg: ATEYQzyY8Kn9lScWKLJ2KPL1E7zqylu0amT/7tk1KiqAl43WJMxhKlZBCWOPRPTZhZQ
	mL6g0eJEs8WiA8MUgi1tPQqb5RqZYUnruybfKEqCSo5xrTPc3TGeDWJZwn+9fj9ZRsQTGP7VsmS
	K7pDHBEcYY+MGfDMEzRUBAbNb5Fb2XA0M/Ghz3UkTiw1AInoaodaYEY+mC35RUgctujRQIcFeEA
	/A3UiahvZeq6ERkp/lpeBTe8Zh/h2SebP3AfttsHhc3WekZbKhkrEZcl6tzzDB2Hky/drZ0FZ+X
	4rYN+xlmp+WAYh2TN4KE41hCjaihPTvvqQmONm/SqYJfUDNgDKNo9VYAd4zHGYdoGfbZS+1PsOV
	VVvHHTipsu+t2KXVsAN1cQMPk5YTxpOT2nkU5+n2zMzT23RjbjdFjf8K36o0VMwYXzZGKofaJJL
	dAIDglWo1BfzFJG8hKU0dExJTDATOVTyRbagRuIgJyODdW/6dNn1sB+ATBFQC1aknx0cfhMQ6l1
	ET2ucip9751lxRTEtYuZmtQ9AU=
X-Received: by 2002:a17:90b:390a:b0:356:2eff:df05 with SMTP id 98e67ed59e1d1-35a21fc5cf1mr6931834a91.16.1773508067935;
        Sat, 14 Mar 2026 10:07:47 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:47 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 8/8] iio: accel: sca3000: convert to guard(mutex)
Date: Sat, 14 Mar 2026 22:36:09 +0530
Message-ID: <20260314170609.26827-9-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
sca3000_print_rev(), sca3000_ring_int_process(),
sca3000_read_event_config(), __sca3000_hw_ring_state_set(),
sca3000_hw_ring_preenable(), sca3000_hw_ring_postdisable(),
sca3000_clean_setup(), sca3000_stop_all_interrupts().
This ensures the mutex is released on all return paths and
allows returning directly without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: No changes

v3: Fixed return statements to make it clear about good/error path.
Removed Not necessary return statement in sca3000_read_event_config().
Dropped else statement to reduce indent of the code in
sca3000_read_event_config.
Fixed indentation.

v2: Dropped Header alignment change
---
 drivers/iio/accel/sca3000.c | 138 +++++++++++++++---------------------
 1 file changed, 59 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index d61ad12aef78..9703946f133d 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -427,18 +427,18 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
+
 	dev_info(&indio_dev->dev,
 		 "sca3000 revision major=%lu, minor=%lu\n",
 		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
 		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
-error_ret:
-	mutex_unlock(&st->lock);
 
-	return ret;
+	return 0;
 }
 
 static ssize_t
@@ -999,13 +999,14 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, i, num_available;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
 		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
 					      1);
 		if (ret)
-			goto error_ret;
+			return;
+
 		num_available = st->rx[0];
 		/*
 		 * num_available is the total number of samples available
@@ -1014,7 +1015,8 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
 					num_available * 2);
 		if (ret)
-			goto error_ret;
+			return;
+
 		for (i = 0; i < num_available / 3; i++) {
 			/*
 			 * Dirty hack to cover for 11 bit in fifo, 13 bit
@@ -1026,8 +1028,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
 		}
 	}
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 /**
@@ -1113,16 +1113,15 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	/* read current value of mode register */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
-		ret = !!(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT);
-		break;
+		return !!(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT);
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
 	case IIO_MOD_Z:
@@ -1132,24 +1131,18 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 */
 		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
 		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
-			ret = 0;
-		} else {
-			ret = sca3000_read_ctrl_reg(st,
-						SCA3000_REG_CTRL_SEL_MD_CTRL);
-			if (ret < 0)
-				goto error_ret;
-			/* only supporting logical or's for now */
-			ret = !!(ret & sca3000_addresses[chan->address][2]);
+			return 0;
 		}
-		break;
+
+		ret = sca3000_read_ctrl_reg(st,
+					SCA3000_REG_CTRL_SEL_MD_CTRL);
+		if (ret < 0)
+			return ret;
+		/* only supporting logical or's for now */
+		return !!(ret & sca3000_addresses[chan->address][2]);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
@@ -1280,23 +1273,21 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
-		ret = sca3000_write_reg(st,
+		return sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
 			(st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
 	} else
-		ret = sca3000_write_reg(st,
+		return sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
 			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 /**
@@ -1313,26 +1304,20 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* Enable the 50% full interrupt */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_unlock;
+		return ret;
+
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
-		goto error_unlock;
-
-	mutex_unlock(&st->lock);
+		return ret;
 
 	return __sca3000_hw_ring_state_set(indio_dev, 1);
-
-error_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
@@ -1345,17 +1330,15 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	/* Disable the 50% full interrupt */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto unlock;
-	ret = sca3000_write_reg(st,
-				SCA3000_REG_INT_MASK_ADDR,
-				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
-unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+		return ret;
+
+	return sca3000_write_reg(st,
+				 SCA3000_REG_INT_MASK_ADDR,
+				 st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
 }
 
 static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
@@ -1375,25 +1358,26 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	/* Ensure all interrupts have been acknowledged */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Turn off all motion detection channels */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
 				     ret & SCA3000_MD_CTRL_PROT_MASK);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Disable ring buffer */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
 				     (ret & SCA3000_REG_OUT_CTRL_PROT_MASK)
 				     | SCA3000_REG_OUT_CTRL_BUF_X_EN
@@ -1401,17 +1385,17 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 				     | SCA3000_REG_OUT_CTRL_BUF_Z_EN
 				     | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
 				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/*
 	 * Select normal measurement mode, free fall off, ring off
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
@@ -1419,13 +1403,10 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 */
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-				(st->rx[0] & SCA3000_MODE_PROT_MASK));
+		return ret;
 
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+				(st->rx[0] & SCA3000_MODE_PROT_MASK));
 }
 
 static const struct iio_info sca3000_info = {
@@ -1507,18 +1488,17 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
-				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_REG_INT_MASK_RING_HALF |
-				   SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+		return ret;
+
+	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+				 (st->rx[0] &
+				  ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+				    SCA3000_REG_INT_MASK_RING_HALF |
+				    SCA3000_REG_INT_MASK_ALL_INTS)));
 }
 
 static void sca3000_remove(struct spi_device *spi)
-- 
2.53.0

