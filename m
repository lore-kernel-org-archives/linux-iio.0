Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AA8460
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944191; cv=none; b=nD7iqDnmSqOtXOOzpUlYhvGmLGKpd3RdkO1j4XM2qBB/ptuwfEYu1ODC1AvEKEkCg+fTJr11HynUNmMSJJt4Hvc42nqYuturUP+WJzF1sCh93aH08LxCge1V8/jPaKmqca+4sC3/5RTFGg8H2ZT8vqqFM021AyT9YeGBkN/aySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944191; c=relaxed/simple;
	bh=dSUXvSzLwKZG6Nl2GPO6UNxqhFumM97KURXLcfNsPkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=By1IOy6uGFasYDOFO0XYjiwbyWsaDSjxncrMeMy315l0Lap3nCzob9/54Ay2ZfWwiZ4I6uXSMh1DZjTOnbWXjn46+iyjdChiQjumutVJZ9NT8Bl/5Mp6K0XTGbeiSsSuh5D1+vnISFVwmIsyefmXMg3ti8V8RiDDUDF9AVwvEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=gL7q7omr; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gL7q7omr"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e582b3bcaaso137664a34.3
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778944188; x=1779548988; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSdtmrJdHfFRkKT+UmZI3jwyLCc28bswVYuYpYjVngs=;
        b=gL7q7omrTWl8sE82SEpoHSDofLX8ocI9EuHfBfxZfpWmucj9MJ2PfJVJ2/grP29SlX
         1bdTslsbWBabE398+vxtQ/EClf8yYYYDFznf6h5F1vQezpTimWXsynkEh+A4kV+FNmEm
         Uw0PLiYFItg9LqUDzWKGwgGKYpfIKtm47qShEWnAzDcxBbeRuhwWuOIolQXqSLwKKi7Z
         eG0EZm8KTd5cRDyRga6RfLZhAeWLiZzNpHkhVmbz0ar5WV6otQUBOLhIhiHcaX7mDHsC
         IbL++ngiuhvvbZZiwUCjUVY69+QQJQok7nJHHu0SON83rQbkVlX9IpMzDdb29FLDZfD4
         jpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778944188; x=1779548988;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSdtmrJdHfFRkKT+UmZI3jwyLCc28bswVYuYpYjVngs=;
        b=pnHcuguRrn/WJ7cuXgLrMY0qo+MxdTwfSXC6Xp1awp4/J9eldCbTq8ftqhqQGUpM01
         TmtgB89vi2en2/WCz6M1i5U3UlXdiZY0nybRwjLBfKHkz2FyAQiue/GR4IloQmgHOLnv
         xYLdETI6AY+TDe+nmL2rJAqJWyInCfGk13nxFCznal6FDcVrIWEnqJv0FhVEKe/D+mTL
         M05U4gUxc8mPwmp2vjrVuL8WbVNlzIz3a7CE0B24fjHODez5EPjBqQc0rsjj+90thPPL
         +3h0qX0Iw+ML67tPv4/Cerjs0KHKafXNKLQ/lCGdJGG/wlg8gw/s52A+TzW2lBOFNtX4
         vc5g==
X-Forwarded-Encrypted: i=1; AFNElJ9tjMSngEEtw5IJLH2VSpsrEQJsGILOeptu+zgx55jtDJG105yjaQVIsWw6hgRWUQch9wurZrjqKyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJoMn5sjqzvyXs+biLEBJ751DkZWwpIV4C/Xmx1GGRoVb3Eibb
	tNmLH/vWgnZvKA/tvygf7uYmRNhnpC5PMnPC3iUHHrrsfOoLOK3m9BOCb6pDY9sfiy0=
X-Gm-Gg: Acq92OHhUbWBQ+6nHXs+fhm0bRsmj3gfpS3mgdFncRkP4THj7Faver6GibDayOXsn3u
	8b/v47pxx3ArEziV67PoXD8kPddWMK5AHKGkbwdUJDmLsOf9aQKqTJc4L3leEq7LgJGm2OUZPYO
	4G30VmkCzde2S5sMUaygfeBvsU9qgtD+039J9OAdT6LaBHl/naklnl381zKJowoCt5jJ6OeGyzQ
	lX7bXp7Wsiyqo55iXD2SDHGpp1en1SNHuxAaxh69PdnuRUwovDn7nSqhLA+hCfL1Td+XyIOtGC1
	eUYO8YMLZ5Q+CWFWDEz1+7/xkWwjGqjYKO6RZtZvPhzaG2MngpX1QbHCk/DjnsRwiuur7W2E5SO
	dgt8PruBj2iPC/z1fZeEDM33Pxdv+Q/YezE7r7paOhKoGjERNowqd2HmF9uIdU07q44ZnAMJQEY
	L81MHMECEN/LdpO9LrFIRdYw4wN+Ax
