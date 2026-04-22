Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD83A1D05
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899631; cv=none; b=KisiKuX469Pv3N5j+luRWxPhKuW3r2JpiYOrDlffUOUkHic12q/sE141oqHKuQPculLyhQl+L3Y+9CE1IrKeWsIPPFVN2dJatpatxqqYFcAMUcfz1GT3/fmOSwQeDevPrspyKBcGawzFSLWjUxE5QfuWrwuqrNZ9qN2XULqV6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899631; c=relaxed/simple;
	bh=fq49wEqRMEriu4wg5ajjeoVMpzdhTPVxlvpKHAIXmc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Tgo8GBB+eMM+dPbz+m/PaV3G+bvti+3yMu81mAeW2Bxhfq3iaOfko+h810OHmiedjMUnJb4tA4vJCEtJnkcnnOq8L2rXANSPH1R6Y/pqqvg95PbnNHT81gzTZgPcCGQJI/jIqBPYq0KLfFOF7al1vSyZkk7cj90vvShndAGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=PTD68ExY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="PTD68ExY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-570f7bd671bso914569e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776899628; x=1777504428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSBqsvb5+66K3poQGiwyMdlvLCTi47vNDqU8WTquujU=;
        b=PTD68ExY7hujMdn2rcmJUE4JLNsEA1hkX9PytaxQTfr/TwUOquO3eQzN/FWkBhs5cj
         nHwnzSmdyl2TPyH4MPf534UgGiZgFIhFBw5vTj+VEC+NnFGMlG+jIPOo2FSpLnOugX/A
         YbPa0N8J4TOHkPV5pT0adb0SD2oY+6D8Lb2L480cPYXJO8dvjqgI36V51z3hijgIFSQq
         Bx912E3JAjKPy2hj4WIOo+WJxNdi00+9ybKus15axElEAlbhwL1BgDAsFiAGypLAgUSh
         KbLuaNNzi7b9+pTuxLt6qmlp92XEsjJzj0kQKzeatZx5Ur/iMWziijHwQJQGPShiew6s
         AS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899628; x=1777504428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSBqsvb5+66K3poQGiwyMdlvLCTi47vNDqU8WTquujU=;
        b=WNG4zrZAmV0FFnWHRu1BFVYSKMmR4juBaTGbWpBZQ6jC3MDed+IhJdgMi3IdaaqTHx
         Kq1xwoQLAEi7iMhDVTfTvGL+PebHIW+e1ftPUIHBaXs6WVxfC+PxFZAhN/G4LdHPCR2M
         zkIvt/N+fPS8BTO1AV3InVUYwVoShzXmgNM/KSaMD4zUGcw+QBlqZhsXVLvJ73Q2ArmX
         yW52s90nN5cQ+xF3x88PJEZaErnfFyY9t3C3MXiy04Wd/6bsROQfHqJZ0ufpTJNRwKKq
         vpMLYAKn8qsFZzRdSa9TKrfLng1Cc7ts46awTqgUeKyJHnpWJKpNrmz4Z3C/43YWPTRR
         7zTw==
X-Forwarded-Encrypted: i=1; AFNElJ8VOssSrHwg8FWev/FcYbfrLz354YyJRtJ8HIQ0wWgYSIutI4Qm5/FK1kVk7EwfFRCn6C/VzfACgkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPmIKqoEx+yaS31Zo0YD4KC5HTA5UnFQj7s25FFoD0KB8Ey8eA
	skv+rXJtydvuhmJgNu/hlSBHjcHvSsE6OPH5CD5cUCl2tutq8y/u0bs95LoLRGriTsk=
X-Gm-Gg: AeBDievB43NF6Cw3CBCnVKwgAT/CCVwS+gHUlDwDBLwb/SS/RV9merhpsnsCpm/znlu
	VLU6MTYuZljIv9Jjj28HmZBy7Hls9kZWPdMkQ6aXBXQ85hgCB45ySUU2cuTGJhJ5bR6GcaEw0vW
	NkK+T8KEuhkWy4PReP+IE9JjUSwlnlzsYcV4KISkPkPdW1sd3Fk1SWwINa+3jsL09v5aYiqyhYX
	nPUds53azHKlopUFTU4J2STuVF/wc/q9h0IzrA/DlXTgWdl4sYyUpYLZjV9UBLZWrxlgb+5ydwG
	DNDEaLG6PjJgYR6IGpRqG5bCS7ZYxqdNzhtpD2v3Iu03G5T+Yn2P1qIecr3l/Jq2K2hc0L58Qqw
	CslbwuuFwVC24JQfL2gatINNl5TFpVpn8h3ZbkBzpJr/EF59uNC8Ctb2OLOrIoq9FukMeJiLTba
	sGc/uS0hGI87JT9R96f2bURuAON1Q0Vw==
