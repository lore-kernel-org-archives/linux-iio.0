Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEED3AEF37
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826191; cv=none; b=iptgr0C50pelMem3haN469Pa7NVgMJuLRhuV7T/gC3skMsEjjuQXOodqFqNluJhZDkkjCH0F5XupWUWNw1NrALZP7Vo2kjrB7RVbreYhTTzaDFTlMCxUoTcFFAUSL75PPkVnTR/risHNApCalH2WCa+0qTErYw5LwPWoOEp+9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826191; c=relaxed/simple;
	bh=sYny+vMdKGhF7mpPlyKtngiOJKnDYbHDcPfb5D/jrWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWau5XxeLYRP41wt6VvEKDaXDVTJ1VRFnudTHVf5v35UYH0fp0n5C+6aRnPVEvlI73gwRVn6OU6Gocm/9xqFgkqmYotKYKPW6bijOYeG9dLo1YUscAqswcF4PMLPiovoR4CV5ybdBblN6XjGz+oomvmq1/arLcve2RCKJNeP6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA0I+wG1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA0I+wG1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358ed696623so3106809a91.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826186; x=1774430986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRjHGTziGVvd+VSh4h4J+ikp9tkHEYWZDQCls0MWsNc=;
        b=GA0I+wG1xx2yhvZrzzcCyClryGbCx30pNkG3uDDdc3pX2/at98P4lPO+4QOxyGK4+7
         ZI76RJAzk0l61OId0I5yfXr2pi27tOcc/r3NvUXd+QTatT/8cskHO+O77SiTUb1604i/
         6pmY+ZytNtdnV5w/We9ln5gMQDQLfEGD6C+ISvunRvzcETA5hSWXXwoti0t9i4Ur8/vn
         vgPNhB1shq1UREXdEY3pAvtmLjmQ7Ij3Xra98os2gViDQ2fip+3oOVPPd+WQ/k0Ar6ye
         7FcdDFBxdXn2kjm28g+VxBswoza+P7QEHweS2IeVOny6Dn/iNgDYArG/jHg7rW2bSTFq
         PnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826186; x=1774430986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRjHGTziGVvd+VSh4h4J+ikp9tkHEYWZDQCls0MWsNc=;
        b=dBiS6enZDVh8wDK4SeiilnqyQro1OEM/0p+VERI+tXJ/ZcSD9/o8dL/yTIa1TxGYqn
         DX/qSqcBNXqRmzaqJjrwP1KG3jVVjWEAjvOGzhxnmZtIw4FieXbSpuA1bumHG9eYEsnl
         fij+NW9rlFT6Y+x0fe9xD4T5GugQpJaEZLqJX8pGr4JarJjEV7WvL9QR+tQ6hzAqmrWt
         La1SqKXHRpE9uY2R9Tz0HzcAgge+4hXd55609GKr0xiNcz3UqFJaKLpBWpAa3ZsNpOjg
         cC0aJg2XIbZjGqeErbuVS3oEEe6fu8qiJ3EVMDOt5EFkRaCs7kbQZG8OrkebhrGV4LNn
         OONQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBWOgDMfiOAKyXvygHGSduHYsD6v1IdID0HPnVYi51DzC9nhb1xDfemSXTUUIQEBlLZgQr23E7KbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQp2NJ69hqOHtgLE8AlsmPrHVvL3nuqPrQcLbcr5DMMeterM/
	+BJ6zt9DTZtvR5GAAPwxr0vCmFxO0Is7QBKOFJ3FAU1Y/CdZoWsSgIcv
X-Gm-Gg: ATEYQzwPVzRG0EVqyDq/DJHDGwFSdgIPPc4+BLgR9WxOiRdarFzDYNd8YcWnU3e/B38
	eLclABowGQbl2hT46DOrZ6MvCEsZA8h6eEL6j3YlbOWuA7sgMY/pInKIJ6E5dpTV1WiSKNYSoKT
	+1+ns1+BSA93hhThwAgCxUpYIWvG7SzbkKgcITs6xyMn/CH4cV41uS08BIAN8c4fqmpQrhk1Ks5
	Hcko9hurP2e93KTu2zxZeyJkTV1BbGrmi6u5f4VVitQhCi+GIAfLxz01UeWwSXkNAocPcxw6zQd
	BmHWpcmFVUrLlVQ2RH/IujMCZVXK82tub4rsEQBSqAJl1NCEAKAXWh8mmDneis+tTLNFZl2MPSe
	Re1vic0fbjzp1DjuuJb6QZwQYKEo04jFcc5Ql7UVHQJI97eqbhaqGUDHNlqlpzkUNd152pesgaL
	KHN6XJtrYJ1V+XFDNv1IOdSbe/0i6kSet8c3JTymS0WRg0+q8777mEq3cB6os8ISEbS75ad81F
X-Received: by 2002:a17:902:ebcd:b0:2b0:6f20:8044 with SMTP id d9443c01a7336-2b06f208484mr22527175ad.43.1773826185599;
        Wed, 18 Mar 2026 02:29:45 -0700 (PDT)
Received: from debian.ari ([152.58.182.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e616351sm21168315ad.67.2026.03.18.02.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:29:45 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 1/4] iio: adc: ad799x: use local device pointer in probe
Date: Wed, 18 Mar 2026 14:57:12 +0530
Message-Id: <20260318092715.42538-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318092715.42538-1-architanant5@gmail.com>
References: <20260318092715.42538-1-architanant5@gmail.com>
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

