Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F23890E8
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579534; cv=none; b=d8rhccqpSJtKw0rUpPyt6HhEJYtYG2ibLr160mV3v+rkmhkcympknQ8TC0hPf3bjnGzKDYXa6k5MplqQp348AVlL0/sES+ZBbB15jLTGTFH39+KvzT9iNCNI17knS36bf0mPIBeOE6xBn2K14gyovGLhIfIvHz3vn4ari67BgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579534; c=relaxed/simple;
	bh=MUStzhD6Xtgw+nKApVKfkNWBpuvdFpQ/izpaMVDaUg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IGZPdxcPBxFresBX6xLjKyQbtF9oxwuYZBiTEaImkQ6/I2Vt0C2sujzo8AJgV7ZXknKin10zoGCrLwNEmEcXGd6kOS1F7snac1WBVJTj6649jKAqiMjBv7dUKkEIKRW2YfdSbVx10UtHnrvVE77vGTd2vmF8BIo76dMSb1BrkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=WBEoXqKp; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="WBEoXqKp"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-610f4cf6ddcso1695526137.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777579529; x=1778184329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SjuU09dURy7vkkZkgmhbNdvT+2q5fqcVhzJNFLqKgw=;
        b=WBEoXqKp/pDOx1NSD88vT+EpQ8NqcOqIFg3qovkfj7e+cg879ytCFgF60PpnFy0vDK
         bjLUrY++EnnVC/ayVhHOEt45NZQQDFyi61gFio6Edky60RNWVR4ZRNPAOvzrTS+iYmr4
         //9jp5At1SVg+ae4KvrelGenaVjUmVMOJfAiqvGaGSO2uRorZcVEAnojSKTBtlhLbzJ/
         NLogcBHeNWZez9mVCmJXBWE9Zudvpjd1mJxgKtzvIcLS/ldcSnAGpZagv+XAi+fjyYlJ
         KcXHG72H5bwQgg9LFIGJq3OQ0slOTjSC440fg0Z2JygsEbjXJaNrTGN81X2ASa8/Kup6
         93Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579529; x=1778184329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SjuU09dURy7vkkZkgmhbNdvT+2q5fqcVhzJNFLqKgw=;
        b=E10pJ0cnxugUP2qRzvrcZ/1yEIA3eq3g2oCbeD2pd33jd31D57Fh9yk2Jah9pmMCJh
         K9bRc7KtWF8PX76yhp95O6ZhWqDWgGPhzZuQMwiVPCgLVjUoSMNlR+W2UIkPdm8nM564
         9Te8IswHZF721MH+wQDYczwhGAYZDPRNCTo+xc9MKNFRF8e6UjjyDtPruSJCA9a6wNqx
         fxBt+fdZ2HEDTT1oe89Ni6nJrBkNz+fZIQqPE3NpwwwKjt0yebS0PwrDYE41A5NfFzZF
         SyEhxDxUsv6wWAl12P/JfAeoB5hYedmVe8MAU+GadcaSzCtUGNUfOyepdwGYc4JPbmkY
         7n2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/5xZWCKjwhuhD7XuCHLngshc3ImMEm9oCex0RbMMpFIodbuGufhaptWsuSn8AkZWh+HPXZVg8iOEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRl4oN82gLh5lGIkXSnM5Ssu8VthZe4QEnV3ePwce2cyEZpQp
	FvGzAvzg4FUwAE/aJQTStoB+hQoRELSgf4PCRHjHScYMSaYRkqf2kX1JLIqujHT7X3lfoQ+VLwh
	hpj/e7Hn8sA==
X-Gm-Gg: AeBDiesSS6M3whF6zrI3DiCHxrQ2it5coVqtB7fgcegONCIRY/x8TLFD60O4NjVoxZE
	R9FaJW6ZYTG5dNbIxTn++7p9bEj1jhvX9cB/H4r6c0PP6xQB4C4dvM981tPB2xqlR9k0cPVfStS
	OTksmfkB+L0vdNGfXhOQLpfYRVDoz1cMs8MmGBm+FkFo0chgmB3Rqmeo7hMLWq5tNqf0BSWdMNX
	0zl321zHKvqEl13w041EB7tMfU770GcjNu9L1DJ3FAHES+o+SKnIwcvvRundKbkkjfUzlljrHPa
	AIvRAh7lNYGDSYsEFjda11Dtzjkef+/ce+s7Cy1ZirbzsDLZCchMCW2JiypBT8SbF9sxos01WaH
	/gXiiJMcVcyEhQe+mgxnAs6oYXkxYM0OQMIraVll9q6RJP5BREYR19TUxqiNESoL+qWGsDrjSb7
	ZrAZjiz+I+Vu1az1FXUieDnIrfJJaVOCLuZveUJEiZnw==
X-Received: by 2002:a05:6102:4b82:b0:607:f4e7:d2e8 with SMTP id ada2fe7eead31-62afc506609mr2075995137.4.1777579529264;
        Thu, 30 Apr 2026 13:05:29 -0700 (PDT)
Received: from Arkham.. ([2804:7f0:b2c1:572c:7637:145f:a3f0:6c60])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95ce08f4a7asm425901241.5.2026.04.30.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:05:28 -0700 (PDT)
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
Subject: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual lock+unlock
Date: Thu, 30 Apr 2026 17:04:56 -0300
Message-ID: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use guard(mutex) to automatically release the lock on scope exit,
simplifying the error handling path and removing the need for
explicit unlock and goto-based cleanup.

Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
Co-developed-by: João Paulo Menezes Linaris <jplinaris@usp.br>
Signed-off-by: João Paulo Menezes Linaris <jplinaris@usp.br>
---
v3 -> v4:
 - fix indentation

 drivers/iio/gyro/adxrs290.c | 74 +++++++++++++++----------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 3efe385ebedc..f7344ab4e6bc 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -115,65 +115,53 @@ static const int adxrs290_hpf_3db_freq_hz_table[][2] = {
 static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	int temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	temp = spi_w8r16(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	*val = sign_extend32(temp, 15);
 
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 static int adxrs290_get_temp_data(struct iio_dev *indio_dev, int *val)
 {
 	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	int temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	temp = spi_w8r16(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	/* extract lower 12 bits temperature reading */
 	*val = sign_extend32(temp, 11);
 
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 *val2)
 {
 	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_FILTER);
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int ret = 0;
 	short temp;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	temp = spi_w8r8(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
 	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
 
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
@@ -220,11 +208,11 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 	if (st->mode == mode)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	val = ret;
 
@@ -236,21 +224,18 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 		val |= ADXRS290_MEASUREMENT;
 		break;
 	default:
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
 	if (ret < 0) {
 		dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
-		goto out_unlock;
+		return ret;
 	}
 
 	/* update cached mode */
 	st->mode = mode;
 
-out_unlock:
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -506,19 +491,20 @@ static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
 	u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
 	int ret;
 
-	mutex_lock(&st->lock);
+	do {
+		guard(mutex)(&st->lock);
 
-	/* exercise a bulk data capture starting from reg DATAX0... */
-	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
-				  sizeof(st->buffer.channels));
-	if (ret < 0)
-		goto out_unlock_notify;
+		/* exercise a bulk data capture starting from reg DATAX0... */
+		ret = spi_write_then_read(st->spi, &tx, sizeof(tx),
+					  st->buffer.channels,
+					  sizeof(st->buffer.channels));
+		if (ret < 0)
+			break;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
-					   pf->timestamp);
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+						   pf->timestamp);
+	} while (0);
 
-out_unlock_notify:
-	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.43.0

