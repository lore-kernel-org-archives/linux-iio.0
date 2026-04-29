Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12589390993
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492348; cv=none; b=G1SPo3ne3LUCTLd4lu0+pOBrJ9XH08A25mJ/UAMuZCOc/ciZeYljka1GlmvlMjkdu6wc/aEFGfyd9ljDLB4Q/yMwA9rJxD+Nq+Y6kZA2rrJNC2ISCERrNWvAibu99qQioSRU5TVsc+RBiR3XFaykmTh8xE6mduIQT39wmcis3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492348; c=relaxed/simple;
	bh=nFAntSksO/HSbqi/tcMsGYxXwATuCkXkJOicsie3mN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bWXjua6hhDgVC1Tip5pLW6934bYJqe5lh5EoaIP1YcQqjIuBOVCUIv5meFymEi+4vn9ze/fcuGZDmC2qRjm4TWlu+jJEoDFTXZPK9vIYhsfpbt41faIO8QOvA8PtOzrK0Mb0MHJLNBlUJHmjnfXFhQQsFLxq3Pd3dVXnZOBU3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=TBiBDl53; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="TBiBDl53"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12de530cbf1so469054c88.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777492344; x=1778097144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/w5aLyh75k6AdfxuD+rV3S2u/OXGHxfHq3eXR+ydnc=;
        b=TBiBDl53wpe8GZlJGJTmh5cLZg9qT612kNI3s7NVcYzpNbSXPAgGUsFv0JRsdnZeL3
         Bpxtu8I6x+6dTATFU3wpNmIzqiNnuSAu/EURHGrBkOFU5Hvp+2aW768NSo33IlUNw7yG
         NBk0j2Ql6yz7bz/2wxIeW53+E+NPHVnW2DBLpoEZu2FZB7dvfsNFGutUnWwMMpgtnGB+
         PKtvYBlTipijnOiG1CmXgGJS4eHLvAZ84ik3bJwBYR+E8XfZcUZ46z3FO8kX91THI+nY
         xANR4rcrQzg3M3fXEFZHa9rB4VxvzgsGoY0QTl86jMdqtn5vyx2GyRCSFNOkMkqSht/N
         oGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777492344; x=1778097144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/w5aLyh75k6AdfxuD+rV3S2u/OXGHxfHq3eXR+ydnc=;
        b=GbORzZuxoWkQ2X9nx05lj1ugqWWofUF0y6QyLpKgXndwJRnu17TGv6kRIB9963pcvQ
         VwBU46D/ujUG8ZkC0KDm4EN6sbrSYXjIJ6od9HV0rQ6rAYnKyyDvS9zXT2pLJr9sCAYu
         ARlmwzxt4Nvz6eSgBQKAwlB7PFs1s1kTmvCJd0SfiNl1R/pGgK4OjwLCiTBljfXi0zv7
         IS88dGRkTypL1UPje1mSXQzoP9FKTKe0jDONsbwrDi3zLA+4OTTsTZ6XWi8BHXJwl1Oh
         P2wABl13WdzBdfPhlhqXQx558YD01hSjPMUaintCZenD9zEl5hCHo4p5d5wFHYzlnsl+
         xnQw==
X-Forwarded-Encrypted: i=1; AFNElJ+0vQu1ELTtnYZjBCBQUn/Jm93lXnqOseo+NFZqdL6vR6AQMJMQHvkQWYqLqDdxFGGmxtxK/FrwdfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TNljmza8FLbBkbQ3g01CDJJxIHXAeAQH73H0G+uVqW//4VsV
	Pxoxtf64SAlkPchGic/SkWwPY7xwJA+tK8+H+waAGvJJlbnCcYoP8Zu7/nXSIs0lCtI=
