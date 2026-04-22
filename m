Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF03F166C
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886049; cv=none; b=q/rPu48z9OF7Ip1TmuC7ouLER4N6gifr0eHmKajWmG+sckYkOCZ/YEBQl4tZlvdK+emLhsaD4K0LwAUsboHzbvjGLkCw537+ITaBOQi9DVHLjbVw7RZ8yEjXma8oiR4vw0LMKdzPuBfoKsOYg/lL8jEFE7BUyhuv5TU04o/uT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886049; c=relaxed/simple;
	bh=74uMZIqMTGiCbmVgHh/ItkusQdu4gxP0QcoPV6iDJoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNqKgCRoyQ2Q1qmcgEN7sPJNYKcE6UzFDE7fzy7kqrg0/e+GLQvZ61LH9hOCnDrpUuXtns9l9fYiPyKUaKQ3v3iKCbW61F/U9OyHu0xvuzdrH752XX/OpOqdBBYfl6gtPJK57i4DBQxSe1moXBGK6bovK13BooycLiGCic1sm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=gApSuJWx; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="gApSuJWx"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so3135627eec.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776886038; x=1777490838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9hvR5jDgqqdhVjQ1Reqh4HP73mZmpI9VtwqzI8TwQs=;
        b=gApSuJWx1WOok27YRE6540l9MU9wElzNP1nDHgZN/JpYmaB0FyAfF9b5gXqC2y0QTj
         HZhauSjijVDTRKODAxL5xa9jGmRd44f1dMTw/Rpgrna1ypvml6nE1t9EaLNIp3YwxKRl
         kWQGDfrNHKvnqyyAYm4iRh9UDIQFP/9C/ha4fJQY2FPmmfvwwiasR0qsvsyBaCWKYwkX
         jOUpi/Dn7fpBNfLrWcI90MgXwVGQzwo82inRBjzZFmvDx5HMpCFVBNYmgP9L58DXbZe9
         xgV0OZO+3G+oaCcDXgkX338HrmhcxhslnpEKob6egGYcNeqwcqGYQoNC7k3w3TQNonNn
         70Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886038; x=1777490838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9hvR5jDgqqdhVjQ1Reqh4HP73mZmpI9VtwqzI8TwQs=;
        b=K4xESdw4RTr7Sk3IW+HcWyxRxk5oyS+gN1w843kgaE4jS1TNRnVCF3F9Xcdsz5YO6A
         laa3DcdhF0LgN+pjOB7CoEXif3JygaoYjgqMBuX+KIWzu8adDyFUQKGz19bamMR8FSWC
         dOihmdpwMMQ7FC0NPNXFeMiTkLxYX2KieJX6bLKgbk6m+C7rgbMg5fLItoVyuDA4zR+H
         sx28kPlLMUZvczxSGdy6qtr7/1H4v2btgvAczebrPna6elkRSHdvkOFiYUmscuIBgGHU
         FgHDNlOq+ziad5+yPh2U4Zvcr8mm9Owp0LtqmdtlsvyaXLwbYz6RfcnBZGmAvrBbL/yD
         dpPg==
X-Forwarded-Encrypted: i=1; AFNElJ9X6krsUZk4U6vu9sJA/az7LC69xDyXLzRB32J8pUkIlI7vi9Gt7LFcnkkVSlOA0gscqkTQVzWDKl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWStqTE8zybq2X6D5nfluOtMjjSpqk90LVtswcGOg0Z/27mrRy
	4dZAgkluA7Zt4PQ2NdzDcQhfhU+YlPJlIv0tE0EN2Iew8sVPCybyFEVm+5kRMtDdn5s=
