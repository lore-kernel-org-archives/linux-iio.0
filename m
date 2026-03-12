Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEC2F9D98
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303638; cv=none; b=JgbWZNlmUoGfGGnJAB1o4olJi6zrUFdMvpy3/5RQlG3aChbKWrMRO+QcYJrBkn5VXxvQ08nHKHBadQKz2AKZ3Wpya8qBF0rqtdLQuZvaMZjrpE9ascCPL3fzV22cP6B/U7sLATpc7vOOTighMyuOmrvSg6DW4dIecxBBeQOQ0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303638; c=relaxed/simple;
	bh=KBL2KAHrydV/D79+7VJo4kt+VPO0aydUCdNVSju3OPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAMR9NGvl1HuFT4jxpDoQp2dNIvARRULJKD7/z306i9Ctf9TZOo9Fkeju8SwSoIh0j5zKeiUdAWw21kkgXz0v0AbuYqb22EXLhInlX1MY3SHjuBShkVZu+ghA8urfTQD0+Dxl1iSbEWA0UkO6tfEXOrje/je8n709z2BJGpsdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHLUB6Na; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHLUB6Na"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae505619baso5468065ad.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303637; x=1773908437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yns/Hh4dMhlD/GzsEPl3R4E74c6TjlD5Sw6wnI8YU3M=;
        b=MHLUB6Naq0DM71/rY9hCvhJZ6CmT1M0zg7mPERIouTtomzJxg2wZ7d/vY2cnjH/UDy
         y8sgUv5kSfGFVv9GvVjMG2HCFrMu5wCZt7PtagFrSXuKx9MgMXztPwDpG0b2aCqz1QBB
         ckdQWD9O3fO/OVHe6PN4o8Zq91KVTow8J0gO0dq+C3HZrD0HyAsgQIoUYYXtimDJ0rx/
         hQJfdBohp43VKAsKsMsri0wBII5Ew63sresZIUc8ZCOVSidSrsJUv6hY7nXOYap4QBKZ
         TrKsHlOQKLtJpVcem1YmiuaxppPQ/wPd6hboTB86eclsFG55ENd0WhS2ClPBUZC5uCiL
         ayeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303637; x=1773908437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yns/Hh4dMhlD/GzsEPl3R4E74c6TjlD5Sw6wnI8YU3M=;
        b=K6GEPPQnTL8ZpcJAg4tf3+2mh1StXaE5XEhYHkOLEtTdKWAmojXyjUB26Hu24eEYM0
         azGO2I2MqxtDGkJxfRqLdpWy6+CU1y4XyTR9rta5N4oOFqnmM43vRvAssloMKAttdY07
         jJYMFNWxtqkEydJZRn5H5QKxC63fgdnTWv5pR/ftf+rBKRik3BFyoh4K2cwvAu2Wy9Ap
         mhj33pf86af9EXTTW/EFsEUJxi32b8OnsduKzcyINv8ZWEsCa8pT6lc8vAhvuWQyr9Np
         Rx+ptGCSderOdabL/HYnvbPVUl1ADpG1istk6bgFJ2DwyCYRyBzicxYlZ4I2kpLBxkZy
         lHNw==
X-Gm-Message-State: AOJu0Yw5FKj1NPG+kyJolrXgxmoCzu8GANzBwxaZfRYX1brl1iJPJb3x
	YZU2J8vWCPNcb1NQvo+/Sjnc7WI2QrO6yiNl9T2/UYTO0q6qUx9PldoE
X-Gm-Gg: ATEYQzypH0uLfDe3RJC3pg8n3p+pufe0Wvy/upGmpswpQQ7gyJmoO0N+OC/NpeJnXfO
	z91unoAGTd6oavW37g+/tBJom6dk0kgRrNO6qVlrTYXj5DLVbBBApvD5OQNj0ABz8Y90kNRo5Hf
	l7sIxhs3I2vmzHz5SPh+Tpg74oCAXXEq9d6IzSfE39ZiMGSjCwWkhrBMMcnTY6QG8xHhiF5PtHQ
	hQq/eVZBD6fua+vzS816gTc5hJlZGIWFUxsPmvrum0Z7abiU4qB3iDbh2Q3rO2NbBlgn2LF031R
	VXsFxHmIXHsDFFN5LrftMEfWnFJv1tsd/FprRNFQyRwTn8+QWXSTFRETepo5QqCV0Kohd0lt3ro
	DP66IgbuiGYrjpyBIZHh7yi+v2RhgwRi18QllepkIOETyLzxbQ4ZhEQdX3yi3x3MKtRsfLb6uW4
	vN5H+sFue8K8QS3990Eh/3T2lKIgGNAVwWcdy/IHA9xDCaSLCUvYtm80t3cShdKDMkFpu0axFKA
	ETmT7s81EJHiJaw0oglfw0WiRVbSkeJWQ==
X-Received: by 2002:a17:903:2412:b0:2ae:4aa6:dc1a with SMTP id d9443c01a7336-2aeae8dc06amr52879765ad.42.1773303637035;
        Thu, 12 Mar 2026 01:20:37 -0700 (PDT)
Received: from fedora ([103.92.106.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae24a91dsm64388905ad.31.2026.03.12.01.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:20:36 -0700 (PDT)
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
Subject: [PATCH v3 4/4] iio: accel: sca3000: convert to guard(mutex)
Date: Thu, 12 Mar 2026 13:49:42 +0530
Message-ID: <20260312081942.23858-5-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
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
v3: Fixed return statements to make it clear about good/error path.
Removed Not necessary return statement in sca3000_read_event_config().
Dropped else statement to reduce indent of the code in
sca3000_read_event_config.
Fixed indentation.

v2: Dropped Header alignment change
---
 drivers/iio/accel/sca3000.c | 139 ++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4a827be439a2..2586a72d36aa 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -9,6 +9,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/fs.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -424,18 +425,18 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
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
@@ -996,13 +997,14 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
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
@@ -1011,7 +1013,8 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
 					num_available * 2);
 		if (ret)
-			goto error_ret;
+			return;
+
 		for (i = 0; i < num_available / 3; i++) {
 			/*
 			 * Dirty hack to cover for 11 bit in fifo, 13 bit
@@ -1023,8 +1026,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
 		}
 	}
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 /**
@@ -1110,16 +1111,15 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
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
@@ -1129,24 +1129,18 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
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
@@ -1277,23 +1271,21 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
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
@@ -1310,26 +1302,20 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
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
@@ -1342,17 +1328,15 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
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
@@ -1372,25 +1356,26 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1398,17 +1383,17 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1416,13 +1401,10 @@ static int sca3000_clean_setup(struct sca3000_state *st)
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
@@ -1504,18 +1486,17 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
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

