Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F06480952
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506782; cv=none; b=ocpNaBrld7+/da2Lu4HPm9jgIH3mAtTFygsEbS1YfJ+dk+hA6r25wmFA909dq3u3BgJELFLct5VF76c7r6ITIMvqVcYk/Wo71/uvF1A+wOZpQlh4AFHxbAHvPJu5t18I0E/2959a4Ep4UJHTmhBccaGP+POmEO/fg/U2VLMcHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506782; c=relaxed/simple;
	bh=92QMxbg9OM9tIa76RuRwrM+dPii8Tq6UIhU4yfo+Ymo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVnUdKXxhBgVDIBa+OkPZreVWlGuabK6AHFA5KR0CSF79elDlJTHDEAFferUgHzUf3HUyNwNLqWXdCD15UVWmGttscG01lA9hTnGFMmi5Vh1OrgiiuuGl4h6XuiFtewGb0PSAtTScGl56ivacM02+905bV1rmpx4vpSgKqHgLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeVzFCo7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeVzFCo7"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so641036f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506779; x=1781111579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMSn5pkdQNE0J6eKuFLup2G1Dj4O8HRGoerYXvW5gEM=;
        b=BeVzFCo7TF3qVXlXkpITpyTB3CF4ZdGnmIFSnZWkq15q6Pd+WsaATEvOLBKy7FGMo5
         dbMWDJdz7ubrFCjeCz8jAP7fwOR7+aYTPQQKHTCBKwUiYqZ01LC1wSU8zFMan0L+pf3s
         Hb71b+4B+Y+JqSL7uqRNO+v2cJ5F0LydBLhp2woCa1a8rRZf5flmQgecJfXWLj7ACpkx
         /c2iP01dQ7M8CuzV4gqwR+XMjtQzzr/83s2tp6OK3peTGt7uG7nmZO3E1Qo+gdQhag2/
         wzMBHb13ZKbZqGBvON+NohSMXFvVHLxCrkMgmJn72DL4KVrlnHVyCCGwlzvEIG3IQkhl
         zUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506779; x=1781111579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZMSn5pkdQNE0J6eKuFLup2G1Dj4O8HRGoerYXvW5gEM=;
        b=JqqI78WjNWfN2qembzo2yuf7TwO91bQ7DZHSFfp37dqlJUlvDySF2ofuC1eBPchpEH
         ArpMxuzuK6bpexr5nzAiehpGSVRw0zo8y5YBilSFf6Xc1Wrs0mocMwjZXJZ8aeHT1udj
         UstwLZ73YA0fjh/DjP6gaGGYLrEA4iGqITxEHqjfx3zkNAy017TKNE8UF0N5izEWr1yE
         EbSZrKvPa1ouzG4kmymb29MLAILgif+ZOUKCg44V8HxFsvqPaMC+aGh3J5oLvEPWuH3s
         6AiHCgQiNP624w3G9/h8TnqVXGYQAQRh15vL8B7xOR8HxsHNo1M8KTKjAS0qE5T3QdNF
         xE8w==
X-Gm-Message-State: AOJu0YyaqL1Eo3WLyyB+Kmc/NaV5VUR65v8z+kSZouNIeRsWtcmZj3+D
	W2UB7n6ty/3RiPFe8TQhwcUjgHh5fJ7NF2Cn7+XxyvEOUpBlzUKnYD/4
X-Gm-Gg: Acq92OHcmsdm0PrAz7NgxuAn2AdXB/m68YG835uEzuAV61i8GpPXNTr7Wr/Hlqeq4MW
	WBdfdO2d434uWC7kz0+UjjIW7reGxOcbS+RY9k3Q1+INC33EaQvFaXV4yhUsmf7pxn/+ZFL0Eqx
	pZo6xq3nK33+bYN/tSHTPR+YcSCdSg1Ab3+lh5vf5wtfc381J2Mg3th4IkmAwE/3z7FoqlGyqq0
	QbK/GGEDO8jwNC9vSRJBipbSbw24p5tREq2pxHpMhhhCJwSkVOMOLTvyCyydjPzsHfy0vpnlnGa
	2qo4HjoNAiH8RzshCmLevb1dL6wzXlOtFcV+n9ZAhXOrmdojoztZQUHQf3dftIhD7PHYsu4skOw
	VfRVGLMl1qFfNY5tIqm5xRj2suE+x3AQZIUbjRSNFD4VLIsDJ71+PXm5M0PEdnljs5Nqg8FUYqC
	bgeLeZSx0Fwxz9FAggD65dpfmWYSHPwwXOXIsxh4cZNtRV1Pmlb9zJ1qTT8mpZN6aLXlHpL8Sqz
	dPvESUYIBkx6D3HZmRBn6NmDxWaqO4/hNY3DfmdT8gAIc6j5aJgwJCUW4HXUuQvbGAYDoQ2c6Iw
	1bdPVW+pMcM66diP8OHV+E5rcLzWt03/9nnYmGYUGt3Wrf+ESJk=
