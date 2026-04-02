Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD435A93C
	for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099730; cv=none; b=aydqty04bSnKn9lmFsNnWQgLsZKqRk201PPo0AQTYlIe4G3Tu9wIPG1OxDrB8eXeYgzQ3Bxj5hKwb6ym5oDS7MSYzzsd6BkgKQ9xL4dgIlJD/WM3Tp09mElKoQAObv5mIZCHy7aig1Q9ctfxIHp2D2eRht9KOH8G0svkfeVLYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099730; c=relaxed/simple;
	bh=mHU1EGjHak2fUPiGOB/lBaNe1/0E0ZQ2GsLOi7IziJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUWwC5oEbjWrXA3PyWZouL5Pplhk2mBwktGrE5pScOUPz2Y3Fkpq3+L3qFoTtTtOy+wbxOtlmBzmwXVR6JXHLwbxelCGCSX4yoCNorgPpFRRV5TAp0i1FAxyK1kFQ7OIDrIw55nCu1OShodgM5EtC+Mut3ZOzygWadpgK2wkXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5qTATWj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5qTATWj"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a857578a8so180641e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775099727; x=1775704527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/+cYI48e4dsSXmUJSv4Ut0MOgOPobb/gGRcAqckbUE=;
        b=m5qTATWjMKyPGO4IDBDPNdK3XdhqZsYvmL6+3U/GBwkWNH/pjYk+HDL8myR64jglSw
         8yvd7kQ5UWdU0XQ3f7co9GbylaIKj7A0A0sTZHygLnVbn+VO72/Ij446jipyW4GsNio3
         WzOa2OiCKfgNN2zPz/qZthVFiAQBuTlTl6C8oGMwX6r6m2xIjI7TFxFErUcIDPobI7mX
         8Vlp6KVS0F1547Qz2Dy24C/wzUxkKEMo5jyqK8+SdQ3K9Dbbi6hTG9lXg9w3dahEBhKK
         IWnaNU2BDx3jPbo1hDW9cpWIQ0F1CUPL1O/yljWrS6yz+b880K3FDmnpGSMJu2zqGnwy
         MRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775099727; x=1775704527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/+cYI48e4dsSXmUJSv4Ut0MOgOPobb/gGRcAqckbUE=;
        b=D8BW51+QQWTMdRifr4/X1D6PFc/M+pk+kQ5elBDOktdn26IXGCSJ4dYgKnAiGZQJgU
         ESNJeV1iKlJ0O8DfwKXu8j653wTa3VttpcT9r22Y5tZLjmXDCQREu4YyBMKbmo+2z7iv
         3dCaKS3q+bqailTXrVpr+33kdEp/Py8QyzAjUZn72cS2Oh+PkZMTVUZISX86o2YAwoHo
         RIvCuRI9j7Q0ftIfFepGQTfRzEghEMtgGL1pKU98GKyWxbQ1/TSTELVXwH/gZr4RQBfg
         QTGh4K+MU8LJddEjMz2pTC3Gpyv+Du2blabUPt0FbObA1zNblA6vRIR8m1F7Fd0JvItA
         DAsA==
X-Forwarded-Encrypted: i=1; AJvYcCWpo1CKsnFuX3usFJlI5NVMer8MyFjuIPYae6cPmKlj12PbY7F6Vk2jS4Dq8l840k0EUZJIjmwIt2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEJMzUZl9DXxH4jRsQYA4XNxghD5zxKXPkC+FP6dE0Olz7K9J
	UvKFibwIE6oHSMxqA0p4E90iZlH1A2uKjitpobGbO7EwM/mT7RktkCtGB0l5f+Lh2uA=
X-Gm-Gg: ATEYQzz3GxH+DcdaG4RWRGOqxzSYgMNqpwu83uFad74zZ71AED2WI5JXZp0JYe+LdXP
	e+y+b18KTmr5wm1yeIAEN0AmgNZWkuBSGxGBw7bUOn0ogBOZPVP7Yrb659B2OyxgcKnBaVeMj7n
	G1rSIRkspEpe3SP8vNzN89yR9iUnzaPTZy2nYTdrp6LzX69de6SPI4rAfHFPoQ00f8UI5GpV1lO
	2+5YnmY6RuGv4j1hsUhpDknsIQZJgCzDAKeSaiVdSE7m/q5CqcTrLReUJSQIikr88YPgsTwnSJI
	gnmiiDEG4IA89bTLh+XVnn6CUOPj3iZjzC2RLMmIrVkWPz8Bdw/E4UFuhhEnYwV7lT+/7/4UstM
	GPffSgoBSSV4iJz/3/8P9ZSwSEZL1Lx7W5jbQFzYcKQ+qcm5XoKAajwCt0BG829qEdEShFGMKuB
	WiWA4vHaCYJMTZy++QVInplDdTc74JG0XRASDKmA==
X-Received: by 2002:a05:6122:3290:b0:56d:3c26:20a8 with SMTP id 71dfb90a1353d-56d8a81bd3dmr2512203e0c.3.1775099726655;
        Wed, 01 Apr 2026 20:15:26 -0700 (PDT)
Received: from localhost.localdomain ([2804:1cd8:df54:18b0:b0fe:e504:f5b7:5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba81b53sm1897035e0c.4.2026.04.01.20.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:15:26 -0700 (PDT)
From: Matheus Giarola <matheustpgiarola@gmail.com>
X-Google-Original-From: Matheus Giarola <matheusgiarola@usp.br>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br,
	arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: [PATCH v3] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Date: Thu,  2 Apr 2026 00:15:06 -0300
Message-ID: <20260402031506.237467-1-matheusgiarola@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
ensuring the mutex is released automatically when leaving
the function scope. The change improves error handling and
avoids issues such as missing unlocks. It also simplifies the
code by removing 'err_unlock' label and several mutex_unlock()
calls.

As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
case in braces, providing a scope for the implicit variable
declared by guard(mutex).

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
---
v3:
- correct v2 patch tags

v2:
- fix missing scope in ad7280_read_raw() by wrapping IIO_CHAN_INFO_RAW
  case in braces so as to fix build errors.

 drivers/iio/adc/ad7280a.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..f34514be1648 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -496,7 +496,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	devaddr = chan->address >> 8;
 	ch = chan->address & 0xFF;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (readin)
 		st->cb_mask[devaddr] |= BIT(ch);
 	else
@@ -505,7 +505,6 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
 			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
 				      st->cb_mask[devaddr]));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -519,10 +518,9 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad7280_read_reg(st, chan->address >> 8,
 			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +549,10 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad7280_write(st, chan->address >> 8,
 			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -737,7 +734,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -760,8 +757,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			st->cell_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
 	case IIO_TEMP:
@@ -785,18 +781,12 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			st->aux_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
 	default:
-		ret = -EINVAL;
-		goto err_unlock;
+		return -EINVAL;
 	}
-
-err_unlock:
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -884,14 +874,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-		mutex_unlock(&st->lock);
 
 		if (ret < 0)
 			return ret;
@@ -899,6 +888,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
-- 
2.47.3