X-Received: by 2002:a05:6122:289a:b0:56f:61d8:86d7 with SMTP id 71dfb90a1353d-56fa58bf83cmr12682008e0c.7.1776899628362;
        Wed, 22 Apr 2026 16:13:48 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm10669834e0c.5.2026.04.22.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:13:47 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	"Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/3] iio: light: ltr501: use automatic cleanup of locks
Date: Wed, 22 Apr 2026 20:12:56 -0300
Message-ID: <20260422231305.677778-3-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422231305.677778-1-rafasales@usp.br>
References: <20260422231305.677778-1-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

Replace `mutex_lock()` and `mutex_unlock()` calls with guards
to reduce boilerplate and allow for simpler code blocks.

Signed-off-by: Rafael B. Sales <rafasales@usp.br>
Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>

---
Changes in v3:
- Replaces `scoped_guard()` with {} + `guard()` in some cases
- Simplifies some return statements
- Includes cleanup.h header

Changes in v2:
- Maintains original locking boundaries
- Simplifies some return statements
---
 drivers/iio/light/ltr501.c | 131 +++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 277c497bd6d8..81fb35cbd56a 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -14,6 +14,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device.h>
@@ -250,7 +251,7 @@ static int ltr501_ps_read_samp_freq(const struct ltr501_data *data,
 static int ltr501_als_write_samp_freq(struct ltr501_data *data,
 				      int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	i = ltr501_match_samp_freq(ltr501_als_samp_table,
 				   ARRAY_SIZE(ltr501_als_samp_table),
@@ -259,17 +260,14 @@ static int ltr501_als_write_samp_freq(struct ltr501_data *data,
 	if (i < 0)
 		return i;
 
-	mutex_lock(&data->lock_als);
-	ret = regmap_field_write(data->reg_als_rate, i);
-	mutex_unlock(&data->lock_als);
-
-	return ret;
+	guard(mutex)(&data->lock_als);
+	return regmap_field_write(data->reg_als_rate, i);
 }
 
 static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 				     int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	i = ltr501_match_samp_freq(ltr501_ps_samp_table,
 				   ARRAY_SIZE(ltr501_ps_samp_table),
@@ -278,11 +276,8 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 	if (i < 0)
 		return i;
 
-	mutex_lock(&data->lock_ps);
-	ret = regmap_field_write(data->reg_ps_rate, i);
-	mutex_unlock(&data->lock_ps);
-
-	return ret;
+	guard(mutex)(&data->lock_ps);
+	return regmap_field_write(data->reg_ps_rate, i);
 }
 
 static int ltr501_als_read_samp_period(const struct ltr501_data *data, int *val)
@@ -504,9 +499,10 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (new_val < 0 || new_val > 0x0f)
 			return -EINVAL;
 
-		mutex_lock(&data->lock_als);
-		ret = regmap_field_write(data->reg_als_prst, new_val);
-		mutex_unlock(&data->lock_als);
+		scoped_guard(mutex, &data->lock_als) {
+			ret = regmap_field_write(data->reg_als_prst, new_val);
+		}
+
 		if (ret >= 0)
 			data->als_period = period;
 
@@ -524,9 +520,10 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (new_val < 0 || new_val > 0x0f)
 			return -EINVAL;
 
-		mutex_lock(&data->lock_ps);
-		ret = regmap_field_write(data->reg_ps_prst, new_val);
-		mutex_unlock(&data->lock_ps);
+		scoped_guard(mutex, &data->lock_ps) {
+			ret = regmap_field_write(data->reg_ps_prst, new_val);
+		}
+
 		if (ret >= 0)
 			data->ps_period = period;
 
@@ -667,23 +664,23 @@ static int ltr501_read_info_raw(struct ltr501_data *data,
 	int ret;
 
 	switch (chan->type) {
-	case IIO_INTENSITY:
-		mutex_lock(&data->lock_als);
+	case IIO_INTENSITY: {
+		guard(mutex)(&data->lock_als);
 		ret = ltr501_read_als(data, buf);
-		mutex_unlock(&data->lock_als);
 		if (ret < 0)
 			return ret;
 		*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
 				   buf[0] : buf[1]);
 		return IIO_VAL_INT;
-	case IIO_PROXIMITY:
-		mutex_lock(&data->lock_ps);
+        }
+	case IIO_PROXIMITY: {
+		guard(mutex)(&data->lock_ps);
 		ret = ltr501_read_ps(data);
-		mutex_unlock(&data->lock_ps);
 		if (ret < 0)
 			return ret;
 		*val = ret & LTR501_PS_DATA_MASK;
 		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -704,9 +701,8 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			if (!iio_device_claim_direct(indio_dev))
 				return -EBUSY;
 
-			mutex_lock(&data->lock_als);
-			ret = ltr501_read_als(data, buf);
-			mutex_unlock(&data->lock_als);
+			scoped_guard(mutex, &data->lock_als)
+				ret = ltr501_read_als(data, buf);
 			iio_device_release_direct(indio_dev);
 			if (ret < 0)
 				return ret;
@@ -815,14 +811,13 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
-		case IIO_INTENSITY:
+		case IIO_INTENSITY: {
 			if (val != 0)
 				return -EINVAL;
 
-			mutex_lock(&data->lock_als);
-			ret = ltr501_set_it_time(data, val2);
-			mutex_unlock(&data->lock_als);
-			return ret;
+			guard(mutex)(&data->lock_als);
+			return ltr501_set_it_time(data, val2);
+		}
 		default:
 			return -EINVAL;
 		}
@@ -959,7 +954,6 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 			       int val, int val2)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
-	int ret;
 
 	if (val < 0)
 		return -EINVAL;
@@ -969,20 +963,18 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 		if (val > LTR501_ALS_THRESH_MASK)
 			return -EINVAL;
 		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			mutex_lock(&data->lock_als);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_ALS_THRESH_UP,
-						&val, 2);
-			mutex_unlock(&data->lock_als);
-			return ret;
-		case IIO_EV_DIR_FALLING:
-			mutex_lock(&data->lock_als);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_ALS_THRESH_LOW,
-						&val, 2);
-			mutex_unlock(&data->lock_als);
-			return ret;
+		case IIO_EV_DIR_RISING: {
+			guard(mutex)(&data->lock_als);
+			return regmap_bulk_write(data->regmap,
+						 LTR501_ALS_THRESH_UP,
+						 &val, 2);
+			}
+		case IIO_EV_DIR_FALLING: {
+			guard(mutex)(&data->lock_als);
+			return regmap_bulk_write(data->regmap,
+						 LTR501_ALS_THRESH_LOW,
+						 &val, 2);
+			}
 		default:
 			return -EINVAL;
 		}
