Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296233B6FC
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336341; cv=none; b=fW772IgrE0sMJhxTkIieN9SmtsU49wju7ad7FnFdSCrEB7nVC3tOq5hzVHkgtD0AL1ZfHdvPx9eOSdQN01pIkb2vgLk4PDNf5IGTcOFVhmrw5vfD42uQpAfqMz0IXAM7pnvXI8xeFE5wSwB8Nl6RSgecscp6p4RsZN84p8sqkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336341; c=relaxed/simple;
	bh=07X/+r4FQs5VHXmMzGcuGWaMDeBFQZZjjZ/2izXOFQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpyi27EhY8V4fAVILblKWco+nqmthTkGCxYOqolLMzNgwfoT23NIbhztlLNa1dW6NCoJIswscTPIE3f1ARg3n+bq1q0ZEcmwpPbPMoCYSRtJOvff5zlQCZu9vh+E0qdq/ejEDEcCkiHJb55uttYeT4s+OGcvSosj5jxYfEGu29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW0RPGr3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW0RPGr3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a29e6110so8223935e9.3
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775336338; x=1775941138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byIWEtWcr/ZkucG4RN4fe8hAaX3tjSZ5r8jwT3XAMSQ=;
        b=lW0RPGr333D66Dg4wHeSrXOwM2+e8jZQ7FoPdZ6bmgWYvq0u/zaf73DwDe1Zn2/Mwa
         xe7CSC1lv10/I3pjKhoh53vUqedNXAxKjeZMIj2GaKr2opO9B5Kd1gyu8Lks3kXtEHwB
         hPkNEH5uolwtCFBScdf7dTeCYeEH4vUI5vpWASBvtyWPMe5ck2omk5rvAjoGAT1xePhv
         ZPOzzgKkZ5zv6MefzSEmevvckNHjUhuck3osBWSuAWVkyItxu112mKw7t7D69Th9ZquW
         ROVA/6z7lquyB/faD00FuNSK1Sw9cDDnCoNgFmeudHyxWKttRmygwQifwgS8i6esYyhX
         lpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336338; x=1775941138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byIWEtWcr/ZkucG4RN4fe8hAaX3tjSZ5r8jwT3XAMSQ=;
        b=njYrd15hzPyeMdM8vjNmnHd8dEowIEazxgkUEjexEkUKQ1Kg+VPoaHe3P8IZLv3KXR
         dqhF+d4bs+AxdiMhbeQH6hRJclXnUFF/J4ymsa0AewNe2w/fKUw123+nSQ8UNMFPgYCl
         rfOufpGRLdMjyrOXkYTV1AfSJu2/M9S1QYlaTMIf3vbaSfAfyM0HLHe09xijWx5L9RUm
         s02Alz2wXX/IMmalpi4J33pObN4M/w1r8y33mqQxqWWQrokjXMMhuZxjcDA9k9ORB5X9
         rqL8yAxUKufBWjDXczabIH3qHUyM5LClSF4NXl/JMwvbOebGRveOWFKd2vtxAknrGwXv
         XH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbIwxt2DQibnP3yIOugtYlPWWAWwpNh7S69242OkZ5spyzEP6FyKn724Gv8nIwWDjuHvMZDK7Mc5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpDokCL+Wes2VuNcX/z2zTa4hhkkRx9ISJMDsd/l1os9QJ14N
	UMEFyMXzUrnjKOa4vl+oCfxJqxlSNRSIImnsRpRkThUo1OJOG6CpLXkp
X-Gm-Gg: AeBDietOrfgIXES0ZhI+6Nl70YSx6BDcu86pb3QXul9YXYWViF6a+OOywsEGmpZ0uaR
	FFB0pfpRJ1uBd86db6q/LYkKHK33/khsVRGbUrg5trdz0irvoM9yZb4AsdtxrDGkaqPCugILifH
	SvMoCxANE+TXO/fixpHlZvcs6SJ6pEXZyClT5gCY9FGUUO6M+H1iR5HAyiwgHoyaqMZ6ZYL/Bl7
	lPCPfp1HzIiMKbiSYKZ/TdW8aUf3p599nWUzn7e3BWUpOVv92BlUDMzUyyXOijvxC8xwzD7pFka
	9ZPFk7U03CPGXTdwGNF8YS6y8QTfxTiEkTnyqQ/Ws8gigRIE2QNOhS7+ckSoPq/+ss9rIiLOiil
	baDEuRiCTyb1Yn1dnu8Em04H1XZ/8Sh4sJsryiDRX2hJVSFzYvsnFuPKx1/ZOcyhMwiPTVDWl2v
	2ojhtrg+0U6/0xPSqACX/8aUwfphkAUnrdWn5zMlkykwn8jM6WxeR0
X-Received: by 2002:a05:600c:4593:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488997e7b16mr123898775e9.31.1775336338349;
        Sat, 04 Apr 2026 13:58:58 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([94.164.143.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a36f22b1sm84749535e9.10.2026.04.04.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 13:58:58 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 2/2] iio: light: cm3323: use dev_err_probe() in probe path
Date: Sat,  4 Apr 2026 22:58:52 +0200
Message-ID: <20260404205853.18559-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404205853.18559-1-aldocontelk@gmail.com>
References: <20260404205853.18559-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err() calls with dev_err_probe() in cm3323_init() and
cm3323_probe(). cm3323_init() is called by cm3323_probe(),  so using
dev_err_probe() ensures that deferred probing is handled
correctly and simplifies error paths.

Remove the redundant error message in cm3323_probe().

Tested on a Raspberry Pi 3B using i2c-stub. The driver probes
successfully and successfully read integration_time after this change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
Changes in v2:
- Add struct device *dev local variable to shorten dev_err_probe()
  calls to one-liners (suggested by Andy Shevchenko)
  
 drivers/iio/light/cm3323.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 0fe61b8a7029..5b36fc265c6c 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -80,22 +80,19 @@ static int cm3323_init(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct cm3323_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 
 	ret = i2c_smbus_read_word_data(data->client, CM3323_CMD_CONF);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_conf\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading reg_conf\n");
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
 	data->reg_conf = ret;
 
 	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_conf\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error writing reg_conf\n");
 
 	return 0;
 }
@@ -236,10 +233,9 @@ static int cm3323_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm3323_init(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "cm3323 chip init failed\n");
+	if (ret < 0)
 		return ret;
-	}
+
 
 	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
 	if (ret < 0)
-- 
2.53.0

