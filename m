Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759BA38E8AC;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=MCsX+jiqGzJyznoMjPL8AwVI7Mqo5P5mKBUp6i/Ajlv3zg1NCFND2ZvfKz50Awp7ZJGZqZoC06bt2JlDPhJcStylri5YJ2CwbdQfhRGO22JmX0HQ0uddddZ8sCHmGkLP5adD+ifr8toYjbwGU/G3UIFIKq/xXB4eukWdTjIJN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=LDKNhQ5zV7xT+giK8Y6Tm/Cwkprt7pR2VrXMIIFt4uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1BlHnnXb8BzjokMKpzfR9uFA1a8Q3UzQTZnBaka1Wl8qRnv/90F860Exkbn0YeVsly6fBSFzpV7fN5ptni9Bh28IHFBP6YawVtE66epPsnN9oVYM0Rp6YdQ+02BjZ2q06b8l1P2yRCoxz7xHAWotATiF/ugLOB/bS339KIN34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNAXO2Nq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNAXO2Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57BC2C2BCB0;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=LDKNhQ5zV7xT+giK8Y6Tm/Cwkprt7pR2VrXMIIFt4uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uNAXO2NqGEALWG1gRvS/36DOu32s/0h/Xt80lK5XdAaxAC1fy04dpfwhePhEUsNpp
	 1KM1PlmWQBWvymg7UG3NuekgHHvqxwrsNJk/MqxlDelRZw9uuyNHTtTRM52ao/cgfc
	 5JsT4kBXw7qb7EUfIAdl6r36TUgtCYTF6gv+pQVgqkU8mrs78K4kDblfB12eL5fLab
	 pGT0O9nQErH3CII5TDJSV3UE2HMJuVuuw4YXV5gbunzq8SeNw8nuemnGTTo3QMNeBG
	 rE3ORJPyRW19bWhOJ33O1a5bWVXpvQ8+22bHFrGBWX0ag/QfGOZLmn5DCJ18BrJ8Yi
	 h6NDTUBUSvtUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD9CD4F35;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:27 +0200
Subject: [PATCH v2 07/10] iio: light: opt3001: prefer dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-7-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=3829;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=37rRREY2il0fiO/98aujElf7Lwb4t3do/3EAx2mE6o8=;
 b=ePJsxbGYRUfMAm9rOg+cBydEIrMvF+Wu1mWxZQQXJm9GaT9iuV2U1cWmH/4URhjNZY929ao9I
 gkSwnGB/JBVBoFM+S8DiXT96zvz4oFX1njzZLPLEwedBmIKcvWAtw+H
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Switch driver to use dev_err_probe() to unify
error messages generated in *_probe() and probe path functions.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 59 ++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 8eaa2cb6b5b044afdc405f19cd2499abb7e4d7a3..6f7c524d3a7a41c5177c9b02ebe1b7858294a0b4 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -707,21 +707,17 @@ static int opt3001_read_id(struct opt3001 *opt)
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_MANUFACTURER_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_MANUFACTURER_ID);
 
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_DEVICE_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_DEVICE_ID);
 
 	device_id = ret;
 
@@ -739,11 +735,9 @@ static int opt3001_configure(struct opt3001 *opt)
 	u16 reg;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	reg = ret;
 
@@ -767,28 +761,22 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to write register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_LOW_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_LOW_LIMIT);
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_HIGH_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_HIGH_LIMIT);
 
 	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
@@ -896,10 +884,10 @@ static int opt3001_probe(struct i2c_client *client)
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   "opt3001", iio);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ #%d\n", irq);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request IRQ #%d\n",
+					     irq);
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");
@@ -907,7 +895,8 @@ static int opt3001_probe(struct i2c_client *client)
 
 	ret = devm_iio_device_register(dev, iio);
 	if (ret)
-		return dev_err(dev, "failed to register IIO device\n");
+		return dev_err_probe(dev, ret,
+				     "failed to register IIO device\n");
 
 	return 0;
 }

-- 
2.47.3


