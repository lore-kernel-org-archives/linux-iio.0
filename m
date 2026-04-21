Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6219F11B
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744258; cv=none; b=U7WKgx5oJIA1XZafdjJrfeSpvHmJTvAaNNNRkeMsquALDigLv3y0uQ/AYk2ZJ+TcsfIzIG8AmHppWD3bozLS48DK9xDsE6wTLws+uK0l3UKQtED+GkKAVz8I+GkGkLj1x15t7aUY4klMGTRrRKulEMn+WlNiTGC3HLppM6/0dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744258; c=relaxed/simple;
	bh=WT+nA1CwkA4jXosgrZulWHMfsK9rlApU5gVcB04kQxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUhZVWzToEZoMoMDLJO7jo0+qE1X6xvKr4Zebek5oGJdixnlONGcAMoHB8+rmB5YZ4PPotSYlzH6nKq8UqDH02FoYbjl+jc9kXq46nya0Ori8uZFRmQHvF1lLanYzPpJ8dbrXSLr6hcsFL2i3q+9u5hRxWX7UJUDhv7Zp0rHvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=VUFE8YAJ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="VUFE8YAJ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1597308eec.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776744255; x=1777349055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKeE5qkgY/eIZhSVRTYw5WHxtwlOYkdsnM0936UFRKI=;
        b=VUFE8YAJHvIFnOcdLcobUZsw3s7YjOCQrFnsUavH7b4k4YMSWrEqzsF0KOFQf/mG0z
         2HqAvmU8wWC1/R99lh7Lu0BVw0w0xU57vejGTCf8vxUl++MhMbc5bntDspLMSu2cf1qD
         rFAYTwQgag+ouIBSaaX/H3t8KWpDcokp1K57AsxKaWANM9tRKGdhz+yeTZRPM2OyYQTp
         P4NndCQk2IVvAw/tu9pSsA31JKy5n9M9oZsRlmq0evQQsAm5Vrq5Zgk4y5If7T+EmmN9
         IHFfyj6c/Q6MboCc24ONMPh3Rf60pUGVvz1rUsYO8eFLIwFXMOcP+eC2JKoPvz8rkLqm
         vSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776744255; x=1777349055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKeE5qkgY/eIZhSVRTYw5WHxtwlOYkdsnM0936UFRKI=;
        b=S4fqURuLI5R4xsewRvtHpxktW1g/Xy/muqBX60PpBmoes33pVnZ1Tbasb1NhOFhgk4
         a2Wrj2jrgeFhe0i+JzlxyfUCUONG6wHYTDtzWx7eUZRni7BuKEdDDtBnbseaOlV18YGO
         WdlgKaMjQnA2TvtCdKlrJmcyhn414ud/46XotTGvk7eGxxKrT6YBAb+HbPMi6l8UkQQF
         WqKwGSlhCy11CL1ykyj2kensqnVMl60SK8hVVKRO7yStUErFOyJWwa1mJRUcak+aYUKM
         /pxNPCL4+X0/nySAY+QuQQahMnP914/Wj6OTcGZMdD1f3liCzMEsFSEXOEuvaJNOY6Sl
         g5vw==
X-Forwarded-Encrypted: i=1; AFNElJ/eZZ2dYCBiCuYEUKd0AWEcNv8IGpQCBlZXYLqT8Ofn7YkrUSZzXVKxMr/cXZE43E4JIJeilAQTI6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPkF8C8En+q0YWxzxhP2mP5lmJT71w7Nbw7zQvXx5TzbewKXF
	cpIripWJcTax6sfB1okkOV/RFFc/l/0RVF+uDm0Ao2JHF5VNwP681TDdOkI9JtPpDbNOCUYym2I
	wkza3YjkO5A==
X-Gm-Gg: AeBDies0qKAUScJuT2ucyBX2L7TvvRa/0zCSJEz7tSGI9mBgfxcqqulC3cIWG4MAQkr
	mN/lDlNkY1nIW5cRD7TxVOrXU8VQFP6lcVMMdyRqCH1Lodj7sT7QMY7hazKtNZ2KRrqgsVXfC5N
	4Tg3Gsb0hIetosQ0IyxICjcuEDfmt3RMfWjexJuXmZ5jIhbXgZgm050jXD87nBjXDSoWaXxNyVn
	DFFJgnEHVYug/ljbyq2isaEYxKwWqq/QFvU7Ipd1i1EIUl+6b3LipA/o813xsTzG/nehiUhZmYc
	uvoYYmY2LQDWtUkPficruCvbc3om/QtUD7g4+TxHx1AiAvyYX8dmYw3MQMV2pYWtW/om4g2SIO1
	9b1pebR0AIZ2wOVbZVRcuYEeXTuKt4Zl0W4/p5fgoM9pn5JdB8wXI4sLTr4ZvFnX9NSUeeOVwt4
	IAjUEgE6VJCiwAcZgZdQZZa97PUMJ9YjBaLRSDbyimVVPpcLunc5iHZXdfvWl4kgxB
X-Received: by 2002:a05:693c:60d0:b0:2e7:120:137b with SMTP id 5a478bee46e88-2e701202231mr4585609eec.0.1776744255003;
        Mon, 20 Apr 2026 21:04:15 -0700 (PDT)