X-Gm-Gg: AeBDievzNtYmtySJlwyng/psZTT2SF0hhG2YGSuKbFq/kY6k7PKar3G0E7tUo8mXpVz
	ZtuyBdk2K4vbFLionfAGIHEVEGcXx1zXHR/kJxViDljN5FoEbZC12l6VR4RXZHjs38IdMuJwM3s
	wgirbSTxtuPvoGp37GwyYYitIHB8MSkkM0PDQrIEFOKILpKMqfAvYw1LujYNInbbOXHeYyackKv
	lPs70CeAHyTgVKMhs26yL/lNdKrIuWCYCtPaLQ5vqhIcVZb4M7cb3hfdXRP/HogeeFsq3Sj+eXr
	nZxhKNO8MtpKfWpLHr5oqIMIxiT5xURIP69f0yY4Fszg8nhbYYkN1aM1taR+t8ahB86nqBoRvZh
	b1WtEwzn97LUu/1RFGUR7BNQyiu+HRKX5lA9j8cCDhGp9HPrkPJiLi1ItxfqkP4oNXJolqmHpq7
	3u8vyDm4aADTHLE7leis+Jwc4zTrCnwYxG7rNojWDm2Bg36YhZGUTJ
X-Received: by 2002:a05:7022:661e:b0:12a:7165:7405 with SMTP id a92af1059eb24-12deac55741mr13874c88.8.1777492344052;
        Wed, 29 Apr 2026 12:52:24 -0700 (PDT)
Received: from Arkham.. ([2804:7f0:b2c1:572c:be3c:b50f:c336:77c6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3261596sm3829464c88.11.2026.04.29.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:52:23 -0700 (PDT)
From: Guilherme Dias <guilhermeabreu200105@usp.br>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nish.malpani25@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Menezes=20Linaris?= <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual lock+unlock
Date: Wed, 29 Apr 2026 16:51:05 -0300
Message-ID: <20260429195214.22374-1-guilhermeabreu200105@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use guard(mutex) to automatically release the lock on scope exit,
simplifying the error handling path and removing the need for
explicit unlock and goto-based cleanup.

Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
Co-developed-by: João Paulo Menezes Linaris <jplinaris@usp.br>
Signed-off-by: João Paulo Menezes Linaris <jplinaris@usp.br>
---
v2 -> v3:
 - add blank lines above and below guard()()
 - direct return error code in adxrs290_set_mode()
 - use guard()() instead of scoped_guard() in adxrs290_trigger_handler() 

 drivers/iio/gyro/adxrs290.c | 73 +++++++++++++++----------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 3efe385ebedc..e0a3a0aed93f 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -115,65 +115,53 @@ static const int adxrs290_hpf_3db_freq_hz_table[][2] = {
 static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	int temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	temp = spi_w8r16(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	*val = sign_extend32(temp, 15);
 
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 static int adxrs290_get_temp_data(struct iio_dev *indio_dev, int *val)
 {
 	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	int temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	temp = spi_w8r16(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	/* extract lower 12 bits temperature reading */
 	*val = sign_extend32(temp, 11);
 
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 *val2)
 {
 	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_FILTER);
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	short temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	temp = spi_w8r8(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
 	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
 
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
@@ -220,11 +208,11 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 	if (st->mode == mode)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	val = ret;
 
@@ -236,21 +224,18 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 		val |= ADXRS290_MEASUREMENT;
 		break;
 	default:
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
 	if (ret < 0) {
 		dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
-		goto out_unlock;
+		return ret;
 	}
 
 	/* update cached mode */
 	st->mode = mode;
 
-out_unlock:
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -506,19 +491,19 @@ static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
 	u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
 	int ret;
 
-	mutex_lock(&st->lock);
+	do {
+		guard(mutex)(&st->lock);
 
-	/* exercise a bulk data capture starting from reg DATAX0... */
-	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
-				  sizeof(st->buffer.channels));
-	if (ret < 0)
-		goto out_unlock_notify;
+		/* exercise a bulk data capture starting from reg DATAX0... */
+		ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
+						sizeof(st->buffer.channels));
+		if (ret < 0)
+			break;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
-					   pf->timestamp);
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+						pf->timestamp);
+	} while (0);
 
-out_unlock_notify:
-	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.43.0

