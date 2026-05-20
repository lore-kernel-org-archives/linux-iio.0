Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F33D567B
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271973; cv=none; b=gOPZWg9qOeR/WVkttIV4RU6wjPc8saAdboHvLbqHBv6WEUV8TM28Af+58m/wQBMtMtl7jx/22m6a03NSQL4ziHYZyxnVxW5TB1oOq1o/tUGI6qSg5TYAFlV+AXhS5nomoT0GmNTE358acGNgSLl9wgAh1uQYFqSabDsDj0bGC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271973; c=relaxed/simple;
	bh=4xcArRGRq+w57d8yxnb8jHbKeYqbOIs3eRr21NBoj3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZh7loJhp/+eKuulKJLLhpwpNPoWuNMC2oo23lZ8mV+AapHhMmETktqD4COMcSPhXadgfyWqGDHZNbCSvxL5Tk5IdHXnJ6/Z3JEAPt4it03qt1LVg+/CFKg9PHS1NHfYRZic2rBX9ouwVT3y3ziHqBxJhec079ezqr98f1nDbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEAbv1sE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEAbv1sE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49021532ebdso15730475e9.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779271970; x=1779876770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jlKj3vqVybuLuT9iC3xNZJPcSjtJp50MyUrzENU6qY=;
        b=gEAbv1sEbHnyGS+Sur99fGSllT0Qz4eGqxKgZGaJi2jrnWaPCRbctcv2l0Hk4jsgj5
         3+X1QV3wcY0F8QMYENIaMmtHSryzv33NjGdbwuYzdLCZ7DxeqBTKi7sBzZcSlzQ+J2ed
         u5KsVUQ8w9R5KEAolU+fTupsE37t9SP+CeLC7axzL/qJEapyxtauxXAYNhP8bgor4sQY
         7p46lANeYIEwxUJ4b7TnFhjCcPxzX40BzpcalSIAJkYcBrRAj8pIxeeox3JY9zMaDelm
         KyOSJX0nfr4Dv7TgMkOVIGkcHhKQoFzw0O/XH4RWTJqvQ7C3Qn2zZnN09yZoV+yUiNJx
         Ukgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271970; x=1779876770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jlKj3vqVybuLuT9iC3xNZJPcSjtJp50MyUrzENU6qY=;
        b=d2YwhyoEAHTfxER1QGHX8LEt76GM1N+tqZkVCpVtxp+1QwaLjP+rnDdnq7b4l+wCAV
         11auJUgoiHQlOdVKv1w8tMmdhQKN6+iviYTOm16g97bQPpZJ4wOdndumLXlsdKKG49j2
         gX+pFzWLNi14QHE4Ta3Al1o3U3hj8tuVqADXdlPyLN7fryAb9VBzkE5oTJAOPHZO/SBf
         lTLcED+2Cwmi5WL0qNUakewHrn+ghc+FqcyYIWJ/mxKMCmY1vq4tjdr9clWtf34eqeBC
         xT4aOg8jDKpTHFBEsztgFsUdR119ZkmkCvc8yRU1Mk+BXAywInqEfhEUe/rt39lPANu/
         nQMw==
X-Gm-Message-State: AOJu0YyGzPRGiet8xESXQmwty/jENNQY/Qgt03VpZ6w9cqNF0l228usm
	NWrDuMC1lEh+xAZFD0wItbW7EpBx6FGQ5G+UTdf0ppZN4GYHyrrdHkYQ
X-Gm-Gg: Acq92OHdDw1Uq0gkEdWCSKHckNsFIhv3Wq40gYbvgIFx7XwCSeBUlP1q67Spc2xq80h
	L2wDXe73bYslsF02jOwaThuBLUF1LAVmDbyMefcEfwWi6SyHxjATZ5pH/vTjPoH8zD6SXlCL9Di
	+8HTchKIBPvUTaVAKk+E1rNS4kVySXjvuuHO5KxApjZRRbIgqtkPimdVb83RiMUd0N9clnheE0y
	o2k83H7ixBn6Bu4KV8z7pilEy0pGRsO8KyOfdaw9yskzzoC8P8v5HYVPMXTbyVoDagYKpM9qRfo
	DQBYRRjoAOH22NJHZFm813Zexm5EZKUW39e7E3Lz2fllx+ZnpPVoQqyCkvB8lgSWL2agXCEhOmx
	4F7L4IznN4F2EDoSg2pF7ZJqGlQflZLqGX4A0RHK4bE17lidLjLrMtrdtfRjpG1HxmBkuWafW0S
	4XInZKdtS91v8C+rNBv1i0B4/9IM2VPRM9Aa5cSFYaVUM/JLbx0uMO
X-Received: by 2002:a05:600c:3b0c:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48fe60d55f9mr350093655e9.8.1779271970284;
        Wed, 20 May 2026 03:12:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:ed18:5665:257e:fff1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe78aadsm124804255e9.29.2026.05.20.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:12:49 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v2] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Wed, 20 May 2026 11:12:47 +0100
Message-Id: <20260520101247.64458-1-grondon@gmail.com>
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
---
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
index 2398eb7e12cd..1e0bd5ab4298 100644
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
+	return sysfs_emit(buf, "%d\n", data->fifo_mode);
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

