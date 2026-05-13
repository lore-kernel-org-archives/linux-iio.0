Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572237B00C
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638019; cv=none; b=pCSXxEtIlZ7SV55MA8n2/JQGRAjw2xDr52FAo9Qt7AVMrsup9gUwlwojoGOhDbJxV/c2+M+rhkG8dziWJTljF8ur1jXrbIJ/MZder11NKGcY0VdB+PQlLG8ASvJxd3d+0o+Xq4CvpN6cN+S5Udmi/yLXFfIvkz6JnvaoGAp+9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638019; c=relaxed/simple;
	bh=vond2xIWWthhre52p1kIFAniJV4Kjqp9incPlq1jEgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWH0eaxl7LecrJvjlJZnhNm7WuOPAdEGiM6DqLLs1FUOjqQPON/tEHFnjynia6U1Zhb1sZ5vx6fZpFYGSWYZpzNxMHOSlOzcmvjK5zcsUerbmHTZwskQYu53c4VMg7Sk91qNhMlpMRLD/FQIqxNILuqwVIvNec4ziBm/41wNLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh2ECuTP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh2ECuTP"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d4df9035so4638602b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 19:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778638017; x=1779242817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDhy/x3DM4FisnOspwaroIeEW+Xi4GBI8y9aLOvUOX8=;
        b=Hh2ECuTPrYPkf3Wa4kf+scDIsUFCNdUIK4o+3Z9WB3fTJIqd3Qso4WaJqHzTBXydTN
         PrGWhPPkoGCTym2g82UgQSPMsCW9LK+zSXiRopSovdgEmzkk8/W6aQoA8c30ttBe2pFL
         cDJWzx350ugC67oKKMI6Dzod+npzuB7BSIur+uLh/bH72zMsU2GAXLM5eNTFRXrywSIQ
         hCgXg5wOUxdYvJGlioL3YmVF+GpwB0vEmX3BewAroufmFmMQj1UIQlnZR44KuJaTj1Ul
         z1kG4Rhwk48CfQBds6zIsLLmFqo6vtf1TASZKdksQlTKwBxvaqx7sezEzwLqUfcXFnlJ
         kVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778638017; x=1779242817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDhy/x3DM4FisnOspwaroIeEW+Xi4GBI8y9aLOvUOX8=;
        b=rO9nABhVamFAN9D4XT0B7DheXhsiTry8Y03WDuSTPvZQ6bWLY/MRRr4yFOt5nTm8ew
         SDBDwCiPOEbUk1+uXA7ILeMTaOj8+7jf0akycd4vZe7tgGc1jhvW+I18662r7n/cE2xU
         CD3JOGJsAWWOqECttXNw6oCcFOj5tTRm4YV3wfudvgx6F1detbTX6PPgX7CSO6HfLNrl
         BQiOwD4x/QQ4bQ1VbBbTCHwzCcRMFiIJzUmBKzyIXP3MEmUOq9JonQOkkoZCpFdfqsMb
         3TziWCaMbX2CJRWKLbKC/3RI29s8i/BEUvtlcJsSkNvykxSLxBCWtltt0ttNwmCqX4gx
         9+UQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Netfg7+0DhHcUZ/0o369Dswc4slKb+b2vnfCmi8RPj2nEzT7NoCyR7Fh9oGByMhit0peV5OR8nAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywn5xQS0fU9pTpxfKrInvzXSjILvSJJZqM4FME2cU9LKTW7cFP
	SFbnm9yEZDRs2y/ndRNIH6wqc64lXfjczv8F9w3mBjny23kx2mLXAu3j
