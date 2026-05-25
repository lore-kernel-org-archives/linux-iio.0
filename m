Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9026F2BF
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706904; cv=none; b=YV+cSaMKEHVcXeDTa2UyHRaDaaFdTkjoE/yKnryanteFP3UPdba3nsE9QloDDiFX7/5hckSbwjSFVRcTKamuhqyizyDUzz0nDeOz0lduuwK+F0650sWgls1p+0uBQ5EuaY4CPBJYnWxIFwdeWXZH9xKT11MzaQ5K/3CokpE1XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706904; c=relaxed/simple;
	bh=Zos+qgIjbJfieklSGDIwVMAHBFpTdFUw3LBl++UHaK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ObkmqEKV5hQ2L7NBrxXJ67RKjb8On7gc16M0esA1GOKk2ovpGLfvOzw62Lby9vhrikBuiAP6mrNgBxf3nZk7ibM/3vJQzUTPkg7Bor5DNPJlhwPnzgQQPmKRUEHQ4DIUZ2OGy5aPvSG8QCN5Atd8egjlcSMQauYeqRkr+433mv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpmb85D0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpmb85D0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4905e190c71so11433955e9.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706901; x=1780311701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwzakygw4EN8seZI+IQRrpcLpC9qbJLKNAylpwQVQ+A=;
        b=Zpmb85D0FlH8/eppoLD7xgJKheTBBdDNbhCfJSYSQiuerAkOdjX0Oy+4047wSEdObQ
         miRKJnE4bVWnkX/5Znw2Z8jbWyVzzBGX54KWF1QoZnHscHYop+p6wMN9R/N4XTJWYrGv
         zI9dwoDbtXd+f3dcXaxbTGw4xzS9WeNSPZlNb0LY+PFNkr0IL3MDybE7ifL/mF5Kf5ip
         zE5gY5zn7iq7kaLD6BTM2fVsAZ5OCAWiMWwuLTXKCu3Klh/rsunPbTisA0ies/GiQbQG
         IfUbQVFKhJjwaPjZEAl8m3TCEDL8R4ym10DZyPBO7ID50m4y9MD/tZ+uGvxAEs/g9lCX
         MlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706901; x=1780311701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwzakygw4EN8seZI+IQRrpcLpC9qbJLKNAylpwQVQ+A=;
        b=iYaJ8ZI6lz/4YAtDfutxabk7qcxBQ3IJBUYDQLJyOJUWQ4VRdxszG1O8lMYwZsrsRr
         HZhCtabl14SpDR/T0GM5PYykOKYwz62zRCDQTWm1N5YEOOpzGX7jXgpIEDLDYlMfxBSJ
         e6MVP0k+wKDjYVNtzd11o5fI00vHXJmzh6jUclVqYGQmtS44AkhSJxlXrduppWiGEWIg
         PsfNLm/AelwwVbBvpEsR+fIz/mlfqE4EGiW2Nmjc4atD1Rj3cP8t3hr5Tzgax4MyDFbl
         Q+kQOh44Qng6InGxlG2f8v6Vb0Eu1L5lM0ULXJxVMfFIZm5arXRv3bTufY+Xcbi4iRS6
         NVgQ==
X-Gm-Message-State: AOJu0YxKwHUZi/TMM8xTo0bshyt3HXnsq94VlrQ0VR7o1B7yZ3CAEDse
	FxeQMTdKLVC0WZ2/07KU+2ZpguJPdYxTAvR1tsJB3/Gckbe/+dNQQOjm
X-Gm-Gg: Acq92OFqNzp3cRA6awkyFDY1ByeUdUipI26DkJWvwVQaqTFAt9+oiIu5sZtImqeKKbl
	rJBHF2BTCcMLEzfoMdM2vYS9qMN6xPVX8cvr9Ili7Vg1JcsvmYnBv1Zv2yx6l9KcP/qvC/t7zn+
	U49r/1+pTe1fDm6GjR1P0Q/cs8ODAX7yLJQbsM+M3qGxunosgUBlPialc1tSq3n+4M9pwPGyafL
	JW6uVn++ywiJeuFuNJ3QikxWU9AkXNgddjM009E+YpDjhIRbqV0v392FCpRKG5vVGCm8vaeVXtO
	ZRq6QD8eSpsi4T5d3xwvBp+KEAfmXd7WKzQUuo8W16mEImOBt7AuVX7M+nEo431eHeXRgLoS8J+
	HpatOKMWYQxf+Mf3AjBJi/ztGaB4cDlkx7HuFbovHbcM4cfOnhOycDE9T/romCKPToM6g+v97Pf
	umRGIgyvRQTBTQcBLIR92Ohr0h43emPvI5iagGnDe07otqd4ktuH4m
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-490426cefe0mr164507855e9.18.1779706900959;
        Mon, 25 May 2026 04:01:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:e928:104a:57a8:6fa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042aeafa8sm80034525e9.27.2026.05.25.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:01:39 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	sozdayvek@gmail.com
