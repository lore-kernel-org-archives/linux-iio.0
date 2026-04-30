Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED543FE661
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552913; cv=none; b=YojmZBJN/UHKpCSSpx49aXNfhoQjhY7wh0K4BscPjZw9NyX2GqgdS4HekIYEvgEdWWflD2lXqx6hN1jwvMdDZdRUYGeIL66QRkDCD0g58fHZP3Z/X0rYnOal4XJExBBfzLqALmPixab3Jd1VoeiMlBUd9jMV+7E7gEFgkw+28TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552913; c=relaxed/simple;
	bh=yE+dxtyo/mnBAWQmcnqGs/kf46ZHUImb5KeuSv5L+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qdgl623qJF8smGJsNCfvZic/ww7j54Iq0ufWAZrIw4OAnV3/35tvzkl1ems/6An7QDcgJJoSKp4i0oy7V6u5T4OtTbO8V78gGVQaSZ+Jo/UAVlQElQi1qxAJat3DfdFvoJ6y9MTkJLC4K7BDTorlKDwsDswSISupJDg+rG2KP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euL4OoIj; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euL4OoIj"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-41576c5c01cso498846fac.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777552910; x=1778157710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4HerAL4XgZ0CkXjzGik+1L67/vMPz2ImR9zq/nJdQY=;
        b=euL4OoIjuOT8QKorYuJGWyT3T9/4utHOlOpGSx7pZyAFNuF1TDrb6VFDtPWlp2SUfL
         6C7Th+1At5fIcyqfQcV2wgOY4yp4TCoZdBSu7PQwojCgwvQLVrivREcse6hrgZQcNOjg
         7WEnDMuunda2pjGTkaa4L94beZlAXbmqPdBkPoBbZj0NdTX7hYjcZ8STz5bLWEwjBaOC
         YeoBDLf8Ys3SL1wpoktRseLjszQrFlkuqMYQMsVIGupb+LWgAPbyBKKJ6lBrZ+sZIjF0
         EzYL/jdToR9iosOMWUAfadaJunJNDeCGeVJhvFaFZ3A7Rl7zp/X0zH5F2x+K/Qaxm7t4
         JdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777552910; x=1778157710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4HerAL4XgZ0CkXjzGik+1L67/vMPz2ImR9zq/nJdQY=;
        b=jmb7R/q+0bZ2cAhULemlNQzqv27BIDMC6qPRA9FuUkAhbEAPvVpsKtoOzzoWfiBNNu
         XLpCTallCSKB5Wtd3LBGQx5gDCKmQYhN8q39jlZ4v/eURboTdys16vuJrjRbOkOmL85m
         T/rrGJDrEkAZrVGH/EqpfztTFWlAr9Khm5eFAcjwI324ONNj5c6CZetygTWY1T/r937B
         E/nwOIXRg3poZm926JH+91yXnVkvEm+f+3A+gJIcOpwuh0uITW0i51BLJtxzQgDlTkr1
         wS5gAGlJ4MClpzrpgVw5pU2bv4qprH7Jn6gMv7MxHsu5Mfz511EhZA5yYniKLss+TUhs
         LBvg==
X-Forwarded-Encrypted: i=1; AFNElJ921J5eHFvLPaLNZWCdnmXAmS7jPSUeO9Wa63jmiN9DoIZVjuAXVZoSbLsDnm3Iqw/tSMH9QxH2AWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcXjUUY0wcsYgBQ7TLSnTvwHtkWw6n1gUNmuH5E2Sej/lxAcf
	zEB+xiKq+KZgyVzm4S3+1BJt/R9OyYWE6H3UwR0HcKaHGjHVxEDLnI6N
