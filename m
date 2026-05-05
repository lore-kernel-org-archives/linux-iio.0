Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93A492507
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003236; cv=none; b=pJXAyZnSS7E0RIZlR8Xqrnn56ebY8/vg/qmoIiUuLHG1tEOmwWgkBlN0MR45bXKTrbpVGx6UwvsS7Ue3ntGMuBk631w3fl1H9aO7yHMrkMvR7xGDKDEfrBo92T3/p/LGW0DQ8RYi9VOShZtXMlRI4SMgkKuJKrs5xPcKnz2RL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003236; c=relaxed/simple;
	bh=74BbHk4KwopHm9jTxcu00JmtdsKxcIk2Jcrc1S6Dfek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7ILa/GD5LNLFICgbfWeI0A5onWA0AzzHXawY8d+YPlqTcXbhl4EDw7qn/526X08KBv5J4MOtWbZ/GQu3kN8J4FdMqwhBKvlmmcl4fEdsf+RHmSdNt44BHjm3qnBIJjK5WTXlYDzx2Ziw3y8hi5fHrYNekB/dzyoG09Wn5OWFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEoudPHa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEoudPHa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-364c5317d67so5696005a91.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003231; x=1778608031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o+TU90GRNliwuyGMLuu+yCImBRr1/AI618n8XgB2MA=;
        b=lEoudPHakK9NmeZfijOa9FfM3ajXZi+wY6lwKYyx/Q8ilYabro33fU2QLvNgrwOKmQ
         5JEPWDvswE68ZNvhONBV9rqbd+PE9a3TA+Am4gP56z6UiANLLxKSJx8WG3e66swv/yMk
         hUG4BAPewy2lvFfmH5S88bl+87AMo2KHXyxlftjsg7bZ+m6awzwHynPT52ZsN/g8TD86
         nyUzrEEJpEV2+9TrSaYMkY3x1uM/g/jzFK9Z4sKnxJzQcmUq0SoLmK1CZqFvGpchEckz
         yrRkf5QBfyKJ6jMuhXvCCpak0ZzhrckIZo8qsAmDXu0UNkGmUowtYPyLAaj1Cw5qx4KY
         W1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003231; x=1778608031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8o+TU90GRNliwuyGMLuu+yCImBRr1/AI618n8XgB2MA=;
        b=aviMMs24tfj18+d4Th9ZW7YG8ZK33XPfidOnV0TrbEn2WFbqHaufVnZh6+AayTzHt6
         FDbQtFwN13BDPXCQ47l6R3JhCSJ2YM2YHKurYCdOE1KZxQsyCHe2l2qbSEgQkxF6igyn
         pzTx4yqg6JDQEePLy48NB0weHWOrdPAYBssCvnQHAs+V96JaNZluPGeDA+T1Xk73w4pG
         NZkSwV4EkdH7zCITq/IfA69ND2g6ofRwMsxCBVgYh4rcYgUo9S07HgRMhlXm/ef+GmYn
         SavboVKcBwcloPrBe62IGveBxbr+zooHKgCZ6nDRgj9Mchp3133gqIQvkDUnDg80xVwK
         Js4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+b+cUNAW6P6TWifO8paEKsxHBUOUzhOcemUupcipnkyxJjQ82xed36UYZPtW2eAxKJL17yAUfo0tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxa5Oeyh4VzBRObCetXKBtO9REOUCr4/nuH8P9B/obvWsp8r9Q
	Fw2IJKfKm2KwtZ46vFZyItc6e6M6ub3zJKsrQBxrRplmTZdGUS0ASjDM
