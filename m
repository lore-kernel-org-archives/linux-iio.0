Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50413EB813
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324035; cv=none; b=qtC/X6fUsM5ByYx9yd7/xA7jvP4+gD6/UpHrxYff99Bg1B1jFj9qJItFqRK/qeHmwnA7mAC54d1A3LaenuBIvMNvOGH5tIVhQ88CPXURNlnfxZ18T6sfmL7b6G276y51I0gLi5eQWK3J02Sfj5ItNkf3iOcxf7HIn4SV5u4G8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324035; c=relaxed/simple;
	bh=4Td/3xk/j+D52F+sWpZhilghFQ5RdbJzXaKbrOkDpW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJjCNeRhsKIYy5UA8gzEMEcBRNkDqSG96bSR2Ib5i7J5uqAtMp1FQDAGHzyVJeu372w5vEBIKYPFU9YzydGS92PyZyXb6f9BLmvet533eCKYsMi7wnWPYX/40WZZhcUeSyz6HfV7URGRvT3h3WeEsESe+fFxO61Tmg/YIgIuHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkUx0Fvv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkUx0Fvv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1317871a12.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783324024; x=1783928824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rW6nwGc5Ym3OH9Bwi0azBGX9TutVu37wXYRT9OWIchA=;
        b=jkUx0FvvXQrmPIhwzAnD3zOMoVO50hBERBuPtBw2QVXC/nphOJ++9q7WKPcqnkXYS2
         XiZAfm7o52rhcpqsNydqFrzgC7vEnFqWn8RHguq0MZ+nPFqp91xkR6rlPpnhulrJ6faM
         jeiukh5gb0oL2UZ2hvfMlL1X0ESk2SR14tnW11VCWbtPh3+x22JqDtsbQNNB8oV+0kmm
         jX4aM/BPXg8w1xVD6OKEMVtmMQYoL7hERynhWkKjIFAEHmVM0+PaxWnoZIatH53xwEpp
         12lkdGC8M++SDCWjZsDVRHoRPbhzirOqiv7qgqksjawHMleh7Rg9BbJWNjGpPG8PzaUi
         t/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324024; x=1783928824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rW6nwGc5Ym3OH9Bwi0azBGX9TutVu37wXYRT9OWIchA=;
        b=VYT9bX20SFKq1y0Gkv3UHltBEwfY2QnSHUXPjp9UU2cBEb2yCkjkv5QOfUfPeoehx1
         56paKbDWvd6hAA5rhY7kGlG/sAnMFZwH/dEuAzwBfOykApWqrpDi2YpajkbB8OXCZv3B
         sUfNd663AT6/ovCOYpYH6SBVZl/V6QQNYunkDiCvtJ5BnBRUpLbo3n0lPSOs+zCDrhiB
         YPjAICbIx1DYNzoJGlkE9wyzN34BnyQQjLQ0rVaDj3CgvvQrRL8+fTfuuUlBxlig8RFy
         3yXQh6AXtp5gPw+m1/BPSXYPK+uUyZxnJy07rUXBRcamHnSQiXFo8SkKoRlf3WbuoyiG
         eg9w==
X-Forwarded-Encrypted: i=1; AHgh+RoJZjzRFOss7iivaVTvQzRyc4Sadks1lTycvylTzf4JgacEqwK7Ik2Oiqr7Pto20WAraK13lRwL/N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUii1Yyzyv8JgHDml/pWboPg7B4EcGuNo97K1JXReEbHWSAdt9
	hpQs0bjKbTQkJscX2TtWg6nu29B1W8fTMQEbjrVQk3nDWzYX9iiCR3le
