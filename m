Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08698277017
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468181; cv=none; b=nS5474H1fOqJwyId8NYZa4czN2DkD30Q7K48/F5ozrppiy74RWfv8umudmAVrz94b5W9Z23q2jFovg1JVEtNdQFs2DLDdMCcyF8tA7Nn5jg4gRwr9c757ddNnB4pOpf2xkEtt7h+8y7M/WVPaPTA1G/T7M8QFKFHOaGQsDVPGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468181; c=relaxed/simple;
	bh=Yz9snSJF0jeyCudaLTFzwfAA3jyjKzrb0jhPuElnXuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq5BjeGscvPvt6zpvv6bE/n8CfOXSBg4eo0zo0Khh/i2UePz2u1FgP6HlQDfk9WrNv4wuBTEOf/9t7QRX5Wm3FV10zbXcsNODkxz0uTWmFwl9Yu0lk64DY50DuQTuFNyaMqk3YSAaBCtj41myJ0hVaLpzgml4ui/zLtHUAfmdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtHtzM2l; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtHtzM2l"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b86671f87eso891112eec.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 18:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771468179; x=1772072979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuFP5v7SMXV4DVA+yxAHBbrT46M+siIg2POmogyVVsY=;
        b=UtHtzM2lxzp+aVqNpkpV0VGus6Ik+wkkq+fE+DX2axiIBVubjliikcWR6RnT2dUcbM
         L5905v9z7fjdbcyO5KhRYiS+5xxI0fTg2BJFkkJ2KbRZMwR0MNPYqE21HZe8DBLjG+YF
         h20X1XMVPgYmLOsTIFCHa1E31Kzm0oVMia/s/DNrpnYumrrUczikmryEVj9s5RA8iDmY
         5O8ol0W9r3Iqk2+2YHVDy2pW+9ZNZMbbHob3y9J5bLALpXZsBwE1RmoijLcOF+mn3L8i
         u1/yAnwjuaedBiYcPipiPQz7LQ1eDejy8kyukMBw0LBgRvbAaHLWHMcN8Y3RosnB4yJi
         vc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771468179; x=1772072979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OuFP5v7SMXV4DVA+yxAHBbrT46M+siIg2POmogyVVsY=;
        b=g8YsEQ2theLvsvA+GzB5LB42ckDXh8dQ+PWGIllFyJuGzL1XMz0G5boViBCO7ke5oa
         soVM6TQC380vR33cN0aeNs71rnFN0jfBkynLsoiiHdRiyH7xb4Ssqy1sS0DXc5Ut/cN+
         m0pgYt1yqbwwjQPFERsCxNGZWXzt/JZlBZ5FJIZHK+Ua+9A1/+6nB5bln1DiW4FV0JnF
         YJmWG6LiFRLaG/LbBF+jfJ96Dow4WMmdeC/Hd/9iI9nfAib/l7WlSrVNrmjRJxYwHJ6t
         So/sL97Epfj5KqudkrgUNmZaL6ijMYWSKcMp90esaiax5cS362dlKJR0TWAuNLbm4gPQ
         VSgA==
X-Forwarded-Encrypted: i=1; AJvYcCXFCOVXQvp7f+02mk0qOyFLzFe/qV0Hi46vXH4O4Sb2510N/kWMfqUzskf7uqL6gStsiVLOWcLzSxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6phNju3SGb+A5GPRWwccBWA4nXbrTHQigpCp9iVz2xY0tZ0ZC
	X2aFftAXZ/JQHX3C1CX2WmJgbQiCPHhpElUOfbVjjNaWpzImUrywUojv
X-Gm-Gg: AZuq6aJa5zOEK1FeEN9ydrhw34h6CCArKaSpIUtBOkjWkLIqwMahLwttsJ0ETCFpoFF
	8qwwObSP178tlAIucW6sxYTxWuVAcHeqCvPvKQtyJJ1Bnun8vlfwiAfO7jVcMSk7c4BBEv281Ou
	mCkly/rE6wdZLpWnA+q43KHtotOjm7/ZxaDFyJoMEHAAWdgOJ9eRctgzNkuBPGdVUUa2sercFFo
	rzEix+EbstRwn2PkIVFKQZ7InUE9szqsFbdbIyLpil8ZJfzRLGy1sH4XAXdatMrtM5uRjQlAXYK
	gUiCkPX55xsFCQxkH6OCsy8O+9xbUCIyPbthjE51cQYXAm0tDd2xSI8dFUl4WpyFseH0igKHw3n
	aTPO1o4vuUQRDlDjSG8RaUWhqPwaX43qVV74TC1IlNR5WJuxyPlg25OywhH5GeNMVT2TMesEkyK
	a+00XkJkVIEsd4ztBPKSycQzFREzxYAFXueeI1r6F3m5Xw8FcF7gVXQr39OOf9cH/bLpGzHwskS
	680Z/Q+k4Qplx4=