X-Gm-Gg: Acq92OGuLZWu6fuO6Bj/vghxz6zUmejB/cmgxHF8i0Cp3otFZTktNPFi4fVQ/a0grfj
	GCHYaSrz4fwYUSjdhf8v5bDznV62TTKRQNiUmtz9hprfJE1WE9w0a3TRIBzluomIKD2sDRpNJzI
	nPTg97PpS8+KBY2z77lOvphJWMvrbftDS9xPXjbLvWc0ERI+Uy9qJb9yCnHgYJNipMuiGr8EwrF
	zRMc0/kFNo1COATvj6/0Rw8rDrDDqNwijQmbj89CGVWMO1bWN23qYjPQ6MNlZmCzVzJGnydeSTJ
	HN1MzWmW9Uah/3AED94UjA0rFbGHdrdpjmcPIqfUpk5lKtuSKCeTOKoRs3qrl9JcfpH/aGXCCuF
	aqecKvct8z7xXKgSrrr38or+CD8gkBCTzi4utZrijqKfhedr4qDkfOkecLISIaQG7vq/DKPG3UM
	AD6/wZLvTgUNbIVnskIkH3THNLJFXbOful0fuuM79kPkSBYhActNVhIb4HQw==
X-Received: by 2002:a05:6808:e401:b0:479:40d4:b140 with SMTP id 5614622812f47-482b2de0676mr726248b6e.21.1778638016806;
        Tue, 12 May 2026 19:06:56 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76936271sm23449951b6e.9.2026.05.12.19.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 19:06:56 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6] iio: imu: kmx61: Use guard(mutex)() over manual locking
Date: Tue, 12 May 2026 21:06:54 -0500
Message-ID: <20260513020654.168071-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/cleanup.h to take advantage of new macros.

Replace manual mutex_lock() and mutex_unlock() calls across the file
with guard(mutex)() and scoped_guard() where appropriate to simplify
error paths and eliminate manual locking calls.

Add new helper function kmx61_read_for_each_active_channel() to mitigate
certain style issues and to prevent notifying that the IRQ is finished
whilst holding the lock.

Update certain returns, and add default case to return -EINVAL in
kmx61_read_raw().

Remove now-redundant gotos and ret variables, as the new RAII macros
make them unneeded.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Remove redundant blank line per Andy.
 - Put kmx61_set_mode() function call in kmx61_runtime_suspend() on one
   line per Andy.

 v3:
 - Add dedicated scope for guards.

 v4:
 - Fix certain scoping in switch-case blocks.
 - Remove stray ret variable.
 - Used scoped_guard() in kmx61_trigger_handler() instead of guard()().

 v5:
 - Added new helper function kmx61_read_for_each_active_channel() per
   Jonathan's suggestion.
 - Add default case to return -EINVAL in kmx61_read_raw() per Andy's
   suggestion.
 - Add blank lines between guard(mutex)() calls and regular code per
   Andy's suggestion.
 - Change last return statement of kmx61_write_event_config() to be 0
   per Jonathan's suggestion.

 v6:
 - Rebased onto TOCTOU fix per Jonathan's suggestion.
 	- (note: now dependent on said commit, link below)
	- link: https://lore.kernel.org/linux-iio/CAKqfh0GHVtAS6Uw3Bjo+B0PCpcfT8FogqEPCmt2x59zhmmh1Kg@mail.gmail.com/T/#t

 drivers/iio/imu/kmx61.c | 127 +++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3afa369de3cf..b7bd2497fecd 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -7,6 +7,7 @@
  * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
  */
 
+#include <linux/cleanup.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
@@ -783,7 +784,7 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		switch (chan->type) {
 		case IIO_ACCEL:
 			base_reg = KMX61_ACC_XOUT_L;
@@ -794,28 +795,24 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 
 		ret = kmx61_set_power_state(data, true, chan->address);
-		if (ret) {
-			mutex_unlock(&data->lock);
+		if (ret)
 			return ret;
-		}
 
 		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
 		if (ret < 0) {
 			kmx61_set_power_state(data, false, chan->address);
-			mutex_unlock(&data->lock);
 			return ret;
 		}
 		*val = sign_extend32(ret >> chan->scan_type.shift,
 				     chan->scan_type.realbits - 1);
 		ret = kmx61_set_power_state(data, false, chan->address);
-
-		mutex_unlock(&data->lock);
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ACCEL:
@@ -834,41 +831,41 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = kmx61_get_odr(data, val, val2, chan->address);
-		mutex_unlock(&data->lock);
+		scoped_guard(mutex, &data->lock)
+			ret = kmx61_get_odr(data, val, val2, chan->address);
 		if (ret)
 			return -EINVAL;
 		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+
 }
 
 static int kmx61_write_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int val,
 			   int val2, long mask)
 {
-	int ret;
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_SAMP_FREQ: {
 		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = kmx61_set_odr(data, val, val2, chan->address);
-		mutex_unlock(&data->lock);
-		return ret;
+		guard(mutex)(&data->lock);
+
+		return kmx61_set_odr(data, val, val2, chan->address);
+	}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-		case IIO_ACCEL:
+		case IIO_ACCEL: {
 			if (val != 0)
 				return -EINVAL;
-			mutex_lock(&data->lock);
-			ret = kmx61_set_scale(data, val2);
-			mutex_unlock(&data->lock);
-			return ret;
+			guard(mutex)(&data->lock);
+
+			return kmx61_set_scale(data, val2);
+		}
 		default:
 			return -EINVAL;
 		}
