Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7A30AD10
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203598; cv=none; b=tjNntOIq6Dp21izQRlzpyDEdzLdN6pSt9vgdPbMoaTdzf/7YD3KyhlYM8qTU/IV451cDr0+c4SiOoTDFny7RVHW7aKf/9gVF4jV7hxG60McGQwto6o+SeTH5EOWLtn0xG5mx5driRgxgTQ+rIHC5eH0pt6fNpFZ/MyPElx14EMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203598; c=relaxed/simple;
	bh=Lf5g+RN+RFRx5DSamfvVjA0BW8eDenTuDrgfdqstkA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEfIsjQ6lDb0OVQx5e4wLNpw3NpU2iL2LOK0VS5d9fJwOA13aQ8O2BDRTilYY5UF1BgFB08iElurbV9lhjhNE21ap5VnKzHAxbrx6DbR9NXSlVLPjLHdNXnO0DHnkUR9e900CWNyzwwBRcsc3Xxtt89cVCkq0TceR96AV8ogbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUQ3gIdX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUQ3gIdX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso1233288b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775203596; x=1775808396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1kRvoMLvRpc27HAkVeOWBr+cEQlRdyB+O8+VNEKt40=;
        b=FUQ3gIdXIrdvDFdBQRrj6EZL3Z/Gi/D9mDvFHbdtcqMn7z2TfuwioI8anKGrGECQQo
         FNDW2BophhcqkuElg2Xh5m99zAof9Y2pHSiNBMfjrssvWZS+Nw2snvCln+Bcpze6oxc/
         Axkdrh0RDr/ja7DOQIHdrZ5njasQgmAyeRy220BU/g7CoyTqu4FtA2cWre7vrBO2SKfD
         9Ovki5F067jbHOUtpy51EEj0Y+0mSwm/NapMIc/taSsOpXk9l6nmiyV7Doov3Jp22vmi
         UmlMGoKLjkDwRVs6aGhUJd+laKkxF60O1+3bnePx8s9xgatEc9lvDruk//GvOeNv/AuH
         PWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203596; x=1775808396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1kRvoMLvRpc27HAkVeOWBr+cEQlRdyB+O8+VNEKt40=;
        b=qyyOnToOK5PhWWROlXGsbHTEhIxjoPuFajHbPlTmNHVPjxFeh6GPg3VEWHag8jJ9xi
         Na5xNPvZ3IP9xnHRl9AftdrIvUMlQ2i0HllOrWC/8hitegG9iKwFo4xsJ4EPjYB3bioR
         b0ELKPNWyfzyE6Du8V8uQ9UvEWoS+oNPkwhBkJrC5oCBYi+LFWU3wwPWb85mRQaNuvyP
         BlzLfgZK5NwC0YrM6jIRsXsgpUBT0FBIpwxhrdJJcI6ERwOKxrydPVnOhP7a6MgR7eKw
         gA/1pv5wnhpsNNuHjeU7ZOsH71vHYLn4y1i7bVvi43uEuK5xYGNxvDl2iopBt0vslbSP
         u8rw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3UPCpUiDWqdz51sNqhTiP3bbpDzJvTVfRq1dL7EP0l9rNawXuTze7Arkro8XH4tO+YRbsvmF59w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mm9i+etzhLEAQ99mwOwFXGs5kuF0srTx4i41PDO8vgtlZfIt
	iXmyviiTGl0jKzXj8xP3LOTvk7V/Fbt6hSY1fJqwGCzu10qRhkAcKDch
X-Gm-Gg: AeBDietcNAiZcdpHv8PpsZuTIaRxqcVlpMUfrQZuozNtMzm2LtdAIzvBftzMll4pvnw
	nQidgIswJed8gp3TF/VQQGXtyj1YyGEzy49Qj1eGSx4gSwu1v+QA68hSpkfG50xlbzUaX85uur4
	y36elYEdl+5h/SphAO+VjOHwgk6f1qB6qnT87j0lC33mLnsg9nF58esh+7OqFZq/hyMuz9ke4vS
	LJUFD4FO9JSHqFC7IQRbQcrdJGECnp/6xi3nNyKzKnwenMeRxP7BWNygT6tFV9Q7aci+8eAjYnv
	JdgakYuXk+/eZKLs08GXBwbZVvCc0xzGJOF47NK6id0Xg2PVzEI8rdtpYPaF2m+amTP4UYkHqhP
	7RavpeSyexGBrxuAS5JWROGzdxTxZ80fNxmb9f8mSSbmYwao6S1UiWI9k/eiXNF4wqUGIptMArR
	TQat4HoThvVK/rlbTR9UEiea7CV8d1REARdGbAv7m6bmflvd38bHmh4Ca+p2kBcM9Xa55fJTTiw
	w==
X-Received: by 2002:aa7:9069:0:b0:829:bd4d:3817 with SMTP id d2e1a72fcca58-82d0db5ad37mr2326020b3a.28.1775203596399;
        Fri, 03 Apr 2026 01:06:36 -0700 (PDT)
Received: from debian.ari ([152.58.181.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm5481093b3a.40.2026.04.03.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:06:36 -0700 (PDT)
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
Subject: [PATCH v7 2/5] iio: adc: ad799x: use local device pointer in probe
Date: Fri,  3 Apr 2026 13:36:11 +0530
Message-Id: <20260403080614.14213-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260403080614.14213-1-architanant5@gmail.com>
References: <20260403080614.14213-1-architanant5@gmail.com>
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
index f37f1fda2dc4..bf0575585a59 100644
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