X-Gm-Gg: AeBDietmKTrzbWXkRJOEGOaUFO+NrpCmv88Kvdv8OehYIKsbpNezKIgMqP0ZxKf3bXq
	yHcNr/O4tiS61EMb1NfoKQHrKlK55t3dzAZjH8BR0eKLK5/PX3CmEtb3gn/5j2mTgxeNi3+fEiI
	NFoPtjRu5spLQgWbIKgPoti2i+4lfol24hSf1l6z8kck6HUSMaxvHjKc/7yshz3ReBuwRiGL/Qt
	gtdG4eT9w1R7s3j2EvhZUrA75FdYxUY6+O8WsVhLL46NJz9rr2Gnb/ea1jfli7ub2eEoMXpbHmf
	WH+/2bsqJfef0889flm0KTpzwtut3r3ztEe/CvUkcxhShC6ozQwS6mtq+RI/tjah9C1Q270iBBT
	MassmPqzw1q/9XdDHveDweKLAm7fzdtd3JwK3foUMUhC8qIFnlgg4jMafq0gc262tyj3syjbOp0
	Td/al8jnHkmF8chwDLeDB2YTjHxd6OL5kSxmWwAtDGaIJ8nmh3Qyk8AXGwPqUJuOn0b2GfyQ==
X-Received: by 2002:a17:903:acb:b0:2b2:5503:1b8d with SMTP id d9443c01a7336-2ba535c157emr40983995ad.6.1778003231163;
        Tue, 05 May 2026 10:47:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:10 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] iio: accel: mma8452: convert to bulk regulator usage
Date: Tue,  5 May 2026 23:16:36 +0530
Message-Id: <20260505174640.3998281-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The "vdd" and "vddio" regulators are always controlled together. Switch
to the regulator bulk API to handle setup, enable, and disable paths in
a single call.

No functional change intended.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 59 ++++++++++---------------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b49949792190..1c984c708ec3 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -111,8 +111,7 @@ struct mma8452_data {
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
-	struct regulator *vdd_reg;
-	struct regulator *vddio_reg;
+	struct regulator_bulk_data regs[2];
 
 	/* Ensure correct alignment of time stamp when present */
 	struct {
@@ -1570,25 +1569,15 @@ static int mma8452_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
-				     "failed to get VDD regulator!\n");
-
-	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
-	if (IS_ERR(data->vddio_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
-				     "failed to get VDDIO regulator!\n");
-
-	ret = regulator_enable(data->vdd_reg);
+	data->regs[0].supply = "vdd";
+	data->regs[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regs), data->regs);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable VDD regulator!\n");
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	ret = regulator_enable(data->vddio_reg);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
-		goto disable_regulator_vdd;
-	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regs), data->regs);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulators\n");
 
 	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
@@ -1723,10 +1712,7 @@ static int mma8452_probe(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 
 disable_regulators:
-	regulator_disable(data->vddio_reg);
-
-disable_regulator_vdd:
-	regulator_disable(data->vdd_reg);
+	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 
 	return ret;
 }
@@ -1748,8 +1734,7 @@ static void mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
 
-	regulator_disable(data->vddio_reg);
-	regulator_disable(data->vdd_reg);
+	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 }
 
 #ifdef CONFIG_PM
@@ -1767,15 +1752,9 @@ static int mma8452_runtime_suspend(struct device *dev)
 		return -EAGAIN;
 	}
 
-	ret = regulator_disable(data->vddio_reg);
-	if (ret) {
-		dev_err(dev, "failed to disable VDDIO regulator\n");
-		return ret;
-	}
-
-	ret = regulator_disable(data->vdd_reg);
+	ret = regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 	if (ret) {
-		dev_err(dev, "failed to disable VDD regulator\n");
+		dev_err(dev, "failed to disable regulators\n");
 		return ret;
 	}
 
@@ -1788,16 +1767,9 @@ static int mma8452_runtime_resume(struct device *dev)
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, sleep_val;
 
-	ret = regulator_enable(data->vdd_reg);
-	if (ret) {
-		dev_err(dev, "failed to enable VDD regulator\n");
-		return ret;
-	}
-
-	ret = regulator_enable(data->vddio_reg);
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regs), data->regs);
 	if (ret) {
-		dev_err(dev, "failed to enable VDDIO regulator\n");
-		regulator_disable(data->vdd_reg);
+		dev_err(dev, "failed to enable regulators\n");
 		return ret;
 	}
 
@@ -1815,8 +1787,7 @@ static int mma8452_runtime_resume(struct device *dev)
 	return 0;
 
 runtime_resume_failed:
-	regulator_disable(data->vddio_reg);
-	regulator_disable(data->vdd_reg);
+	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 
 	return ret;
 }
-- 
2.34.1

