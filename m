Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADB3803E8
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738522; cv=none; b=fB1gQcRMnDYnpMR6hUkk3ZkeL/aJIyAe51dxrknosaCHc3H6yy6W9BExz0JO9klIGvSZdbfr56JQvZ6kQAI/trqZ5Rmt5UYzgI8GhNSPnLW2hJinECpo71WvVAeSwg+i9f1Q1+tmgHc57+ZngwX9QiltAZ/lY2tLElSjIGCf1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738522; c=relaxed/simple;
	bh=3SWnArpUdPvh7sURBFPMyY8lv0kCsfhAdKB/7fgwDT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qc5rpkSOTiTmm+CF2fA3QYj1nMFvpaT9i3scmInmnczgG9g7ERcrrp+XxGUg7/48QiZiLfxaXbbSmasPqzsa+ARKBSM6A+EgtfySDuBpXIp16XUSDS9o2OzPk/VpifMUXYidoSA98DJPudX2VbQjROyULRPEjw/W5TYzQJNy0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9KcXdJm; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9KcXdJm"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be1c918173so7179928eec.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 11:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772738520; x=1773343320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRSHQ7gatZSUG3RtlqSDdsXge7aN0hna6nERoHcMWWI=;
        b=e9KcXdJmD95Na9Q6wV+O/tMphO4LEVfhZu6kYU3GrnJglzjoelJjBlmlG50kDZ3+EU
         jtDbyjwj9mvRWfJLv9fmYIrOesm7hvaQgSQgn+UxrUyj0JuwxbLbT8okGaTyWR2cCpjl
         DuvDcfZTBYs4bvV8sMNi/Crq6YlLawsR61CFNPfNFB8TxvOUVvmKkO/EC8bn2+vAQJNn
         EkK3+g8Uj/mnNvhE5cmn3hsKvZinweq4YGMC4N2wc7NtgMQUHI1Dsiy1UO3HL0zV/0qM
         MFDb+GL7yPxR+kQYSx+qjFRvgsN3jKBLKr5o1WGdRW3omxBzMhf5gCzW3u8Bs88x4YeR
         YufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738520; x=1773343320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fRSHQ7gatZSUG3RtlqSDdsXge7aN0hna6nERoHcMWWI=;
        b=r66UScQmFec0kfjzq+aGLRnRQtF9jKKhcoVUsXWnH3fbCUaQB9YLaKmnZjdfH3WwuZ
         9DIsS6/na09t2LDjiRfMerV9ToZiA6ZYMZz56JLEZiglmE+gdEuh+d+IQ/YEuTHQTM7+
         pvYmX4mHyLtKtx9BmXDatMYwooL9xpF17ypmzUab3dUgz5xS30hgfByCNZt6BqIp35Tb
         SU1ZwQJuXc4dKvDqwQaF08eqgdV7N7+W7SJlLQY2qGKCCjtuukrJ0GhaheYvyOXqEqH6
         36+Z7mZdKVQBP9N6ciise+D7f3Yk47y/D2/tRf3tFf9ugftzVbgl1GhK2jM0xW6Rhv4Y
         N1/A==
X-Forwarded-Encrypted: i=1; AJvYcCVaIWLKeAcg9noafgh0wsopJcaMU+s3NY2OWv71BWXJGEaxPeFqHSnZoVi0tuPukGxKg1lgxH4ePPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1nWOdvJnE0HDjZD/2nnr7VEG0SkDPbwuoPoXTEff/6m8ivMt
	pVu8DeVkFllPdgYzbk39nRXAPcMoCyhtHtxy4wR67GfnRf9/psSzzGWR
