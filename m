Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF41B85F8
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776634403; cv=none; b=aHUVXGf1Rd7mbPFsjX/MpwOekogOUtV16W72W70rgzMNJQo3Qq5vYdIm1IGv8pkGj2Y2YbCxYmnW40miQ/45VVWPsajszoyWq+PjrMn4IWSf/K65oaO4l9q2Z3a18LJfc3+S9FZh/TIYexaiA2yB0u+l1t+LIqzsFPvBP0SEI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776634403; c=relaxed/simple;
	bh=NRA9yGASW0o6sD+QV4glvLKxdzsYBVtIXWeLfnX8VPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGpvw4k/GDebOsY3BSfnFBTLqmoa1Ozta6hE82FEpg25K8j4tV9uxjqOHP8QoIvwV5NPBz0lQxq8Y9dYgzpvpOwsqto7GAUjVpcjQCwVZ1U13jPOrGQ/buYmXqJhlzDGhfB7YDNbcrpg4NGosFK8lX9zzj+Tp3gOpJypK71cnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kptXJxsb; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kptXJxsb"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2533027eec.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776634399; x=1777239199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=msZ9AHZ7QczS2MRKRGw1VpCCPv3vEWfcZ3yvMBPRg+Y=;
        b=kptXJxsbB15edkAjmoAus+nNsWhHErfY2Rnv1If/bi9dxHEMhI8Lb+zMLrCIDhH/dG
         7ROaFDl0/m3A+bZa9QW71t7y8xiEOsajLB1hTHcdSf+qmFgyjs6nYRfX8fc51YclRqRk
         B7TmLrg9sIhgK5x9xi3hNlEUdjOsCBswQfn8TQxX4Rd0tavJoU1KpIUVYkIkG/reKePi
         JbuWNQYHUl7IiY9AnqU2w/5kuSChXm8/mPoMLXTsV2nleJquCfhjY0UL35RpZRbchTqu
         AXOMF1insV5LOBANpqLMGFzYCO6ZyxyVygVhaEoOPugsh62lu9kaGFaAOTmu6pQMZhzt
         h/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776634399; x=1777239199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msZ9AHZ7QczS2MRKRGw1VpCCPv3vEWfcZ3yvMBPRg+Y=;
        b=lHuDe3gaq1BQ5kNQ7yQdygAxY9I/Vd03f2HmEKg1SFrAdrlmQZzPF647GpcD3sEGTh
         PDptb69uJ3Vzq2rCXbiBFjJcDcPG2nA153799NuhHAKydHqwbtm+tspozb392yz4TCS/
         RTxiRC4kXnviYo4rYXUoHed2pcx1TPukwXTSq/uUY7Dfn66Q0+J+53JQQGKLxupesZeb
         8zy8HlU5iPawH1dpKpYbCABpOVG+kZDFyvq9XSJyu58/hcJI1DT4JmAJlkhqQhLtsuqj
         bRrlcwL0tH1Tj8EOK4WikLWCNwQR1zJIJJnNDro3iYJR0Y5RTIjzNhrzeQPnXcTwgXmH
         6Www==
X-Forwarded-Encrypted: i=1; AFNElJ96EMKuxtnhiUEsCUFHQIu1L480z9F5ajPtiaZs7+kOCLFTi4qIrLsURySY3x2DdkKuD03HY2qOn9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5uLPRBXHT720H3NdhgMDwY+tnPkAr7iS9cdXj7FP+j5OXNRK
	KLU1GGRna0PqvPhSTzE6eqhu6geFY7qwWmx9T8yvskr+48V+74hRsGZZCDERfYTPBO4=
