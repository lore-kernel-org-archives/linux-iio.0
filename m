Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B01A23A4
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779560344; cv=none; b=o1EpAnShQD49BFUWP1Azusb6cjJCZG0Buq48M/0Ur9VJHKXmG9CZinsYOsUurpasXRiZqxuCNrYewo42MUtRcmIVc86m4GEAR3vCDPF28o7NPXN4j/SYMOdGRTKoBjmPushGMNFMYeBLcWVreg1At+BoPfK8o9OSz4PnIFEOqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779560344; c=relaxed/simple;
	bh=TXlBbCeRQpAYKjtSbtq8dWRX7Lp+ozqkl0FyiHx88e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rinWgMUStop0vjnBzpjZwgb3Mpk/OroY4C0J4qTS4cWKmv28o7zgkga5N3hIOZ2eRJu4mo7hDYpQWxyIFMPDPM1D00aKgY4eJv9SkKOBS9tiz5ijjyoYoKi/PXes5GyNjJR1XT23pWFZ3EqIbiDW3AABzCG6ZBSnM0AFRXR7vhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+EnmcTv; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+EnmcTv"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5771954bcd0so6012535e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779560342; x=1780165142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyeD0OdnYGf6nkKpDLnXOKcxqGSyQT6SnIZ/nCi0uWs=;
        b=i+EnmcTvgLIilzrh0/PBcZTth+drSVmgu62bT0CNo0hZcypp9y4Wyqhj9tMSiaVgZ4
         JBEbj3E+OA3kG41IOG/E9523++16KG6d0kLGXRNi8K5S73GpK0MYohcUwSeYCsOfHp+f
         qM3pbqUmN0mFbDyHWcR9NTo8lrLqNhs5efV5TqjdnVJY/XD6LLViheabVKs5VEw4aPRp
         GYrUsqpRXsW660zgqDZBuO5VILSuyHyYhigVNC3SZbCQfI/gMwFNCKArYI16tu0j0Rur
         p8gJ+JVA/IGCPG3jh2ZVrPFStfJuQwBjP4XoD/YtQoypjI0X1AUqX0gpdOmdASr0IMDe
         VKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779560342; x=1780165142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyeD0OdnYGf6nkKpDLnXOKcxqGSyQT6SnIZ/nCi0uWs=;
        b=WAu3NXFX2N3fY64Llm/8g9n1iEc2ERUA/nOiM+1PrU3rqLto8DEul8x2FYhjycA2XI
         jc1TORFDfDI6w7SwjcXGXjlZ9EVSm3lhfppl+BhU3sjgwLojsO/jzKyemDHYojXdQ2xZ
         OuIjRBKFC0lYlflgmwN2OgVHuR/wP0wfpSjKHA7nHEQ1LXc2rEQg0QJOsJP2M0V1CwIc
         d1Ug1/JyfE0vAgUm21uKMEMOyqV8yJZx7QqbSr9OBSgIbqPJg0VLl2xrijr2PArt1OTx
         DKxPA7KwxCN/T6I9NzjZTxs08kKeU0STnmkCkkY4lKGTqajtvUu77lG7FwN2eVWQbDJX
         /QkA==
X-Forwarded-Encrypted: i=1; AFNElJ8KdeWjavfRK9rtT9sa7fgtFcr4HawWmveCHnl5EWrbNYkj2fSwKQqSMge98ZIO1Mt5Pz7jOHCheno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN56doBr8yiBg2sWWpp4Ux8mbh/3YrFxxTwAnValURPpsly4B4
	B+HmPCdKx5c5JFUUcfAXgrxbKZ7Curu7b94e+mcXbn4Om+Vphhwbur04
