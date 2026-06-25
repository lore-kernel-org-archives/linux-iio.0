Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AA3DCD80
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389102; cv=none; b=u0qnZ6LTIue+94FojtMSXu2brW97CNYaqnzcfCPIf/i/sLIXasPOPKIdIlJGAombsZZDBVK0FVpKUuz23pus5xvpUzBCGyi8tqgexIf+ERI6dlOd3L+3vRcBCqlhdlPT68Du3u1vF9bBHRqYLDMIR9kgEuUWYxcvFI5dFIPj62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389102; c=relaxed/simple;
	bh=KX4j5dfZ4TIbacLcQ0pYkg286VcTDip2XjdZMyDtwTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4aQ3gcAVjI2OVG4VMJnlouahciCcr/GGrG95DXok3PeTKBcmHwG8dnc7JGmEcmq95y0MYEXdofBYROpjj9yBT+Ms8ICdBfSD8fxBRN/wsogTvS2gZO/eG2Cga0ibVTUZI0xgmWkO6y2xVA1EoDhuKhZhMpG2nkMH0CR4IGzSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbj648/a; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbj648/a"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fd464d51fso1325773f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389100; x=1782993900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hys8RmE1l7PhUa99M9ZeaA23kXdy/j07bAQ7G83FKzg=;
        b=Pbj648/aeENpC4C4wkBxV4cst2k3Fl7tPXtMx9JSY6NWSZnkHMmgxjDBDbotVRs6kf
         o29o8GWNRANP13z7z1wG6zFbjeKRxs6XYz87Z2MosB8W/8y32CySWF63bAYuD0VXTRQU
         7aHwCeVnvSMYatwFKUV6ywjlMKZtLg7CvzeJQl3Y8fi2C3Z2FQlNBo+XAEkXuzVtCKsy
         Bm4lQu53rnjXMr+VFQpEV44fjq7cNZNkAjFgyEFk+VVHJ8QCOBmXfJ/YVbD0f9WWdxNL
         Yui6FKdfYVfrY+eSmrsvtZXTvrFOqk+1QpWqpfE8ENzfrQGlgaFLlvQaLw4BXDcg12Zq
         JELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389100; x=1782993900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hys8RmE1l7PhUa99M9ZeaA23kXdy/j07bAQ7G83FKzg=;
        b=CSi7BH/wZtIn1RsCyXzpkC8jxm9nzn9QEvNCvQf0igJ/Mw3lhnK46rBl9Su2fFb61K
         eut096O2bemxwNTJCs8Bo9iOQDBiyWohmqGAvH7R3pC4Xag+xw44L4NDbwEJoti85hpm
         WU3D4Nxf/WGzFdBe6L2HYyyFsP5RTHrUBRFBJIiV6Vx0PtO3nqmM4fcl0Nqm/CicStuo
         5J+YXJXOk1FNxOGLn+Bl1YeKy4mW54HIIWAZ7eZl/L//X0kf87rIDTqb5DNJ9Ly6Fggc
         GVfg3dcdSQ19Ui8IJ860/Hw7uhR92rRig6gd9yaP1ES8Y93Ndqw64VCdtCdZaC3S2K7u
         xYcA==
X-Forwarded-Encrypted: i=1; AFNElJ9pxvlFsmQgYFXkBrOqRsyLXxEDi2NnNNGbrp7JGF/2eijfbJo7vglS3DKpKzTfV5wigDgtIkYQy0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSf0+MV16n0QPlg9vL/3HLNU13IQbGVSmaRxkUbDxPFEtfMsb
	sHjh9W2fjx6EbMEdNwbCQvgV1x4XKOlKcIrvAZliHAElNE4ZtNzndzeW
X-Gm-Gg: AfdE7clVmGf7B/I11QU9UKihrZMmyKznZXJbcBtcLz6IUm4BvahVLdsdhvmkCrsJeZk
	zCweKJkm8/TyXd4fXmJ5NqGtHsECyJfYvXsD6O96sgsmqjd0//1jlAdIIYh2nFj1mBQdZve215z
	Y/w0Bbbeg+Jhd1JE+voplneIJ1gJ1K0/irzueqO30cqvikgmuxJr0kXPa2I+zIpyGw6J23Q3IYH
	IrQe6T2S7SXGPsrdjnlFlmSkimzXKdKA15t+enbbcs6isUBgEiUkI7KrPaTnsf82/O5AMj6rfow
	5pYGXrdLBPcvXVXojzx7oPspcND/JH75b9Fx7dsM/1HMkp+rlT4GB/SJ3VsvKDZFupRWJEXjaT1
	oZuDeenpYg11mCK1ULB3360QoAHedo/h3kOzAetyMLLXG1nYh/hs3Py6OFaKNv1YwF2LdllgyfW
	LFbBw2dMEcH/Uro7wM6VJXRD+UErvUyacVEqku/2sTOfkWNfU38zaxc4lx
X-Received: by 2002:a05:600c:1d0d:b0:492:1e36:85dd with SMTP id 5b1f17b1804b1-4926689f6d5mr32803555e9.37.1782389099369;
        Thu, 25 Jun 2026 05:04:59 -0700 (PDT)
Received: from legion.localdomain ([31.223.63.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49265fa8004sm49941925e9.10.2026.06.25.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:04:58 -0700 (PDT)
From: Batu Ada Tutkun <batuadatutkun@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Batu Ada Tutkun <batuadatutkun@gmail.com>
Subject: [PATCH] staging: iio: frequency: ad9834: use guard() for mutex locking
Date: Thu, 25 Jun 2026 15:04:55 +0300
Message-ID: <20260625120456.1267-1-batuadatutkun@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex) in
ad9834_write() and ad9834_store_wavetype(). The mutex is now released
automatically when each function returns, removing the need for
explicit unlock calls.

Signed-off-by: Batu Ada Tutkun <batuadatutkun@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index bdb2580e2..f15819eaf 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <asm/div64.h>
 
 #include <linux/iio/iio.h>
@@ -152,7 +153,7 @@ static ssize_t ad9834_write(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9834_REG_FREQ0:
 	case AD9834_REG_FREQ1:
@@ -210,7 +211,6 @@ static ssize_t ad9834_write(struct device *dev,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -226,7 +226,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	int ret = 0;
 	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	switch ((u32)this_attr->address) {
 	case 0:
@@ -269,7 +269,6 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 		ret = spi_sync(st->spi, &st->msg);
 	}
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
-- 
2.53.0