X-Gm-Gg: AeBDietiNtz9SKz5YBYsWtKUgu/TnP4ipZsHMmO9IGFeBowY+0Pn0eGZzN6JvT7xrkb
	KYs8ZeI75xEWeIf7NezRdOVcMuqlt5PT+bSePa49DNnwYHOiMVieF31SJ2a7iAajnExVT6dj/U8
	qOYvGcWw+PiUPhO7b9UcRp0hVdZaoGw9Bb7BGHPibZ32jdDoj+e2tlwpanGtQ9BW2pB+2e8R60T
	pLYs9NyBuJ8pRiHQMdLC/XEiY4yYWH8/HB5vEAaiQmK+88XWjJy3ckA4GN8XdSfE4+mUXlzPQKW
	IqLSSIrwLOR7VcbvCzYFOZgNEygFRRYCJ1RvLQuP75T1eN4ye1bjGZRDtF/dE9pG5Ek2CxNOoP3
	T33TzYZm1BbOPTl0OWcv8iFaAtsvKmVL3+M9z6qVRHayOl0Tim4H6RvGanA5n2Pudwu67oXbWu+
	7reQ0y/UGbuXqdqHCOZxH9lcoCB4YYiEBjg3A/luFzh6vMEtCldClbAI0J7ZjBURj6rkIY
X-Received: by 2002:a05:6871:332a:b0:42f:d9dc:2cc with SMTP id 586e51a60fabf-4343372314emr1477828fac.1.1777552910162;
        Thu, 30 Apr 2026 05:41:50 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434372a58c8sm1520905fac.14.2026.04.30.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:41:49 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:PNI RM3100 IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and refactor control flow
Date: Thu, 30 Apr 2026 07:41:47 -0500
Message-ID: <20260430124148.11572-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100-core.c with
the more modern guard(mutex)() family. This will help modernize the
driver and bring it up-to-date with modern available macros/functions.

While replacing mutex_lock() and mutex_unlock(), the critical sections
of rm3100_read_mag() and rm3100_get_samp_freq() have been extended to
include negligible operations for cleaner logic.

Add new helper-wrapper function rm3100_guarded_regmap_bulk_read() to
help keep rm3100_trigger_handler() switch-cases clean while maintaining
mutex locking and avoiding re-entrancy risks from potential callbacks.

While at it, remove redundant gotos where applicable, and use direct
returns instead. In addition, remove regmap variable in
rm3100_trigger_handler() as its references have been replaced with
variable data.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - The following excerpts are from the original cover letter:
 - Added small style fixes per Andy's suggestions (Adding blank lines,
    moving an if statement in a scoped_guard block).
 - Switched out scoped_guard() for guard(mutex)() in certain commits.
 - Fixed error in commit 4 where deadlocks could occur, as goto
    ignores __attribute__((cleanup)). This has been fixed by the above.

 v3:
 - Added new helper-wrapper function rm3100_guarded_regmap_bulk_read(),
   see commit message.
 - Squashed commit into one commit rather than four.

 v4:
 - Changed function signature of rm3100_guarded_regmap_bulk_read() to
   supply struct rm3100_data *data instead of struct mutex *lock per
   Andy.
 - Renamed rm3100_guarded_regmap_bulk_read() to
   rm3100_regmap_bulk_read_locked() per Andy.

 v5:
 - Fix kernel doc of rm3100_regmap_bulk_read_locked() per Andy.
 - Added Andy Shevchenko's reviewed-by tag.

 drivers/iio/magnetometer/rm3100-core.c | 93 ++++++++++++++------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 2b2884425746..c0ce2784e97e 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -204,27 +204,23 @@ static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
 	u8 buffer[3];
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_write(regmap, RM3100_REG_POLL, BIT(4 + idx));
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	ret = rm3100_wait_measurement(data);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
 	if (ret < 0)
-		goto unlock_return;
-	mutex_unlock(&data->lock);
+		return ret;
 
 	*val = sign_extend32(get_unaligned_be24(&buffer[0]), 23);
 
 	return IIO_VAL_INT;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 #define RM3100_CHANNEL(axis, idx)					\
@@ -284,11 +280,12 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 	unsigned int tmp;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
-	mutex_unlock(&data->lock);
 	if (ret < 0)
 		return ret;
+
 	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
 	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
 
