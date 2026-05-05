Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F736215A
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018843; cv=none; b=p63SUmTfZcVm+H4gf8ADFgdgLUdiC0wIReVWDJKLfDQpHnw6csVVlle74W5e1kHgiBWt6nVFi++Yz+GRfuoPmO4/AGMZbwqQH+zo/48zPZpOPUsBhsoGUfkgSZ//uLQvZuDTsMGAERt9T1U5m6yB9DE+rJUZ3Z2YsROmqXYUbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018843; c=relaxed/simple;
	bh=lZD7D11CckBI/PKQ7VizyDdDmJE29dmL8JUuxEkEhow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJmfZVMo3meeecKm1adZyM6w0otWnD9DOzUqKgaLbPhyui+vajvfWt9pOlxZDbEnArSJz8SPnrxUBosNfWuMdaGs9tr1jBPOU1UDRgRU5+w5iz1ZbvN3TceP+nfA5nARs8BTsndFdRN1WAN/vwn3b8HlrZnKM6qYAlH6B0dN2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8XFJda7; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8XFJda7"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-682fce74c06so4949077eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778018841; x=1778623641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3kzjFemdAtx6Fwcj2vfs9gjIG5kFgwI9kSRgO10wIQ=;
        b=N8XFJda7aX7r6pOEdi1SYhAbuesNsBODpVD3gN244e5BgN1HbWPwhosqAdU2Kf1DEG
         agWwpG0WAts1PKYHC9ore1hX9IJmbwhqzLAIsjLT1EFVEoQqLwgeuE2Py24IEY7Pz9P9
         EPckcQE5He0Bnu4p4gl/FbSZzV9tRuZlIDkll3EOo8QCw2U9MjXDxKyiAnnM9jD2DZij
         tbYTRqfMG5WuRGYCaV27QKEYUI/wehU6Ow3Z4eifhy5Yl2XZGDUklxgoHcH909Uq7Lzt
         Y95iPQzKnx9agSEKoVxvGIvDUP1jGpAm/+DjLm/PDGyLKzUDCU/51LFDc9ZcCcdM/TSV
         wBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018841; x=1778623641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3kzjFemdAtx6Fwcj2vfs9gjIG5kFgwI9kSRgO10wIQ=;
        b=cksKNifbGfhIqMB5TiklhgDfIcqyt8fLs9VKBhNrCo3Cs6BiGSEZjn4LSa0PREwUuH
         Gu1RtFQ60NLqBi1n9D8Lk7hxwNZwH8zxljLib2OyTDbChehxYDM9WKP/gBh00rZ4zX4b
         z+CXBojU+ejQVYpqnBR9FcBCGKoSjP1agqu9L7XCHiU0QOxAMBmuv8EwI3StLL5BRr47
         aHO3ONrDCzsl/0mrdelm+M8NAFVsBXfUZTQSNwzREY1tctbiZkZxXZXZCJWvXBOdupkV
         2cbf9/iLy3yS4d7NZ0EqJEFv5U8ji42nXuhiJnrp7zGTJZoGbq5hyBFWgMdnooB8ZgaE
         oySg==
X-Forwarded-Encrypted: i=1; AFNElJ/kAf+cfb5DMkYsSwkFZOkOfZ9rWKZWu7rSSjw3FXzhB32+jF5c5ZVe7gcad0uzDFRpsCSkgz+ZyeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+V5ekIppIsQT4s1CWQtHZvq4vIvMnpS1geYdEuJUI/c7ne2h
	ArrlNc5PNW6DvVKWPPs4hKiuemZd6D6mwSSp29hOTPR102MwecaiXSkS
