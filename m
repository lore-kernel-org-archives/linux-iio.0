Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086D1A9FB7
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944702; cv=none; b=SUD4oUSJooyVB79+8Q/pTCTOyDloSF7e350Nx8VM2XMK3jJuGJkABdySP3sksqFgXy3MAmyDrAw1Hv4QxCLdH8WuDI6iKOKOlla6eQoC105IODnP1m424cN28W+1hkJNE2Nozav7KFxc0dqTviIZv1YyLUM7cyhW+mQZf2Jk/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944702; c=relaxed/simple;
	bh=5xCqo/NLI84yXmyv/8tPF56CFvUg9eOOUrmBLI7ZpEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIPvh59t81+5cbqym9xkubKFmUMPtGWiXfLiqR/dJmtQuPkBuYpnhp51ajR1PIW+blV2fLUdLQlDIyY2xgH1wvr/bGXdaKzfxcV4Mnb+tjaY22uBAlD7O8fZxb+NL5PZ8WbMxnM2awTdGTq9T2Fa0p8AalHmsTEJq3iUBGz7ATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQjgX3w3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQjgX3w3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso1716085e9.2
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778944699; x=1779549499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GpoxQ6kC4ane6XwRPu1EFSN8ZEDWzHnTSyZhyFmWQ7k=;
        b=YQjgX3w3x7Atm4v/9f92wpl82jVaBcJbRVmqao3NlWnYhWHM5X1Gfb9ENP100HDLNS
         JlQtZWbn0txD29mUWEivzcQxuwJDBl41mNN0oH+wop71tKRgO+LTyiJFpjziDXsVyekb
         dQk+MBDYgBPGYEl1+n4XT7eaWUo4IewL8pFozUtUTY953mfF9uK2aJenOA7eT6rbkLgc
         cEFf9qZ7i1egssKSKDyI1Id7O5jTpMLwKoCDcmwALeYFy9CVFZgmkM179BF0bWzfxZH6
         JdV16AO0xD3gqUCgerzg67KIjqNBmNDRWVfs8qgHe5j29mxdY+EO+0N3GKZBtDQOTzJm
         rc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778944699; x=1779549499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpoxQ6kC4ane6XwRPu1EFSN8ZEDWzHnTSyZhyFmWQ7k=;
        b=RZKohErY2LuYNsDSaAQD6bLoUFnk6Hq2b8LbgySUZgXynpfYBDLpNJkZh4PPPsCiUx
         dtlSAR6j3QD20EaUj4738nQ95QcvvwByYjUt18rsO1Nkxzdnk66oNdGKmmhmhiGB57mf
         hH7vP0S56tPO0xrzUSlu32mx6teTKZVzkmLoZgbMTB5N1Wg/YBK/sjWwzDKH0WBI3rR7
         wxtyRrCM9Zum+WTJgZUILT0tk5dMO7wbYhrMjMpYYfLSZrvfVxnIn5wUE6QFD1WrHuMw
         oQy1mDFiFJ0hZXfQ2Xoh+o6kFqrM7h3FM9rBiHugyrFVMjdlAr4rD48GZdCUzyU5dr2I
         czbw==
X-Forwarded-Encrypted: i=1; AFNElJ99Uod1W4EwALSz7gFPgJKjDD4DYm2okfceAbOg0NiiVTf4U6p5isHTr7J2unLmfuSun+NhmGSndW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RlARss8XsWvpxgJOFmHk9k7ECyOGAiezt00UgrjU54QTYXCT
	8OHfLGRUYALRcf0GPriWbTqIs8T5Ow5hLGFsxFve4Gjajy6DFrZ1AfGZ
