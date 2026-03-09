Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3913DA5C1
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070502; cv=none; b=SPnoa/xcMY5bBLDExLJjhg+m6a+/VO/PHNdEooFh4DPpRuDPUEVyEZWRmF2R9R/sRdllymajezbLCB3fuUw7XQTDTxhd5Oj1mQNp/mLKXEuY3XoTU4YY6AyiWu/h305eS5R99lNEIpQaFaYbm8FIfTxzqSyQ4ZSTpFf2B+yjZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070502; c=relaxed/simple;
	bh=vrE+CMIeHFYAeyFK29dqpzRZODZ4uJrVcL4FShk+xks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWFzRdnXVKE5CvLYhBjGB4l9d7xVGF1u/CKc2ATh9L4K9URYCSZolDr/hLNhb4vFRZ/OdEdHyQ5whWoW+ocfA4vhAYbG285o0mmH0yf1uE/vRuOFqX+222sDd7bTNc62WNzB5TwEEIkGtJXNRBO+LFRF0tqWTy43Vm+GNubMcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTyJ2GtI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTyJ2GtI"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73bc3dd25fso296894a12.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070500; x=1773675300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TofA4+zPs6CJY0GvXEWYtD82c2puhy10CmQlWfM+rhE=;
        b=ZTyJ2GtIZJGfvCHT04sM3VYYS00GRh2OA1UHiaIv69ban+GZPat1fmzNaQQC6JCBLV
         sClXFBCXTlU4ngiWkjOR/MykrClseFPY9Vwtb47FwHhmpmHyAWXzDTibv3BLD5yq5YlN
         Z78jj7O60Tdx8iyitx4e9C0CBmmFIcE6nK8+eog+CNFJnHuBoeKautSFXM/zOQxFGz4X
         zk21FVaUQZP4Prtycly1q2GKxKaGKP+xjNnjf8ab5LIE3Kc7uCbD9Zc2HhvqtwW2SdgZ
         a3L+qFKmZwCN8HQju9KGZRXpGY2AfqK256jW/OADcwgir99MS5tW526a4KPuWnnSyoeM
         ndJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070500; x=1773675300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TofA4+zPs6CJY0GvXEWYtD82c2puhy10CmQlWfM+rhE=;
        b=Wr+ygECQs8dt5JdlpLj6jZ7kYUugprntSBF/D1KdJgUefhP9dPj4R6jV7n7TJEIqWY
         Z7jyZ1aVi7UoA4YhBnCEnFQwgkeLwLFcUC2vLa7fIr4zy2fAkenXDrZwidsaFlEHRINB
         5bw+r69hYc17QpRQBqXq9gcDAZM1NVdfQ3Q4Qsa4yZnsn6q+KK04UykmwzZjCfxMT5Qf
         KQlRL4SNmgR78kJaQ9znvftFWfS6RdHmrQKbiEWUD7w/PTMfGyfdxQjbKqDm53lXR7C+
         wIgGYyWndFq8yTQopWJklflc0/Ti5U/yVhF6pp/tODZwq8c0b8jma3Vzx+cwQW4xabQP
         B9Bw==
X-Gm-Message-State: AOJu0YxmYBXnXx5bsC2/xbDuxYt9J5eaca4MZsnMGCpRnPVplJKYS1lA
	2N06kMeuVfOru7w0NYFmVUplLMyVF49YM9X4iWgArKG3C/LIBgI8n4wb
X-Gm-Gg: ATEYQzzEUEhz2EzY6HcfG3O10lZUvLRm7XoxkaC4MkIFJIZEVghy7t3vzVhs6japAir
	ueJXyBs/V4uajzBEepJQrtP1HC9E4+3ULVmYCoDOODe9hXf/5kCv/IkjW13ZZZ3h11UEVC6PCwf
	odkgQByCYI24TT7oWUz5brTouVIugpDKP3YsaB4LfRK8mmv/AR/IQrPgCP5nn2RRPH/wSHmLwUZ
	mUIDE72EHumNqt8sGq9Z1M7hn2APU15wPyIrQV0QvmonvJMMvHfh1/z8w72RvDmezOhfibJw17w
	T15nF5LAHoMMQKrh2robu1eZBxzri0A5wbEhCKGdep1FeRCik5g42ogEOz9mzN22TqfPmtfqaED
	KZFNELqUXdD/h0XdiVD5KhnJuksbsEVjsDyV1Ikq27oczTJZXZ50MD1EbztqHAjlSD65bKGqRFJ
	uYWM85E+HoUCgT5uyQuwdNJXSW+GlY4th6OF6uFfRArOGZd/HMHYbF9Pm4nhv3zhNTLCu86cbN7
	t6ujYLpVyqFH1UX+7yhjVmwsTM=
