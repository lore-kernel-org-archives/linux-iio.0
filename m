Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96A1C5D59
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331126; cv=none; b=XFO9XOQ8pYdeZqpAJF9s1XkXpVBR/uFArwWGMcKlK6E0KCY2AfvH2mPd17uSyx4G1H0VrrRIagncHYQfN+Jrm5BAj4jObutLtoalnwFaywErAIkVSK/hSdyrWx0nBZQtNOO6eewIFI7hG7I8vo5SNRyyiRRVDOv/vV9A1zKPs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331126; c=relaxed/simple;
	bh=Is/luQILOTRTzOueYyGOzSnqu8p6mu2iWPMLegwUpKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooI08OhuyHjHjDSZSpQMPlZ4X4lovKaq4Gv9pAdmSczg2C+FdeIdMKqFwClxNdTV8BzMNseNVkdnG7QbaWzgDcmMDXPXOWJ/2l7GT7Pq8vYRNdUgygWOiVmIWeB3VuNhZzdL4FYvXIT6vqMNpzp7eNd4vqibvwrS5V36rG7LYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj2rqhnl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj2rqhnl"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d85152c9so1177559b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778331123; x=1778935923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T45aydPJRbvh8SgBOmoAMmbmCUpht/fm7lQKE9iIbos=;
        b=Gj2rqhnlCSy5iB3XX+6NO/sOCznla8VNTfs0QMhE77WOghjdpKOi8tV5HlGPiQJ0Vr
         CJcAGOt1bJwZ+iXJDQ4wRcE6HDSlMXXRyV6GFw0QdEczTLWxFwZnkFn6N5C4Dfzqj1cg
         IdbPVcD+sBw258o3J0l27jM8L1usgznoIbULsiHo8MJpVkt77hOF0MH1dYdhOMfeIIGl
         KwJQn5ujotTsMv6eHacJqUt7OuaYJ8Wm9C60rpQ1YV/8Yut3/DiPvejdPQ2UkUA5uV7O
         QAmB37eRLTlCY/Ct6JHzVro6+bKo798RWz9Z7sbT+CW13xV9jjsLWVkC41O610rR8yVF
         S8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778331123; x=1778935923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T45aydPJRbvh8SgBOmoAMmbmCUpht/fm7lQKE9iIbos=;
        b=MZ8QO03rUrOTDnCVol1YQAohXt8e9k3+7lLZIJI0brCPsoeAbjsULqsUQUSuN6O4vI
         mg6gMm1fbWMB5RNbkBPCIzTDfg1K7W3cG+RuXhw+ZdHx0/ONdV0cCGKvPyOw7Je3Cs0U
         Ta6Ko9epwTCha4PWxb3I5GYwoQwyoEmOftgsCCPY62jdfEsgW0LApttTn2Lqf1Y6Az4L
         +hSa6Z+liLNd5zGop4/1Zdz+QpoBTaJcxAh5cxbx6oRuGJuQdZMbMVA1dZU3iAupuQFg
         8nEIZwOig5Pjdj58gW9FLl5n7fqHTjAD5ho3hyZ9vPyjpx2h0gjzd/qnZpQkQg52IJaT
         hUmA==
X-Forwarded-Encrypted: i=1; AFNElJ8haLNRKnC1K8dBsyn1mxpE/VZ8CNYf3m62Xm/qB8HRQ2BOHn3pomqXeqPmNDbukt1hobaPFL+0p0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoMolyGdAeAn0qlejA4435kNqMw3Ur2n2F+FzghcW67Q4HpCW
	cOrxX6eba14neAqBUatinWTcwSbrOse5Hv/iETlcAHzIPpjIVg+cpf81dbWaIMasKI0=
X-Gm-Gg: Acq92OGCBcvL4abGesUuCeh3kJ4c9pvMC1SZgqiA7pVnXNgEoZ4QEvYhcZm0d4ZGaOo
	mmOoutBQL1Y7RrIqVfDEVyYLNOr1ddEDDb41PMJbeh9rG5INxMkMyLkXadzKnUFNMR8gZ6Sz22f
	uA0eBZR3iZPFn/69evMSy2gHRj7Y4MJRZcU/xcf7Rn0/5AvnjnMk1Xz9FRQWsj3pBM4ZKIwhRsi
	YZ7xfA0BW55vrEMuMYSoVGSpoG5cE4o7F8sUfeOCOPE2CaG2PSe2ziqyKkt3sPZLwEEfziWMYwp
	diruYSAZK2AYB6m82yq5s9EM5u1S+zZRNlKPWG5FNxBk72DyvNBcAsdsvynwblv3Mt9jA9D8u1r
	iuahG9/5O+9PWxNivy+wZs86cKcyqk1kvgANtApVr/CuJIbdr43VtBdJUFaG9P03XV+dj8XQ8xh
	2D3kNW7lkf+L+HYaNqSW34mEgsJwAYw5hLYvX3tGLqMNT4kZQxtbF4pt7E+w==