X-Gm-Gg: AfdE7cmGbXDjrM/RQHlZ5m4jIQ7pVIXfUubNuxYVBMkcXThMiqwHPvd6GZcRRleMFM1
	w/qXM5GSQu3EbJeov3nxht9GRwSb54nEEn8qiWVmY+GOVoGoOrbnbgeCqrHQZqE4+3VkiQcYqqe
	kG7fFFnOsW7C5qJZVsjsNRsC6CpC5IVbURV2yC6pd8hGSKjv8+/yJ48Rgx2QtWiHb/o1/nEWcWW
	Z0s+3yd7Fhqyzyew83aQZkIsASrDZIY9WzP3SDmpl7MTrl2qob7NcSQVJHrV7c0LyPqzcyvJwxl
	y8kJ36SRlAr7svZCOpx2nb3TEeE8AWr4VpcXBEgt0x7KxedypIpzUkJ6H/POKjavUpyaVlavKnX
	o1Tzqy3QyddqVi7/9srg5z1BPCBqi3n5CMZKBozIg/QUg5muSe9BJZCFumGaGSkfGedDn4VVA1e
	6rSCbtC+EQ05sSli7ZCQtFP8SpX9JUfrAE3HedMlc7u+M=
X-Received: by 2002:a05:6a21:310c:b0:3bf:6c07:b2f3 with SMTP id adf61e73a8af0-3c03e5af99emr10273298637.54.1783324024002;
        Mon, 06 Jul 2026 00:47:04 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm67081836c88.1.2026.07.06.00.47.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 00:47:03 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v3 2/2] iio: accel: kxsd9: fix runtime PM leaks and unchecked returns
Date: Mon,  6 Jul 2026 13:16:52 +0530
Message-ID: <20260706074650.96042-4-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260706074650.96042-3-birenpandya@gmail.com>
References: <20260706074650.96042-3-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kxsd9 driver previously used manual pm_runtime_get_sync() and
pm_runtime_put_autosuspend() calls in various return paths, which is
prone to memory leaks if a return path is missed. Specifically, in
kxsd9_write_raw(), if the user provides a non-zero integer component
for scale, the function previously returned -EINVAL directly, leaking
the runtime PM usage counter.

Switch to using the new scoped-based PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
and PM_RUNTIME_ACQUIRE_ERR() macros to automatically handle dropping
the PM usage counter upon return. This simplifies the logic by allowing
early returns in error paths.

In remove(), use pm_runtime_resume_and_get() with an error check to
prevent unchecked return issues, and perform a best-effort power down.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 59 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 7569201ed3c75..a71b473cbfa03 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -139,68 +139,65 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   int val2,
 			   long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
 
-	if (mask == IIO_CHAN_INFO_SCALE) {
-		/* Check no integer component */
-		if (val)
-			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
-	}
+	if (val)
+		return -EINVAL;
 
-	pm_runtime_put_autosuspend(st->dev);
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(st->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
 
-	return ret;
+	return kxsd9_write_scale(indio_dev, val2);
 }
 
 static int kxsd9_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	__be16 raw_val;
 	u16 nval;
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(st->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = regmap_bulk_read(st->map, chan->address, &raw_val,
 				       sizeof(raw_val));
 		if (ret)
-			goto error_ret;
+			return ret;
 		nval = be16_to_cpu(raw_val);
 		/* Only 12 bits are valid */
 		nval >>= 4;
 		*val = nval;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* This has a bias of -2048 */
 		*val = KXSD9_ZERO_G_OFFSET;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = regmap_read(st->map,
 				  KXSD9_REG_CTRL_C,
 				  &regval);
 		if (ret < 0)
-			goto error_ret;
+			return ret;
 		*val = 0;
 		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
-error_ret:
-	pm_runtime_put_autosuspend(st->dev);
-
-	return ret;
+	return -EINVAL;
 };
 
 static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
@@ -239,9 +236,7 @@ static int kxsd9_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	pm_runtime_get_sync(st->dev);
-
-	return 0;
+	return pm_runtime_resume_and_get(st->dev);
 }
 
 static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
@@ -476,12 +471,18 @@ void kxsd9_common_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_put_noidle(dev);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_warn(dev, "Failed to resume device (%d)\n", ret);
+
 	pm_runtime_disable(dev);
+	if (ret >= 0)
+		pm_runtime_put_noidle(dev);
 	kxsd9_power_down(st);
 }
 EXPORT_SYMBOL_NS(kxsd9_common_remove, "IIO_KXSD9");
-- 
2.50.1 (Apple Git-155)

