Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BE3EE1D1
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921516; cv=none; b=tXJ8hgNLdwnrSTGt8tX6A0Lcf8WFuozUG0YyXBqSBIleGo/4HViFUe3uaRvUfBm4FznSlbaikwxe4kxQ3Pum2GjgngOrH/nbwGGGOl3mBP19SCLicNxcG6UW2wBtau7XqxYWsKW7Rx2Fy8WlJFnRzqT9TTJQhzQExFnRjWw7cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921516; c=relaxed/simple;
	bh=qRl0DVIRsvGE6dc6roEBAz96Z2HgVpzZHR0lEe3ayYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKQejGACObjbOr7V9WlyQKmuJP0Z1kzmRcdZgWCHEtQhweq2/n6chPNPPSe4+Nr4zCMSJHlvNjRddhLJjMeTURxG7yaZik23G+DjN3eXO9LxilhKca3vd6Sn4PKAFhVNlGbtDj0oEpEIbMEVz4FNRWmVreVowC1YzEa5iJjghGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=I5HFDdmT; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="I5HFDdmT"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12e332315a8so5774716c88.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777921505; x=1778526305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeTVA2mKrk6N8/5i/XDHWV0fO8L7jMCCSTG4CTdH+1I=;
        b=I5HFDdmTj3Fi07QP4aUwEB/zgqAwHeBRyVe98jPslAhSmWOH0/pPvyfRrbsZTqT9pQ
         qeVGi4/motIt2DC0002zWHi4EliR8ADJxngfmON7oHvMcnvPgPWmvxvpM8bFYqHq+M9q
         2aVOs6+yNzrk1atnJqXmIqV2Yo8bchS0lJQ+0ax4qgGAoVQzcx8UuCY4C/GN4zV9xNNI
         GRWmGDzzgGuEfIMoUF4oItR+zGHTD9W7k2QTKXubJy5VEom3nzhHyuO7psYVfGAb7zqG
         X6VyaoQcpRpVHMQrXqmnrVL6TYszQz7YzUmbYoNBw9lrljFLXew3ffoWoWVAXzIZv2RB
         sr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921505; x=1778526305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeTVA2mKrk6N8/5i/XDHWV0fO8L7jMCCSTG4CTdH+1I=;
        b=VJM+CwFonjtRtQhO/FwT/Cxu09OzJ9RtqiT5dSIlEhcrtk27Ht2Vw0QkmVw2gXmv+W
         pxhfbhRqZJOU/A70ovVKjav6wuTjRCu2K/takmxj3DZ8lUbs99+wdY/9GaM6TsmYp+Nr
         gYn6BkfVlXOYH/jY470D1LMX81NHAtzsRnLO0VBVLVkeEPpsz5aJ8gJjtwQ7H5m0OBKh
         yYCVXOp2JN+IIACQDw8iBkJQWXpcW93LEwOOztAhmw45pultMYzsh8YvGKoZ9M4j1bWA
         B8G8qsRcL9wrF3uQy4O7vhLmmgT0jI8CXopXkMssXsCJXzPXKQfsY3DnSPUnsv9TVXzq
         IQ8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9dGOFaAYT13ANJxyBsjA+6SFPsejFRrbUnnbZn/qOoOrDoeKZ/nJ6Sgisl3HD62EC3uQrrTgBZ0ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGJXXcVcQnFT0kfbgtzf80TVLJw+WrtzLxxuICFFRYLDHMsio
	2lpeLVOv09usjZqM/F63xC8DYb4fiVrZP31Vby2Cez8rbrFXsZhz5IcJTkbFKeSJLb4=
X-Gm-Gg: AeBDieuZHiWkOv1xjdJvhkzd+coP2BCYxh/neDk6Lp6dn5oB+S4bstgxy10MDnFEwxJ
	rZpsQLHOT2V9bPSW5WryAG99FRxqAPF/g/v0+eA2VGMkV0o8IofFDx+rv92nfSooh/hCarfiNdw
	PlTnaxBV5/wQEIRIjkGJBClyTBcfldjL3fzA+Kwf+j1UJJePjqmQyVtqbY8iGGA0lEvaRqzDxTh
	nVwci0iEbPwb/rt7FNT/UL8zzCq8PikUXEyE6CvY//LWGnGNBDXA1/hT3UphKhqAYGYu47OQIve
	eLa/sZHyUGb4tNTERtZdaH+aEqeS/sxPGmRnQvqNIGMYF1NEcE7CCdszWWQybBOqY0bGGDtshVX
	H5z+Oa8PySQtOGCXPhTrflo3yg2CCf4EO5IK7C+yxIq8HcpbjLvj6N70ZYqLdNMWbuhP4zV93l6
	Hp9UtVwOB17xBuhMkAatxEnu3ZPJ2vKDE7+kvB8ghAeCZOS0x/SA==
X-Received: by 2002:a05:7022:6b83:b0:130:6c8f:5a87 with SMTP id a92af1059eb24-1306c8f5b92mr2349934c88.13.1777921504185;
        Mon, 04 May 2026 12:05:04 -0700 (PDT)
Received: from Arkham.. ([2804:7f0:b2c1:e3f0:ba:3725:69a6:8946])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84250f1sm17095506c88.11.2026.05.04.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:05:03 -0700 (PDT)
From: Guilherme Dias <guilhermeabreu200105@usp.br>
To: nish.malpani25@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Menezes=20Linaris?= <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual lock+unlock
Date: Mon,  4 May 2026 16:04:25 -0300
Message-ID: <20260504190455.9841-1-guilhermeabreu200105@usp.br>
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
v5:
 - add cleanup.h

v4:
 - fix indentation

 drivers/iio/gyro/adxrs290.c | 75 +++++++++++++++----------------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 3efe385ebedc..35928383d4f2 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -115,65 +116,53 @@ static const int adxrs290_hpf_3db_freq_hz_table[][2] = {
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
@@ -220,11 +209,11 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
 	if (st->mode == mode)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	val = ret;
 
@@ -236,21 +225,18 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
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
 
@@ -506,19 +492,20 @@ static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
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

