Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEB283C93
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946021; cv=none; b=QfW3bvAtsuuP7AFSYwBOUB0oxTUO61GPutQna1C6zpnn6ospuU3rRMDYLpuW3VuARlCm8ihX1Lcpp1Tx7fZ5RIjc9UGt+7PXEO27zHHDFKnQBXnyI6PRindFnAe8USUfZxhksOTK9ROBH0XZ94aCwbYUwsH45B82m0JWqEHCF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946021; c=relaxed/simple;
	bh=LxnmxXsFxSNIsWziPyTAvOFqSYCKkC83yG4sVGQtNSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv77PgCQ8L218UqlvAoLU7TVzxy4pkr1AP3jIxHQIf3kiI/EfDJer7iBb2755nLBDloTUnxxiPW21RJsNELqQsa62ZwNXkoUFzkHH4PtpAPhOPe7E9ELDtR8mOXzL4Jzfd3lc9XPknRhX5A2hq6tEI3B+FAGX30O8yQYCaEJUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiCsZ2P+; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiCsZ2P+"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56cc8a021e2so878676e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773946019; x=1774550819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9q6os7J60I3c7phh9Hq4zpKkWGPhK1u26ddAssiUGM=;
        b=HiCsZ2P+c9ae1U/5IpQAPl7X8riGjIoy0rUZohpCWjR9UI2Uf7sC1hYq0PQAHa0e2k
         6w0XAbM7yjIZMz3MzLnCGWjCXXubdoy/y3r8MpzHIpijetYoJqz34OMOgamj+2uBdlTf
         swSNAPDKXRO4DQk4jSTUoAxY4Rs03JghqkIV0CWuUlo7syX2n6zj+EdsYBaby0PP3gNq
         8p20ZABqkfQLs7LrgcU0c/7y61tAC43TDrW+7nbGrokrNTRP5wyFCDIiZeoNzhPcfpz1
         +RYTHvSRdr+TEShWY7eP42y2flTwZTaV52l0ewkSnNjNAxDCsu6d5jwHh6VK5USwkRvm
         UQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773946019; x=1774550819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9q6os7J60I3c7phh9Hq4zpKkWGPhK1u26ddAssiUGM=;
        b=n79baQ9MY0Fhs/a8f0MeXrlYun0ftyfm8Q1gZcgit47h82oz3R8pUT4umz3emVi/wY
         HrtR5qX6qaCD1KFbeOoWi0jKGduhSlgcVvREGnsn+uloxa41ivqv52WdSibswF+B3cHR
         HRy7+09VX40mO626FVzGUWCEpcHTEOI2B/UctjcmoZdqlzgfHhnEqfr3q9C0AvCBnS2P
         3McacuTCs8lM0tSyf4G5BQc4RBpU84zLJYASNc1s/9Q+uOD3KjmZIPMjy/P4Pu9TpZM8
         tlXJgqgTZLr/NV9y+w3OkMefqSA95T7uhLMMx6+byL/Kuw9wtB+kzCLZxgbyIj2e23TH
         Bdyg==
X-Forwarded-Encrypted: i=1; AJvYcCXkPIXKZIiUPdsVDFqxoRqqSoxAqLiDw5A+NVQu4HOeNO9CYMljgIfu+ONAk+NM8jNixCVGnMUkVzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmt9U6zrfEMq2Yv53Jm/0u2dZYnoSnCy8XNjjQ+mB+7I5hNtL/
	HkeN1kGdvYuj3rpFKITDzwGqfJPQHzLISIIJjc6+n8IQGe8a3xt1noX8
X-Gm-Gg: ATEYQzztiwyhs8WrHbaQX8Utk+fjFpofz9jU+AdUqBUlDVrHB/qcrb6gAtPWjcsAyuf
	9W2Zi3fMzNAGI57KpEy/5+pxE+fbeyvOJLAHHExbGfRLTEByX3bmlQNDcu/t4KyHHC7xaajIi5T
	sw7D31yCBLwDwZUbvisI+gnB8fBITd/Nxr8E3j/VcyPyEBxYS/k8Cdc611ggyHMsmCRWSFT1IbS
	wFCAcWv/CstFgC2nQf/B4qBClSy6626XG+HxcA2qgPwIENQRea+sj+VEh9blWBdiDAtrfWfFqwI
	E2iK9CUHDPN94vp/yEVz0VDGuIOdmZpwtEMiKmmnVPA2HAcBl9TDz+Raiv98KgA5gc10DQFZbny
	FyanedpVD8CjQRFKz6ik+3hsM6D5vkl9wsGBtvBFDooy65GR5glrgXxfllls8H3ytgTLTnR//U+
	BhFYt5iYkJV8O6rQJE4bHg2XDFHGJ7UCkwTi2Wqg==
X-Received: by 2002:a05:6122:2087:b0:56b:702f:d0f6 with SMTP id 71dfb90a1353d-56ccfe20238mr2207650e0c.2.1773946019435;
        Thu, 19 Mar 2026 11:46:59 -0700 (PDT)
Received: from localhost.localdomain ([103.68.207.146])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcc2d60sm279724e0c.15.2026.03.19.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:46:59 -0700 (PDT)
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
Subject: [PATCH] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Date: Thu, 19 Mar 2026 15:46:15 -0300
Message-ID: <20260319184615.10970-1-matheusgiarola@usp.br>
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

Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
---
 drivers/iio/adc/ad7280a.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..3a4f0dd37d78 100644
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
 
@@ -885,13 +875,12 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
+		guard(mutex)(&st->lock);
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-		mutex_unlock(&st->lock);
 
 		if (ret < 0)
 			return ret;
-- 
2.47.3

