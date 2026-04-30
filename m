Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA727BF93
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515283; cv=none; b=gw0zTamtZ7fNLTOe93TfhqDJq6wlLBaf4TCQPTW0IMV9/5zlOWyccsX/Cock6kBB1iLS/M3lIZ4++sNuD8mvI3gfrntDbdbxdC+OI93GGG6J0awac2FJl8HiSX1QJzBFFEHAqSYfgyDr/EG9254E0AcxcC9hoaI2Ux/LPVqh9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515283; c=relaxed/simple;
	bh=JsHltVg/9p51USf9RqOqUZIyIFziEemLfG3McpKScvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kARR8HOLqWKmwMmeTZgq8fnJ+dSugmjOlqPvE6tmmTt7IscYZAQUmBj+wC4qdLY5Ie0gEfDt7ZfZPReDz1bGBsyuSWhWgcgGGT6xxnBdSE2izzdc2V3AoDbmhCaMahEinIxwS+VllC2RVAvoV5D41E9X+qPThSMzb7DUfsjP1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2omtQUe; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2omtQUe"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4645dde00a7so1086813b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777515281; x=1778120081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTdtKUVaNDrgJLOyHFxqOi1YzUMuCevDfpxXF7PGypo=;
        b=s2omtQUeIjFoiY7cm3hSvhPP+/J6bYxZ2RjXO6BBPwF3ZF8cfFtOzXdgOrOioe2wGY
         hGNk5jC3YV0GcSzfLmV9veY/PEQqnZRQ5MVFk4FXs5yzG29l6OT0eXUDZj1+QBp4gcJ7
         vxlFtXhEiSYZ0d488s3YwTA96Q/pTf5/yMBMLGpkYf8SKEsubGnXG3848zx8Hw0zw7M+
         rqTK5GTJPKudZs+QAGRS2Wsur01XcrBL+Ge9Hykks+4eKjFqArVLJeQz9t6ZtQi61zGc
         hochv1F93h8FDTJ/4PsY3Rju8r03Recqd8+rwJHdpn6XUJPZcW1/1m7gdNUlG4AIEfZs
         8neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777515281; x=1778120081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTdtKUVaNDrgJLOyHFxqOi1YzUMuCevDfpxXF7PGypo=;
        b=HGODoO7VvlsJSWIA+N/g2sRp+Em42aiu70ZSbqCY4TAg2pZ6cwo0nV2DGsN5qBo/lr
         S5Q8i9+GrU/ZwQ5t4uHay9DT8su86D1pfoY5CO5scktNoc1s5W5IEAWqhpQJ8eHMYePj
         MCb5ycw66FkqZ0lKfSutfz/qTRWcUnv8mHYyuLBQL66LdKEMh9HQ3I/rK4XCPspxTC+g
         2TGUoKKfS+X/WLwX2J7xSUQQy0bx6OpXw31vOiO7ZsN1bc6fMIYxyj9r/Xcw0tHtNqTI
         sn/3QP/INcm/oeOrYfOp5OSNFGfLXJhJm4HoEzyqu47yRVqUicWCJ+/UVD1VR5ZGJDuk
         wUYA==
X-Forwarded-Encrypted: i=1; AFNElJ/wZQJzr7+klIQ3T2AzaSYm4SNZ/qr0YuU9X2Md/kD8z1ss79Q3GRQq4ltbQAgJg3e9qk5Wvi1jELI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjJbojWy0z7eTNq6Q4XK1m+ONS72CGOef4BBOgOGilohE2Nej
	shEBrVX/ZAWPWmkDOtrrIuk62oLCpg31ho7dELuNyiJEtQZporTqms0s
X-Gm-Gg: AeBDiev4I96dVubNVQsC6Vx/mtG0b1ry7aJNpTP5GYslQ6t61X2vo8hfR7y+wv+/+fl
	rOnrebRxXl9h/ukM5cLNbOGshYQAe7wqynKjwgZQsoCEk8uEHYtqDPxOF/YVZEwsupbLzAuF3l3
	+G7SCyt2Wei6NXC5/HQgnhXwWDuBkYkEJdoPjyLHI/7nn0fIH459PAlhR2m05+/j+mAFRaXnpOy
	JOUpw2kwzx9Yr2Cbeg6Uwlzb8SZEPIx6xSzsiNfspdupyMimijDxu05yBUc20vjafMa2XwOrhdv
	aVPecrBAYZkEnMECxSDtbTmbC2k/DNP2CHJ1kqibgso7bb/Yr/f+s5dIlEZcD/3Mj3vAPwJB6Gi
	GJramprmHFxlfyDBRUxUsTY3pHgeLG0o0sXEcKlu19/ehFzJJDoqeqxeUdFx4p8sgRl2wB+vjJ9
	Roii76p7Bk8BQv7y04bVC5NiBfRTbUe/nfpP7tfq8DM7rVgP5psKuV7Q4ezJ1lxytOhhIS
X-Received: by 2002:a05:6808:4f5e:b0:463:a42c:503a with SMTP id 5614622812f47-47c6207d74bmr260564b6e.14.1777515281101;
        Wed, 29 Apr 2026 19:14:41 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c43edfbf2sm2109498b6e.6.2026.04.29.19.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 19:14:40 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:PNI RM3100 IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] iio: magnetometer: rm3100: Modernize locking and refactor control flow
Date: Wed, 29 Apr 2026 21:14:39 -0500
Message-ID: <20260430021439.67591-1-m32285159@gmail.com>
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
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 93 ++++++++++++++------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 2b2884425746..ffa9b46278ed 100644
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
+ * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read() with a mutex
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