Subject: [PATCH v3] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Mon, 25 May 2026 12:01:27 +0100
Message-Id: <20260525110130.61284-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
and scoped_guard() from cleanup.h. This simplifies error paths by
removing the need for explicit unlock calls before returning.

Most converted functions hold the lock for their entire body, so
guard(mutex) applies directly. bmc150_accel_trigger_handler() only
holds the lock around a single register read, so scoped_guard() is
used there to keep the lock scope unchanged.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
---
Changes since v2:
 - bmc150_accel_get_fifo_state(): normalize fifo_mode to 0/1 in the
   sysfs output (data->fifo_mode ? 1 : 0). v2 dropped the bool
   intermediate and printed the raw mode value, which would emit the
   FIFO mode bit (0x40) as 64 instead of 0/1. The original 0/1 output
   is preserved. Reported by Jonathan Cameron.
 - Collected Reviewed-by from Stepan Ionichev.

Changes since v1:
 - Drop the verbose list of converted functions from the commit message.
 - bmc150_accel_get_temp(): keep the original declaration order; no
   unrelated line movement.
 - bmc150_accel_get_axis(): convert to guard(mutex) as well, the only
   code outside the old lock scope was a trivial error check.
 - bmc150_accel_trigger_handler(): use scoped_guard() so that no manual
   mutex_lock()/mutex_unlock() pairs are left behind.
 - bmc150_accel_get_fifo_watermark() / bmc150_accel_get_fifo_state():
   drop the intermediate variable and return directly.

 drivers/iio/accel/bmc150-accel-core.c | 68 ++++++++-------------------
 1 file changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2398eb7e12cd..e8c40aa0375d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -600,18 +601,15 @@ static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
 	int ret;
 	unsigned int value;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_temp\n");
-		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	*val = sign_extend32(value, 7);
 
-	mutex_unlock(&data->mutex);
-
 	return IIO_VAL_INT;
 }
 
@@ -624,25 +622,21 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	int axis = chan->scan_index;
 	__le16 raw_val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_accel_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
 			       &raw_val, sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
 		bmc150_accel_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 	ret = bmc150_accel_set_power_state(data, false);
-	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		return ret;
 
@@ -810,17 +804,14 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	if (state == data->ev_enable_state)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_ANY_MOTION,
 					 state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
+	if (ret < 0)
 		return ret;
-	}
 
 	data->ev_enable_state = state;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -845,13 +836,10 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int wm;
 
-	mutex_lock(&data->mutex);
-	wm = data->watermark;
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return sysfs_emit(buf, "%d\n", wm);
+	return sysfs_emit(buf, "%d\n", data->watermark);
 }
 
 static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
@@ -860,13 +848,10 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	bool state;
 
-	mutex_lock(&data->mutex);
-	state = data->fifo_mode;
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return sysfs_emit(buf, "%d\n", state);
+	return sysfs_emit(buf, "%d\n", data->fifo_mode ? 1 : 0);
 }
 
 static const struct iio_mount_matrix *
@@ -906,9 +891,8 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	if (val > BMC150_ACCEL_FIFO_LENGTH)
 		val = BMC150_ACCEL_FIFO_LENGTH;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	data->watermark = val;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -1021,13 +1005,10 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev, unsigned samples)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = __bmc150_accel_fifo_flush(indio_dev, samples, false);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return __bmc150_accel_fifo_flush(indio_dev, samples, false);
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
@@ -1187,10 +1168,9 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
-			       data->buffer, AXIS_MAX * 2);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
+				       data->buffer, AXIS_MAX * 2);
 	if (ret < 0)
 		goto err_read;
 
@@ -1230,31 +1210,23 @@ static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
 	struct bmc150_accel_data *data = t->data;
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	if (t->enabled == state) {
-		mutex_unlock(&data->mutex);
+	if (t->enabled == state)
 		return 0;
-	}
 
 	if (t->setup) {
 		ret = t->setup(t, state);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	ret = bmc150_accel_set_interrupt(data, t->intr, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
+	if (ret < 0)
 		return ret;
-	}
 
 	t->enabled = state;
 
-	mutex_unlock(&data->mutex);
-
 	return ret;
 }
 
-- 
2.33.0

