Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD13644A2
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615233; cv=none; b=tH5SvIleISWLgvbuXJVW8uzI0NGMdH9XS5Q1bo0+1Th2dKjJqeG7lDHS/slByjv4BKWrtU9WE9jS8FTn9qmhuv8igp5czUs6TNAtvBMQbYytj/TAEfo1pks3hctU8wbNTwf6Jn+fZJPlWHHVUZJeM5+z7quwzuN9KxzOwXkYRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615233; c=relaxed/simple;
	bh=VypmrAivzn5922wpb53YtlgIG9kmZNcmnIIjDM/FuVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rzlhs0jECkrd1ea2fDOgXgBUa6rVZ5q2bbZMd4uuXW8dTpZtBUA+wFzSNKoKjr2+Y4dxW3r9SVAPLFo94BI+v6xcQl9kMcAJ9rRsIKYz/skL29/WTBIS75QaG7mxT9szb+lxd+Lo2y2nfP5NULymkW1QTIIrYJf0YjEhRwjHPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRnI4s3+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRnI4s3+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so28344855ad.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615231; x=1782220031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7f1le5tzm5fRbVe0E9jP8qxNwgcJ6Pf+ghXkipVpu4=;
        b=rRnI4s3+ieXhYvRZCCyb35j4zU89YWhVEAa7DvwZiHvufi4R9eItwk7gkksalTlCIk
         NKpKoJ334Yy5sWkt1nOxgN4wQrMD69dBDNELQ/0GW9FPZOx2p46csd/zhSaHAW4yQf08
         SDVsyMzpCswhWFVATrZFHNgWy+7XXwWSwWrZv8+rS1VDuDGAcXZfQAQjy3sv9Rz+rpa8
         FiLu1VZIMZKzASoWeEgTQmaL4LJ+Fedhw8t/vwtOFfCmFsP5i3DHXaKpbBNIfl3GuHGg
         XAlGoUkumVEaQZMFy4zsrNxAIDEZz4hpugo1w0x1OtxsxjmptdSRWmVM7B42Ss1x+ocb
         bVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615231; x=1782220031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7f1le5tzm5fRbVe0E9jP8qxNwgcJ6Pf+ghXkipVpu4=;
        b=Lfgk388GS3lYynodw0ubQqjAeIbubU1WmKUjm1K+zl+xVw2Ta3GGsZCQsNqm214cbg
         kAF7QpF+ljGmkq3RyEAfnL6hMwfEvs7iviMOA1D1lUS8xQ1/X7HSqXCmK9Z3z5piKk4i
         fCeaN4ojMOgEMU1hceuPC3kSMYZqrvJ74HkWSG+VXkuyk3iD7u+viwRGWXuaRJLXu0l+
         WSUv/ru6d9rDHk+FMhMQRRqbhRABnApd/EXUd5tOZWRh0ZMnjtr49x26qcSKWJEtJfR7
         RUjlYg0triLQzvGdytzIDuja7Vlqbo8DMqC9tzJesgsnwB4zSuOR2fAGDk/lWCjonHz/
         zC6w==
X-Forwarded-Encrypted: i=1; AFNElJ9hqsqw84OA9Y7jtzAq1VZqqEjlG1qQNQ1rE88zCwR+htpGucVUwWH7nAMO+jYWKusgassuJ36Ovj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LSs4kZUSlbAzPyppBEz6w1pFhV1gwwE617jGca3ZJQ6k6dRX
	uKrraOuoH34c2u7FbNs2f0SCenY71CpIgimyenMOtF9LqO6AGDAeLCkUJT/tlbDghUr0Wd2G
X-Gm-Gg: Acq92OEAoar6M6e9pRqHrfpWXVaL43V0uOykeOycN/oxL9vDnrj8V5aoUizrJsjzpbo
	ifxtZD4o5P1jM2X+QWLpOlnlkcQwZnzEEAZZcJ0yhmYtFL1Sb2eFaZjWZZxprevRrXnJarHdDv5
	PHeun2DXvplmBRIKpegSIYR5zoII8xulU6PsIzokhjUp4S7jdXHUwvJC1/qjjVpRYneVMOzYtdE
	4NobTU7CEsLupYJf2eeo/t4FX7Teuo/ck5hg0rdp6Ss5kc6YGYktp1ifFzNgmxvOFHgpXAYrE74
	iqhEyFdAtTNTSsxZpnL3PLByU+gshN+zonnypox0RK/GvRPxKwSzsUsmbPOKklqfzv+4Phr1wuF
	AA1pR5c4s03rw7W3aSr7WC5PsqJdgMtKg8HpAf5pUk0jls3DYqZa0n8vx21oxgPDQqLzhp5l2nf
	7OIx8vJ1iiteQEyHuDWCDH/OW79/hvkZHPSTtt88fc9cW39PG35kg+ACscVQcWeW7u5cenyF4gC
	omstL89eX+ahQ==