X-Gm-Gg: AeBDiettr8uxlJeXEiw0oHlUv/f91noYgXJluJYrc3dwSuqpygshNewZBBoYSXHcJaW
	OXOkrNFJi/uw02ncNDqFmk7foziRBcP+IQsY24Am8sVMayXjAHjcHjImmS8+t4W6CC3qWjqBKbQ
	x6efVy5mHh3esLgR04CyBcpTVqskUcct32jdTwQnaizDxOEUuHFWD5XUA/Y6MjFM+FAXO5g9cUJ
	l6VrlBIsMnrolQoKtnyEvg4n0Sj/ZQSYoqTV7kWroDKWqf7woO4JqCTMeaI04aQ20b84oC3Oniq
	UMnt0/58v4E4BTaQISORsXkcr8/KBgP44UlHpEQW+wmNS9Xj3vnM6zWitx4buPyJOTVVw+jOt7i
	24+zjmPnIEeQRWHjAJmSXcjM/g9XeXdoe3JnOlixQME2UqX7deST0THQbKY3yXzKlUddB0hLmhv
	zl7+bwZ8nb0BUg33whep0n2t/r7bNEzXNkULspWWXCCL8ajLC6Cy0=
X-Received: by 2002:a05:7301:4586:b0:2c8:7172:3b7b with SMTP id 5a478bee46e88-2e478646190mr15401513eec.18.1776886037620;
        Wed, 22 Apr 2026 12:27:17 -0700 (PDT)
Received: from Arkham.. ([2804:7f0:b2c0:99a2:bdde:cdd:fa83:d648])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa3ce1sm23370313eec.4.2026.04.22.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:27:17 -0700 (PDT)
From: Guilherme Dias <guilhermeabreu200105@usp.br>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nish.malpani25@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Menezes=20Linaris?= <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual lock+unlock
Date: Wed, 22 Apr 2026 16:24:36 -0300
Message-ID: <20260422192521.7472-1-guilhermeabreu200105@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use guard(mutex) to clean up adxrs290's error+unlock handling.

Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
Co-developed-by: João Paulo Menezes Linaris <jplinaris@usp.br>
Signed-off-by: João Paulo Menezes Linaris <jplinaris@usp.br>
---
 drivers/iio/gyro/adxrs290.c | 57 ++++++++++---------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 3efe385ebedc..86893aeeb710 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -115,65 +115,47 @@ static const int adxrs290_hpf_3db_freq_hz_table[][2] = {
 static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	int temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	temp = spi_w8r16(st->spi, cmd);
 	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
+		return temp;
 	}
 
 	*val = sign_extend32(temp, 15);
-
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int adxrs290_get_temp_data(struct iio_dev *indio_dev, int *val)
 {
 	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	int temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	temp = spi_w8r16(st->spi, cmd);
 	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
+		return temp;
 	}
 
 	/* extract lower 12 bits temperature reading */
 	*val = sign_extend32(temp, 11);
-
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 *val2)
 {
 	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_FILTER);
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	short temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	temp = spi_w8r8(st->spi, cmd);
 	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
+		return temp;
 	}
 
 	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
 	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
-
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
@@ -220,11 +202,11 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 	if (st->mode == mode)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	val = ret;
 
@@ -237,21 +219,17 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 		break;
 	default:
 		ret = -EINVAL;
-		goto out_unlock;
+		return ret;
 	}
 
 	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
 	if (ret < 0) {
 		dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
-		goto out_unlock;
+		return ret;
 	}
 
 	/* update cached mode */
 	st->mode = mode;
-
-out_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static void adxrs290_chip_off_action(void *data)
@@ -506,22 +484,17 @@ static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
 	u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* exercise a bulk data capture starting from reg DATAX0... */
 	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
 				  sizeof(st->buffer.channels));
-	if (ret < 0)
-		goto out_unlock_notify;
-
+	if (ret < 0){
+		iio_trigger_notify_done(indio_dev->trig);
+		return IRQ_HANDLED;
+	}
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
 					   pf->timestamp);
-
-out_unlock_notify:
-	mutex_unlock(&st->lock);
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
 }
 
 #define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
-- 
2.43.0

