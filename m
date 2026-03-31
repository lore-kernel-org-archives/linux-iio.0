Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A13410D07
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971179; cv=none; b=E07tsFl8EIJ4AIIeN45wXMh7vpFX2VAFwtzkyiQANl/H57z76niUB/9jaLaJMw1D3/D2zxTbU3EJNGm89Nt2S3k70DHFXrA6nT+sm9jq3vgSu9zzHVIOCbuG3ZLpgh4bHo5dh9hQXPdU/9EoNLj0wB6jP7ZR6yGpMcYcC0fnvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971179; c=relaxed/simple;
	bh=x6tyjelC4H3L6zPzPZxHnUGgUmhQoi+UZRklAGtLICw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HissvFxCyGFcKub2PVnKoOTH0704cQKhFmER3f498J0zqMstVnF7uJf5xBEjeQbZ5nxTAzuEzHX7a5lEiRDvdB4ZZ4JCWS+lARgz/37cYp8Y+E5zuB2YcT8F1fVYGRehGv9pc3blEIiLxr3GAiQqGlSDSNkVBHv7kjwZNRDtJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTM70Qd4; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTM70Qd4"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56adf76631cso2700154e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971166; x=1775575966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jsfk26F9qEIjJYOEqoKp7gki9gIgb4WS48DZZCXcG0=;
        b=KTM70Qd4Xu9mkW9eLpzX5DQLlE7/IZrHvLggFfeud5k5sUttkdInXRLTIie+3916T+
         7Cl7Mz3iMkQ7H2sB9ZiRFvK2I7I7QDh1kidi0gi+aj38biye7HAKEEaMjwbx1KOcPcCw
         JPZZC0fUXZZoWKBxTBk9nfjJE4PtMRry4ns3pLyqL0S0FhyTdLLShgfbgp3DVP/N7ClY
         8Uwvh7vJ4KGEbm5hMZGPgMGMYQXQMJLvJbsRxHzJ4RUcGqPNQCWDsiahSsodwdRRwWPF
         WgNmnvNW+ZVvaWaUalTN1sVbBTkYg5faRi81f/cJ0FEp2p36Xs7qkKkAzJ459e6xxMkk
         36Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971166; x=1775575966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jsfk26F9qEIjJYOEqoKp7gki9gIgb4WS48DZZCXcG0=;
        b=qGedl1Gx94+lUK8DLWVjhqGucu6aBBscyzO01AK+/by9rtVD6ujaG7HNiu/b2EdpYH
         hR01tSPOFBVwtiXInYenxm/WeFRVLdhxJ4vDxJQjlpJNyIoYqTb7VEenM+CYFo/mX9yk
         53xUtVEelcxw10RN0Fjzz589WqY06/JH1Hz6bpuIBNv6W+1Aojs3gh/OFQm6qEBb3Uqq
         VIIufO2xoEJT4tbHC6a30IAYODyfFztYKJgjHjv2C32xvN60PPe7cRfsg1YA/n9FL+jr
         QG039p9dAM2/G+TcydPVckOveMzeK32t2x+LrT6Ryw0+3piRbhhnMEBD6hJD5cv5QBVg
         tiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGtEU/pSOSZA+Go9gtBEdpnXOyKRGQRJy5BlS6Bqi4eDP1PkaV3YFUiUSgfdobGPpMgGKrAs/i+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WZmoWe3W86jFIAQAc1CKCAIOkFflDYNMJ82JipMdWunMOHuU
	SBkchrZ08uqNJsZmRmTdNkcGhmqVyAUSiSru/2oqY/adOkK0x3yWaUYq
X-Gm-Gg: ATEYQzwRFnrPzh/uLmZKNdFnELYENOk9AgWD0qrkjf8WMxkMYjuqbWgGe6KJRON281I
	Ac7wpVkgQWquPOtceLA1oXW+MI/KeYEW26Koo9iMnfDYNG70z0dW1k7cYV3TCWVcpes3ES1Plr4
	y/dCZt0ldRFsf2Xgi4Pe9/tT811v3ocJLx9BlF+ZbX4b2Klvq36eT7VO4wZKBi/IDLTFeIIKtJ2
	b57eJvFDptYoGGUTRNbbLMD+cr/xSg35OPsKPn0ljY8e9pukjNr24gqQTYxbAep8R26Ax1lEzsZ
	baLq83k+n9uqvnU2qRe9LS8mTcVdWKK0uLxYD7DdBdLcbujSjC10oCKo6nhiTOO7cKytQFEvzMf
	nDqauFHbfAOZt+TN9Lo/wmsMPlXVp4zKvIhMzA2+PI+KjcEhePR2P7o/Rgb2QmIqk5TAPEw48uB
	cl+51VTkxcjWEeH01YvjsYxW8usZvwr3y09d9XOw==
X-Received: by 2002:a05:6122:318c:b0:56c:ca38:ebfe with SMTP id 71dfb90a1353d-56d4a6aa8ccmr6485345e0c.16.1774971148129;
        Tue, 31 Mar 2026 08:32:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:1cd8:df54:18b0:b0fe:e504:f5b7:5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d88e0ac0bsm552314e0c.12.2026.03.31.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:32:27 -0700 (PDT)
From: Matheus Giarola <matheustpgiarola@gmail.com>
X-Google-Original-From: Matheus Giarola <matheusgiarola@usp.br>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br,
	arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: [PATCH v2] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Date: Tue, 31 Mar 2026 12:31:59 -0300
Message-ID: <20260331153159.204124-1-matheusgiarola@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
ensuring the mutex is released automatically when leaving
the function scope. The change improves error handling and
avoids issues such as missing unlocks. It also simplifies the
code by removing 'err_unlock' label and several mutex_unlock()
calls.

As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
case in braces, providing a scope for the implicit variable
declared by guard(mutex).

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603210357.KTWqlL36-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202603210411.t4KwH3aX-lkp@intel.com/
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
---
v2: 
- fix missing scope in ad7280_read_raw() by wrapping IIO_CHAN_INFO_RAW
  case in braces so as to fix build errors.

 drivers/iio/adc/ad7280a.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..f34514be1648 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -496,7 +496,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	devaddr = chan->address >> 8;
 	ch = chan->address & 0xFF;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (readin)
 		st->cb_mask[devaddr] |= BIT(ch);
 	else
@@ -505,7 +505,6 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
 			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
 				      st->cb_mask[devaddr]));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -519,10 +518,9 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad7280_read_reg(st, chan->address >> 8,
 			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +549,10 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad7280_write(st, chan->address >> 8,
 			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -737,7 +734,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -760,8 +757,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			st->cell_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
 	case IIO_TEMP:
@@ -785,18 +781,12 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			st->aux_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
 	default:
-		ret = -EINVAL;
-		goto err_unlock;
+		return -EINVAL;
 	}
-
-err_unlock:
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -884,14 +874,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-		mutex_unlock(&st->lock);
 
 		if (ret < 0)
 			return ret;
@@ -899,6 +888,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
-- 
2.47.3

