Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999036E48D
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548348; cv=none; b=H4e5HgMW08Q3KtBkyNBSpzyxkMUcbJRWuHer+cPm8+1r2ozRyhUDkekF6ByGeC9hZpWNWccl8avprYEHEn4+BqoVHSRwBYWCEYtUfJ/aXgvW9YAVzdjEbAIqCNX39Uq9+FR3xAWQ3aOtnObcM9qh8nRBcMNtAqHhump8Bz4L52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548348; c=relaxed/simple;
	bh=sYny+vMdKGhF7mpPlyKtngiOJKnDYbHDcPfb5D/jrWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJ3Y2kw6oNpRNcNhlE/mDDjiKXMC8EbIYke082O9NnE1xgn+F+OFWZ2pNwwL8fmP6qSc8RpQRRtvjbzONngQ/Izhv4EYfXlA9Ot5ypNywEoaeN1pMvhsRC3iBY4OrDYZHsSM+LGswPhuqGSETaDz7tecpEymd0A+dhTcDK2trG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQofHHh0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQofHHh0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70f91776fcso589043a12.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548344; x=1775153144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRjHGTziGVvd+VSh4h4J+ikp9tkHEYWZDQCls0MWsNc=;
        b=CQofHHh0AM8Uooqauo361YDv3ChyCOM8Y6jXablEAykauu8MaO4YnMwgINWWXgreSQ
         6+y+OITgL9JnbOyMf6PtCjC7haNZNYNLcVAkXXZeqiPo6cbffZhAP1c1nUBkfD4FhIrl
         6iMleafX66r7Rkujj2eCXP2HCqepDwfzTbMTMV9LgKI/gN3skkKJrdDp++T11vOTQ1/T
         340s0vApb96zzt8VxGvpNYa98axYJXQYrIIhUerQ/oGnjCBjJXIH5L+bT8XwZ4yMZiDW
         Ru/N1ki07pFDv9TNbHO8x4Rnmia8jKwmiCObNc7wfs1+gNBxESir1A89SeSi2vuKAr07
         H7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548344; x=1775153144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRjHGTziGVvd+VSh4h4J+ikp9tkHEYWZDQCls0MWsNc=;
        b=QjSr5QhavpOjM1cEAEBqjygYW32s4rPJjL4pFFX+saB/RVB0EicDIX8oKLQIhl+VDL
         zHLEbAyOo0/mxIjDz5DbYN+xsbHStLsXtCVj8RI0ZNmQCFKXOw8KFtFsg++x+CSqAqRh
         Y4UIgvlwaxATm9K/FQwKh5nTX3yRSiCRz4Fnlrw25zhHmkX6XAXqPpYmSy0o2NmEmoy1
         wXgItWDhZOxR6B3gzzxNXVjQyYeu4U3mTvOLUzOijo+O90dLOSu+huDseV51ybOQ3h+d
         tQUnHG68CNosEJiqf7B46aP6fOywJmPh72iP7mq2zFizkZvi21vTpMBiSGW1Fm9Jlx4g
         Nk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc8Yo4drqfJd7UNZP+SbZry+X7GSPX/gJY0iQO/7dY8Mmix3U8MBSmPYvX2+aPRF+4ddqrULLP4qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxup0TGd/FYv1C+beSSqdeJeByGUgNcfXfx7NbsvrPPkXKmHky
	El/bFsytWu7vqMjyNjVbeNb55H6FmIhN+31lOVXFRKJW+hutk6Eo5S+Y
X-Gm-Gg: ATEYQzxI2Sl2PekQsBxSuNAYuzROAGCqcBALkJya8ZcwajlvbzUHyScMEzuUB6rJ6CU
	9jPXH+OxYMfbuJs04l3mUDaoWFO57CAgZk2ZPwtw6DsI6SkAsVW+9FS+/3mWSJSnIUXFsIQoxQK
	fO/8plm446kYX5XkUBe/p7ocnOtkmQ9y6ygKVEek8yPACNmSNfWVJZ0VJkZ/wVRoxUEUBy5yDn2
	i2ax/TAh5QU8DxCFoKH/7aI4DYQuobtg86phqd5h138VTss3WY8Eo54WfNBsUUEt23Qz3D0vqI2
	7lX870DiCCqoJg+3WzhGDYMuO7g8QT1zSrpGYux08jB3fzfbEnfbYzm6Oxs5Gj6Mlj3keBYDe9w
	8PnC+o9VY8wWqfcNqQxJpzMgu6IAnWr6rmDEEq+KSRvmBTspOmMgti0/RsyOEeJmLqmtO2e5R4r
	KS/KlHxLN9HL0q+MkknndzXJa4Bb+d0hMNZsc47mza4q7AJJY8ImUzezHSqJ/AThkvNf9S5qPqG
	IY=
X-Received: by 2002:a17:903:1b43:b0:2aa:d671:e613 with SMTP id d9443c01a7336-2b0b0aac1c7mr98129325ad.38.1774548344315;
        Thu, 26 Mar 2026 11:05:44 -0700 (PDT)
Received: from debian.ari ([47.30.237.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a17c5sm43823545ad.26.2026.03.26.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:05:43 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 1/4] iio: adc: ad799x: use local device pointer in probe
Date: Thu, 26 Mar 2026 23:35:26 +0530
Message-Id: <20260326180529.19154-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260326180529.19154-1-architanant5@gmail.com>
References: <20260326180529.19154-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a local device pointer 'dev' in ad799x_probe() and use it
throughout the function instead of accessing &client->dev repeatedly.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..9825abc9285d 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -783,6 +783,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 
 static int ad799x_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int ret;
 	int extra_config = 0;
@@ -791,7 +792,7 @@ static int ad799x_probe(struct i2c_client *client)
 	const struct ad799x_chip_info *chip_info =
 		&ad799x_chip_info_tbl[id->driver_data];
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -807,7 +808,7 @@ static int ad799x_probe(struct i2c_client *client)
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
-	st->reg = devm_regulator_get(&client->dev, "vcc");
+	st->reg = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(st->reg))
 		return PTR_ERR(st->reg);
 	ret = regulator_enable(st->reg);
@@ -816,17 +817,17 @@ static int ad799x_probe(struct i2c_client *client)
 
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
-		st->vref = devm_regulator_get_optional(&client->dev, "vref");
+		st->vref = devm_regulator_get_optional(dev, "vref");
 		ret = PTR_ERR_OR_ZERO(st->vref);
 		if (ret) {
 			if (ret != -ENODEV)
 				goto error_disable_reg;
 			st->vref = NULL;
-			dev_info(&client->dev, "Using VCC reference voltage\n");
+			dev_info(dev, "Using VCC reference voltage\n");
 		}
 
 		if (st->vref) {
-			dev_info(&client->dev, "Using external reference voltage\n");
+			dev_info(dev, "Using external reference voltage\n");
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
@@ -853,7 +854,7 @@ static int ad799x_probe(struct i2c_client *client)
 		goto error_disable_vref;
 
 	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(&client->dev,
+		ret = devm_request_threaded_irq(dev,
 						client->irq,
 						NULL,
 						ad799x_event_handler,
-- 
2.39.5

