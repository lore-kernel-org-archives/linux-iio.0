Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9931283A
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775450372; cv=none; b=aw6nzUn0RumqrXZ/KF2ShQieHTlUsR9mTzAU3JPYVuUozEp7usSz/ucNoDHePMt9bcTqrdvKzHzwqRCzdmRc01h8CpyygKS30y0YewNcpMtiSDLeD0hdTHEvNrUVPJJI6TI092M5OJoyRpXJYN0VxkMSyNRpc0Bao06o6ornjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775450372; c=relaxed/simple;
	bh=Jp11lnnBrydu78xWpI7iQkASv1g6UtX/tycmB5OGwuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7NSomK3tIddcYvyOq2JhYD7ZC6VO/+Sh8v/y3zXDrV8XGcIxBf6crp0QQSjycjckR9+UnP9qHn07jVZDhNn36YFaZ6H2PvzXJlnAON8PFsjx4TxuPV3YowUBIfmY0i6IyI/Lst0RmxcqwcLOCdV8PhQeg4xvMbDoHiaf26hjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGv3t+uy; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGv3t+uy"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12776bebe9fso8410502c88.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775450370; x=1776055170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm4XXEcWjidns3Evs84tEMwqC2yXbhhjm6W1vqULni0=;
        b=LGv3t+uykzFn4AzECoZMV3TV+6IDSpFEr9A5rcl5TmCYxvMQ4GWOvDqbqkWEnQs99w
         WdVxwcTRyTvtsieQ7vasOOqDKuqwL8vO++Zgmjv96jli/meVRsuY/lGhWwGb0mQiMJd2
         5VCyEu5VS+DfzYriXJeIxmrGFLfeWQ0LWm7cxtMZOF4nxQTZkbnBNhfmiyaFHCeOt0LE
         Ox0RSQkMc6otHc59ztM4dFpEaHfbQ4cKQGFTRl21fpeNsOmldRe1JyWI9v+rT0vWr6lu
         BtzlqOZsnCJoD/RxpWbfrwkx34EcNWc2r+D3S35ImPasbfZDVLPSn6/Pvi7Qxjm5MqMM
         7UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775450370; x=1776055170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bm4XXEcWjidns3Evs84tEMwqC2yXbhhjm6W1vqULni0=;
        b=VboeZaMZBtQkQgTqbfb/dH9n0nwGanPWJ5RZwaDg+hXRDWPH97af0RgUbKwsSkSYdu
         PH/SMOQtUbuy+3ulQrFkcj0He0rw5cwVc0CQgR9Do5oQi7h6v92JYkd44LMKQJqItSvx
         zjE8tLYYvusJCx4bWtEGpqEBnt/DfAGAV+LSETTn6Sn8k7aSmvzgV8rdugroNsrhGc98
         5+ODsBkTHFg4vtYFaey7k0zPkqcpB+yDPZohhFdNI7i+RDkQDIb+kpRrmKSPDPV8soNE
         ZJAj/dPRfYYLadfbceYaPANmJ5k1vbXTlfstfjE7h4pnlN0fYtbXaL1SITpEGGymGBrc
         n60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe97YOWv34pcU2ctvTlqGNYevuk7Kc3bWujspn5Xkjx/xmAhygrG/LnpkNmvVN4fT/bmkocAapXCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHzfZmg1V6lzdJUE6VV7MkzgBsYKAgYtkhXXMqs7ECTjlWma8
	a0LXCPA667cGQBLzRzb8m8deBVKSL56RB1phNk2OuMAeHM4HPQw0VTEF
X-Gm-Gg: AeBDieuiA8L2GZj6vbMjpaSn/gXisZ9Z4BVoFqx1qHs9SiA1Muk0h9rL0jBDqo5Gw40
	0pIo+ULnL+zFNgXZ4/i8veHJkYCOrTMC4JCQG/IAM6jow1p9m/Uo1UjgTg54LChp4kfyd8J7mwB
	lCQc14Pxi3Yqe1ZTg/p6B8xIWUAW4eLAlx4lz+DPDABfMN2+ekHUalknQRQLN8ckyXsku5bP6xZ
	W9f8MZkfw34cDqlhjaSHHMBKE3zVaEWwN7M4m8Zjfjs78i9BrLX7rs4iDTDlO0p5ZL71Oa0tLgJ
	VYZJI25rEQWyNUR25TmcQ/0JZfCYYw91VtEsB42HeYH5GrEmE3qQVE/8FwIS116jopxGQf6HlYM
	o+7QmMHrgUoN4CO61BQPTj23HafrTt+Uh6ieSrDT9usD7XpG7dGTntHfsm3X9S7llF3z8VdSsnh
	yZ7N0PrwPlUzUc6wm88PmMmcqANyrRZOcv7KgtIcE/ewwMWBgfvR7bb5MZABtWD2mCLkBbBGctV
	2LtkOBasSf7n0s=
