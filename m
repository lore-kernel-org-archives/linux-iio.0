Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F83AE19B
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553818; cv=none; b=j86CvWqV8LmBgMVln0DDBdouUkz2faNCYpW2HKpT9z5mzgoAQz/VB0AbpF7dltmjEZJRD77dtD5i5GfWE+zQc7h9Ut1Dehhz7EtNFGl4P7c8WINXDvzLsQ4Y5fwQBGM1fgvE47RZ/PS40FqKzdgKNzBBbNrkSKOn0oC27he4fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553818; c=relaxed/simple;
	bh=MX4tfIeIUP2JNAfGBkbaVwMAfGJ79oNWBvBcRIJ6L/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4J/3qtwqSKP21IYiDsdx8sFvBb+AE9WrLG33p/IejgR5LqX4RiurA27VgPiDHPgJK/BKRdRiSRq5lx7VAYpghzdSjvl0a62XSbDHgDiIJB3wO+G3wgneFs6tBUDIua5PqXvPu1V0+vyDfcWbBVMnTa6O12SP8u21EDvaSknRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuaBJVbp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuaBJVbp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c379e8ffso25369175ad.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553817; x=1782158617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UlTxPy1b6VFV8iwjr8AQ1pKpnY184xWWnM9UWZPBFro=;
        b=nuaBJVbpv5P8ytNSwg4ajDnCn2MKY612lBbdXv0f+5uYtWmOgK+eKa7B/6qprZBtUM
         /tu5HDF4xK2Aw/OPrj5sPDj9Xtve/p4YBNtNDWJFhhvJaw6ohLkcvuK1IH05+Un7xpty
         gayWcb19pPFTAW9lmtb6eT4Tzu4l2VIbT5XWPP7y1r9DduMKbhBi3q0uex2KnQtmWtyJ
         SgSrRHOiFtNLK1j49qygronKLuqT8FUIxr1RWeJLgXFEGmbKddgdAoymaAlgNVAap4li
         isMfhnk+hb3eDmynNTGxl34cr4r+9GHgsQiLVt0djBstk5ij0w3YY2Otmb8KXMsW2zpO
         j8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553817; x=1782158617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlTxPy1b6VFV8iwjr8AQ1pKpnY184xWWnM9UWZPBFro=;
        b=Eik5USv5ZIcXj50uC/LjcMZAco6LKHa2hYMjZenaZxHAfVN+o7bjkSr2JqRF9M63k/
         88+andWZHHAoG1m3s2HdEhotphynYIU5CXp48rVrGehlZTYoRdmRiHAND7weK1KsMyVV
         oIOmma0p7b64PIhshUyu8uVTJTMqQLp7GA2B940Ar7MbEqL/YX6A/cfJjbXWRmym+Z0t
         Mo32ZT8XOGKOwTkAwyzvu93esK6STH223I0expY4Ox3YgagXTYU/2FJs2c6GdiC5B22X
         Lr2pvmYqqv8R4eaZne1Q2atWfSAiT9SHZmF2rHy9VK2zcbKEHWiqrTBz/xjKH1+ADxZh
         q/9w==
X-Forwarded-Encrypted: i=1; AFNElJ/Hx9rUlRRJb1Gjh7TaF9+6p6378yUZjyd9Y6lT/CO+mirVT/TW8ObXgk1uaTlVx5aF2imVNn7eM14=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXO9BLwgzz+b5lcJv0oQT3vXRIm6xZEVCTQR9rNGub9TMk/aM
	7kL6ObRjsshpIa4pN1gVLlUOcSzn1MyMiyPd+eS57sIi7g3uNp/qK1VM
X-Gm-Gg: Acq92OHxK9NBiCXJ88wVQwafnO3G6L30EKDe5A1MWJURz4mCx9GQ4+XI86u0yKzmhud
	XIKNW6tjHklz4QaqDPRJfppdNT1OloOWmAYz9W4o481gM5HuQnS/1kRbg/9vbuJs3/Ks2fDWi0R
	q/rlwbuLTA9DFk3GxUKbQo6h+dwn6tme1gNeroMeneLijHJ8AK9Ni/dVR3fi8GkkcAfEptSgm2c
	8wPHFredTQ4lWNe7LQXvv0KNjuEKKE+GlJ0ehSAOF94Dkw/v6y/lzIeboThfgejrBblW0wXPrje
	Q0gn9Cpg3TX3e4ykSKgh8Xep73u1DmhpT8iP5jfjpROf8SnI9pupVYaLB2ZWNeCHwqZGBjhEXkA
	maOJTGzmGA1v3razsv/KrT2o9DX0w3Ic+cmw3ha8fk8jSJcjypsQJVh72Dc5Tb8dk/h/ut06SK7
	sHYsZmI3piP2xYzflZY79snMHtk6o7tbw2ooJQqA6kZZTbfbXeLA/b
X-Received: by 2002:a17:902:d48f:b0:2c2:1982:5270 with SMTP id d9443c01a7336-2c6641e28f9mr144081825ad.21.1781553816731;
        Mon, 15 Jun 2026 13:03:36 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e59e1sm110714925ad.17.2026.06.15.13.03.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 13:03:36 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH] iio: accel: kxsd9: Fix runtime PM error handling and scoping
Date: Tue, 16 Jun 2026 01:33:30 +0530
Message-ID: <20260615200330.33207-1-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kxsd9 driver uses pm_runtime_get_sync() in multiple places without
checking its return value, which can lead to silent failures. It also
relies on manual pm_runtime_put_autosuspend() calls in various return
paths, which is prone to memory leaks if a return path is missed.

Fix the runtime PM handling by using the new scoped guards and proper
error checking:
- In kxsd9_write_raw() and kxsd9_read_raw(), use the scoped
  PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() macro to safely automate
  cleanup on function return, while maintaining the behavior of
  waking up a suspended device via pm_runtime_resume_and_get().
  This allows us to cleanly remove all manual puts and error gotos.
- In kxsd9_buffer_preenable(), replace pm_runtime_get_sync() with
  pm_runtime_resume_and_get() to safely check for errors and handle
  usage-counter unwinding on failure.
- In kxsd9_common_remove(), replace pm_runtime_get_sync() with
  pm_runtime_resume_and_get() and only invoke kxsd9_power_down()
  if the resume succeeds. This prevents unbalanced regulator disable
  warnings and bus timeouts if the device is already suspended.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24a..f23d1660e6da 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -139,68 +139,63 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   int val2,
 			   long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	pm_runtime_get_sync(st->dev);
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(st->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
 	if (mask == IIO_CHAN_INFO_SCALE) {
 		/* Check no integer component */
 		if (val)
 			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
+		return kxsd9_write_scale(indio_dev, val2);
 	}
 
-	pm_runtime_put_autosuspend(st->dev);
-
-	return ret;
+	return -EINVAL;
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
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(st->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
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
@@ -239,9 +234,7 @@ static int kxsd9_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	pm_runtime_get_sync(st->dev);
-
-	return 0;
+	return pm_runtime_resume_and_get(st->dev);
 }
 
 static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
@@ -476,13 +469,18 @@ void kxsd9_common_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
 	iio_triggered_buffer_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_put_noidle(dev);
+
+	ret = pm_runtime_resume_and_get(dev);
 	pm_runtime_disable(dev);
-	kxsd9_power_down(st);
+
+	if (ret >= 0) {
+		kxsd9_power_down(st);
+		pm_runtime_put_noidle(dev);
+	}
 }
 EXPORT_SYMBOL_NS(kxsd9_common_remove, "IIO_KXSD9");
 
-- 
2.50.1 (Apple Git-155)