Received: from pedrobgennari-Aspire-A514-53G ([191.19.131.187])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm22960850eec.29.2026.04.20.21.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 21:04:14 -0700 (PDT)
From: Pedro Barletta Gennari <pedro.pbg@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: pedro.pbg@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: light: iqs621-als: use lock guards
Date: Tue, 21 Apr 2026 01:00:11 -0300
Message-ID: <20260421040313.21029-1-pedro.pbg@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex)() for handling mutex lock instead of
manually locking and unlocking the mutex. This prevents forgotten
locks due to early exits and remove the need of gotos.

Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
---
v2:
  - Keep include list ordered
  - Remove redundant 'else'
  - Remove unnecessary variable 'ret'
---
 drivers/iio/light/iqs621-als.c | 85 +++++++++++-----------------------
 1 file changed, 28 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index b9f230210f07..8d08f28c642d 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -107,25 +108,21 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 	indio_dev = iqs621_als->indio_dev;
 	timestamp = iio_get_time_ns(indio_dev);
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
 		ret = iqs621_als_init(iqs621_als);
 		if (ret) {
 			dev_err(indio_dev->dev.parent,
 				"Failed to re-initialize device: %d\n", ret);
-			ret = NOTIFY_BAD;
-		} else {
-			ret = NOTIFY_OK;
+			return NOTIFY_BAD;
 		}
-
-		goto err_mutex;
+		return NOTIFY_OK;
 	}
 
 	if (!iqs621_als->light_en && !iqs621_als->range_en &&
 	    !iqs621_als->prox_en) {
-		ret = NOTIFY_DONE;
-		goto err_mutex;
+		return NOTIFY_DONE;
 	}
 
 	/* IQS621 only */
@@ -181,12 +178,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 
 	iqs621_als->als_flags = event_data->als_flags;
 	iqs621_als->ir_flags = event_data->ir_flags;
-	ret = NOTIFY_OK;
-
-err_mutex:
-	mutex_unlock(&iqs621_als->lock);
-
-	return ret;
+	return NOTIFY_OK;
 }
 
 static void iqs621_als_notifier_unregister(void *context)
@@ -241,30 +233,22 @@ static int iqs621_als_read_event_config(struct iio_dev *indio_dev,
 					enum iio_event_direction dir)
 {
 	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	switch (chan->type) {
 	case IIO_LIGHT:
-		ret = iqs621_als->light_en;
-		break;
+		return iqs621_als->light_en;
 
 	case IIO_INTENSITY:
-		ret = iqs621_als->range_en;
-		break;
+		return iqs621_als->range_en;
 
 	case IIO_PROXIMITY:
-		ret = iqs621_als->prox_en;
-		break;
+		return iqs621_als->prox_en;
 
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&iqs621_als->lock);
-
-	return ret;
 }
 
 static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
@@ -278,11 +262,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 	unsigned int val;
 	int ret;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->als_flags, &val);
 	if (ret)
-		goto err_mutex;
+		return ret;
 	iqs621_als->als_flags = val;
 
 	switch (chan->type) {
@@ -293,7 +277,7 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 									 0xFF);
 		if (!ret)
 			iqs621_als->light_en = state;
-		break;
+		return ret;
 
 	case IIO_INTENSITY:
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
@@ -302,12 +286,12 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 									 0xFF);
 		if (!ret)
 			iqs621_als->range_en = state;
-		break;
+		return ret;
 
 	case IIO_PROXIMITY:
 		ret = regmap_read(iqs62x->regmap, IQS622_IR_FLAGS, &val);
 		if (ret)
-			goto err_mutex;
+			return ret;
 		iqs621_als->ir_flags = val;
 
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
@@ -315,16 +299,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 					 state ? 0 : 0xFF);
 		if (!ret)
 			iqs621_als->prox_en = state;
-		break;
+		return ret;
 
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-err_mutex:
-	mutex_unlock(&iqs621_als->lock);
-
-	return ret;
 }
 
 static int iqs621_als_read_event_value(struct iio_dev *indio_dev,
@@ -335,33 +314,28 @@ static int iqs621_als_read_event_value(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
-	int ret = IIO_VAL_INT;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		*val = iqs621_als->thresh_light * 16;
-		break;
+		return IIO_VAL_INT;
 
 	case IIO_EV_DIR_FALLING:
 		*val = iqs621_als->thresh_dark * 4;
-		break;
+		return IIO_VAL_INT;
 
 	case IIO_EV_DIR_EITHER:
 		if (iqs621_als->ir_flags_mask == IQS622_IR_FLAGS_TOUCH)
 			*val = iqs621_als->thresh_prox * 4;
 		else
 			*val = iqs621_als->thresh_prox;
-		break;
+		return IIO_VAL_INT;
 
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&iqs621_als->lock);
-
-	return ret;
 }
 
 static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
@@ -377,7 +351,7 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
 	u8 ir_flags_mask, *thresh_cache;
 	int ret = -EINVAL;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -426,29 +400,26 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
 			break;
 
 		default:
-			goto err_mutex;
+			return ret;
 		}
 
 		thresh_cache = &iqs621_als->thresh_prox;
 		break;
 
 	default:
-		goto err_mutex;
+		return ret;
 	}
 
 	if (thresh_val > 0xFF)
-		goto err_mutex;
+		return ret;
 
 	ret = regmap_write(iqs62x->regmap, thresh_reg, thresh_val);
 	if (ret)
-		goto err_mutex;
+		return ret;
 
 	*thresh_cache = thresh_val;
 	iqs621_als->ir_flags_mask = ir_flags_mask;
 
-err_mutex:
-	mutex_unlock(&iqs621_als->lock);
-
 	return ret;
 }
 
-- 
2.51.0