X-Received: by 2002:a05:7022:6092:b0:128:cbc7:4c28 with SMTP id a92af1059eb24-12bfb771ab5mr5387632c88.35.1775450370259;
        Sun, 05 Apr 2026 21:39:30 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fe13:98b9:9e98:d1bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm15182005c88.0.2026.04.05.21.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:39:29 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 05 Apr 2026 21:39:23 -0700
Subject: [PATCH v5 1/4] iio: adc: ti-ads7950: switch to using guard()
 notation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-ti-ads7950-facelift-v5-1-1f980ed3cf9e@gmail.com>
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-6911d

guard() notation allows early returns when encountering errors, making
control flow more obvious. Use it.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 83 +++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 028acd42741f..6e9ea9cc33bf 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -299,18 +299,19 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->slock);
-	ret = spi_sync(st->spi, &st->ring_msg);
-	if (ret < 0)
-		goto out;
-
-	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
-					      sizeof(*st->rx_buf) *
-					      TI_ADS7950_MAX_CHAN,
-					      iio_get_time_ns(indio_dev));
-
-out:
-	mutex_unlock(&st->slock);
+	do {
+		guard(mutex)(&st->slock);
+
+		ret = spi_sync(st->spi, &st->ring_msg);
+		if (ret)
+			break;
+
+		iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
+						      sizeof(*st->rx_buf) *
+						      TI_ADS7950_MAX_CHAN,
+						      iio_get_time_ns(indio_dev));
+	} while (0);
+
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -321,20 +322,16 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret, cmd;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
+
 	cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(ch));
 	st->single_tx = cmd;
 
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		goto out;
-
-	ret = st->single_rx;
-
-out:
-	mutex_unlock(&st->slock);
+		return ret;
 
-	return ret;
+	return st->single_rx;
 }
 
 static int ti_ads7950_get_range(struct ti_ads7950_state *st)
@@ -400,9 +397,8 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 			  int value)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	if (value)
 		st->cmd_settings_bitmask |= BIT(offset);
@@ -410,11 +406,8 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 		st->cmd_settings_bitmask &= ~BIT(offset);
 
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-
-	mutex_unlock(&st->slock);
 
-	return ret;
+	return spi_sync(st->spi, &st->scan_single_msg);
 }
 
 static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
@@ -423,13 +416,12 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	bool state;
 	int ret;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
 		state = st->cmd_settings_bitmask & BIT(offset);
-		ret = 0;
-		goto out;
+		return state;
 	}
 
 	/* GPIO data bit sets SDO bits 12-15 to GPIO input */
@@ -437,7 +429,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		goto out;
+		return ret;
 
 	state = (st->single_rx >> 12) & BIT(offset);
 
@@ -446,12 +438,9 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		goto out;
-
-out:
-	mutex_unlock(&st->slock);
+		return ret;
 
-	return ret ?: state;
+	return state;
 }
 
 static int ti_ads7950_get_direction(struct gpio_chip *chip,
@@ -467,9 +456,8 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
 				     int input)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret = 0;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* Only change direction if needed */
 	if (input && (st->gpio_cmd_settings_bitmask & BIT(offset)))
@@ -477,15 +465,11 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
 	else if (!input && !(st->gpio_cmd_settings_bitmask & BIT(offset)))
 		st->gpio_cmd_settings_bitmask |= BIT(offset);
 	else
-		goto out;
+		return 0;
 
 	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-
-out:
-	mutex_unlock(&st->slock);
 
-	return ret;
+	return spi_sync(st->spi, &st->scan_single_msg);
 }
 
 static int ti_ads7950_direction_input(struct gpio_chip *chip,
@@ -508,9 +492,9 @@ static int ti_ads7950_direction_output(struct gpio_chip *chip,
 
 static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
 {
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* Settings for Manual/Auto1/Auto2 commands */
 	/* Default to 5v ref */
@@ -518,17 +502,12 @@ static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* Settings for GPIO command */
 	st->gpio_cmd_settings_bitmask = 0x0;
 	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-
-out:
-	mutex_unlock(&st->slock);
-
-	return ret;
+	return spi_sync(st->spi, &st->scan_single_msg);
 }
 
 static int ti_ads7950_probe(struct spi_device *spi)

-- 
2.53.0.1213.gd9a14994de-goog

