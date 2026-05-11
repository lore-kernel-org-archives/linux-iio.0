Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E073BD648;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493849; cv=none; b=BMAPC7OdO5PA7Gt7zPfL7dI8WxfLY7r5FdtsNo4Pt46IAG/X3Qp9QkRTRBxJqfCpv2tHqIfQgS8cO067sdyoSKOzhhNuOy8su8Q4USpHt0Gz/bETV3IsQtbg/+N+2TZWTmEj15dteeGRU0fUixRXNfuRacc8VNfFg6Mp4Fz2Yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493849; c=relaxed/simple;
	bh=17HfpOdQ5h55biMgQRtpYH16vvhXYQcihmO2PfS4otk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcrC4PKAXLNKi4o6h0KY65C0+FIY+wjoEIDvsNE7l5ozFrGqDCPObP+Nq3CG4kaCvxrdAEeZjPrZnIDS6WMRYc5A8SVE3HgbNSDdNwDeO3VWZnTudyZ7ZoGUMF5j2J+HvRQCujlcfBQemopcTAZibE1Q+qqEW+IgFxC2QEMaRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMqb6Dew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMqb6Dew"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37DCBC2BCFC;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493848;
	bh=17HfpOdQ5h55biMgQRtpYH16vvhXYQcihmO2PfS4otk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oMqb6DewO2Sk8saYiRULuUtUldTpeHeAsF2XrGHUqaOhHToWG/rt5rt2CuBvZOibM
	 Wq5oXDP4CzWwUOq81jEf3RJKVDvvh/s3F2Fs08dCRLF3SvFL+sTdcCd6SmRiQeYWoO
	 TJUZ8D/q/cJ0yLLHV+yl7180T92SGMeBOzKpRiJDGBUw3XYKHC77R6maurhlmRRAxQ
	 LtFlOe0msSIVy2MSGk+Y+G5KsQOUsqYjFkI4MhDr7ssM7EGSgKIX0m+5K9dGCWCM2v
	 Qil9Pp2DsC06AM5tDrr2Y+34VRVm9M/zA3vLqXZ7ttiTTzSm5dCs9pf0TGBmUbF8RJ
	 vS3lEqZV6JM3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F044CD37B5;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 12:04:08 +0200
Subject: [PATCH 3/7] iio: light: opt3001: prefer dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-opt3001-cleanup-v1-3-f7879dc3455c@gmail.com>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
In-Reply-To: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493846; l=3152;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=4ZDg+2cFad43kksEtMJuHN/u9FLl2280zxG04zaNsxE=;
 b=1g/fiGvY8NnoA6DuWmEFYwmGom/Fg0mRoQLsNJQtHDXZSuc6X8TN85KKdGqyty4PKi5PpAWai
 OdlwBXYVnuFCa8qr+j3IjM+J7ch7zSe3OTuhjuWyxjJrcsjVzNVV5lP
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
 drivers/iio/light/opt3001.c | 51 ++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 47f0e01a95e772954de0f1337ac0d881b8b32de6..4d9a17be04555aca368f7bc70a9d9a47fb5b279e 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -723,11 +723,10 @@ static int opt3001_configure(struct opt3001 *opt)
 	u16 reg;
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(opt->dev, ret,
+				     "failed to read register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	reg = ret;
 
@@ -752,28 +751,25 @@ static int opt3001_configure(struct opt3001 *opt)
 
 	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
 			reg);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(opt->dev, ret,
+				     "failed to write register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_LOW_LIMIT);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_LOW_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(opt->dev, ret,
+				     "failed to read register %02x\n",
+				     OPT3001_LOW_LIMIT);
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_HIGH_LIMIT);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_HIGH_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(opt->dev, ret,
+				     "failed to read register %02x\n",
+				     OPT3001_HIGH_LIMIT);
 
 	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
@@ -875,20 +871,19 @@ static int opt3001_probe(struct i2c_client *client)
 	iio->info = &opt3001_info;
 
 	ret = devm_iio_device_register(dev, iio);
-	if (ret) {
-		dev_err(dev, "failed to register IIO device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register IIO device\n");
 
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
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
 		dev_dbg(opt->dev, "enabling interrupt-less operation\n");

-- 
2.47.3