X-Gm-Gg: ATEYQzyMczE2WJzVeJvTLfB2e5nC56/HwqFh06coL961TFayg/gnpVGbMh+eGp2ODDj
	GkD7vjnris8+e8v+DAIAtu2/yWkcrx8/jG5outwmXXivSr2bolCQHOk8WI22sD25/tPHh8qiHeb
	5PqMB4sDa7oZbZhcZreeNKcx1XtiTUzGQVIJpDUcmC4V5rWIkpEbLcsSSwXMLiB44IIRxLFw9Sn
	J9LBZ4swwLFOYuyHInLv3tZaB1J0HUPVKNOfmZVnls88nQG2cWWnTfvsq2bH18rhXpMhxzUth2U
	gyHN3GV/Q2cfrqk4ydJ51IduhI3/t117Sw/IYynvxhovhQ+ZS8IaVg2Cj24OkV4BOehFzMgRC4f
	AeMrhb6Iu3MmNtjq9DKBGQIJ8MBSyUlXEbPfCAMt5lRqDRFlXlSvVa1aNP095WLu1HmENaYSS+y
	417jzSFkjRwE13WIrkzEXbd/qda+T/91StqC7R+P/F4NHj/RGTitqAd92l1GMzqTgzR4Uw+Qzk1
	IHA8Y2epJvddks=
X-Received: by 2002:a05:7300:6c1f:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2be30fbca17mr3113659eec.1.1772738519575;
        Thu, 05 Mar 2026 11:21:59 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7788:d145:a740:ca06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10800980eec.14.2026.03.05.11.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:21:59 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 05 Mar 2026 11:21:54 -0800
Subject: [PATCH v3 3/6] iio: adc: ti-ads7950: switch to using guard()
 notation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ti-ads7950-facelift-v3-3-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-94184

guard() notation allows early returns when encountering errors, making
control flow more obvious. Use it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 75 ++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index cdc624889559..1515089dd759 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -308,16 +308,17 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->slock);
-	ret = spi_sync(st->spi, &st->ring_msg);
-	if (ret < 0)
-		goto out;
+	do {
+		guard(mutex)(&st->slock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
-					   iio_get_time_ns(indio_dev));
+		ret = spi_sync(st->spi, &st->ring_msg);
+		if (ret)
+			break;
+
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
+						   iio_get_time_ns(indio_dev));
+	} while (0);
 
-out:
-	mutex_unlock(&st->slock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -328,20 +329,16 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
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
@@ -407,9 +404,8 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 			  int value)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	if (value)
 		st->cmd_settings_bitmask |= BIT(offset);
@@ -417,11 +413,8 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 		st->cmd_settings_bitmask &= ~BIT(offset);
 
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
-
-	mutex_unlock(&st->slock);
 
-	return ret;
+	return spi_sync(st->spi, &st->scan_single_msg);
 }
 
 static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
@@ -430,13 +423,12 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
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
@@ -444,7 +436,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		goto out;
+		return ret;
 
 	state = (st->single_rx >> 12) & BIT(offset);
 
@@ -453,12 +445,9 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
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
@@ -474,9 +463,8 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
 				     int input)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret = 0;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* Only change direction if needed */
 	if (input && (st->gpio_cmd_settings_bitmask & BIT(offset)))
@@ -484,15 +472,11 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
 	else if (!input && !(st->gpio_cmd_settings_bitmask & BIT(offset)))
 		st->gpio_cmd_settings_bitmask |= BIT(offset);
 	else
-		goto out;
+		return 0;
 
 	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
-	ret = spi_sync(st->spi, &st->scan_single_msg);
 
-out:
-	mutex_unlock(&st->slock);
-
-	return ret;
+	return spi_sync(st->spi, &st->scan_single_msg);
 }
 
 static int ti_ads7950_direction_input(struct gpio_chip *chip,
@@ -515,9 +499,9 @@ static int ti_ads7950_direction_output(struct gpio_chip *chip,
 
 static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
 {
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&st->slock);
+	guard(mutex)(&st->slock);
 
 	/* Settings for Manual/Auto1/Auto2 commands */
 	/* Default to 5v ref */
@@ -525,17 +509,12 @@ static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
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
2.53.0.473.g4a7958ca14-goog

