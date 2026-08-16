Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E143B4EAF
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786923771; cv=none; b=IysaK3aM27hWViZ1brtfSxkOGHiu9tntHSmOaUzli1bI28DRy/W2mBFJYiET/Oj8MfsjmYNzqUbmr+Ddrr0kC1VhGmGXZuTH2lznN53wGDkySRzShHmxh/zHOFhdFZw8gNTR/F8VfTrWnp0OoMkNQ8+cgGpfJPRdVv84lBykals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786923771; c=relaxed/simple;
	bh=FzzMrGUv6w6DQVY61mapg3obHLo8PGdztAwD/MP6F0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EclfcJ5f6HbVcn/W3iWTCZosMewhm3peLAu8YEsC/YAfGM2UzRK6yPwFzwSuyYzoH537sYWfCbMKq+iI92Za9DupvJg4urKbRuN06mzKjgCyiQd3VhhkAZJi3MoHkCe8TSZbxxKsSTPU40VqwyTqYocIfIMiuH4Dim1GPONtVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvbuUJza; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvbuUJza"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so34752265e9.0
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786923764; x=1787528564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2fYgLPl/81/yBOdhfRHVtzi9qfVdQFcT9Xqjqn7iFg=;
        b=AvbuUJzaBNu6x+xo2uw86sWoyu6fhAH2mAjAhXcy113TyxtOMD9iwo3v1A2QhP24a1
         ZGnXg5y6ycm7kRQv5vwedFqrXifd1Ks5Zk9DvdSakQGPG2hU+DinzZjN37LTSG6CIi2y
         iiSI+2m57U0XSD1MmKTk1HxJnGX+3NxzXeaK6TUcpt8bPRRD48TwNOMU217FasBcVQFh
         2x/fCtmfc3Q1J5V/L7QlU2UlEk9DlEC1HzsDwKfBZgpstWSZDXZV7PYXIAN6nSmzKMex
         UxaiwctXP7NScnv6EruDL+5e7YNNe0RAGZvDIUu6hvXYac8sFZOYUO9AARQzu1z2hwTD
         aX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786923764; x=1787528564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2fYgLPl/81/yBOdhfRHVtzi9qfVdQFcT9Xqjqn7iFg=;
        b=kEhZzycB3sCid+wRdGvSp5Q9Dbc2als0k9Y1SJ0o8yXo7rA09TZ2qwemCd/CHFVlRz
         6pyacsr3GT5Uj1BBl6+ei31h7rPv9290BiodyClmVBJn02w50Ecw22PBY/n2xyA/l7kd
         Jt9mI9Ec/iqXKu2U++cm66nzYy/8elfIEbPHYKMLj51ooUVPTpkVEMKtjP9OPPNmZ5tt
         N0LlXnR09uCEp7jCpZ8IS9KkwM8XL54M75GwkylTGE4IA+niQW9+c5By0e+gQ4rXSei+
         GnrHxR96hTw3nYvUQLauQ3LOFYdtRSnhag18DMbrTv5K7lSKlGx/WMe4M/B2kTi+PT3f
         99Mg==
X-Forwarded-Encrypted: i=1; AHgh+RowjN+B0fEtrahJwwRRWGBq8wfK9OlBtU1gqPPgvavZzyASj7tVeGqsjD+B2mBTrikrFOlcwYS47dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWrRc1bq+OZvwrWsHdjWUfC2BH99YLbwNarj5yLnYrh8U5hcA
	o6B9ZPzf2Ffya29O7CinqjwBcVTKtnzr+Vh5T9B0NdXdKnjzZ8aQYKk1
X-Gm-Gg: AR+sD10ikpOw4lvTX1kpA/HqPJOcGfV3ee6OWj33EBQD0nTv8Pj4k+ZT35zt+aUc7i6
	vRjTaIkUpS69EXmV8NB4lip1TTbbB2CojG/Qu3KqS+lb/9scxrypgv8NYsv9AOZH98vA4Z1ffsM
	w55FauS0Iq+qdswXPckDlPMByxl5bYjE0zZLbq+XxeLkVQq0A6jbR3cBepglPSOJIY3DS97gd4u
	r2/rD/4IgfAc/XRZiW3qHMwWFbJMy0FaXWU5xLT2PZZ88jKmtQGHjohS0A4X16k9RVbJc76WrVf
	GwKIExP8uXIm4o3HzG1sD/RSAFwb2Nk8bNFBj7tpRtcUWO9AAsOXE+MA4QNNRyPxhHDytFSU1ri
	EbAB/y2avuKgnzg+eykSLTVc9TaxW0812VZESTNdOsO2BuxTzfE3K165cP6aLHPEA/R3EJfv2Ff
	72Z+a0YkVayjbz4RbxCgFkoPZfEjz9ytryXAOeivjEcpjSTkokwKU136TfJ3z/6uDm2xc8PthTd
	g/FaLup4gSqO42QhYzhvbtQqggjQNrB8hQ8uS6zn2mdD94=
X-Received: by 2002:a05:600c:1c07:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49987950d78mr298410475e9.7.1786923764200;
        Sun, 16 Aug 2026 16:42:44 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:ac71:8b16:e755:35c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960ff072sm112915555e9.3.2026.08.16.16.42.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 16:42:43 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Mon, 17 Aug 2026 00:42:31 +0100
Message-ID: <20260816234231.14168-4-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260816234231.14168-1-grondon@gmail.com>
References: <20260816234231.14168-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex) and
scoped_guard() from cleanup.h in the functions where the critical
section covers the whole function body or a single statement. This
simplifies the error paths by removing the explicit unlock calls
before returning.

bmc150_accel_trigger_handler() only holds the lock around a single
register read, so scoped_guard() is used there to keep the lock scope
unchanged.

Call sites that take and drop the mutex several times per function
(read_raw, write_raw) or unlock through a goto label
(buffer_postenable/predisable) are left untouched and can be converted
separately.

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 74 +++++++++------------------
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index bcbb9f0c830a..470f5da267ea 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/buffer.h>
@@ -599,18 +600,15 @@ static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
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
 
@@ -622,25 +620,22 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	int ret;
 	int axis = chan->scan_index;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
+
 	ret = bmc150_accel_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
 			       &data->regval, sizeof(data->regval));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
 		bmc150_accel_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	*val = sign_extend32(le16_to_cpu(data->regval) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 	ret = bmc150_accel_set_power_state(data, false);
-	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		return ret;
 
@@ -805,22 +800,17 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	if (state == data->ev_enable_state) {
-		mutex_unlock(&data->mutex);
+	if (state == data->ev_enable_state)
 		return 0;
-	}
 
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
@@ -845,13 +835,10 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
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
@@ -860,13 +847,10 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
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
@@ -906,9 +890,9 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	if (val > BMC150_ACCEL_FIFO_LENGTH)
 		val = BMC150_ACCEL_FIFO_LENGTH;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
+
 	data->watermark = val;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -1023,13 +1007,10 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
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
@@ -1189,10 +1170,9 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
-			       data->scan.channels, AXIS_MAX * 2);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
+				       data->scan.channels, AXIS_MAX * 2);
 	if (ret < 0)
 		goto err_read;
 
@@ -1232,31 +1212,23 @@ static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
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
2.50.1 (Apple Git-155)

