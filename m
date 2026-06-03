Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59047ECDF
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506782; cv=none; b=c8PVi3bbmGjCZdF41LbvlrwsElDBFFAVJsjFB/TU8QrV+cjqbttuOhrKCFPDgQcjRapDDQCw+XZam5gY/jzTxlLs8YAwWVPZDovCmRQHtcik4AQcfOCVprpOexcLs6PlM7wUlIkST1W8drD+IZ3y0VEmoxp/Cw1r05URl5r5BOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506782; c=relaxed/simple;
	bh=2BDkcyxuCYIlZAGkYDGk8pck10gD78JOrPFXgQsgGWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpgD9ZntHgNg0RI5Dh4qYJgPhVQ7RZX4/FyF+mDjvORg1Culxlk08Q+zbb9UjglPMuo79ASoSXQr9x2t7nTvmFLkVHw3bwPhP0P8a4wpG6IbJ2uQHTN/T8uxXeRsVoaW5+Pc8QAAky9y9I7qQQjz/MI/YGAX8MtJSIJfA3F3eWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLCV4941; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLCV4941"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45efa80e0afso3736518f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506778; x=1781111578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlFviVqEyV6yDfca0ZHHxijD0F7o0i8z+Aw19WODozw=;
        b=sLCV4941O4fIGhgLsuqPdH9oy1xO09BctBDieRSxSB5Gadg6P7NZe4ancmI9CpOk3l
         PSs/S05RjJ8dluttLrWMbX8NtPDAnxVbyCIN+ic9kY2gMZkMFywrMKs3axNGjFk+iQXj
         E3tKezf67Q67jMB7Qxw3CA4rBr5HIALKF2tSWuqamuQpzoj/5s+N/NqqMcUtb3aXMVEI
         qnOQCMRIgaPSUsaOGQ7YWbvmR2xQdRTMx2F9lvZgx9uJEGyf/+1ZxczaBaXXDxV8LRZS
         5MIUb7BKQGPkbdcpnild6mzDs+nCJ36RWf4aATDSGqA9YuvRTD+jpLdPPnINoigwXnKm
         l9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506778; x=1781111578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlFviVqEyV6yDfca0ZHHxijD0F7o0i8z+Aw19WODozw=;
        b=f2lwZUtpiXX5zYIqaXOGLhMl+52bRft8uaT8Z1ovd1TLRSR6VbLLqvdv0YsY13JGwu
         0mpDlQfjd11OlSt3WuhrDxDyikvJX/+RWww4NARcVUYqAV0PmytIiUBlcDwb+LWKqpuE
         LKZ620WpKdlOnb2yIxr3HRIXKpuauLEzHPfSUxyTzD5Gn92tl/NDSQSbawp4AhVfKCEq
         5dNFcYn7cNIYU59XuISdfe3cAsk2s8LM7lLUG8Ty18B6iO/rRiSZKVA2ICFkEw6tB5Hr
         5UO/hieBLrl3PZq4x4ygJxjwCs6d4+gsavgg7BbIEjc3WNXM/5wqN1HL1IIVB4VrHZEP
         3GVQ==
X-Gm-Message-State: AOJu0Yx1MnaLyYVZk9t9vc6n5l47JPMJBYx4TYjauKp4hSs4tRXo6uqo
	CqltXlra+u3n8JU9/K22vrSwpoLRCXe6LipuRF1/WnDRiVI9YoeIMil1GHba3X6c
X-Gm-Gg: Acq92OFF+n/sk5OLOjroChiCbdx9TyYr2siDW5zG/rQamvnp7ILv5EwTPGXPlD+sLb4
	PzIMmqZbtK/6MzMArjzXnYLtOgZbvhtADWVNTPkwhXMZRugYxoh1DvV3K1qyDNpo7wdblOfmsUM
	UXX4jBirce9fv0LICqNbBmHDQQvxcmlGFT4ACk3KmwfA1z5QUF3+upQdv+VyEXpPRA2uW+WocaJ
	8yWNT2x/2+IY+PdOJmuARklxcdKP3TEQ+O0woYZdOg7kfz0JFunwMimlDDkB82UJq+bHYN3zFaJ
	UNTQ1BOrgWovgSJRDL3HEQvdPeCRApy9+zdguDnZjjtEm2lLwDfK+18ugRzqwS7Q9cvrNDXR+R+
	A2nfXJtXmVy6GN2P5FRQ2nAhshde1craqRi1tYx+/2p/O+uLdPlj05je5CU5fJtsy9FE+kCnX5P
	sJWUUv8wHD9CWA0NhAu9prVdiUNrBsxrx0HZuDfNqqrmlobtiDJ1IUDWQZTi6W3D8NsHcVNfL2R
	yAofQh+n7VepzJDT4KX908b4P3lIC9yNwOTWyAmXon79tI0ZGvkm9F9K4q9cwQaAxULdQCHDWW2
	XtDaz24iUtsVp3/++S/procj3oZBo3ZMJZxAoT8CGNYqt55cczt7kBkXoOyyMw==
