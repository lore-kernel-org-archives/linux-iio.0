Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD2346A0A
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193221; cv=none; b=U1zK8EfmdLzjVKPvNzkm5AdWJLq1eDbgmi4iNAPm3poV+0l8dOlm4TYDb6VB+3YkJcwpFy0bbKC9erAnlObPUi2+bCpN54V3CribwInIn17MFfGWnDQONP4eP4J8yN0DZzl7XRO0i1z2tahkrAnO8VIMCApUMIXjkUQqjc4d7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193221; c=relaxed/simple;
	bh=vAQnHWxWMSNVh2a676rEuUjl0h7Nrh6Wlb21vb1bD/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCtK0XE2ITHxoYla0Jh4mZUanl6FRxPpwqUPMtT3whMmgGTdEhmKznIM1EYsbhHrfpvdqXRhS7tyIgS+sYRU17kFbTYokLu0j169/LDCod8lW66+TLrsZW/2yAJ3WlZie+zIfZlMdZxepBorP+Qgc1SECgg99AYFqT2NdtdkBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP95xn/5; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP95xn/5"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4233e152457so974831fac.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778193219; x=1778798019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQQUFa2MU4ye3M1dexG0k5SD3Kqn89ob1cFtn0xTS50=;
        b=mP95xn/5yOj+HQMB1ZTDaveHBfgPbgIN9NwRP3cJ4DlruE0/3095XGWZ01+7XuT0fd
         5bvgSwA+Grh8Yq0NAfk4S/QQEXAzFJLiO7FRpsh9JQXHsFSkxXhjOTA5xcX30JAVtMR3
         uPsUvgNe7JkiNlfIkRdpNIISs8IC+V0bdwgzHKF7HOIRXuGSBmNfJDS5E6PfMClvAgyT
         vWcJZLmyGDKv0dYbb1xNyOoBNMyfqahtP8KCquZv9wYUNw/340++RI63c5+nNJi/bFoK
         eYz8FaNXAZ6msTWfI6ItJBCfVswio1Kg7pzjpXkuAYSfpBBpQTmakuNMqu5h/g47gs5d
         3vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778193219; x=1778798019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQQUFa2MU4ye3M1dexG0k5SD3Kqn89ob1cFtn0xTS50=;
        b=RLDF2ffngLLQnMlR9L8hyFW5iptvASh52N3UgjF96Re2gm8j87dMEI36fO/bCaIbDU
         TloyRw9abv7fF55W6tGVWpNm1ni+GGChfhVqjjbooCU8Xl+SF9QadoGkE61hhzPgJWIX
         k3aINJ812240Xm4e86hamknPO78xSLIDwbu9ITMN5c3fBNblZowyH01PRXzNd49/CP+7
         KrRdwZVwbQN76vN+rQrWpp1V3NMxkfvAza0Y0QmFKTpTnMKBxUZDHDimcG78InGNPmH7
         4nY1+60vgbi5ZfYQEogqptv8JWeWsMiArCpJ4M29KH3f2RAwl2tY08E3GRRFQJ6FL5R0
         +dwg==
X-Forwarded-Encrypted: i=1; AFNElJ8zxrDNPONkY4LgiZOX9dvfUR8DRkWCsgQZeKfdrIiK130jlk0aJGgvvOG8YLQU/ugfoeEJVy8MWdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyco/Myf6I/ktUjLQfYq0BWENfF8tt2Velaq+Y4WfGk5JjZzAeh
	v2HV+QCrzwDzejSWU7Jagy3aV1FGWXuG4qEmiIZ5WCQNzKoikOw7owHI
X-Gm-Gg: Acq92OEv2EwrqEz7oQVkwcP1066Q+3Hoxfe+3Pe7Ywlf8ypKhsk/L+ZE7TkbDwGFaFn
	9LIkFaugRNGuB18DzZRL2Zy9m2xFBRl7/zhORilnozhXvadltbm/Jo+Au5fTI30QaCND7+R+o+9
	pX03dxoTdKdLnKrSknu38IapdPH+mrREZLatxinoIHlUmneGLirwMbKn6yZQ/d+g53QHOri3FbU
	RSZZHGtiIAIB+rBB9zwJP7KTP4BVK4yqMWxMw6ShPn0a0JunzLtuM/Tl0r81W3Y/NONUtLwDqCh
	+taFtbHbC5I9rM/fENwmqS7y/PPPoljhNM2YBOVOxr7Zg6xJUY34Mbdrh+vkuRGK7lGPDBxtqDl
	eML8w4z8qt8cp9GxYhXaEn+oTRpzOxXa73i2KTJFzSHoe/ELmE7jchTPHRpkAW7lkRLPJqt/gZ4
	izSK5a0o11WwZThNMORbgUqxDtP2uil3+RUqgROZ5LCwDuxDdkc9Acq3p9ew==
X-Received: by 2002:a05:6870:21d2:b0:41b:edc8:7b93 with SMTP id 586e51a60fabf-434f4e27a97mr6142209fac.0.1778193218617;
        Thu, 07 May 2026 15:33:38 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435571099a4sm97145fac.7.2026.05.07.15.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:33:38 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] iio: imu: kmx61: Use guard(mutex)() over manual locking
Date: Thu,  7 May 2026 17:33:36 -0500
Message-ID: <20260507223337.48437-1-m32285159@gmail.com>
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


 drivers/iio/imu/kmx61.c | 125 +++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..fe3f357c8889 100644
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
@@ -945,29 +942,26 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	if (state && data->ev_enable_state)
 		return 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
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
+ * kmx61_read_for_each_active_channel() - Read each active channel into a buffer
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