X-Gm-Gg: Acq92OF/NnbY3TxzpcszzBUkQhrhVT3DORkmMvIgsVKAYXjnkivH5nRiPU7f0onyMD6
	veaWVahTDJGMPpB3BCldqKpNSqnuOXOn5ewAKb59b95n0rB8vpjI4lsf6TDj1mBGcTwLpqi5qOx
	6/oGbSpsqNSWZOQ3TxNABjturfJQ3frHDmNZHngk7rvNWP8u05XJOT01yh7SxF47QDpCQXoTPNU
	GvaNd9bgnpgit5WcR9WS2yYQwo01vAZE7L/DoF6N5dencCLsf705kkv7dYRPe0mreuunPUA6Gsa
	FGT1hm5hKV0dma6wCr8Z4EBTGgRaehxkHrceGA6FDSj9JEDLlUhJyZ9Pm7k3PcYpH4k4o+fxfty
	h5mKLA4zee4SKZwcbnu473jooR34SaNZQKpruBJY8e9bvehkFyjjdVul4f/PCZTppsup6eLqYzN
	rIEBhCr8zh9O5K1DVQZ4uVAdC9HTux8TmX+sTYCrgbq+tfbw==
X-Received: by 2002:a05:600c:45c3:b0:48a:797f:24f8 with SMTP id 5b1f17b1804b1-48fe59ab0e7mr55061735e9.0.1778944698581;
        Sat, 16 May 2026 08:18:18 -0700 (PDT)
Received: from localhost.localdomain ([185.139.138.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2a23dsm39712915e9.5.2026.05.16.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:18:18 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: resolver: ad2s1210: split trigger handler body into a helper
Date: Sat, 16 May 2026 20:17:20 +0500
Message-Id: <20260516151721.1982-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad2s1210_trigger_handler() takes st->lock via guard(mutex), then runs
the per-channel read/event/push sequence, and finally calls
iio_trigger_notify_done() before returning IRQ_HANDLED. Because the
guard releases at scope exit, iio_trigger_notify_done() runs with
st->lock still held. The previous "goto error_ret" structure also
hides that the locked region extends all the way to notify_done.

The device does not register any triggers itself, so this is not a
deadlock source today, but holding a device mutex across the trigger
notification path is fragile if a trigger ever gets attached
elsewhere.

Lift the body of the handler into a helper, ad2s1210_collect_and_push(),
that owns the guard and returns 0 / negative errno via direct returns
instead of "goto error_ret". The irq handler then becomes a short
wrapper that calls the helper, calls iio_trigger_notify_done() with no
state lock held, and returns IRQ_HANDLED.

No change in behaviour for the read paths: every error path still
skips the event/buffer push, and iio_trigger_notify_done() is still
called on every IRQ regardless of result. The fault-register read no
longer leaks a negative errno into irqreturn_t either, since the
caller never propagates the helper's return value.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/lkml/20260516122838.163a77d3@jic23-huawei/
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/resolver/ad2s1210.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 1be19fe8a..20b0b2b5c 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1276,10 +1276,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
-static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
+static int ad2s1210_collect_and_push(struct iio_dev *indio_dev, s64 timestamp)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 	size_t chan = 0;
 	int ret;
@@ -1295,15 +1293,15 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 					       AD2S1210_REG_POSITION_MSB,
 					       &st->sample.raw, 2);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 		} else {
 			ret = ad2s1210_set_mode(st, MOD_POS);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 
 			ret = spi_read(st->sdev, &st->sample, 3);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 		}
 
 		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
@@ -1315,15 +1313,15 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 					       AD2S1210_REG_VELOCITY_MSB,
 					       &st->sample.raw, 2);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 		} else {
 			ret = ad2s1210_set_mode(st, MOD_VEL);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 
 			ret = spi_read(st->sdev, &st->sample, 3);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 		}
 
 		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
@@ -1334,16 +1332,25 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			goto error_ret;
+			return ret;
 
 		st->sample.fault = reg_val;
 	}
 
-	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
+	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
 	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
-				    pf->timestamp);
+				    timestamp);
+
+	return 0;
+}
+
+static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	ad2s1210_collect_and_push(indio_dev, pf->timestamp);
 
-error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.43.0

