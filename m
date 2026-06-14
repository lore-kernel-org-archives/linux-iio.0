Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC6399368
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443151; cv=none; b=uKuiROr45OYvgi66ahrCnGyNByatqxOUlCUHcVsR3QJckMIXYuYJqCWzcgyZQIEu8Qxr8qUzNqGylcJEpni/IhIWFjr4bNluUpDu7O6jXGsg/C36JYyILmcyzlXA1zRc0aAGfdC2KzSgJXHORMOipJjAKeOQdYyjOZG9Jf5/bAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443151; c=relaxed/simple;
	bh=VpsekJgKgyNUwXeVM3uBLSOq/s4k35Xo3gx0kXHLQ/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pk/DL9e6r9Yid+KZhpqZm/SCxhdkcM9XoEohwNTtazMoqHt8t5zs70OVRjwY88SuzYI5nLxbEL3dV6g4GQU4C+vqMKriwMF4PhEUNd8LAV8iecS/DCT0S2QTM/63QxJQRh2ca/GPvLJrcV48ItYhxCrSSQqqUlZ/pkyKecBhfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBXy8kEa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBXy8kEa"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso11002345e9.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443148; x=1782047948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zf9bEWY7PTPQGv5EEwhDzgckj4bBWYf2ns3N6PMwkX4=;
        b=aBXy8kEajI1zj6BQ3BroaYu9YbYwSUw2kAd2Dl3XpvBaHEUTMuXiADcDWYfE6e9W4g
         JXV4fsMjn1wU5xNwOG+9zMD1E1UpNd6zATbNpdbAxclzzVuKmwk3G8XSC4te8ds3pelE
         /9VXcRAkvaJ7DZTetiWoLsPnRYZ7kgN/PtgikySUeE0DLH7RIC0C19/25MrJvSoZBg4I
         ZAJcMR5UlerUyW2QE/1/B/4eDVwEj/QfLHUgT082KSKS9GWmBtas8RnDB+YiiZPTXxxN
         jyiAHQr38uZSFHzLeD+nFEEngKIfNMd4gKtGiR15CkwmE6LHlwTNRajgXjJ7N8szBgN2
         jkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443148; x=1782047948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zf9bEWY7PTPQGv5EEwhDzgckj4bBWYf2ns3N6PMwkX4=;
        b=UL3gNqjB3PJzcZShVSYpFh/adf5jda5/surWGxS44BvAUd4IFNrLeg7zTlQ6jagiDa
         WMDfJOqE+fKIwkvcohSrobn8yLT27RHYuuNfPqgZPD0VaXJRxToZhsEG6YHL7uBRm9tF
         WP9n5j/d8/j0BxSF4IbEjE8L8C2ckqUJENbYDPmvlcFia0p8ndhvrlot1NeNEbIUlzig
         aR9Wlcij/mj/S3v6fJ3RWjsSssYyi6OTu+F3Z1uOKWgEY4urnM+Mz9cq0857H8yS4tvE
         hxy2sJYggMESmcuqyUdnduM+sgSAkX09cS6JgdP3KJk+8O0Vj9XZXg5aw90qhVm1svky
         Zp/w==
X-Gm-Message-State: AOJu0YzPjw1A74f6FEbAGpJO0ZXH4mIL2w59/434I6jewCv0UUCrWqWy
	7sOmyY1ZppgY414Nh0l8Y/aV52O62oUVZHeKYI8Msg/aLlq6c6iM2XZK
X-Gm-Gg: Acq92OGLmorGWq0fmUPabBDO0yctagvJckS/dy7UXZaagBtoiKXd1fVqCAdJ6PNbNOm
	dkOKGU+jYElPufVrOHtdIjYNKK68QNH0o/+a8slIRDxAYxnwOnoKVD4iebNFbh3HRnKYK8Jagrz
	1tV4AKuwdYowmWmY7AQilRQ5HhsAmKd9r/hbny7qiSnKU3/V8eCesJkq9rv+X+6ghlXa924fnDW
	ZcsuUk50FqOuwJEVqitGqHheowhmrVhVwvqiFQUKnFVbakPrHJg746c3W1h08A1p4OqPh9bJTEX
	u4T38Zpylwc7Fd493rW1MRO2ZXqGQ5h/8Q7d3vAUYqyfP4O5x1SardNgsy5GWcGF/ocSHpwBXnR
	ioNjrPShNrJE4YFXzDGdsjHKNiVqx+9mQ3w7mO9y5UcqU2P7ZFl/gsr1W0iB/3Ug3KyY0LcYAFY
	aWIAAi/Bk5gUCQkeu16y6/0yGnzkLQnue818i8ysbtZ7HXY4nWD50aqfKRX/1T4iVEx9w99kWBl
	b93JASwj5nwgwGFF9T+B8fL9RMc6uJPzGnYnGOo5XDR6dGnknm8HP2AzctbhCYSE90xx5IooeQ/
	sKCGgaEefIcJ8XprI/IajgC2erwF4E1JNzsXNftrT5bPpej9qXM=
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490ec4dfb03mr99342215e9.14.1781443147986;
        Sun, 14 Jun 2026 06:19:07 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:07 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:05 +0200
Subject: [PATCH v6 3/8] iio: light: opt3001: prefer dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-3-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=3588;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=VpsekJgKgyNUwXeVM3uBLSOq/s4k35Xo3gx0kXHLQ/E=;
 b=C/WWQZts2dxmh/A11s9TXIQV2nkOzJlZCFSatj/tkvn0o3xKZOE9A9d04beG14wN1ns2fWCHh
 GV9B+t/wYb4A04df9BU3JJ2Qwco8rpSWRXwgbsGtJdox9ziw4i1sZh2
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Switch driver to use dev_err_probe() to unify error messages generated
in *_probe() and probe path functions.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 57 ++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 28455d887e1d..c1062ace184c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -698,21 +698,17 @@ static int opt3001_read_id(struct opt3001 *opt)
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-				OPT3001_MANUFACTURER_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_MANUFACTURER_ID);
 
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_DEVICE_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_DEVICE_ID);
 
 	device_id = ret;
 
@@ -730,11 +726,9 @@ static int opt3001_configure(struct opt3001 *opt)
 	u16 reg;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	reg = ret;
 
@@ -758,28 +752,22 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to write register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-				OPT3001_LOW_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_LOW_LIMIT);
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-				OPT3001_HIGH_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_HIGH_LIMIT);
 
 	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
@@ -886,10 +874,11 @@ static int opt3001_probe(struct i2c_client *client)
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"opt3001", iio);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ #%d\n", irq);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request IRQ #%d\n",
+					     irq);
+
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");

-- 
2.54.0

