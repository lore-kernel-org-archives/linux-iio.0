Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38993A8741
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443154; cv=none; b=mLR3Z/QCS9iz6rmV1z1zHHwu+ojADftE55U2GuJE0mzbMmQErDKRhbHwTAMJD5VMQYUtMEcWOg219hIgTIqYPv2Yv1VEpqgwMluvOWx/5v8vdBJq6rG7x/sZU+28rJLqIjLUcKRRe/o1rDi0IewuJjNz1QzB+WNL91Wc5JSo6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443154; c=relaxed/simple;
	bh=sqql6YoPfNzQRgyL2Bgucfk1ta32mSgMpwD6uFvjry8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWodyWCeFb9p2gOdEJRb0jiOjqfKpNEgqArNCAEd/ok+zStP0vFgNvId1n6sr9defmWc+9mLskLAv7AnA0WwKm01ZH5yGjM3SSW2yDfN4d+IdRN8EtDVHOLuna5pMB+/icRIw+fYpJwvH9uoW3dZWIC3ulKpp3Z3sbr32Jz2/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWWPG40n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWWPG40n"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3e03939so18562975e9.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443151; x=1782047951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scrsNXORjV/hTJgu04sgSfBQacqOoCGoNdmUQAeULkg=;
        b=HWWPG40nRbFZsMCmGr9AVCarTsjUPEa7Rwds8q1VVIHX3s1CPjiin6WJim0llEv5/8
         IBJ5818p1Y5a088jcs0HLFgIwmsbOTYlPNYtoIxyfC4CAl9n1moQGRn7zEDbBHM5MTkB
         t94U8xuhljAq6IdMHBmgLk4pGhTKR5xdHK1WjRoVNWuH+fTirwBlh86y3c9Svqb6BBXN
         9KNsJxYj2qYuZS+YX0s8p7lmg2oe4TW+SVJNNTiN32rZb7vMuEYjz89tFpzONN59QdPZ
         9uAFKEq8cXNjyGyGEWA3sJMc9w+FQHx+Kor/gkDo2rokZXBxz0XfXD+JMgm5vsp3mG1U
         YpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443151; x=1782047951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=scrsNXORjV/hTJgu04sgSfBQacqOoCGoNdmUQAeULkg=;
        b=QSkDIHEsHaT77kwmFaDKFhv/NSkJsCdIcN2qQNQeVhzo7zY+MhYwSojH6yjsDe5EvD
         uEMRzWtd95FwKW2it+3Nyf0I7oaFvPYmeAL0x6AqVb3sZMLU1k0u3DIgzCOI/9KeOuZR
         Y7UdJbAZak0SkDTE0npImy1hkDqP19UkCmDvRTpQzwOAMZQ5KywuMv6xIhY/+3NbcjTk
         I69geYkdmDdV2+rgya227zbYCKgMx9RGZ/35FyvY/BCA6Ot9UY/1uzdY4dO3Yy/7HtJS
         gh1rgGplGS/f+32g/yy4ypFCdZ0KCMe4E0SI7EUP+AuK+OPted8VGPxiRRMV8m/zeBTp
         WhYg==
X-Gm-Message-State: AOJu0YydMNSD+AP5c0u7zev62t0C5FdXJwjpuvoqYLnf+GVHKsbtwjN6
	/QAOzzi+r22aHYS6bkY2bTJ2aVu4hj/Ho0JNwvVUG+muE4rS2TgCe2m6
X-Gm-Gg: Acq92OHxJuvvL2TWSODDMorg2N171kp0AOmhU5Xz+Paxez9I/HeNoYfg7qSu56x2Kzq
	GyKAJ9vSQKwiMp7cNgsgNdlpLjLMCuKawH1TEN/E51s/u+7CM7W2atGbNcc7XdpNfZqLsgB48TU
	WgfoUxNDEM6dtZBID1q/gKHXcGfVYapc061fwr6WQtYEc49BnPLMi2tV4gGWwQ5zo8UozeK5+mt
	onT/hh9RTDhnV16d/A+dkQEjHsTXBZsoVgNtfPhcsaJiAl3DxVL/JjNhl3YO9GejNWuFFtSI5p9
	7vMm0ziZVr2k3/FaLyv3u3y4QUpU2ocgaHVAnghLIRbQYyDAPRuOMjPuBNlOLSkM8UAOIoJRpR8
	uLC101mRirsC9Z25qxD2KefoaIQ00JyBBnTrNEoGeXdl0cMW/GOsctu8iNCe/e7gHKc3PrLLNri
	bAPFMyfGGlzIKnhmBGuzGAzwCeLCcH9yS5ytKpKwviOMhUs7i4PtMIYE5I9ybMsAxSTvv3d7O4m
	ZDlF0qfkZf5FXJMLfdHhA4rNukwI8geA1Y1de7HXrqzCAIUGGgQa7oS2I4ZPBScjJOaQ5uElga5
	9QQfTG1EJLhkUfvAoO9FOStwfgyvaBhL/i8Vq05gAwfn7tRbFgY=
X-Received: by 2002:a05:600c:1d02:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490ec48fec5mr111338245e9.6.1781443150995;
        Sun, 14 Jun 2026 06:19:10 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:10 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:09 +0200
Subject: [PATCH v6 7/8] iio: light: opt3001: switch driver to managed
 resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-7-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=4217;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=sqql6YoPfNzQRgyL2Bgucfk1ta32mSgMpwD6uFvjry8=;
 b=J0F7IeZe38xl4iF21sORnXKyNuVc5Gebtzzll6nlKU36q+v05xD3qzbICAsED9nrn08178gC/
 T0NMBolcA08CwXi94ik+uTqYzO4lJw/Il2GGAaI2mRo5DVtRE31VQbl
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Move the driver to use devm_* functions to automate resource
management and simplify error handling. This also allows removal
of the opt3001_remove() function.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 88 ++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index a4d626006eb3..b657aa88c1b4 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -703,6 +703,30 @@ static int opt3001_read_id(struct opt3001 *opt)
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
@@ -741,6 +765,11 @@ static int opt3001_configure(struct opt3001 *opt)
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
@@ -834,9 +863,11 @@ static int opt3001_probe(struct i2c_client *client)
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
@@ -856,60 +887,18 @@ static int opt3001_probe(struct i2c_client *client)
 
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
@@ -950,7 +939,6 @@ MODULE_DEVICE_TABLE(of, opt3001_of_match);
 
 static struct i2c_driver opt3001_driver = {
 	.probe = opt3001_probe,
-	.remove = opt3001_remove,
 	.id_table = opt3001_id,
 
 	.driver = {

-- 
2.54.0

