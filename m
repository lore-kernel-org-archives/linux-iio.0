Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C1227BA4
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642083; cv=none; b=K2UYUR+YIs7T/zbYjfbnZsqms+4PFJqSoDk3y2VimCgm1tH5411wXCIsJ5sryKtw+wKC/xDbyl/mtyO1A1v4+L8SfxVQzIfA3e5B88d2g2ypsoTaGkrFt1VIMzUfRPO5dUL0OzjC1jqWOlpL0zysyI70BRvp6Uh9miCG/m3ZUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642083; c=relaxed/simple;
	bh=I/S6s/6ZjjA7IXI2sBfKxl6stZQrNTi4QmcILhIEQeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCGuL1wmZ6vJZ4TSdOqHWKsMPjsO0VXgvPJnY+XRrkAwSZgCUKpBnfjmb+AAqVWQM0xCr6p7OukQ3O6gjNyt48mZG3pKaawKQD7qTQ8zq+j0eeZwV/GYVq/2ZZdyVgk2qU2e3iqQ6/Iqws5qnninuQGo+Rc/g6RoDrkguGphkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UszLoGjL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UszLoGjL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-481188b7760so1294715e9.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769642080; x=1770246880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqsV1nJHnddsaWjla5mepIjqA5JQMm3OKwOvOc1IORM=;
        b=UszLoGjLGTTd7sqO67x2kniyoFdmiqwBksfX1VeNRE9Z2IrOvNxpYf6w/4pmL9ljc0
         dpZEITpnZ6RomW8WVub2BiyqxunqBsLFulHQlPE6ztoYLn/uTm/weei8wfTZB+sr3hzw
         wkd9udF0Nh2aXSc+ktDO+58ajWL9lRtTu6W1ZBCcH4FOWxrK9QhmWIdgskRkatfAtp16
         t1rIV9xN+QbBT6VfUlI7O0gYqTj/5qr+Z7Q9UqQSdqgJtZCr0X04y+yKXt/oKbsarSjb
         5jKeLcVS4+euuG271bmOJPEM2UycsT27vlK1PoSylxIwLhqXLQ98XEyp8jSFH57XV61a
         8cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769642080; x=1770246880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqsV1nJHnddsaWjla5mepIjqA5JQMm3OKwOvOc1IORM=;
        b=sLpUje4RVK6XVw1PHbsPbA4610aGuO0iCwp/dGynDqYBcXTsIJV74AFQAbIrAMY3fY
         P6VjnjgFtqXkHLrW+RospYFvv+UQiXWBxTPy9rOFVF9kkGkOTHbu9d3dLGJIT/UIIded
         Rwi4oxdB1+HzXEepuVSmD612SJkMiiy3TuGpASX17MGDLiYjp0SQXptQf/dUqkcliNU/
         O5qSO1G9ShlJJpQMpYcevr42qLWdWeRRig9g26yukS4oaTaJI2GfaJAU8Ut0ykoZld86
         c6kr4V8WEBTi2xkXxJgfxZRgbQ3eC76OhrU3mEyeNYFdITh/O6JJBgnjaMn3UehD/OpN
         k/0g==
X-Gm-Message-State: AOJu0YxqlLsrHfmmxWUI8qgg45DXrQNReugFIyMxs32Mr1F4AuZ15t2n
	fLcMRSKGOjkOWZK/S25FXDBj1Rk0+Zzu1sdJjHPsH4mVtfxh4mZQVNaYM1ZVfg==
X-Gm-Gg: AZuq6aJ6LQRyXEzIHUEnKowFziwXendZ2TObIkpXW+ETZcYaqM9fNfV8lkKdt1lNL5W
	ddhfIiePCqJtgVKE09UyWYWwy7U0mHfB6faBRZeUlIcap4VvReW82cC1ZOcceZm91BoOHKmtclE
	abFb2Xv5T0467UTz+BQT4ZK999yhbmLLugYIn+UVO62DsiBq1pthz5f2VcpRe4RrpYithszVIrS
	7vZCNqsqg2Fwqc8NkjXJoPSzMrQHcVKY7Fle1b+eRVeDh2F/AmyP/WEOyR0wdmFf43KrJ6XK4uN
	k/2OtstCnfYq0Z/ZxFr5jqb6XbAE8zXmQ4efGfMESxCixTeE2JKgr1Tpl2uTBuJw40eH6gzDISd
	yXw0g1/k3vfbf8cS/wv7D008sIIT/qUk3pRS/Ax13YK36/NEyK2Vq/jRoyoq7VhPQoCcNl8Xn9U
	8e35/0Rs9YgHt3f64mxrdKEpuHOg==
X-Received: by 2002:a05:600c:608e:b0:480:1b1a:5526 with SMTP id 5b1f17b1804b1-48069c167d2mr101682845e9.16.1769642079465;
        Wed, 28 Jan 2026 15:14:39 -0800 (PST)
Received: from arch-xeno ([109.228.249.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d98c8desm74414905e9.3.2026.01.28.15.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:14:38 -0800 (PST)
From: Menderes Sabaz <sabazmenderes@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Menderes Sabaz <sabazmenderes@gmail.com>
Subject: [PATCH] iio: dac: ad5360: converting to guard(mutex)
Date: Thu, 29 Jan 2026 02:14:19 +0300
Message-ID: <20260128231419.415390-1-sabazmenderes@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128153221.327987-1-sabazmenderes@gmail.com>
References: <20260128153221.327987-1-sabazmenderes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converting mutex_lock and mutex_unlock to guard(mutex)

Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
---
 drivers/iio/dac/ad5360.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8271849b1..e79ad64d7 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -206,14 +206,10 @@ static int ad5360_write_unlocked(struct iio_dev *indio_dev,
 static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
 	unsigned int addr, unsigned int val, unsigned int shift)
 {
-	int ret;
 	struct ad5360_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
-	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
 }
 
 static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
@@ -232,7 +228,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 		},
 	};
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
 		AD5360_ADDR(AD5360_REG_SF_READBACK) |
@@ -240,12 +236,10 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 		AD5360_READBACK_ADDR(addr));
 
 	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
-	if (ret >= 0)
-		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
-
-	mutex_unlock(&st->lock);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return be32_to_cpu(st->data[1].d32) & 0xffff;
 }
 
 static ssize_t ad5360_read_dac_powerdown(struct device *dev,
@@ -262,19 +256,14 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->ctrl |= set;
 	st->ctrl &= ~clr;
 
-	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
-			AD5360_REG_SF_CTRL, st->ctrl, 0);
-
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
+		AD5360_REG_SF_CTRL, st->ctrl, 0);
 }
 
 static ssize_t ad5360_write_dac_powerdown(struct device *dev,
-- 
2.52.0

