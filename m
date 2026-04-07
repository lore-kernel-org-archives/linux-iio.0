Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D6364024
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575031; cv=none; b=ku3qF8kKqnnzF21qg7M6aW73Pbtg7S/Dhv0MnX1/eJC3arx4k5YaPWabr5gD+beIZKL0xKTEB+Z07BK80uSwc5sIAzYNutiO7BNdCwkc6/46cTP6mUdirafWST2Ilk+iLF/pmkWRir5BEXq8EyM9wS6CdqFH2Z3smNAJ3ZCTVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575031; c=relaxed/simple;
	bh=UpzQeOIgo32bTfZF9bCVO05d7AFWMI6EAflnf4kcCto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De9fsZZW0y5qBB92p6BxzZgWWTHGGQwd3QbYvJrUemT0pwgQH6ikoaAP03QlRTaG99Sm5M3wR6/mJ/4h+v93FjUhk0RBKRsMNmacApka0WXPcL4y47K+MbiJMxQXyCFRm06OdX5m9bz/NOtvli3NexCAPFMQ14bJRN9tJ1gDLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs28txXF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs28txXF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso4465061f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575029; x=1776179829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDXxiHNfIFx/blBavOrxi008CsS+1VUvxTy8fmtLmJo=;
        b=gs28txXFXIKxp8oukFwdJdZHTzL5aOfa+ky6rcCrQqqKgQZQbnsbf7jftoq5nFPsUu
         hfObjhuSMmWAN3T66XKMasyw6gt4lg5pukXTWOfEhXDupK7pu5yyyDwJTxWgOToiWd4o
         EKM8zHLjcrHjrQ3qsSWp4t2TG8NJ8dGJZc11hWwzboIyRMjqEoe7ut1VjAZXQkRkcqn1
         FgAjUhjLjDwfGnWXKG1mc9zb2FF9c0WIJZBKGDTFppl/6f3LNHDBcMN5ALgLlvjhGZL6
         kj4JLAbG41xzS1NgbPFLP+2AJdJ02pjbnkm/HJmG5JrOn+I4bfcO1oklXavbcEeBEK1T
         UC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575029; x=1776179829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDXxiHNfIFx/blBavOrxi008CsS+1VUvxTy8fmtLmJo=;
        b=a2FHfAR6/pwGufgirx0aEMKYOvpUxfmJDa1s9sqSW76dT13S8uj1A8+zRAvGzOfTkL
         Z6/21OIsWQzJBO1hFcsQDUsrDQxOZABy0PjXoY7NPLoeNlRMv81/9A0RgPAscJTzBAZw
         4MdEzzDt1qD0A4Ki6vm7Ce8ZvZJ9bcfKcIE8IUOwhYBe8cWQkugG5SD/GvNF7v2Y4lmU
         nOEHSw1YB56lpPVjOAar6RZn4iukC456EbrzSdtodfM8d9QNu/9HtwxeoeSKvKYvNXFY
         RuzPKdweZwn0P98+addjoZO4hItSVvnQLGD8gR6t8iC7EpuHy59yb+A3zVrQRcgh0k5u
         W70A==
X-Forwarded-Encrypted: i=1; AJvYcCWcb4I0Mpaf9aMBp1wOaG5EdjSg/ZNwlJ5HcaFddhztgdhUjz2MHw49J8u+2Or2tITGbTE5W0qvYHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/SOW1XQ4ox1iDCX1TnN8nTDyIIKszM47YxkW0sbc/edQKDknS
	6/xlSHnqh2CgtiZL1sLsnMl/TkAgvLRm/c/ltId+VziMp8uSazOvRLDD
X-Gm-Gg: AeBDievU9eemmwrHpQt4PCv0im+xJBK2g0qpFZuPpQY9Ro/KXIt+605jN6SkkK6nS7Z
	S6fu51nNHu7PnKOHsSD3SwhOOqndiOtrteNR7veg0ih8oIcTucx69mg/D0Ed80LJLX2pCL6FAdl
	7IlfPXM+3h5CaeZNSZb5Siui06rwNsqhbI3wNE1y8GAIaiidpS6xuAdrWPc13nwRWgCSJay6jX6
	We2633M1qy41Z05p3qr56PPaaNpmtWoVYks/7+XbULYTACMGwIPIC4LFQYQgage2a7ov9Yxslm0
	6Co3T4/kOmqCPPRtfUCGcc0pPfWwVXWpPjvM3Dilwh8FDsZ/9Bf4omRE+Dbfdqs005n69JqRIK1
	7d69wV2i6W7Z0Zkxxbau1PRNEtZCIZgCQvd+O0tZFX7WSuheWk809YutLKowI75QKXI31e4rZ95
	BtOYcR7z/t7mY1qxYoOl5Hcgw8vlWoAwUQO2f4jPDK0XOYgcm/TtI=
X-Received: by 2002:a05:6000:2303:b0:439:bd70:6114 with SMTP id ffacd0b85a97d-43d292ec01cmr23778032f8f.38.1775575028749;
        Tue, 07 Apr 2026 08:17:08 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([37.163.52.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm51924922f8f.3.2026.04.07.08.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:17:08 -0700 (PDT)
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
Subject: [PATCH v4 2/2] iio: light: cm3323: use dev_err_probe() in probe path
Date: Tue,  7 Apr 2026 17:17:02 +0200
Message-ID: <20260407151702.15208-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151702.15208-1-aldocontelk@gmail.com>
References: <20260407151702.15208-1-aldocontelk@gmail.com>
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

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
Changes in v4:
- Add Reviewed-by tag from Andy Shevchenko

Changes in v3:
- Remove extra blank line after cm3323_init() error path
  in cm3323_probe()
  
Changes in v2:
- Add struct device *dev local variable to shorten dev_err_probe()
  calls to one-liners (suggested by Andy Shevchenko)
  
 drivers/iio/light/cm3323.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 0fe61b8a7029..c8112685e415 100644
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
@@ -236,10 +233,8 @@ static int cm3323_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm3323_init(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "cm3323 chip init failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
 	if (ret < 0)
-- 
2.53.0

