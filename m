Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA062C2FF
	for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782070252; cv=none; b=o/ozcWCyDmKy8AhftXpYNfWh6QlJ/yKH/AQzossy1Z/UzzkIu2fXQZ4tRXrr12Xd34EoIidruPJs5R01L4GURnW2B2WCxTe+dlUoVkP0hOdhuHemn3mUcS+0GmBpmAx+Cesj4unB/56C/smp2CJVOHbVH6jk5MKagpWWNfb2vxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782070252; c=relaxed/simple;
	bh=fTD1hTj9KEJ2FrSkhkNY6rr+H8me3UK+jbkkPO1nz/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifDfXc+NJiWZAf+BckX3FA3CY5eGKSdFg6Obm9tVKpY5zSiu7F4XubIMuJyKFoYDks5l+qTymhcmo2FqUuA9YA4prxRes6DS+TR9VEpY+HfWI8hTC86ZWEm78fejy6RpmYHAulggkt9BSqfZDRrmdg8zPyRcqS6MQz3pLi5tzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+0WFH15; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+0WFH15"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b8d414666so1942032a91.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782070250; x=1782675050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovmYMPQs9wzJ5m3dA5QVnhFKoWOm1x+0ogBnUH/NFYw=;
        b=K+0WFH15JYU+lK9TC4WF7jpyLaatdiDJ7shey1pZUElZjf/ZEwbhcDjVY92VmBuKbq
         evE8R8F2WM9gMJgzbUHcaRtm15hV9rEtbwL/sdKSItNMxZUjWgSq/9Px2nX/bR2OH79c
         eFua7IaNrhqa4U+u5mKaSHlXsjU68RBscLN7t+igSQWRQHG26aeIP0RHjJyfgcbnFpQO
         niLejQ/M+GJpLe5QRxHegpkAL3PGsySLoRgEZZ6kNDP70NsUsGKLJAPSRjFbE1DTwuNZ
         Pjtyod/bcUvhhGFiKgm97IAqoe8JP0g/VHK3JSZcyzOEUXdOYIgjxZEV8Rl/j52V0Qy1
         2QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782070250; x=1782675050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovmYMPQs9wzJ5m3dA5QVnhFKoWOm1x+0ogBnUH/NFYw=;
        b=nczkjut79XshLjDnh+id6J8XavUNCfE9gi42jmZ1yexWlzESFUgna+Vs19O1dQ4Lgj
         bnFslPxWslMF+8G2D3DgQLf3n54e002kMTC8UNYZ3F8X8OAyFFMd+Snag9ENx+PRcNc3
         I7WFT51fwqLHQlPNrunMTexZaMo17BnBCMOs7s57/xDQW+FJIpPw/TiShxkE31PqNGLY
         6qjzkt4su6CVRutimoZI7UYyMY4Ma7/DZqpfPbxL9CH9ILC/oag5ytu53/aSRqPg11/H
         trIipbqZGDPagx6nkiwL7fA/dHRo62/7WBmD6fT4b7t5edBhpD/37Vg/tCL1hNQg/wOA
         H3HQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGB21bq19r7JAUvLTG46PzCr1APAUKJknpG2laTDDmhjaspyMn278wjhdsmBxCJBxXWeII7HWao1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1Hs437yfAl3sbzFA5Ptgn17a9n6nWPWIVdMG3GIU3b1uullh
	jMnaKolUM6kJOXK+9Lv5b1WU4gD+8g7NzOF8lDyzNtU1XUntk2UrhNxP
X-Gm-Gg: AfdE7clLZw873fV4+wu1YlLaavf8COP6e2H0JnYV+4jvzt3e8wC0kZ3iBCTPy4KH63S
	Xo7yQrg/0Fr7i+XMAYQqEHReTHqLn9+ptp/Nzt+Dt7bliCYSs329TtN2kHs9IuZ/ej49VIA5Ih3
	M0PSboNehWx8LztkZ0V37G/oH79vds9v7Fz8hnjZ9UPYaYN7UzsvyCxO1YLiMTadW9AFY1KcWg6
	mKq5YcNijmi+WyUAFbJY0N4O96WtXpVrwDSwOUttSOhzqvf7AH4TMQwzUpOJ1WdPXf7FFNxNhp3
	etRPHeAm9K+EfGK2dYmIlwtEP0RHVAzkq5YITWxDqQJxUl4POo/HiknqZ/ehmwcQp/cIMSL0fjc
	covGTTT/WmFlQW5EawBNVnKEQXFq6SpCle/kU/OsRF9oVsmFKedq9CQ9n28cMyMPsoRzrpObntx
	YoCHqPv1NKLJu9Mz8C9iYDQBuR69sDsjq8EJ13sCgrAg==
X-Received: by 2002:a17:90b:38d1:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-37d4ae34f25mr7764045a91.0.1782070249951;
        Sun, 21 Jun 2026 12:30:49 -0700 (PDT)
Received: from localhost.localdomain ([49.207.234.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15de5d3dsm8305784a91.10.2026.06.21.12.30.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jun 2026 12:30:49 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Biren Pandya <birenpandya@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: accel: kxsd9: fix runtime PM leaks and unchecked returns
Date: Mon, 22 Jun 2026 01:00:31 +0530
Message-ID: <20260621193036.78549-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260615200330.1234-1-birenpandya@gmail.com>
References: <20260615200330.1234-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kxsd9 driver uses pm_runtime_get_sync() without checking its return
value, which can lead to silent failures. It also relies on manual
pm_runtime_put_autosuspend() calls, which is prone to leaks.

Specifically, kxsd9_write_raw() contains a bug where returning -EINVAL
bypasses the pm_runtime_put_autosuspend() call, leaving the device
powered on.

Modernize the runtime PM handling to fix these issues:
- kxsd9_write_raw() & kxsd9_read_raw(): Use the scoped
  PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() macro to safely automate
  cleanup on function return and remove all manual puts/error gotos.
- kxsd9_buffer_preenable(): Use pm_runtime_resume_and_get() to safely
  check for errors and handle usage-counter unwinding.
- kxsd9_common_remove(): Use pm_runtime_resume_and_get(), and reverse
  the disable ordering to call pm_runtime_disable() before powering down
  to prevent background RPM race conditions.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
Changes in v2:
- Changed subject to reflect broader PM modernization.
- In kxsd9_common_remove(), reversed the order to call pm_runtime_disable()
  before kxsd9_power_down() to prevent background RPM race conditions.
- Used standard error checking idiom in kxsd9_common_remove() (Andy).
- Clarified commit message regarding the exact write_raw() bug and added
  the Fixes tag (Jonathan).

 drivers/iio/accel/kxsd9.c | 47 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24a..7aa23ae64b7c 100644
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
@@ -476,13 +469,17 @@ void kxsd9_common_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
 	iio_triggered_buffer_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	pm_runtime_disable(dev);
+	if (ret < 0)
+		return;
+
 	kxsd9_power_down(st);
+	pm_runtime_put_noidle(dev);
 }
 EXPORT_SYMBOL_NS(kxsd9_common_remove, "IIO_KXSD9");
 
-- 
2.50.1 (Apple Git-155)