X-Received: by 2002:a05:6830:82bd:b0:7e3:fa31:1104 with SMTP id 46e09a7af769-7e4fa052bc2mr6092771a34.22.1778944187704;
        Sat, 16 May 2026 08:09:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4749esm3966205a34.23.2026.05.16.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:09:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 16 May 2026 10:09:37 -0500
Subject: [PATCH] iio: resolver: ad2s1210: refactor trigger handler
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-iio-resolver-refactor-trigger-handler-v1-1-25b11ba0155e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0Q6CMAxFf4X0mSWwKSq/QnyYW5k1hJl2LiaEf
 7fqU3tubk83EGRCgbHZgLGSUF4V+raBcPdrQkNRGWxnh+7YD4YoG0bJS0XWZfahZDaFKSUN9CQ
 uOv3szhfn4skfLKjrqU16//5M1z/L6/bAUL5y2PcPlZCm6okAAAA=
X-Change-ID: 20260516-iio-resolver-refactor-trigger-handler-af38933d7a42
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dSUXvSzLwKZG6Nl2GPO6UNxqhFumM97KURXLcfNsPkk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCIizbO7MNJvZcseRWKIROrfLq2QNC3HmjLvMr
 FgyCpF/lHiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagiIswAKCRDCzCAB/wGP
 wPJ0B/4yYesUcGybJbyzYuxORu53mb+ImyKUcJQpENBbpnNRCXrGXbnDUoeo4XVZXfLS2dD2I6k
 9diDKJ0qrv8mbi35acljLLIOZjToKcnxs1/xXLNEUfu0Tlj32Bo1uS+oFUz9dGcvP8OSNq73of5
 v13m+xt2YtQULny+hW2MOHbmv5WYw411PqSz+EURgwvjLx0YAt+BsgHZhCdhAzGSfVnduMidumu
 i7B5TxURXLroQq02XGhrgWgB73MvUOEx+W494Ee5X+vMd0RpsHGxsFrQiVYkvEDEvuXVOyvF8EX
 OPJqCYM4VUK7Jbz1DMntpShadGojL/r93MRs9FNu8S0hzPkv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor the trigger handler to avoid use of goto in a guard() scope.
Ideally, we should not be mixing goto and automatic cleanup.

iio_trigger_notify_done() was not part of the critical section anyway,
so is not moved to the new function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Following up from [1]. This depends on a fix, so will have to wait a bit
before this can be applied.

[1]: https://lore.kernel.org/linux-iio/20260516122838.163a77d3@jic23-huawei/
---
 drivers/iio/resolver/ad2s1210.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 1be19fe8aa3f..59c035311691 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1276,10 +1276,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
-static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
+static void ad2s1210_scan_to_buffers(struct iio_dev *indio_dev, s64 timestamp)
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
+				return;
 		} else {
 			ret = ad2s1210_set_mode(st, MOD_POS);
 			if (ret < 0)
-				goto error_ret;
+				return;
 
 			ret = spi_read(st->sdev, &st->sample, 3);
 			if (ret < 0)
-				goto error_ret;
+				return;
 		}
 
 		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
@@ -1315,15 +1313,15 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 					       AD2S1210_REG_VELOCITY_MSB,
 					       &st->sample.raw, 2);
 			if (ret < 0)
-				goto error_ret;
+				return;
 		} else {
 			ret = ad2s1210_set_mode(st, MOD_VEL);
 			if (ret < 0)
-				goto error_ret;
+				return;
 
 			ret = spi_read(st->sdev, &st->sample, 3);
 			if (ret < 0)
-				goto error_ret;
+				return;
 		}
 
 		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
@@ -1334,16 +1332,22 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			goto error_ret;
+			return;
 
 		st->sample.fault = reg_val;
 	}
 
-	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
+	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
 	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
-				    pf->timestamp);
+				    timestamp);
+}
+
+static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
 
-error_ret:
+	ad2s1210_scan_to_buffers(indio_dev, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: 0eb0ac8b282b273c254dcda52d29b06a92840252
change-id: 20260516-iio-resolver-refactor-trigger-handler-af38933d7a42

Best regards,
--  
David Lechner <dlechner@baylibre.com>

