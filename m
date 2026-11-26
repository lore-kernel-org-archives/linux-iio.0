Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693505;
	b=JjRijsg7CCEccDs8GM2AeRgHu5N1cvepqy5AX4U1wiVh6EVXk6LXCg6YXuxM+OE86F/s
	 QDvo7dbXl2nU0SxYASc+U6AbfFVkrO5+Hogn+/bYVCN1IvC6XgRq3VDC56XWQokWa64KA
	 6aP/3Ww6VkVpCmpJeoA+O0TxcTsXRWuioqAWxkBjSzQwuaVfUOJjWin+P182+dWbC6bNL
	 h1eWg3JByjNZasnX4Pu1+cC8XC7O2jmXKy2vS0oCBgi0KMNaWAjecVw4+ivD+iUG0cG0T
	 ExHOC4HQyxlFCrjapzkqL7ozF+KdkgcwcP9kAew13sVd3akEiNg2bwdOJVH2pKa8quw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nJGypL/OATS2U+96YRcXHiRoKHcq4/rzhG6F9CstjqQ=;
	b=Ru6pA2GOTipZjYuDPgsRISXtWQRZoWlnCoYiCLKvqEzpHX+lhw3Ma3xqePrb0HPxLeyC
	 DATGH1svHrUm3qxqyIlX0ua3Tm+Mjke3lWsDOnBEqgsCG/tIj9HYC9qxzSld1AmS0xjFt
	 m8+Bc290RCA2QL+cGibdFI8T6IifjUI5LEA+ILYMbqTWJALI5VHY7+UpYHawoHTxiuuwE
	 eUwWu9Wfexn5vell2Fvmk3GcHRbOkV1d6mjtkzm/wC/6w68TZRj+dUF7Iu2mOQOavfEXq
	 K34glLwVluwE15FaQ4s/hTKWcspzKRuho+MgloQBhxjKjF7y03UEpwOzu8HcBCpxxdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLnMieZ1;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A357606A33B
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 11:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A357606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLnMieZ1
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so3047506a91.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693505; x=1796298305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJGypL/OATS2U+96YRcXHiRoKHcq4/rzhG6F9CstjqQ=;
        b=pLnMieZ1hT8ans27tjGhsRJmwi4sI4IzNKDgcr+YLBHeYRqoOO8xDAPG73l+EOa0bc
         h02eUeEr27eqLgRceL70AhcODLln7VOZk9vjMW8i+uk3Vl9CddnIIuOqjPrjwgwDUorM
         nlEdeu5sF5bOpCXDi8kaQR6/2EELwuV1nz1QbqERMa2RIwH7Vu0FLt6Vy1jJ5KNtBq5j
         QAGpUqHjlEbt4hGk5aMG1tkKgW/U5ihM9Wv6KxF6zSuTU0lk3s4ZAKQoxWmIN+MfuRxU
         Ci3MRWCnV8ry/2dQQg6n0Ndn0ahTOipnffLtddNzzU+2cimzMBswuF5GbSIOnxoMTggq
         rNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693505; x=1796298305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJGypL/OATS2U+96YRcXHiRoKHcq4/rzhG6F9CstjqQ=;
        b=tshyj2PaKHX8jPgc2XcFA55y8HtyYTRD5Sa6KZNAmaZQMZufgJjy9jRwhXNmipdNFw
         mu2trbOUcFUL1TMsEW+AObazpdgRjbWhOQNdOyblFYLk9TmkPsJsGYtSQn4AjalNYtE3
         V3yTyxqTlamHRjbvfxp6KQ43JTyRi4hhNO10l5TJ9lCQ5Qd2qWns/1HtLtxZ9USEJdGt
         ifwn+JtxySR7VZYPsOgCEtHXbq5FbWjqGT6pSgltvzvPzrgkV4Bktj+NsNGIDCdM68iT
         4oc8mn+OSECFnPRUHAbDGMT4fRe4yPTu7TeG8rw3sjojWo+ct+IW38Q9j8CfGzYmrc8m
         t/MA==