X-Received: by 2002:a05:6000:4b11:b0:45e:ec27:b4b0 with SMTP id ffacd0b85a97d-460217264a4mr6430009f8f.18.1780506778048;
        Wed, 03 Jun 2026 10:12:58 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:57 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:57 +0200
Subject: [PATCH v5 6/8] iio: light: opt3001: move driver to guard(mutex)()
 use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-6-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=5010;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=2BDkcyxuCYIlZAGkYDGk8pck10gD78JOrPFXgQsgGWg=;
 b=PcH3w3TrZ12sMbpkFbwhZyaT7JJZx5u9UIA9uF/7bo6o3+aIkJ1XexZTFh+98bhKD9pNXGSZb
 IQMxy342Zo+AHNoCYFEuVK5ODL6t94YzJEl/aJKRTyrkBpZAehzYYAa
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Move driver to use guard(mutex)() macro, to facilitate automatic
locking/unlocking of resources. This modernizes the driver and
improves code style.

While at it, remove unnecessary gotos and return variables.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 61 +++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index fa799edd6a9c..14a091533067 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -10,6 +10,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
@@ -477,7 +478,6 @@ static int opt3001_read_raw(struct iio_dev *iio,
 			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -485,23 +485,17 @@ static int opt3001_read_raw(struct iio_dev *iio,
 	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = opt3001_get_processed(opt, val, val2);
-		break;
+		return opt3001_get_processed(opt, val, val2);
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = opt3001_get_int_time(opt, val, val2);
-		break;
+		return opt3001_get_int_time(opt, val, val2);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&opt->lock);
-
-	return ret;
 }
 
 static int opt3001_write_raw(struct iio_dev *iio,
@@ -509,7 +503,6 @@ static int opt3001_write_raw(struct iio_dev *iio,
 			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -523,11 +516,9 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (val != 0)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
-	ret = opt3001_set_int_time(opt, val2);
-	mutex_unlock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
-	return ret;
+	return opt3001_set_int_time(opt, val2);
 }
 
 static int opt3001_read_event_value(struct iio_dev *iio,
@@ -538,28 +529,23 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 				    int *val, int *val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret = IIO_VAL_INT_PLUS_MICRO;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
 				   opt->high_thresh_mantissa,
 				   val, val2);
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_EV_DIR_FALLING:
 		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
 				   opt->low_thresh_mantissa,
 				   val, val2);
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&opt->lock);
-
-	return ret;
 }
 
 static int opt3001_write_event_value(struct iio_dev *iio,
@@ -586,12 +572,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 	if (val < 0)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	ret = opt3001_find_scale(opt, val, val2, &exponent);
 	if (ret < 0) {
 		dev_err(dev, "can't find scale for %d.%06u\n", val, val2);
-		goto err;
+		return ret;
 	}
 
 	whole = opt->chip_info->factor_whole;
@@ -614,20 +600,16 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		opt->low_thresh_exp = exponent;
 		break;
 	default:
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_word_swapped(client, reg, value);
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n", reg);
-		goto err;
+		return ret;
 	}
 
-err:
-	mutex_unlock(&opt->lock);
-
-	return ret;
+	return 0;
 }
 
 static int opt3001_read_event_config(struct iio_dev *iio,
@@ -659,7 +641,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
 		return 0;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
 		: OPT3001_CONFIGURATION_M_SHUTDOWN;
@@ -668,7 +650,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
 	reg = ret;
@@ -678,13 +660,10 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
-err:
-	mutex_unlock(&opt->lock);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_info opt3001_info = {

-- 
2.54.0