X-Received: by 2002:a05:6808:1709:b0:47b:c703:4239 with SMTP id 5614622812f47-4804252476fmr9072780b6e.37.1778331123001;
        Sat, 09 May 2026 05:52:03 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76936271sm16444083b6e.9.2026.05.09.05.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 05:52:02 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: tduszyns@gmail.com,
	jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: sps30: Replace manual locking with RAII locking
Date: Sat,  9 May 2026 07:52:00 -0500
Message-ID: <20260509125201.29872-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock() and mutex_unlock() calls with the much newer
guard(mutex)() and scoped_guard() macros to enable RAII patterns,
modernize the driver, and to increase readability.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/chemical/sps30.c | 60 +++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index a934bf0298dd..186dec4cfd78 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -5,6 +5,7 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -111,9 +112,9 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 		aligned_s64 ts;
 	} scan;
 
-	mutex_lock(&state->lock);
-	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
-	mutex_unlock(&state->lock);
+	scoped_guard(mutex, &state->lock)
+		ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
+
 	if (ret)
 		goto err;
 
@@ -136,23 +137,23 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_MASSCONCENTRATION:
-			mutex_lock(&state->lock);
-			/* read up to the number of bytes actually needed */
-			switch (chan->channel2) {
-			case IIO_MOD_PM1:
-				ret = sps30_do_meas(state, data, 1);
-				break;
-			case IIO_MOD_PM2P5:
-				ret = sps30_do_meas(state, data, 2);
-				break;
-			case IIO_MOD_PM4:
-				ret = sps30_do_meas(state, data, 3);
-				break;
-			case IIO_MOD_PM10:
-				ret = sps30_do_meas(state, data, 4);
-				break;
+			scoped_guard(mutex, &state->lock) {
+				/* read up to the number of bytes actually needed */
+				switch (chan->channel2) {
+				case IIO_MOD_PM1:
+					ret = sps30_do_meas(state, data, 1);
+					break;
+				case IIO_MOD_PM2P5:
+					ret = sps30_do_meas(state, data, 2);
+					break;
+				case IIO_MOD_PM4:
+					ret = sps30_do_meas(state, data, 3);
+					break;
+				case IIO_MOD_PM10:
+					ret = sps30_do_meas(state, data, 4);
+					break;
+				}
 			}
-			mutex_unlock(&state->lock);
 			if (ret)
 				return ret;
 
@@ -197,9 +198,9 @@ static ssize_t start_cleaning_store(struct device *dev,
 	if (kstrtoint(buf, 0, &val) || val != 1)
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
-	ret = state->ops->clean_fan(state);
-	mutex_unlock(&state->lock);
+	scoped_guard(mutex, &state->lock)
+		ret = state->ops->clean_fan(state);
+
 	if (ret)
 		return ret;
 
@@ -215,9 +216,9 @@ static ssize_t cleaning_period_show(struct device *dev,
 	__be32 val;
 	int ret;
 
-	mutex_lock(&state->lock);
-	ret = state->ops->read_cleaning_period(state, &val);
-	mutex_unlock(&state->lock);
+	scoped_guard(mutex, &state->lock)
+		ret = state->ops->read_cleaning_period(state, &val);
+
 	if (ret)
 		return ret;
 
@@ -238,12 +239,11 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 	    (val > SPS30_AUTO_CLEANING_PERIOD_MAX))
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
-	if (ret) {
-		mutex_unlock(&state->lock);
+	if (ret)
 		return ret;
-	}
 
 	msleep(20);
 
@@ -256,8 +256,6 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 		dev_warn(dev,
 			 "period changed but reads will return the old value\n");
 
-	mutex_unlock(&state->lock);
-
 	return len;
 }
 
-- 
2.54.0