X-Forwarded-Encrypted: i=1; AL+hErE+BScVnYTE0Zh7Vipk2gj2sqQi7Ws5Hwt7upiMgi+urbcxxc8ybpPpJFJKGY4QnLUflD0V+JDjyHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6rSPfMiJ6QLnUxTRspWuBR9NbgRN/5Uj5qzvr0Xdpfd0wGR3O
	UGRDanxuGiJEheswCELDR69nQsUpz0wsXAc5lzRadEiopU7ZEwYvOIG2
X-Gm-Gg: AZFdTZdiCgi18uOxTkEDB+5fGzYo3Rta2c5+uuLgx42Rb+x5Rq4EUJPmNHHCz+R4nbz
	vNp+77ZVBTiUKW/DlF/GEu/zISVmy/WmwgCCo3tnRTv/HofYMLl7OKOJwUvVz/GImNIzOT0ofb5
	izMNxldO886LF8QOa2tlUTFWOluCX7W695augfp+4hXCD+pRYKK6zMFPtaWi4940IOowedjjtct
	3ofw2cQ8YBtzw+xT9ftpXZoyCdnDEnRHUDhLSE1/tPH5Lyk2Fx/P7ltPOO1Haz0zmK/bIIUSz3a
	64L0VgSnPcvwXt7kC708TMjlgNxj/N/2RL0SWzlNUjUrsUeQD98/R8AoscRhp6lFTY3AzRoMWaA
	toJGr0OO4379Xq99EuNNPUDEXtJVlCk2M8zjsAT1mLQHIiKxihWmZ3GrdMIFQpBA/okFJbIOo9J
	pxuyM2vdqluqpAMZOjPgw0kyJaVs909yp0N8ZBZl+Tn9jYHBAqrYD1ZPxTIs0VEGJlQV/CKmKxk
	hNYP5KDyHE0Ngt3kOnEHHLAMLsqY9kKAP50mJ7nTYBseMblJesUIiHZPZj6yOuBpaNWVqYIOmQo
	xhnfG5+piFUEAPi5CDh3wZo5ZiCbB9MN
X-Received: by 2002:a17:90a:e7d0:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b41c9cfc12mr17524832a91.32.1795693504566;
        Thu, 26 Nov 2026 03:45:04 -0800 (PST)
Received: from omarchy ([14.139.177.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm32962809a91.2.2026.11.26.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:45:04 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Subject: [PATCH v4 1/2] iio: adc: mcp3564: Use guard() to manage mutex
Date: Thu, 26 Nov 2026 17:14:32 +0530
Message-ID: <20261126114433.20674-2-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
References: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) instead of manual mutex_lock() and
mutex_unlock() calls to modernize the driver and
improve mutex handling.

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
 drivers/iio/adc/mcp3564.c | 103 ++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 259ac4ebd..3b363eb82 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -498,18 +499,17 @@ static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,
 
 	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_BOOST_CURRENT_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_BOOST_CURRENT_MASK, mode));
-
-	if (ret)
+	if (ret) {
 		dev_err(&indio_dev->dev, "Failed to configure CONFIG2 register\n");
-	else
-		adc->current_boost_mode = mode;
+		return ret;
+	}
+	adc->current_boost_mode = mode;
 
-	mutex_unlock(&adc->lock);
-
-	return ret;
+	return 0;
 }
 
 static int mcp3564_get_current_boost_mode(struct iio_dev *indio_dev,
@@ -561,18 +561,17 @@ static ssize_t mcp3564_auto_zeroing_mux_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_AZ_MUX_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_AZ_MUX_MASK, auto_zero));
-
-	if (ret)
+	if (ret) {
 		dev_err(&indio_dev->dev, "Failed to update CONFIG2 register\n");
-	else
-		adc->auto_zeroing_mux = auto_zero;
+		return ret;
+	}
+	adc->auto_zeroing_mux = auto_zero;
 