X-Received: by 2002:a5d:6410:0:b0:45e:f93a:2069 with SMTP id ffacd0b85a97d-46027620f64mr301522f8f.23.1780506778825;
        Wed, 03 Jun 2026 10:12:58 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:58 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:58 +0200
Subject: [PATCH v5 7/8] iio: light: opt3001: switch driver to managed
 resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-7-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=4217;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=92QMxbg9OM9tIa76RuRwrM+dPii8Tq6UIhU4yfo+Ymo=;
 b=XLHP7KJoRffnxe2yXtx1AdAQ7tgrkSJpiXrMktbfGmXdLoEOaJneNAd01chtWOBDFl8J1Z4Sz
 e5ihZ4dOn3nDYkTQ+KtvLk0OeGiL2n/41Fwl1J7zplopbnRHyJG2oT0
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Move the driver to use devm_* functions to automate resource
management and simplify error handling. This also allows removal
of the opt3001_remove() function.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 89 ++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 14a091533067..44f4e67eed0c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -705,6 +705,30 @@ static int opt3001_read_id(struct opt3001 *opt)
 	return 0;
 }
 
+static void opt3001_power_off(void *data)
+{
+	struct opt3001 *opt = data;
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	u16 reg_val;
+	int ret;
+
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
+		return;
+	}
+
+	reg_val = ret;
+	opt3001_set_mode(opt, &reg_val, OPT3001_CONFIGURATION_M_SHUTDOWN);
+
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg_val);
+	if (ret < 0)
+		dev_err(dev, "failed to write to register %02x\n",
+			OPT3001_CONFIGURATION);
+}
+
 static int opt3001_configure(struct opt3001 *opt)
 {
 	struct i2c_client *client = opt->client;
@@ -743,6 +767,11 @@ static int opt3001_configure(struct opt3001 *opt)
 		return dev_err_probe(dev, ret, "failed to write register %02x\n",
 				     OPT3001_CONFIGURATION);
 
+	ret = devm_add_action_or_reset(dev, opt3001_power_off, opt);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register power off function\n");
+
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to read register %02x\n",
@@ -836,9 +865,11 @@ static int opt3001_probe(struct i2c_client *client)
 	opt->client = client;
 	opt->chip_info = i2c_get_match_data(client);
 
-	mutex_init(&opt->lock);
+	ret = devm_mutex_init(dev, &opt->lock);
+	if (ret)
+		return ret;
+
 	init_waitqueue_head(&opt->result_ready_queue);
-	i2c_set_clientdata(client, iio);
 
 	if (opt->chip_info->has_id) {
 		ret = opt3001_read_id(opt);
@@ -858,59 +889,18 @@ static int opt3001_probe(struct i2c_client *client)
 
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
-		ret = request_threaded_irq(irq, NULL, opt3001_irq,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   "opt3001", iio);
+		ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"opt3001", iio);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to request IRQ #%d\n",
-					     irq);
+			return ret;
+
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");
 	}
 
-	ret = iio_device_register(iio);
-	if (ret)
-		goto free_irq;
-
-	return 0;
-
-free_irq:
-	if (irq > 0)
-		free_irq(irq, iio);
-
-	return ret;
-}
-
-static void opt3001_remove(struct i2c_client *client)
-{
-	struct iio_dev *iio = i2c_get_clientdata(client);
-	struct opt3001 *opt = iio_priv(iio);
-	struct device *dev = &client->dev;
-	int ret;
-	u16 reg;
-
-	iio_device_unregister(iio);
-
-	if (opt->use_irq)
-		free_irq(client->irq, iio);
-
-	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_CONFIGURATION);
-		return;
-	}
-
-	reg = ret;
-	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
-
-	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-			OPT3001_CONFIGURATION);
-	}
+	return devm_iio_device_register(dev, iio);
 }
 
 static const struct opt3001_chip_info opt3001_chip_information = {
@@ -951,7 +941,6 @@ MODULE_DEVICE_TABLE(of, opt3001_of_match);
 
 static struct i2c_driver opt3001_driver = {
 	.probe = opt3001_probe,
-	.remove = opt3001_remove,
 	.id_table = opt3001_id,
 
 	.driver = {

-- 
2.54.0

