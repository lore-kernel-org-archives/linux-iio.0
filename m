Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9EC34250D
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985231; cv=none; b=kn+DYgBRPd4IESeZL6n1V+u0zfbLnAvWK7FDAQScL/U13aM1a2g0gBPXszsmLxVUiWrxcpgVKo7c8P0cLPnGOkHCKJdSlrXLFmUHFqLrnNrJTODhhYmXwNnGZU6tYcisjFXyte7QF64dmMu5hFQY0usic3uJpKZflh5p5a/WI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985231; c=relaxed/simple;
	bh=ctoc8LlLlBjE0niJJEck2zd4RQOEPqXc2Twy1eMgRNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3azopu+vhDHS9AzfXVuWK569M2utLjR1QKKSTlHT2eoN6VYQCdoNA/9RdGKiXLV7wI9pwN+CqlARhS0xJMaG8CtRjNSly7MFjG7fQtBWsRhxB7HC9emOV+YKF/awe2apQ970kk0Eu5RJS5LLEj9488zoW6DC+DJocRzHn1ZHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pToD/QrL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pToD/QrL"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479d37e7d7fso1514786b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985228; x=1778590028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVMRujASvDSHhgOv+ec0q+nHlkOG175QBTOF3/J/MAc=;
        b=pToD/QrLfec1lpwCh0/bnVeLNpNCYgCkZjgi/3pSC44syY3UKnc8XMz8a3aIENZ53Z
         mGYG1LpIUWG+/LbWC3e6MmAVqIwIU4Lbx4Nzmc9byNy6Rv1vxiTKv+m3ZVdPQbvH2oI3
         dW1TFXco0ciKCBEV3XNyFsP/+35rXZ27OPPJPOe6YpIb+kW21+rHHvPTnBZjhdvmeIpQ
         EoCmQUmByZEQbZYUSmNdvNa5eYyh7l0diFf6ogFzJJsU35oLeTfrlbnoHyhI8n+dDpxn
         +dHAoWHQv/VmTfpMzStU/3nDd3UtP+mZDnU86BpPnLGbbIWoyVVFb94INwfMd7BRjx/D
         5Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985228; x=1778590028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVMRujASvDSHhgOv+ec0q+nHlkOG175QBTOF3/J/MAc=;
        b=lw586KT86KXFatNkVrK6rZnfrRUKweeuZ+obG1bUXsCX/5wEo/Fw09+ZbNuAPahm46
         NEdL6jxAbQfWzG06pec3eGdICWajaXTwPJ8D8oR3My7UoPzOIeee6ZjYd79ycWnt3pMt
         M/Pj4LMOnZPDT5WZzwlMa5X1vgq6zxjIGpFy9LnRgoPhKZpo7IoOjnT98sTkqtQBxtq7
         XSI3NMglw8+bUgbvX45129zHs4OtsxhGqZl7MyFN6T5jK86JueZDmenulplsm5y6f2AR
         dTWMWiwoMYyVE/qK7w2/sENJKHOTERBnQQLUnAs3GSien5hGo3EyM3+fStEzjpr0sKx+
         qdtg==
X-Forwarded-Encrypted: i=1; AFNElJ9pfGyD+aoHJm2H+dYMya1CJqXIP2G4zDEDnfSoT0uErTBF/uviG/uw9rlNjaOyOSdFWMLBkEsRnHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQa+Dy/U/1FaWhTSA+CbTuuglxN2pcn+4UjpRz7GmK+e5ouTbU
	Qg7CkjHPGyKPlD+UnUWeMhOqLgo4oSCjJZq2ALUd3V/sVMWqWYfrXPH2
X-Gm-Gg: AeBDiesbj3LnMDQx42FWb6TZ1GiV7GdzmvjreCyaXUXr888IXIfLW2Su2MYYzOrFPe5
	AX6ttDPZLJpuiyH/VoqxkpMj0/MasFaa7mJ4rX7A/XEPyKdNh6HWqHYrV0ULCjuGE1Q+S67Uny6
	NOzuLVzQPCuNiIvkfQ+FReaMTcokhY93Go0qy2EbZe+CeM4caVLAFfhdyoG1uPrWfp2SJ3xd8Nf
	SDR0z2yRRZ0tdQpr9rBD5uBQl/tdSQalZi3QuY4ksnmFQ8MKSKkI36c0Xin29NhpbgQiK5KeBMj
	ogafVDLf2YPtzSx6cUpgNFAp9Yu82bqdmSYl30FE1xkQeQAo83oFh/8pFg3FzSrNaVIzQgPtzh0
	cOEvIGraV6p1n4EWp+c0J/bYmkvEEZDrf4nnL8R43U95FmefwcytQ1a64u64sM0DeFQvnc9g3J6
	UZZy2pwI4jNuMbVsFEneOI+JqZZK0Nn9dxJoOBUzkVY479QHOyslrztv5bvalWWtfR9nsIzXY3Y
	XpSlNA=
X-Received: by 2002:a05:6808:1644:b0:479:d48f:d6e0 with SMTP id 5614622812f47-47e25c66b68mr1285304b6e.19.1777985228094;
        Tue, 05 May 2026 05:47:08 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b32dbsm8596627b6e.3.2026.05.05.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:47:07 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] iio: imu: kmx61: Use guard(mutex)() family over manual locking
Date: Tue,  5 May 2026 07:47:06 -0500
Message-ID: <20260505124706.9862-1-m32285159@gmail.com>
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

 drivers/iio/imu/kmx61.c | 82 +++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 53 deletions(-)

 drivers/iio/imu/kmx61.c | 88 ++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..a112e291c064 100644
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
 
@@ -852,26 +849,24 @@ static int kmx61_write_raw(struct iio_dev *indio_dev,
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
-	case IIO_CHAN_INFO_SCALE:
+		guard(mutex)(&data->lock);
+		return kmx61_set_odr(data, val, val2, chan->address);
+	}
+	case IIO_CHAN_INFO_SCALE: {
 		switch (chan->type) {
 		case IIO_ACCEL:
 			if (val != 0)
 				return -EINVAL;
-			mutex_lock(&data->lock);
-			ret = kmx61_set_scale(data, val2);
-			mutex_unlock(&data->lock);
-			return ret;
+			guard(mutex)(&data->lock);
+			return kmx61_set_scale(data, val2);
 		default:
 			return -EINVAL;
 		}
+	}
 	default:
 		return -EINVAL;
 	}
@@ -945,28 +940,25 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
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
 
@@ -1020,11 +1012,11 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
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
@@ -1034,7 +1026,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = kmx61_set_power_state(data, state, device);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
@@ -1042,7 +1034,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig)
@@ -1051,8 +1043,6 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		data->mag_dready_trig_on = state;
 	else
 		data->motion_trig_on = state;
-err_unlock:
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -1195,19 +1185,17 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	else
 		base = KMX61_MAG_XOUT_L;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = kmx61_read_measurement(data, base, bit);
 		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto err;
+			iio_trigger_notify_done(indio_dev->trig);
+			return IRQ_HANDLED;
 		}
 		buffer[i++] = ret;
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

