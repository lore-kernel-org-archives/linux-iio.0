Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79246263F4A
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984034; cv=none; b=qsvVmdU9te7T149RwW1DKomMyrur+kFs/YE8mOz8A2t3/jJAuizmms5B3aJTnCEMOJFiZZPKZSx0D+z+AKCB2uEpG2ry+kqCQdCprHucrAxpVnTIG/k0ggp5qz5Zb1k4ozrSVY/ygUq2IsCsPe1lIHpD2DF4nz9lL6LHd2VTsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984034; c=relaxed/simple;
	bh=+9RtrJdE1JpsZJpABQaGb4aDsO4LuUSNkTm7x9Q/cig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LWSCDUE1LC7uUGRRSaXDLcKSPmhRDn6CWESizxJhYxWXGmbr/TzsJMwG7oXPVM/czR6JN4X53axo4V91usHGSaiJXd7fNQKXTJZ6B9JM4AbvG/j1dWYDkYskl+v0Bh/LFH1czzsARbf7Xwu+F0ILtDIrotbYqggVeXJEAyyJMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Hw9Yi/Y9; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Hw9Yi/Y9"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2eadb000b8cso766901eec.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776984030; x=1777588830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcel8yFzvjQLbN7QIxGyEVzu8gDLD1L5rbvBmgsgXHs=;
        b=Hw9Yi/Y9sHj3KkAhQxDc9lQgastK28WLJRNsJfE7Nin+k2adkyA9BgaEcQnSqUPAHx
         eJrcX9iHRX6BJQvRGsbq2TLTLmLxAztc8lxNW56v2by6EZQJYbgn8vEkPnZYpTqNl0r7
         OOHfIyg11IzRg7kwuz0FbwP+0cNSQlZ/H/xsMIcyvR4KJnhI5PEqsWm9Oc7v2IbjFnOX
         o89xkjCW5U/Ez6inrQo2+rFOl/WjvDPM2nRAl0y/015q/J+RFlV7dk311L8QEOeeD4sk
         GTauQvkGymRCO3V9XoFKItA1jq6ch0U+drT74r/jpP0qJQYKvX+fskGda14pY9D75SdE
         2ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984030; x=1777588830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcel8yFzvjQLbN7QIxGyEVzu8gDLD1L5rbvBmgsgXHs=;
        b=h2uC4JKiuUWpshffOWi59s2Y98ZP2vmQRl6k8LkgLLDI8JEOcOJM729hShxGMNI2O1
         BCt5TFJ2W8OIempst5d2Atn7tqj2PRolu1hVeeAGBknjNmRpwBV0LDFuiCjywUHFp2am
         EyBlwQzE9+yVwzHS0lEoLxEfMqyb/vEVmAVNnpmtt4+QNpb9/+kEa3jWOYZY5Lln27EY
         CxJS0MiQAcE4Z3ydH1xmA6jiGy+EQ7/yJTPKbxuTiDg2YS34QqJPmtGjpsb3q2FFTcZR
         QyA7dR4xkh1a7xfWaYMiKgffSA59wk1UUA6gqX05YIE3kwMYklaklnGycWPaxjcTRJAw
         GDtg==
X-Forwarded-Encrypted: i=1; AFNElJ/oTkBjqUuK/jyv1Hj81ezd0o2C2wDHg22chwwQrCfX9Gq2M0FKiaCDwpxD5mT2nDzdAq8MM8pg9WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLDVPIYb6ut/fenwsO9LhMdf7e2Yk3NLspR/C/tX61m11XIg+
	HKPgYbTA1qjQLQzfccL/eCHh59O2Gt5u2Huosrx1jPys1Hus3qOqMpkUlwHLS4DXV6Q=
X-Gm-Gg: AeBDietgLk8CWl8YLyCNcDQ+Z3Y9gUXRADjE02s4sq+l2iZo+0/rr7pdKG486guN4mz
	7IF3iAdIOZYVYnULCdMH7+lpjhrdtI+4sSIqAXKidh9HrrA8jwzdA0W9pIujKlrlT5z23xhwD3A
	J+4XUxMRg8aMZtA9yUqCNmt014yB5F8tuhbtNr7gaBW9MStCwP2bQLKixIHkoVFTtMpmDOCLq9w
	YCeDPK4t0ioh5ISdO13IV4MoPksf+ejY2XXCRM3UFwSR3t6zV3NqkpXQDPMYUPBxyQ1rKCNm4kI
	o5+a/5VNY1I7ZngW3z/jHMoTN4dHhUxmJhCxznLLUax2gLiFZ4lQuwFVKq15wtJWWoF1k3ihMo4
	ZHTYmMISiJvbXlQgP4RzfAUWclVp+S5L3kPzRAeGHoD5fJTDOtP/xhEniqwBkRIZa6imHH2G1gH
	rHo2LR7w2ZKj3UlXv/KjqcMomzkKiEbBHHCf4DGU7CDg==
X-Received: by 2002:a05:693c:3009:b0:2dd:6937:79c8 with SMTP id 5a478bee46e88-2eada6d7359mr1053447eec.5.1776984030380;
        Thu, 23 Apr 2026 15:40:30 -0700 (PDT)
Received: from Arkham.. ([2804:7f0:b2c0:99a2:9a46:6b1f:9788:7b72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm29272538eec.27.2026.04.23.15.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:40:30 -0700 (PDT)
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
Subject: [PATCH v2] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual lock+unlock
Date: Thu, 23 Apr 2026 19:37:51 -0300
Message-ID: <20260423223958.100487-1-guilhermeabreu200105@usp.br>
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
v2:
 - added returns mistakenly removed
 - remove unnecessary ret in adxrs290_get_rate_data(),
   adxrs290_get_temp_data() and adxrs290_get_3db_freq()
 - invert condition in adxrs290_trigger_handler() to eliminate goto

 drivers/iio/gyro/adxrs290.c | 65 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 3efe385ebedc..25b6dd6e986d 100644
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
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	*val = sign_extend32(temp, 15);
-
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
 	temp = spi_w8r16(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	/* extract lower 12 bits temperature reading */
 	*val = sign_extend32(temp, 11);
-
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
 	temp = spi_w8r8(st->spi, cmd);
-	if (temp < 0) {
-		ret = temp;
-		goto err_unlock;
-	}
+	if (temp < 0)
+		return temp;
 
 	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
 	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
-
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
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
 
@@ -237,20 +219,17 @@ static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
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
 	return ret;
 }
 
@@ -506,21 +485,17 @@ static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
 	u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
 	int ret;
 
-	mutex_lock(&st->lock);
+	scoped_guard(mutex, &st->lock){
 
 	/* exercise a bulk data capture starting from reg DATAX0... */
 	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
 				  sizeof(st->buffer.channels));
-	if (ret < 0)
-		goto out_unlock_notify;
-
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+	if (ret >= 0)
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
 					   pf->timestamp);
+	}
 
-out_unlock_notify:
-	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0