@@ -338,56 +335,50 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	int ret;
 	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	/* All cycle count registers use the same value. */
 	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	for (i = 0; i < RM3100_SAMP_NUM; i++) {
 		if (val == rm3100_samp_rates[i][0] &&
 		    val2 == rm3100_samp_rates[i][1])
 			break;
 	}
-	if (i == RM3100_SAMP_NUM) {
-		ret = -EINVAL;
-		goto unlock_return;
-	}
+	if (i == RM3100_SAMP_NUM)
+		return -EINVAL;
 
 	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	/* Checking if cycle count registers need changing. */
 	if (val == 600 && cycle_count == 200) {
 		ret = rm3100_set_cycle_count(data, 100);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	} else if (val != 600 && cycle_count == 100) {
 		ret = rm3100_set_cycle_count(data, 200);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
 
 	if (iio_buffer_enabled(indio_dev)) {
 		/* Writing TMRC registers requires CMM reset. */
 		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 		ret = regmap_write(data->regmap, RM3100_REG_CMM,
 			(*indio_dev->active_scan_mask & 0x7) <<
 			RM3100_CMM_AXIS_SHIFT | RM3100_CMM_START);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
-	mutex_unlock(&data->lock);
 
 	data->conversion_time = rm3100_samp_rates[i][2] * 2;
 	return 0;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int rm3100_read_raw(struct iio_dev *indio_dev,
@@ -458,6 +449,27 @@ static const struct iio_buffer_setup_ops rm3100_buffer_ops = {
 	.postdisable = rm3100_buffer_postdisable,
 };
 
+/**
+ * rm3100_regmap_bulk_read_locked() - Wrapper around regmap_bulk_read() with a mutex
+ *
+ * @data: Data structure containing regmap and mutex
+ * @reg: First register to be read from, passed to regmap_bulk_read()
+ * @val: Pointer to store read value, in native register size for device,
+ * passed to regmap_bulk_read()
+ * @val_count: Number of registers to read, passed to regmap_bulk_read()
+ *
+ * Intended for use only in rm3100_trigger_handler().
+ *
+ * Return:
+ * A value of zero on success, a negative errno in error cases.
+ */
+static int rm3100_regmap_bulk_read_locked(struct rm3100_data *data, unsigned int reg,
+					  void *val, size_t val_count)
+{
+	guard(mutex)(&data->lock);
+	return regmap_bulk_read(data->regmap, reg, val, val_count);
+}
+
 static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -465,14 +477,12 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	unsigned long scan_mask = *indio_dev->active_scan_mask;
 	unsigned int mask_len = iio_get_masklength(indio_dev);
 	struct rm3100_data *data = iio_priv(indio_dev);
-	struct regmap *regmap = data->regmap;
 	int ret, i, bit;
 
-	mutex_lock(&data->lock);
 	switch (scan_mask) {
 	case BIT(0) | BIT(1) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
+		ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MX2,
+						     data->buffer, 9);
 		if (ret < 0)
 			goto done;
 		/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
@@ -480,36 +490,33 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 			memmove(data->buffer + i * 4, data->buffer + i * 3, 3);
 		break;
 	case BIT(0) | BIT(1):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
-		mutex_unlock(&data->lock);
+		ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MX2,
+						     data->buffer, 6);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 3, 3);
 		break;
 	case BIT(1) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
-		mutex_unlock(&data->lock);
+		ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MY2,
+						     data->buffer, 6);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 3, 3);
 		break;
 	case BIT(0) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
+		ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MX2,
+						     data->buffer, 9);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 6, 3);
 		break;
 	default:
 		for_each_set_bit(bit, &scan_mask, mask_len) {
-			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
-					       data->buffer, 3);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
+			ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MX2 + 3 * bit,
+							     data->buffer, 3);
+			if (ret < 0)
 				goto done;
-			}
 		}
-		mutex_unlock(&data->lock);
 	}
 	/*
 	 * Always using the same buffer so that we wouldn't need to set the
-- 
2.53.0