X-Received: by 2002:a05:7301:d19:b0:2ba:659f:2002 with SMTP id 5a478bee46e88-2babc3c8a4dmr8115517eec.15.1771468178933;
        Wed, 18 Feb 2026 18:29:38 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577bcasm19609433eec.12.2026.02.18.18.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:29:38 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard() notation
Date: Wed, 18 Feb 2026 18:29:27 -0800
Message-ID: <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
In-Reply-To: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guard() notation allows early returns when encountering errors, making
control flow more obvious. Use it.

Also variables that now only hold error codes (or 0) are renamed to
"error" to make their purpose clearer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 105 ++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 2a7d4a1d9fa9..d31397f37ec4 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -306,18 +306,17 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
-	int ret;
+	int error;
 
-	mutex_lock(&st->slock);
-	ret = spi_sync(st->spi, &st->ring_msg);
-	if (ret < 0)
-		goto out;
+	scoped_guard(mutex, &st->slock) {
+		error = spi_sync(st->spi, &st->ring_msg);
+		if (error)
+			break;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
-					   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
+						   iio_get_time_ns(indio_dev));
+	}
 
-out:
-	mutex_unlock(&st->slock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -326,22 +325,19 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
-	int ret, cmd;
+	int error;
+	int cmd;
+
+	guard(mutex)(&st->slock);
 
-	mutex_lock(&st->slock);
 	cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(ch));
 	st->single_tx = cmd;
 
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-	if (ret)
-		goto out;
-
-	ret = st->single_rx;
-
-out:
-	mutex_unlock(&st->slock);
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
-	return ret;
+	return st->single_rx;
 }
 
 static int ti_ads7950_get_range(struct ti_ads7950_state *st)
@@ -407,9 +403,9 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 			  int value)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret;
+	int error;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	if (value)
 		st->cmd_settings_bitmask |= BIT(offset);
@@ -417,47 +413,44 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 		st->cmd_settings_bitmask &= ~BIT(offset);
 
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-
-	mutex_unlock(&st->slock);
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
-	return ret;
+	return 0;
 }
 
 static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret = 0;
 	bool state;
+	int error;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
 		state = st->cmd_settings_bitmask & BIT(offset);
-		goto out;
+		return state;
 	}
 
 	/* GPIO data bit sets SDO bits 12-15 to GPIO input */
 	st->cmd_settings_bitmask |= TI_ADS7950_CR_GPIO_DATA;
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-	if (ret)
-		goto out;
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
 	state = (st->single_rx >> 12) & BIT(offset);
 
 	/* Revert back to original settings */
 	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-	if (ret)
-		goto out;
-
-out:
-	mutex_unlock(&st->slock);
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
-	return ret ?: state;
+	return state;
 }
 
 static int ti_ads7950_get_direction(struct gpio_chip *chip,
@@ -473,9 +466,9 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
 				     int input)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret = 0;
+	int error;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* Only change direction if needed */
 	if (input && (st->gpio_cmd_settings_bitmask & BIT(offset)))
@@ -483,15 +476,14 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
 	else if (!input && !(st->gpio_cmd_settings_bitmask & BIT(offset)))
 		st->gpio_cmd_settings_bitmask |= BIT(offset);
 	else
-		goto out;
+		return 0;
 
 	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
-out:
-	mutex_unlock(&st->slock);
-
-	return ret;
+	return 0;
 }
 
 static int ti_ads7950_direction_input(struct gpio_chip *chip,
@@ -514,27 +506,26 @@ static int ti_ads7950_direction_output(struct gpio_chip *chip,
 
 static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
 {
-	int ret = 0;
+	int error;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* Settings for Manual/Auto1/Auto2 commands */
 	/* Default to 5v ref */
 	st->cmd_settings_bitmask = TI_ADS7950_CR_RANGE_5V;
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-	if (ret)
-		goto out;
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
 	/* Settings for GPIO command */
 	st->gpio_cmd_settings_bitmask = 0x0;
 	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-
-out:
-	mutex_unlock(&st->slock);
+	error = spi_sync(st->spi, &st->scan_single_msg);
+	if (error)
+		return error;
 
-	return ret;
+	return 0;
 }
 
 static int ti_ads7950_probe(struct spi_device *spi)
-- 
2.53.0.335.g19a08e0c02-goog

