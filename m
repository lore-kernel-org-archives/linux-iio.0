Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310E3B531C
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066289; cv=none; b=DLMHUxsglDS30KbncprjEewwcHj5vY0XSPNxK6G9lSqlkxS1WwgHNI0sWxPtopjibRsJ0cUpxa3rFM35UfuCnnYFJwTl86aRshSpCN5zkIf1wESRxMwD/KBmYbeX6+Tcbrek6cAyaXmDkhyCrFvtObn2pbqn8ymqXpMMQiJAD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066289; c=relaxed/simple;
	bh=OeumYQcWod62VsS2S8b+iZBWRuL6oFtKHJEN73VsxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPNj0gVGwOSlryDkQyCOLzyCp17BkYJOwrg2zHpo9BUw0+PasqE1HXQ426r4yid7S+FixLZ7RZhJOIxZB4ziZQTNx1PXqTJXCW/5kOYZGttpHR0MNd4VyFoycUCSqCRV655eAxleMq6lwkYUh+9qhSXRjYtWtB44i9DRXwBDfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV6kLA1y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV6kLA1y"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3598df39444so5178349a91.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066288; x=1773671088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO6elfLV0A9oqUoZI+t2ZUKkK5BDK6w1X39syVG7a9s=;
        b=iV6kLA1yZta/nAGnxbfARZh2WeyjqljmgBCOfSZwl50A7KZprNBALqV5QTqGaiLiSg
         OWivvAQSBDbRlKgruQaga65gSsCvz5JIUbMAtjt4d5s7YQkqlSMq6lq5GZllXaTP1Xhq
         9bV8Pvn6OUTNZPMVG0bjgLTdekTRG3BK7qXdv7pzUl61wL/GyEs0wvAoZtDR9Y8IxC+k
         sZrch88oYqxMCByEj49BDpFI2mA8AByz9YnovELzIbNvAH4XT8s8ZNz51u2w0nWtnbRU
         QvLkaUGF0jBRWcXvY7jo3REmTCjgJXVD97uNWYaaWzAsWBSwHFOCZAWd5WoCcOyFRzcb
         mgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066288; x=1773671088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jO6elfLV0A9oqUoZI+t2ZUKkK5BDK6w1X39syVG7a9s=;
        b=PQNwAFjTEd5GErfy9uhupAMmYQcCFPClHL1OWdYOWBbIwz/7XJKKyZYZUEuEngHz91
         cP0TqRmxQfL3j0ZqPrYcIYRsmVy9R+Fo7+TwLmiUMoBRx9gARkoRVXiycJr9sMXkrphX
         LaaF+gVjoeljhJgmtuvYn+5yc85WhAncsnMjDYnKLFrN5/Hf3chDRDJByhVEP/yOAwiH
         mBNyky7Itvwycm/hwsHIPLQGFMtaEtbxlAyagFxaGsMsKlrCuaFO4kG2dJxLCGaPTKBw
         FBZp9R4zaq7PMWOHxXAQIhAbqeqe5IwBx5668l2tmZxYVOSGlsXcYi9takmHsImcbFv3
         ks5A==
X-Gm-Message-State: AOJu0YzAZx1EKdkR8rIaonkmoyNWMh0l2OZJiLpm78wud69y0iYH62Ti
	clL4xKFmlwYKEgP2bxYUmf6RkAX+x7XcoivZzxNFNXB2gOVkAK3QwDWT
X-Gm-Gg: ATEYQzyWmqqvb5zPAzVKUStxpPDfsKFZqLgmK61/zAYiKHijkSJtjA1YLR1bbg62rKm
	Qtf5JMa0LACbTJbZu4/YMJ4F1+5oLqBEf0ksq1hgARUrYfPV4OpV6wWGPTNsHDnJLejmS4aWw5Q
	A9p6F0LPVwrpZANa9gk2f5QVgDV2hddpq/IUyHkpSW3ClMTUfbVgLJq4XDCxWHWzbmye/X/+2dk
	x1pQVNHc6VsXgN+6bwaY4c4uVPsPdBD+0GEAYVV8VgfrRTPFnGL+dW3KnB7mqUN41y6HzFaiAZD
	nla29VjZ3+IwzyykwmVjgwDYCpG+gsiB1iXvSwsNKF5PGlSqjlyXm5VRCIMWyh73dce3soRtrgA
	qXODhX9KeFBHlwJ+aaPlHNexrU/NQpXHvXNEaz0UPED//AjkScXFUVlWnM2yJbQPQJE+49uX4/R
	khuOs+A0X6PcudbFXXAguW1q3DTohNzKU6ISy0KlMPjzYv6faYfbSJn2uha9qPJ0RytKc1fPx9R
	pcPujbGTxWSWzjg9Npsmih1AoBw1FpWKluBuA==
X-Received: by 2002:a17:90b:4c0b:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-359be21cbe3mr9605797a91.4.1773066287816;
        Mon, 09 Mar 2026 07:24:47 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e0e1aasm18985311a91.15.2026.03.09.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:24:47 -0700 (PDT)
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
Subject: [PATCH 3/4] iio: accel: mma9551: convert to guard(mutex)
Date: Mon,  9 Mar 2026 19:53:51 +0530
Message-ID: <20260309142352.57407-4-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
mma9551_event_handler(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Aligned	headers	in alphabatical	order.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/mma9551.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 02195deada49..0936b148e424 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -4,17 +4,21 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
+
 #include <linux/gpio/consumer.h>
+
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/pm_runtime.h>
+
 #include "mma9551_core.h"
 
 #define MMA9551_GPIO_COUNT		4
@@ -337,7 +341,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	u16 reg;
 	u8 val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	for (i = 0; i < 3; i++)
 		if (irq == data->irqs[i]) {
@@ -349,7 +353,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 		/* IRQ was triggered on 4th line, which we don't use. */
 		dev_warn(&data->client->dev,
 			 "irq triggered on unused line %d\n", data->irqs[3]);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	switch (mma_axis) {
@@ -373,7 +377,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"error %d reading tilt register in IRQ\n", ret);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	iio_push_event(indio_dev,
@@ -381,9 +385,6 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 					  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
 		       iio_get_time_ns(indio_dev));
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.53.0

