Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F22CCB9
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426707; cv=none; b=Bu4Hf+hqXiV3FDLb9G/VKajkG/HfcYmp4riK6AIasCeDHi2bRFyQMxf6LNoKyJkJFBbk0hCftudHUCrsn817OJ8n1JRaZUnBu8GC7dPxxJzpmt0aY4fS7YgjXPVusnuua64xAhJQiqWgcbs9L3C0u+Wr3jh5fpwOJkiNdYOz92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426707; c=relaxed/simple;
	bh=0wgBqE+3AhlSd4a7u/7Y1FFMNOaInIuSIVa959ZZHl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQara1Fqrjp7tJZNXAmZJ6NkdjWdx8rBO/lvZSD2VkzYIb/y0Cj+4PX07GLvJZ2Fnp/p6jZblf6OR+5OoQGNLTOK9Uy5OvmkfZ3reeVya2UNgLz/EfIcLJc1gexsz0OFGGwZmpPTq/gcVJ97sLSBjCjHzHa8KFiHu9wDP1PCvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=eneYo3QD; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="eneYo3QD"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501d242e2fso11269256d50.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 18:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777426704; x=1778031504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMiF6QBtp9iskAzzp3uGC3uetkYnil+mLFOkQLB306k=;
        b=eneYo3QDd7mz/1kvkRgBB/1jPHS+nM2/+WCUQqVj6CiGJL2mWK8xyTmkAtd/YeKcBS
         qNthmp9HTJoI/xYM188lUSwlhVLFlKBsBLiofYrpbfBuSL4na/L4H2KpL8/YeZZs1BhW
         4kW8vSXsiGEl3scPDJ/Pv3jB8WC4tBNfybu7hA71I4pNcnqwbitdQ4dQbKpHaYYwJf1o
         B8USRFof/kvkoTB7UvRoaDGX8wGOnQk2paWFlYpoJbGiAtyMi0ROtUksfiVx87xLwV4P
         e6bAoxFpHnz6/yN9GI71lfvbJoEH3JbY8LTm8Df8rdZkW68BbtWZ+30pMzG1lTUwCatJ
         Chtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777426704; x=1778031504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMiF6QBtp9iskAzzp3uGC3uetkYnil+mLFOkQLB306k=;
        b=slH6lIKOkytYmHFCestjsK5jMKKgJOL/jrIr+GlCBwPuvDhkGN8AHeA2Ls/45EcIhe
         4TQRQgtWvssPi4+UCvlGuIV7fTrlW96EDVd39kkbL0wSAT/3RXXUoY10lthbwa9FBAzr
         ljmS+vBZqZVma0fFXijdaKRz1L9+VcYWwoQDcRQEY6tac4txMWRLqTZP4B/oalfI6gV2
         nujOp2f2F87ptmZtPeTYtJ108v7Toa/+DtJlGTSDyQOFcyra93VXbnA841mP8Yk65kG7
         mElU7wyl0M5Bmc+WEOxvKzRR3xmffdQYgFBYH2RDvnrlbIsKw5uspuyz8y0U7/6ZKa8Q
         Qibg==
X-Forwarded-Encrypted: i=1; AFNElJ+UziyFfUoiaGwRtvEa7b1WADDMZgFeU+Aix/vX7e4ZLY0AS2ImE87PmKhUBiseleOwRdCH5/qt7QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNExSG6f+aPqzEgpDMEsunUIgDbvLLdiVclH9JJRrlW8cojb3j
	AjgOYA1i90VT654PRajOHkzJSNuOY6MKWcaclApwx7d/RPYZ/an1/ppL/6YaUNAArCU=