X-Gm-Gg: Acq92OElWKS+fblSMJVIZpedrgg5VrQiwvTvrqHqPmx2Czb2Dg8tQAJAFgf2287rryh
	RRSTW2C+Fegqlelip7qxUEyvThJJeA0ZRf0g29aM8RA1kh+yu+18hVomDJzrx1+D+Cx2UnPZ54D
	6tvX353n0iU8ERVERQNXoOV8XYQpAt2PX78xNW2v0cfSU1sAaReYkJRXu1hVOFQDLitpZ59LeH0
	jYZJNFKf57qR0LkogjEBUihjVxaHuowB7g8X80PU2DTkVX3dXfDzX9OCa5dlVw43yyn6/uhIMY6
	BcBDyejOf8TrqkrsqjDOO3drpAG7NE7S7iQCLi3VJnuHhR+eC/lhz85z5f14AFam4QgeMusW73i
	M8KwM5jmgFuPyznPfBqzYJLhvjr5UnegOQdPAdL+AOU1p104FhB1ri/6ch2XFJOETEg92qEYbw6
	VgGXoZ3Ev9WVYn1ADN/VbtMPRZZMf7VA==
X-Received: by 2002:a05:6122:924:b0:56d:451b:e4dd with SMTP id 71dfb90a1353d-5866395de75mr4709856e0c.12.1779560341744;
        Sat, 23 May 2026 11:19:01 -0700 (PDT)
Received: from i-use-arch-btw ([2600:1006:b017:e193:bca5:670c:e4c:71ed])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f889e7e3sm6493090e0c.15.2026.05.23.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:19:01 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] iio: chemical: sps30: Replace manual locking with RAII locking
Date: Sat, 23 May 2026 13:15:36 -0500
Message-ID: <20260523181536.5254-2-m32285159@gmail.com>
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

Move mutex locking into sps30_do_meas() and tune it up to use guard()(),
as every caller takes the lock anyways.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
v2:
 - Switch over some scoped_guard()s to guard(mutex)() per David's
   suggestion.
 - Remove redundant whitespace per Andy's suggestion.
 - Add new wrapper sps30_do_meas() per Andy's suggestion (see commit
   message).
 - Add Joshua's RB
   (link: https://lore.kernel.org/linux-iio/CAKqfh0FWig8mRR-xhvnfcFeSinR6RySyPaf9Gbpb6WU+diiiUQ@mail.gmail.com/T/#t)

v3:
 - Remove sps30_do_meas() wrapper per Andy's suggestion.
 - Remove Joshua's RB (major changes).

v4:
 - Move mutex locking into sps30_do_meas().

v5:
 - Tune up commit message to be more specific about sps30_do_meas()
   locking.
 - Fix up some stray whitespace.

 drivers/iio/chemical/sps30.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index a934bf0298dd..8e15baa31423 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -5,6 +5,7 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -69,6 +70,8 @@ static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
 {
 	int i, ret;
 
+	guard(mutex)(&state->lock);
+
 	if (state->state == RESET) {
 		ret = state->ops->start_meas(state);
 		if (ret)
@@ -111,9 +114,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 		aligned_s64 ts;
 	} scan;
 
-	mutex_lock(&state->lock);
 	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
-	mutex_unlock(&state->lock);
 	if (ret)
 		goto err;
 
@@ -136,7 +137,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_MASSCONCENTRATION:
-			mutex_lock(&state->lock);
 			/* read up to the number of bytes actually needed */
 			switch (chan->channel2) {
 			case IIO_MOD_PM1:
@@ -152,7 +152,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 				ret = sps30_do_meas(state, data, 4);
 				break;
 			}
-			mutex_unlock(&state->lock);
 			if (ret)
 				return ret;
 
@@ -197,9 +196,9 @@ static ssize_t start_cleaning_store(struct device *dev,
 	if (kstrtoint(buf, 0, &val) || val != 1)
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->clean_fan(state);
-	mutex_unlock(&state->lock);
 	if (ret)
 		return ret;
 
@@ -215,9 +214,9 @@ static ssize_t cleaning_period_show(struct device *dev,
 	__be32 val;
 	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->read_cleaning_period(state, &val);
-	mutex_unlock(&state->lock);
 	if (ret)
 		return ret;
 
@@ -238,12 +237,11 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
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
 
@@ -256,8 +254,6 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 		dev_warn(dev,
 			 "period changed but reads will return the old value\n");
 
-	mutex_unlock(&state->lock);
-
 	return len;
 }
 
-- 
2.54.0