@@ -942,32 +939,29 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (state && data->ev_enable_state)
-		goto err_unlock;
+		return 0;
 
 	if (!state && data->motion_trig_on) {
 		data->ev_enable_state = false;
-		goto err_unlock;
+		return ret;
 	}
 
 	ret = kmx61_set_power_state(data, state, KMX61_ACC);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, KMX61_ACC);
-		goto err_unlock;
+		return ret;
 	}
 
 	data->ev_enable_state = state;
 
-err_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return 0;
 }
 
 static int kmx61_acc_validate_trigger(struct iio_dev *indio_dev,
@@ -1020,11 +1014,11 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (!state && data->ev_enable_state && data->motion_trig_on) {
 		data->motion_trig_on = false;
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig || data->motion_trig == trig)
@@ -1034,7 +1028,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = kmx61_set_power_state(data, state, device);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
@@ -1042,7 +1036,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig)
@@ -1051,8 +1045,6 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		data->mag_dready_trig_on = state;
 	else
 		data->motion_trig_on = state;
-err_unlock:
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -1181,30 +1173,52 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t kmx61_trigger_handler(int irq, void *p)
+/**
+ * kmx61_read_for_each_active_channel - Read each active channel into a buffer
+ *
+ * @indio_dev: IIO Device struct to read from
+ * @buffer: Destination buffer to write to, the array must be of at least size 8
+ *
+ * Intended only for use in kmx61_trigger_handler().
+ *
+ * Return:
+ * 0 on success, negative errno on failure.
+ */
+static int kmx61_read_for_each_active_channel(struct iio_dev *indio_dev, s16 *buffer)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
-	int bit, ret, i = 0;
 	u8 base;
-	s16 buffer[8] = { };
+	int ret, bit;
+	int i = 0;
 
 	if (indio_dev == data->acc_indio_dev)
 		base = KMX61_ACC_XOUT_L;
 	else
 		base = KMX61_MAG_XOUT_L;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = kmx61_read_measurement(data, base, bit);
 		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto err;
+			return ret;
 		}
 		buffer[i++] = ret;
 	}
-	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static irqreturn_t kmx61_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	int ret;
+	s16 buffer[8] = { };
+
+	ret = kmx61_read_for_each_active_channel(indio_dev, buffer);
+	if (ret < 0)
+		goto err;
 
 	iio_push_to_buffers(indio_dev, buffer);
 err:
@@ -1419,22 +1433,18 @@ static void kmx61_remove(struct i2c_client *client)
 		iio_trigger_unregister(data->motion_trig);
 	}
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
-	mutex_unlock(&data->lock);
 }
 
 static int kmx61_suspend(struct device *dev)
 {
-	int ret;
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
 
-	mutex_lock(&data->lock);
-	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG,
-			     false);
-	mutex_unlock(&data->lock);
+	guard(mutex)(&data->lock);
 
-	return ret;
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, false);
 }
 
 static int kmx61_resume(struct device *dev)
@@ -1453,13 +1463,10 @@ static int kmx61_resume(struct device *dev)
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
-	mutex_unlock(&data->lock);
+	guard(mutex)(&data->lock);
 
-	return ret;
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
 }
 
 static int kmx61_runtime_resume(struct device *dev)
-- 
2.54.0