X-Gm-Gg: AeBDievIcuEpa15/iOpiykoU75b3tHC0ckjaW1V8swEC5RobrMygvEGvIY2OXleBDzT
	xr5xJYRtSR8Vtmmre+Pak+mbC16AphEdXO38QHb38Ax14JaP0ocZ5upGOVqI6mPTPtkLz7f7lro
	d1y8MtzmE+TaXt2wZESdXgLOwnSWKLPzX4oqlFIW10fpe3yqhLXYzojkqpumq+lVjg8M7jqI6Ja
	vqFP6tNFpKZUM+kxl01X0TYNm/2rdmNNgV7mIlr2nnuPsaCY1XmICyjN5L8Ew6txJl2BSM0hHYw
	q7KuoeD7SHu/ZhuS7uL1RP3rev13TKdz81tHtsQ8cE5NbV3IFoYGcd0MIoojiIVMiwRzH6gLwjn
	JDOTfhQr953WylzHVAjsOlwWZ4dN4HT/GZJZtu3sGfkLawkTbPnzKvFEBO6BWXNy5hw77rg0TP6
	iQ92//cvVipQrf6UVNZzlToSeCob3Lj3k7uw/e6v+FSN2MhUscE7hHlrVyMmwqwuj0
X-Received: by 2002:a53:d78d:0:b0:659:5b8b:a407 with SMTP id 956f58d0204a3-65beee852ecmr3587413d50.47.1777426704045;
        Tue, 28 Apr 2026 18:38:24 -0700 (PDT)
Received: from pedrobgennari-Aspire-A514-53G ([191.19.131.187])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd259dc229sm7182457b3.39.2026.04.28.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 18:38:23 -0700 (PDT)
From: Pedro Barletta Gennari <pedro.pbg@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: pedro.pbg@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: light: iqs621-als: use lock guards
Date: Tue, 28 Apr 2026 22:29:54 -0300
Message-ID: <20260429013640.26870-2-pedro.pbg@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429013640.26870-1-pedro.pbg@usp.br>
References: <20260429013640.26870-1-pedro.pbg@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex)() for handling mutex lock instead of
manually locking and unlocking the mutex. This prevents forgotten
locks due to early exits and removes the need of gotos.

Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
---
 drivers/iio/light/iqs621-als.c | 93 ++++++++++++----------------------
 1 file changed, 31 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index b9f230210f07..25a655b328fc 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -107,26 +108,20 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
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
 
-	if (!iqs621_als->light_en && !iqs621_als->range_en &&
-	    !iqs621_als->prox_en) {
-		ret = NOTIFY_DONE;
-		goto err_mutex;
-	}
+	if (!iqs621_als->light_en && !iqs621_als->range_en && !iqs621_als->prox_en)
+		return NOTIFY_DONE;
 
 	/* IQS621 only */
 	light_new = event_data->als_flags & IQS621_ALS_FLAGS_LIGHT;
@@ -181,12 +176,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 
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
@@ -241,30 +231,22 @@ static int iqs621_als_read_event_config(struct iio_dev *indio_dev,
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
@@ -278,11 +260,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
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
@@ -293,7 +275,7 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 									 0xFF);
 		if (!ret)
 			iqs621_als->light_en = state;
-		break;
+		return ret;
 
 	case IIO_INTENSITY:
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
@@ -302,12 +284,12 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
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
@@ -315,16 +297,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
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
@@ -335,33 +312,28 @@ static int iqs621_als_read_event_value(struct iio_dev *indio_dev,
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
@@ -375,9 +347,9 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
 	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
 	unsigned int thresh_reg, thresh_val;
 	u8 ir_flags_mask, *thresh_cache;
-	int ret = -EINVAL;
+	int ret;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -426,30 +398,27 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
 			break;
 
 		default:
-			goto err_mutex;
+			return -EINVAL;
 		}
 
 		thresh_cache = &iqs621_als->thresh_prox;
 		break;
 
 	default:
-		goto err_mutex;
+		return -EINVAL;
 	}
 
 	if (thresh_val > 0xFF)
-		goto err_mutex;
+		return -EINVAL;
 
 	ret = regmap_write(iqs62x->regmap, thresh_reg, thresh_val);
 	if (ret)
-		goto err_mutex;
+		return ret;
 
 	*thresh_cache = thresh_val;
 	iqs621_als->ir_flags_mask = ir_flags_mask;
 
-err_mutex:
-	mutex_unlock(&iqs621_als->lock);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_info iqs621_als_info = {
-- 
2.51.0