X-Received: by 2002:a05:6a21:6197:b0:398:a71b:a0f8 with SMTP id adf61e73a8af0-398a71bb767mr895162637.14.1773070500331;
        Mon, 09 Mar 2026 08:35:00 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm9316563a12.16.2026.03.09.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:35:00 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v2 4/4] iio: accel: sca3000: convert to guard(mutex)
Date: Mon,  9 Mar 2026 21:04:08 +0530
Message-ID: <20260309153408.71512-5-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
sca3000_print_rev(), sca3000_ring_int_process(),
sca3000_read_event_config(), __sca3000_hw_ring_state_set(),
sca3000_hw_ring_preenable(), sca3000_hw_ring_postdisable(),
sca3000_clean_setup(), sca3000_stop_all_interrupts().
This ensures the mutex is released on all return paths and
allows returning directly without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v2: Dropped Header alignment change
---
 drivers/iio/accel/sca3000.c | 97 ++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4a827be439a2..8a06602ab41c 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -9,6 +9,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/fs.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -424,16 +425,16 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
+
 	dev_info(&indio_dev->dev,
 		 "sca3000 revision major=%lu, minor=%lu\n",
 		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
 		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
-error_ret:
-	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -996,13 +997,14 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, i, num_available;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
 		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
 					      1);
 		if (ret)
-			goto error_ret;
+			return;
+
 		num_available = st->rx[0];
 		/*
 		 * num_available is the total number of samples available
@@ -1011,7 +1013,8 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
 					num_available * 2);
 		if (ret)
-			goto error_ret;
+			return;
+
 		for (i = 0; i < num_available / 3; i++) {
 			/*
 			 * Dirty hack to cover for 11 bit in fifo, 13 bit
@@ -1023,8 +1026,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
 		}
 	}
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 /**
@@ -1110,11 +1111,11 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	/* read current value of mode register */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
@@ -1134,7 +1135,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 			ret = sca3000_read_ctrl_reg(st,
 						SCA3000_REG_CTRL_SEL_MD_CTRL);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 			/* only supporting logical or's for now */
 			ret = !!(ret & sca3000_addresses[chan->address][2]);
 		}
@@ -1143,9 +1144,6 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 
-error_ret:
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -1277,10 +1275,12 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
 		ret = sca3000_write_reg(st,
@@ -1290,8 +1290,6 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
 			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
-error_ret:
-	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -1310,26 +1308,20 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* Enable the 50% full interrupt */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_unlock;
+		return ret;
+
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
-		goto error_unlock;
-
-	mutex_unlock(&st->lock);
+		return ret;
 
 	return __sca3000_hw_ring_state_set(indio_dev, 1);
-
-error_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
@@ -1342,17 +1334,15 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	/* Disable the 50% full interrupt */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto unlock;
-	ret = sca3000_write_reg(st,
+		return ret;
+
+	return sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
-unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
@@ -1372,25 +1362,26 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	/* Ensure all interrupts have been acknowledged */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Turn off all motion detection channels */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
 				     ret & SCA3000_MD_CTRL_PROT_MASK);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Disable ring buffer */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
 				     (ret & SCA3000_REG_OUT_CTRL_PROT_MASK)
 				     | SCA3000_REG_OUT_CTRL_BUF_X_EN
@@ -1398,17 +1389,17 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 				     | SCA3000_REG_OUT_CTRL_BUF_Z_EN
 				     | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
 				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/*
 	 * Select normal measurement mode, free fall off, ring off
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
@@ -1416,13 +1407,10 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 */
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-				(st->rx[0] & SCA3000_MODE_PROT_MASK));
+		return ret;
 
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+				(st->rx[0] & SCA3000_MODE_PROT_MASK));
 }
 
 static const struct iio_info sca3000_info = {
@@ -1504,18 +1492,17 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+		return ret;
+
+	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
 				(st->rx[0] &
 				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 				   SCA3000_REG_INT_MASK_RING_HALF |
 				   SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static void sca3000_remove(struct spi_device *spi)
-- 
2.53.0

