Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC91F936
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779402648; cv=none; b=VXW5/mruQunceK9+LFtVcMGaz2Ko8zGDdKnfZdWV02el2YMLvz3qLYfYD4C4NtXUHSW9m8uvMLjTn3VvC/mpLUbfNdgrJ83CsxozPHDGqGU2HS2wAc1Kz24gWhRG99ndvsdlP/Lg9tfcFK3eK1f0TWfp4Bd2tTQBHxS+4Twfwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779402648; c=relaxed/simple;
	bh=VnXfzPH9brgsj50Stf9Abp88lRTU/TIIhpm+W/WOzho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sogov9iMUNu/J1dObNDoingeC+39mu8eVVHY2R6MUFheT7IotZOskEaM7YGUmT6UmavrCAcAP8SGi3HDhCdeMzaQxKh1Z46AlPjHjHGqiMXPHpEwI0ze2sZ07LAAittRv8KOjaI/5uBBp9Uly8ABCVe+SyFFVab1teHj/uSoaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unc1FaaG; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unc1FaaG"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e55b95ba13so3758134a34.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779402645; x=1780007445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMhBDFDgKZRx83UVOPdiHbmxSFoojJEMEdJIQW/FVqY=;
        b=Unc1FaaGIUxUCq6v8eQVzuCR0V9XOA9qqaWTULTN9GXsA7vxrkJhSD5MWxHiCtKZ5/
         mKHsrBQdeRSxYbEeKsskdVYmimVqKr68YOK/hmsbrg26PTxGEzilJg7xHmOORKvLhq/T
         9uT2awOkuoxS8lJwMDR4ZaMi+WnzXxIH6w8wup1l6TZc1Nn2GRpvdOKFHU/nuVgRSyGA
         9sr8ku4zox/VEsXICBq7wx9JlSDte9cq3K83QqDvTwamts1A6zJH8BUxj3dEIsVYZ/u1
         mvgExi8jY5WQAB9CFaIjlank1C1WS/ACoTFRT/PsHVtTKLMg79uz/PmU3t4F+K+W01dK
         i4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779402645; x=1780007445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMhBDFDgKZRx83UVOPdiHbmxSFoojJEMEdJIQW/FVqY=;
        b=EHAF7BxJ9AH0I+WUwW2SqlQ8r//0WGdGHB2ARm/2phiSWzAZ/V4KwMfPyFgwNTgMZF
         NJeQXCoSOfVRo0D4K3e+ga+8ZEEfpf+8zT156u0xCA1zSplBHX7rPsNamGm7bm2J9bhg
         VVHOv1QClqXYdpfVsMo1HDcQU2sQPB5i/eE651yAw8ntSQApnqTXHJNJrg4AJGLU0JgH
         HRrIY9iuGFDsOPwq5lZ2vHGBuznUa7pfZceLsqZYupvP3uz0x6/9TJL6Dkiek88LMEhJ
         oXOHt12+r5DDYgPUmGc5/pEgRQ4tnXghCJHkEH0ic8Dzm6x30ll5C63eG/xIWJ9JXv4e
         jSeg==
X-Forwarded-Encrypted: i=1; AFNElJ8NfrM/0dgusUaGg4g87hfJT3rihqh2N2A8ualfDBNon4g2yUswWGowiC63WEncqdj0E50abmD9GsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjQqm8HW9fI14oqugovZjaFdPFYoltbFeobCC9AeuJcMtQ+4S
	KT9yk6mKp06nuGhKt1loir6Io4QovUpQGEUWuEXFEhu88VDHK5eyjykRsaE4omIHays=
X-Gm-Gg: Acq92OEI4ZfdfHMUzZ09xz/Dnta/uvf0Izchy88nS8vbU4cdsECIa8xpWyPxSNWQeix
	pYpQyh9PbCRih3LDun4UMUQA991V42Sz630EJw7YvvzKHSp+ft99uoUYyI0asyQuc+AylUAiqDA
	GshMacwQJ/U7jtRejHE1SZK7/J/8AjEE9kxIucO/nBycC+echKfzkyN3YYoo8XDMMXpO2lAntEk
	Hm+niKDPr8fMJi5mtAck4CVLGgHqGFkSYcoQW5d2mpsPf8nXqDuWqwSe+5NkT1dFWFPrU0P2SjJ
	WRV9JnfjSAlPd0cxWkia03m0Wxf0c3FrG6CnYdTRfWtevs/3H4tSfuoYxZlzRamV8WVuMOzgSor
	IburlK4xcgUSeSWIV9rTfmIEYoICG//Q5GqN3stmRwukJFPbJnh6oecRgNN/G00kc/zs11bChqd
	sSkeUbKms5vxg61xcu1feNs6Ieb71eTQUqVV3AgkRYJP56G83COuH88JKcPGVNlx2euANnYGZXf
	N3RyCk=
X-Received: by 2002:a05:6830:349f:b0:7db:b5c9:2d87 with SMTP id 46e09a7af769-7e5fee043cfmr721201a34.11.1779402645566;
        Thu, 21 May 2026 15:30:45 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60094a23esm332463a34.23.2026.05.21.15.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:30:45 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7] iio: imu: kmx61: Use guard(mutex)() over manual locking
Date: Thu, 21 May 2026 17:30:43 -0500
Message-ID: <20260521223044.61410-1-m32285159@gmail.com>
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
 drivers/iio/imu/kmx61.c | 129 +++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..6e9eafc06d78 100644
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
@@ -834,41 +831,40 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
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
@@ -945,29 +941,26 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
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
@@ -1020,11 +1013,11 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
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
@@ -1034,7 +1027,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = kmx61_set_power_state(data, state, device);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
@@ -1042,7 +1035,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig)
@@ -1051,10 +1044,8 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		data->mag_dready_trig_on = state;
 	else
 		data->motion_trig_on = state;
-err_unlock:
-	mutex_unlock(&data->lock);
 
-	return ret;
+	return 0;
 }
 
 static void kmx61_trig_reenable(struct iio_trigger *trig)
@@ -1181,30 +1172,51 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int irq, void *private)
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
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto err;
-		}
+		if (ret < 0)
+			return ret;
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
@@ -1419,22 +1431,18 @@ static void kmx61_remove(struct i2c_client *client)
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
@@ -1453,13 +1461,10 @@ static int kmx61_resume(struct device *dev)
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