X-Gm-Gg: AeBDieu4XrY7Q8iv7A/7n8u3r4BD2z0mKXm8fIR3DD2Yy+uJrYw+OgPCL88CEldcfZh
	aK/Ru3YMsBQwVnqUobPmGSLVs5lrxSrbzAfAa5Cg8aByz/hHhaVY2nIqp3jBMX0QflOO+y+GCUh
	fotVQ137Zbl4LT+Sf6n7BgRnn8+GmI0bFZfreNl3dmpm+NlUitfXudiSXIAmyGeUWSL15FhsL8R
	1mPRk4Fkkq3/TzWO78cRvM/6BqBQw5gduzb4+1+k6sNppCrBSTd2NS0pDuDk5pbN/NGXEcYUGZy
	2sZTXM/IBC12+ETDOpD+uhEGUo9ddVb1QdQpht9esohyfMEiIMd/cFgotUONZL/cIuavSeheLvO
	AeeFDZQr2O6+Y3FmiCl5lJbdLQq93wKXCSNu0zAKNECyOPGpvVvrDYqZNWM/KvoQ6Nn77LfwEre
	xkWSQADb2Hvv0u8WTIf8tGXAgYQvOhlwUWxLlMVw5ejeWOE8d2WoAvbjG2pA6ji/GA7Ut7ha8nR
	U59ATs=
X-Received: by 2002:a4a:e905:0:b0:694:21fa:4ef5 with SMTP id 006d021491bc7-69998cbb3b1mr395797eaf.5.1778018841039;
        Tue, 05 May 2026 15:07:21 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454cbbbd7sm13881595fac.10.2026.05.05.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:07:20 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] iio: imu: kmx61: Use guard(mutex)() over manual locking
Date: Tue,  5 May 2026 17:07:19 -0500
Message-ID: <20260505220719.44646-1-m32285159@gmail.com>
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
with guard(mutex)() and scoped_guard() where appropriate. This will help
modernize the driver with up-to-date functions/macros.

Remove now redundant gotos and ret variables, as the new RAII macros
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

 drivers/iio/imu/kmx61.c | 98 ++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..1f1a695ab161 100644
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
@@ -830,17 +827,17 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_SAMP_FREQ: {
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
 	}
+	}
 	return -EINVAL;
 }
 
@@ -848,27 +845,24 @@ static int kmx61_write_raw(struct iio_dev *indio_dev,
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
+			return kmx61_set_scale(data, val2);
+		}
 		default:
 			return -EINVAL;
 		}
@@ -945,28 +939,25 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
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
 	return ret;
 }
 
@@ -1020,11 +1011,11 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
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
@@ -1034,7 +1025,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = kmx61_set_power_state(data, state, device);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
@@ -1042,7 +1033,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig)
@@ -1051,8 +1042,6 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		data->mag_dready_trig_on = state;
 	else
 		data->motion_trig_on = state;
-err_unlock:
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -1195,19 +1184,18 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	else
 		base = KMX61_MAG_XOUT_L;
 
-	mutex_lock(&data->lock);
-	iio_for_each_active_channel(indio_dev, bit) {
-		ret = kmx61_read_measurement(data, base, bit);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto err;
+	scoped_guard(mutex, &data->lock) {
+		iio_for_each_active_channel(indio_dev, bit) {
+			ret = kmx61_read_measurement(data, base, bit);
+			if (ret < 0) {
+				iio_trigger_notify_done(indio_dev->trig);
+				return IRQ_HANDLED;
+			}
+			buffer[i++] = ret;
 		}
-		buffer[i++] = ret;
 	}
-	mutex_unlock(&data->lock);
 
 	iio_push_to_buffers(indio_dev, buffer);
-err:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -1419,22 +1407,16 @@ static void kmx61_remove(struct i2c_client *client)
 		iio_trigger_unregister(data->motion_trig);
 	}
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
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
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, false);
 }
 
 static int kmx61_resume(struct device *dev)
@@ -1453,13 +1435,9 @@ static int kmx61_resume(struct device *dev)
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
 }
 
 static int kmx61_runtime_resume(struct device *dev)
-- 
2.54.0

