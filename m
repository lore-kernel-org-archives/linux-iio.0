Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984872;
	b=lT/ZpJ6JgnzI31euFPYo69Na92osNdrcV39T0yBmv8xeyfa/6vMl6MqEChuaimL1TbDH
	 HCiMnhF11eij/c6s9rix25VGoRXpEyXPo70VKL2r9IXoKzNg+zHpsHrY8AKOlFWgKQqHg
	 FyIzracMkvaXLfHcwFW32WJWHHBCraYBSSCKcWRBQ8btXQG3XhMbwZnjKEQyKusGtG3LV
	 6lJzmPrzvdjJbH6U9zQOWyE2ioxTxhbfmGRzB8PORFd+cx4OnDt4wp/ZZ/Tspzq7Om2YU
	 WACFGd2NqtJeU5SJyeR/u7oThssKDp4SevhsDaw3iwYmqKeKOAQCBcbDpjkREdkYHDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4TFid/5LWy9Xb7w72RfdLQ2tz1tqaj7R1O5YAF6uqHo=;
	b=jJf5h/B53bWMqHiFT/2eQ1DxR4h2XcOjQu4Q2XQC1Jk2R3ipmkO33dLLlEZqL8zhLTll
	 b32x7RLIR+oZsw1wxCSYvWWvdn8of/I+kvK1MVcV8T7J77CbWQIXtCIgjqNrgjWxykIyo
	 QhFKLOuQnUEAQuJaYMu1WpP89aTOr0HJZaOGefVUikUOxfQ4udP1iO+WriiTrmf0/hBBv
	 37AqE153i+Eg/J37x5SW2pgQuA6SYz0dzCLuOai+DeHG9XhhhcDnJOEba36P6EX6Wp3JV
	 sYRDsGrjvxOI3jkCUTij5HKAM0vOs09suYgVe4JucnG+Y68rOASdnrYEuSY/SOtVE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqNF3VoD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC790606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqNF3VoD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1701F031E1;
	Mon, 26 Oct 2026 03:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984871;
	bh=4TFid/5LWy9Xb7w72RfdLQ2tz1tqaj7R1O5YAF6uqHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqNF3VoDrSaLRNdu2IoXwyV69ZLhQb6bQQd+64m2Xe+as18XdzLmu2Q3Rj0nRnyxJ
	 aBcKZgRHaCVKdM9L+CqPvu6p5mMH7hpCeQeK9bW9nfcxXJmnbfMLhsCVPJ2qNBFMWh
	 yOCWsf7gsdqSCSBZiXFW/VeI7oCT3PD+wIVLsh+YXQTkQac7OlPkJr3kS/71e10uDd
	 4+94hqRdkov1jdc2sRnSIsmxM96k7gMiEHQU32Gjy26XtBeKtg6hQQBcE3uDPlIrqS
	 tqpfw8wdvgSwP7uL5EtYAxFM6EK6aegmxqpWkWTS7YXg0WT4mYNlXqSw3Uv61UnOcX
	 NYXMbwI+pq1CA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 1/2] iio: gyro: fxas21002c: Discard pm_runtime_put_autosuspend() return values
Date: Mon, 26 Oct 2026 03:20:50 +0000
Message-ID: <20261026032051.1004536-2-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026032051.1004536-1-jic23@kernel.org>
References: <20261026032051.1004536-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@chromium.org>

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

With the driver modified to discard the pm_runtime_put_autosuspend()
return value, it becomes simple to use PM_RUNTIME_ACQUIRE() and
guard(mutex)() to simpify two locations. At the remaining location
simply dicusard the return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Brian, given this tweaked your patch a fair bit, please let me know
if you are fine with this. Hopefully I didn't mess anything up!
---
 drivers/iio/gyro/fxas21002c_core.c | 66 +++++++++---------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index a88670207cec..fe1ac3e841dc 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019 Linaro Ltd.
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm.h>
@@ -364,48 +365,28 @@ static int fxas21002c_write(struct fxas21002c_data *data,
 	return ret;
 }
 
-static int  fxas21002c_pm_get(struct fxas21002c_data *data)
-{
-	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
-}
-
-static int  fxas21002c_pm_put(struct fxas21002c_data *data)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-
-	return pm_runtime_put_autosuspend(dev);
-}
-
 static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int temp;
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = fxas21002c_pm_get(data);
-	if (ret < 0)
-		goto data_unlock;
+	guard(mutex)(&data->lock);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
 
 	ret = regmap_field_read(data->regmap_fields[F_TEMP], &temp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read temp: %d\n", ret);
-		fxas21002c_pm_put(data);
-		goto data_unlock;
+		return ret;
 	}
 
 	*val = sign_extend32(temp, 7);
 
-	ret = fxas21002c_pm_put(data);
-	if (ret < 0)
-		goto data_unlock;
-
-	ret = IIO_VAL_INT;
-
-data_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return IIO_VAL_INT;
 }
 
 static int fxas21002c_axis_get(struct fxas21002c_data *data,
@@ -415,31 +396,23 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
 	__be16 axis_be;
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = fxas21002c_pm_get(data);
-	if (ret < 0)
-		goto data_unlock;
+	guard(mutex)(&data->lock);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
 
 	ret = regmap_bulk_read(data->regmap, FXAS21002C_AXIS_TO_REG(index),
 			       &axis_be, sizeof(axis_be));
 	if (ret < 0) {
 		dev_err(dev, "failed to read axis: %d: %d\n", index, ret);
-		fxas21002c_pm_put(data);
-		goto data_unlock;
+		return ret;
 	}
 
 	*val = sign_extend32(be16_to_cpu(axis_be), 15);
 
-	ret = fxas21002c_pm_put(data);
-	if (ret < 0)
-		goto data_unlock;
-
-	ret = IIO_VAL_INT;
-
-data_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return IIO_VAL_INT;
 }
 
 static int fxas21002c_odr_get(struct fxas21002c_data *data, int *odr)
@@ -725,10 +698,11 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct fxas21002c_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	mutex_lock(&data->lock);
-	ret = fxas21002c_pm_get(data);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -741,7 +715,7 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 					   data->timestamp);
 
 out_pm_put:
-	fxas21002c_pm_put(data);
+	pm_runtime_put_autosuspend(dev);
 
 out_unlock:
 	mutex_unlock(&data->lock);
-- 
2.56.0