-	mutex_unlock(&adc->lock);
-
-	return ret ? ret : len;
+	return len;
 }
 
 static ssize_t mcp3564_auto_zeroing_ref_show(struct device *dev,
@@ -598,18 +597,17 @@ static ssize_t mcp3564_auto_zeroing_ref_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_AZ_REF_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_AZ_REF_MASK, auto_zero));
-
-	if (ret)
+	if (ret) {
 		dev_err(&indio_dev->dev, "Failed to update CONFIG2 register\n");
-	else
-		adc->auto_zeroing_ref = auto_zero;
+		return ret;
+	}
+	adc->auto_zeroing_ref = auto_zero;
 
-	mutex_unlock(&adc->lock);
-
-	return ret ? ret : len;
+	return len;
 }
 
 static const struct iio_chan_spec mcp3564_channel_template = {
@@ -828,10 +826,10 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (channel->output) {
-			mutex_lock(&adc->lock);
+			guard(mutex)(&adc->lock);
+
 			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
 			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
-			mutex_unlock(&adc->lock);
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 
@@ -839,12 +837,13 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return -EINVAL;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&adc->lock);
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&adc->lock);
+
 		*val = adc->scale_tbls[adc->hwgain][0];
 		*val2 = adc->scale_tbls[adc->hwgain][1];
-		mutex_unlock(&adc->lock);
 		return IIO_VAL_INT_PLUS_NANO;
+	}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = mcp3564_oversampling_avail[adc->oversampling];
 		return IIO_VAL_INT;
@@ -888,7 +887,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 	int ret = 0;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		if (!channel->output)
 			return -EINVAL;
 
@@ -903,41 +902,45 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (burnout == adc->burnout_mode)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG0_REG,
 					   MCP3564_CONFIG0_CS_SEL_MASK,
 					   FIELD_PREP(MCP3564_CONFIG0_CS_SEL_MASK, burnout));
-
-		if (ret)
+		if (ret) {
 			dev_err(&indio_dev->dev, "Failed to configure burnout current\n");
-		else
-			adc->burnout_mode = burnout;
-		mutex_unlock(&adc->lock);
-		return ret;
-	case IIO_CHAN_INFO_CALIBBIAS:
+			return ret;
+		}
+		adc->burnout_mode = burnout;
+
+		return 0;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS: {
 		if (val < mcp3564_calib_bias[0] || val > mcp3564_calib_bias[2])
 			return -EINVAL;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ret = mcp3564_write_24bits(adc, MCP3564_OFFSETCAL_REG, val);
 		if (!ret)
 			adc->calib_bias = val;
-		mutex_unlock(&adc->lock);
 		return ret;
-	case IIO_CHAN_INFO_CALIBSCALE:
+	}
+	case IIO_CHAN_INFO_CALIBSCALE: {
 		if (val < mcp3564_calib_scale[0] || val > mcp3564_calib_scale[2])
 			return -EINVAL;
 
 		if (adc->calib_scale == val)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ret = mcp3564_write_24bits(adc, MCP3564_GAINCAL_REG, val);
 		if (!ret)
 			adc->calib_scale = val;
-		mutex_unlock(&adc->lock);
 		return ret;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
 		if (val < 0)
 			return -EINVAL;
 
@@ -947,16 +950,17 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (adc->oversampling == tmp)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG1_REG,
 					   MCP3564_CONFIG1_OVERSPL_RATIO_MASK,
 					   FIELD_PREP(MCP3564_CONFIG1_OVERSPL_RATIO_MASK,
 						      adc->oversampling));
 		if (!ret)
 			adc->oversampling = tmp;
-		mutex_unlock(&adc->lock);
 		return ret;
-	case IIO_CHAN_INFO_SCALE:
+	}
+	case IIO_CHAN_INFO_SCALE: {
 		for (hwgain = 0; hwgain < MCP3564_MAX_PGA; hwgain++)
 			if (val == adc->scale_tbls[hwgain][0] &&
 			    val2 == adc->scale_tbls[hwgain][1])
@@ -968,15 +972,16 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (hwgain == adc->hwgain)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG,
 					   MCP3564_CONFIG2_HARDWARE_GAIN_MASK,
 					   FIELD_PREP(MCP3564_CONFIG2_HARDWARE_GAIN_MASK, hwgain));
 		if (!ret)
 			adc->hwgain = hwgain;
 
-		mutex_unlock(&adc->lock);
 		return ret;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.56.0