X-Received: by 2002:a17:903:1a87:b0:2c0:d9b7:b7b0 with SMTP id d9443c01a7336-2c69a1b8a67mr38225485ad.31.1781615231338;
        Tue, 16 Jun 2026 06:07:11 -0700 (PDT)
Received: from thorfinn ([223.185.61.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm14942915ad.31.2026.06.16.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:07:10 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	John Ogness <john.ogness@linutronix.de>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-adc*: use dev_err_probe for probe time errors
Date: Tue, 16 Jun 2026 18:35:43 +0530
Message-ID: <20260616130612.73122-1-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies error handling and ensures consistent error reporting.
Also add missing error messages in a few probe paths where failures were
previously returned without any diagnostics.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc081c.c    | 10 ++++------
 drivers/iio/adc/ti-adc0832.c    |  6 +++---
 drivers/iio/adc/ti-adc084s021.c |  3 +--
 drivers/iio/adc/ti-adc108s102.c |  2 +-
 drivers/iio/adc/ti-adc128s052.c |  2 +-
 drivers/iio/adc/ti-adc161s626.c |  6 +++---
 6 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 33f82bdfeb94..f6ce23975b80 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -174,26 +174,24 @@ static int adc081c_probe(struct i2c_client *client)

 	err = regulator_enable(adc->ref);
 	if (err < 0)
-		return err;
+		return dev_err_probe(&client->dev, err, "failed to enable regulator\n");

 	err = devm_add_action_or_reset(&client->dev, adc081c_reg_disable,
 				       adc->ref);
 	if (err)
-		return err;
+		return dev_err_probe(&client->dev, err, "failed to register cleanup action\n");

 	iio->name = dev_name(&client->dev);
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &adc081c_info;

 	iio->channels = model->channels;
 	iio->num_channels = ADC081C_NUM_CHANNELS;

 	err = devm_iio_triggered_buffer_setup(&client->dev, iio, NULL,
 					      adc081c_trigger_handler, NULL);
-	if (err < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(&client->dev, err, "iio triggered buffer setup failed\n");

 	return devm_iio_device_register(&client->dev, iio);
 }
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index cfcdafbe284b..ecd5dbb76e75 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -289,17 +289,17 @@ static int adc0832_probe(struct spi_device *spi)

 	ret = regulator_enable(adc->reg);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "failed to enable regulator\n");

 	ret = devm_add_action_or_reset(&spi->dev, adc0832_reg_disable,
 				       adc->reg);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "failed to register cleanup action\n");

 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					      adc0832_trigger_handler, NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");

 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index a100f770fa1c..9c7ee09955ca 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -230,8 +230,7 @@ static int adc084s021_probe(struct spi_device *spi)
 					    adc084s021_buffer_trigger_handler,
 					    &adc084s021_buffer_setup_ops);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to setup triggered buffer\n");
 	}

 	return devm_iio_device_register(&spi->dev, indio_dev);
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 7d615e2bbf39..440afe584f5d 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -256,7 +256,7 @@ static int adc108s102_probe(struct spi_device *spi)
 					      &adc108s102_trigger_handler,
 					      NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");

 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 4ae65793ad9b..14ed60895ac7 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -225,7 +225,7 @@ static int adc128_probe(struct spi_device *spi)

 	ret = devm_mutex_init(&spi->dev, &adc->lock);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "failed to initialize mutex\n");

 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index be1cc2e77862..10c25770a7a6 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -207,17 +207,17 @@ static int ti_adc_probe(struct spi_device *spi)

 	ret = regulator_enable(data->ref);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "failed to enable regulator\n");

 	ret = devm_add_action_or_reset(&spi->dev, ti_adc_reg_disable,
 				       data->ref);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "failed to add cleanup action\n");

 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					      ti_adc_trigger_handler, NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");

 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
--
2.54.0