X-Gm-Gg: AeBDieuTEbuUJnOyWGc+kh9P+k80t80CbTNI+k/yDTniBCthjwqeEq8BBq9h7EUEcrd
	BaJBnGm9XgpOkdIMh2O3x7atjW18HmE/QS0TFlFcHSfqpe1TDA5XUP5Po1KvuNlaRhbX/24oZgz
	ZDUd37BShy8kO0sGloXbqgZEifeSTsnB9HligwB+Mcsh+/jIWamoDmDFKZrtwu23F87pjj9YIDw
	4uJnTd1W4bPB7bC0Ss3uUDd6fezhuofDAT03vkQpoCoPpuUlWAlzgiq+jeeocC+TWTd28Fd1Ogz
	Ez8XQTVv6abPh9izPRCAyerJidw6cEQEl7rqdh8/0A8DVEbepffGjKKFs62xd2ljdUGINnOQz+/
	qcxwtAMWvMn77iC0zkh9ghRWCOaZzZFvBEr0AlpHOF8pn1J8TDWl1d0tFfLaS/0pBdvS6vjkWEF
	LVmtPx9mHqQXJ/xjdqvgUN8e54bQRB9yNehwuY4E6h2TtidwCqQY6W6A==
X-Received: by 2002:a05:7301:4094:b0:2d8:dffd:f765 with SMTP id 5a478bee46e88-2e478a317b1mr4804651eec.19.1776634398533;
        Sun, 19 Apr 2026 14:33:18 -0700 (PDT)
Received: from pedrobgennari-Aspire-A514-53G ([191.19.131.187])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a7ff1sm11303450eec.9.2026.04.19.14.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:33:18 -0700 (PDT)
From: Pedro Barletta Gennari <pedro.pbg@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: pedro.pbg@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: iqs621-als: use lock guards
Date: Sun, 19 Apr 2026 18:31:23 -0300
Message-ID: <20260419213202.68356-1-pedro.pbg@usp.br>
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
 drivers/iio/light/iqs621-als.c | 83 ++++++++++++----------------------
 1 file changed, 28 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index b9f230210f07..222a42036799 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -15,6 +15,7 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/cleanup.h>
 
 #define IQS621_ALS_FLAGS_LIGHT			BIT(7)
 #define IQS621_ALS_FLAGS_RANGE			GENMASK(3, 0)
@@ -107,25 +108,22 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
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
+			return NOTIFY_BAD;
 		} else {
-			ret = NOTIFY_OK;
+			return NOTIFY_OK;
 		}
-
-		goto err_mutex;
 	}
 
 	if (!iqs621_als->light_en && !iqs621_als->range_en &&
 	    !iqs621_als->prox_en) {
-		ret = NOTIFY_DONE;
-		goto err_mutex;
+		return NOTIFY_DONE;
 	}
 
 	/* IQS621 only */
@@ -181,12 +179,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 
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
@@ -241,30 +234,22 @@ static int iqs621_als_read_event_config(struct iio_dev *indio_dev,
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
@@ -278,11 +263,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
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
@@ -293,7 +278,7 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 									 0xFF);
 		if (!ret)
 			iqs621_als->light_en = state;
-		break;
+		return ret;
 
 	case IIO_INTENSITY:
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
@@ -302,12 +287,12 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
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
@@ -315,16 +300,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
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
@@ -337,31 +317,27 @@ static int iqs621_als_read_event_value(struct iio_dev *indio_dev,
 	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
 	int ret = IIO_VAL_INT;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		*val = iqs621_als->thresh_light * 16;
-		break;
+		return ret;
 
 	case IIO_EV_DIR_FALLING:
 		*val = iqs621_als->thresh_dark * 4;
-		break;
+		return ret;
 
 	case IIO_EV_DIR_EITHER:
 		if (iqs621_als->ir_flags_mask == IQS622_IR_FLAGS_TOUCH)
 			*val = iqs621_als->thresh_prox * 4;
 		else
 			*val = iqs621_als->thresh_prox;
-		break;
+		return ret;
 
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
@@ -377,7 +353,7 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
 	u8 ir_flags_mask, *thresh_cache;
 	int ret = -EINVAL;
 
-	mutex_lock(&iqs621_als->lock);
+	guard(mutex)(&iqs621_als->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -426,29 +402,26 @@ static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
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