@@ -990,20 +982,18 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 		if (val > LTR501_PS_THRESH_MASK)
 			return -EINVAL;
 		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			mutex_lock(&data->lock_ps);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_PS_THRESH_UP,
-						&val, 2);
-			mutex_unlock(&data->lock_ps);
-			return ret;
-		case IIO_EV_DIR_FALLING:
-			mutex_lock(&data->lock_ps);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_PS_THRESH_LOW,
-						&val, 2);
-			mutex_unlock(&data->lock_ps);
-			return ret;
+		case IIO_EV_DIR_RISING: {
+			guard(mutex)(&data->lock_ps);
+			return regmap_bulk_write(data->regmap,
+						 LTR501_PS_THRESH_UP,
+						 &val, 2);
+			}
+		case IIO_EV_DIR_FALLING: {
+			guard(mutex)(&data->lock_ps);
+			return regmap_bulk_write(data->regmap,
+						 LTR501_PS_THRESH_LOW,
+						 &val, 2);
+			}
 		default:
 			return -EINVAL;
 		}
@@ -1095,19 +1085,16 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_direction dir, bool state)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (chan->type) {
-	case IIO_INTENSITY:
-		mutex_lock(&data->lock_als);
-		ret = regmap_field_write(data->reg_als_intr, state);
-		mutex_unlock(&data->lock_als);
-		return ret;
-	case IIO_PROXIMITY:
-		mutex_lock(&data->lock_ps);
-		ret = regmap_field_write(data->reg_ps_intr, state);
-		mutex_unlock(&data->lock_ps);
-		return ret;
+	case IIO_INTENSITY: {
+		guard(mutex)(&data->lock_als);
+		return regmap_field_write(data->reg_als_intr, state);
+		}
+	case IIO_PROXIMITY: {
+		guard(mutex)(&data->lock_ps);
+		return regmap_field_write(data->reg_ps_intr, state);
+		}
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

