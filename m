Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552902;
	b=zSczWbTNFfuR20bzuAvwo0308Nz0paOqF9unD7tivYdalyTlMTHDrpOv2Q/l2EGL1r4i
	 AV+aLStEBjnITR/cwtF+a++Fgwi3ioJkAYeWuiEItrMeGRlbdk+lofgLrk/yoRj6e3XPa
	 Rp9GiSX0qG0+yPwUidjWRmkPguWSjYOiYwLz4TVo4dLF22MQtAprMDV14PWMz83EuSS8x
	 BgLsM4opitNKJH+XTm1AiRj+kG1cJtGBF5WjLKwJr05wYxzRk/bMrWe3s546keJHqclg/
	 O/csTckp5sHrJaX30KUANkp57arNyVFnOGjnItQVXgZoa7XUXSX6/lmhYs4CVrn5ksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oTz4yJysuJaLUfy3cRuCYqOwsFm6T170lpx6HPpZBnU=;
	b=grjXhB7qdYrZXODnotZVhlSwOgPN+D4kOpMqtInyganU05qDI1uaIuozWGVu1ttajNkb
	 x7A1OzmcJmnOWdk1GFFTdnJhID4WOWgECBdRp7nmppg0R5QGGjvN7DtaOpT76WXkjNw1N
	 AxuWtSyfHP/UpcMCeUXlf57WfonUGC7/y1smEwcjNWld0J55/yA+FqyG7NG/Ow3iOjERA
	 ZXJyU96cXBA44L9H/ven0Q00C51Uru+bFh75ZqgvJhj56moQjZCt3/wNfO2i9xHJh1V6P
	 rcpa9riqJzIDq2LHr0A8HYIKj5AWvDNuIixgMhtw0IPBcRIknLHchbQY3f23UhWbSuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i4cLhX68;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A266606A335
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 20:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A266606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i4cLhX68
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3866a784546so6583095eec.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552900; x=1796157700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTz4yJysuJaLUfy3cRuCYqOwsFm6T170lpx6HPpZBnU=;
        b=i4cLhX68CzuLKinuriyOO7ZbOLSSSujr3bdCgDUMtg6V5QiIXlA3SPNTMtz+VPIdTg
         WNbGHje8wtDLFXqRvrd6FECM7nzJWqAzekY9Ry23AKUDvibrQmBmyfdI16oyoN9/swxE
         d1E1pSniS9U78veGCuGCDuZfXhBlMQlxri6qoRf/PS3h2x1BxtQFC67b//Atp2JJZKsg
         b6fDH1BQtPvY8SGtUpDVyo5ySukyjC13omSlzS6a9AOWgV2DrD6hHCGbAKZiPwVNEajG
         JNgYFXUKgmVSZNW5op8Tr90WOrGzKE7ZRGhGFTEmDt5uhnp7Rahu9B//x4yxcqaTOKO3
         jQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552900; x=1796157700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTz4yJysuJaLUfy3cRuCYqOwsFm6T170lpx6HPpZBnU=;
        b=Od4HO3JInm99UUoHePpTf0R6EclGhLQB+7xfXXZ5SuNUj3ywGHbZJvO+dHuZOXjicr
         jFrsyLjz7Zk3q0He6/RwK0PaG7KCK48dLOZhxyBcWC6SOlu3GD/PjW7XOxyW28+8TLz9
         PGzn2dCampeHv8NXlk38geWMMzXsXejLZH29tj+RWA2CNuoFSPdIedY2V5B6SJdkSnK3
         oEcAMFHbWJwod8KShQRCq1I6UQSyWLs6u1fE/l/NBQkic6UEQ100zSPeM4CO+P2j92hU
         s6yZss+1PanKPo3Mb2m8wTAbgK7Rk0H+KYKv/04J6exYPLt9uwYV98JzP5g5uiGG6Dq5
         sHXA==
X-Forwarded-Encrypted: i=1; AL+hErFBUJf3NarENQ9Eb+E9azRlA3SxD0qDuLQ2W8deC4F+xuw9LFGrE7DS5Q6ip5GfNNx09MWVCLNkwyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ufu2DW3PjwXBu9WLJphJxCL17e73JjC27ZpkUUl9Rgk9/iCQy
	McnQNPK6k+p3hUgq+mVsDjcfSQ+JOr8lpXiBDLl9ZRtH1RYRCmktpOxO
X-Gm-Gg: AZFdTZcJtCMOjDLT3nH468L6r8dnjsdN+RgWyohDxg4UsTuXO02tDFCWZEcDqjKdK5J
	gZAcDiqQ4vuD+tWILi91ab3+VIOxcVzJhGaOAlKAl+fNZG9s/VV/SUobas2gwd3QlcDKLDsGD6x
	XLQZb5UW+YpX1mdJpNzJmHtTvV4RyefDU0QOd2zrEQPpt0bDMTU+V0H0vdK49KyXVl6HqX1iegi
	xutNet0WXfaogU4rOKEYb5ZKwKHXJ4xAWZBUwIfPGPaah1pQv+/idNqquifXFa/AyjXHM2vMmC9
	WcJ6eHwRVmtvSHouyZYVpwZNe/zx8UZ8sHjIh+PHj6B3ccc109YYEwuro0298GkzNS7b80MGOHd
	UxcCmSy8Y1lYI/BnPu7bdAfQ51W/FHibs/RRGHjFWF5WxK5kUAsPiJa5o0Plmjr4wJebcvZp/CD
	4YsMQ1xKcQgzVG2dReBtCPT/XBL3jyE8E3O0r6UwQeOjFS0Y6sT/a1QGtKHuxVP+6NauTUDaeZW
	RAZYPDQnTQg5VLesLISpbs4igRIvi7NJSuMLAWNW3gncpkIeeg9WX3tVcJxIT1i7lcQYlJAYKVv
	1LhSfvOGUSZFFqSjXuHZu253LXPLuEKoMmPeau5tRzEfQ3mbug12sw==
X-Received: by 2002:a05:7022:3f01:b0:160:90a3:ca8c with SMTP id a92af1059eb24-1b55689f73amr16833087c88.7.1795552900499;
        Tue, 24 Nov 2026 12:41:40 -0800 (PST)
Received: from omarchy ([122.186.156.30])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm54214420c88.14.2026.11.24.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:41:40 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: adc: mcp3564: Use guard() to manage locks
Date: Wed, 25 Nov 2026 02:10:53 +0530
Message-ID: <20261124204054.85634-2-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124204054.85634-1-vaibhav.chahar26@gmail.com>
References: <20261124204054.85634-1-vaibhav.chahar26@gmail.com>
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

Use guard(mutex) instead of manual mutex_lock() and mutex_unlock()
calls to modernize the driver and improve mutex handling.

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
 drivers/iio/adc/mcp3564.c | 97 +++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 259ac4ebd..310161f48 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -498,18 +499,18 @@ static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,
 
 	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_BOOST_CURRENT_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_BOOST_CURRENT_MASK, mode));
 
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
@@ -561,18 +562,18 @@ static ssize_t mcp3564_auto_zeroing_mux_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_AZ_MUX_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_AZ_MUX_MASK, auto_zero));
 
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
@@ -598,18 +599,18 @@ static ssize_t mcp3564_auto_zeroing_ref_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_AZ_REF_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_AZ_REF_MASK, auto_zero));
 
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
@@ -828,10 +829,9 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (channel->output) {
-			mutex_lock(&adc->lock);
+			guard(mutex)(&adc->lock);
 			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
 			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
-			mutex_unlock(&adc->lock);
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 
@@ -839,12 +839,12 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return -EINVAL;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&adc->lock);
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&adc->lock);
 		*val = adc->scale_tbls[adc->hwgain][0];
 		*val2 = adc->scale_tbls[adc->hwgain][1];
-		mutex_unlock(&adc->lock);
 		return IIO_VAL_INT_PLUS_NANO;
+	}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = mcp3564_oversampling_avail[adc->oversampling];
 		return IIO_VAL_INT;
@@ -888,7 +888,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 	int ret = 0;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		if (!channel->output)
 			return -EINVAL;
 
@@ -903,41 +903,46 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (burnout == adc->burnout_mode)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG0_REG,
 					   MCP3564_CONFIG0_CS_SEL_MASK,
 					   FIELD_PREP(MCP3564_CONFIG0_CS_SEL_MASK, burnout));
 
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
 
@@ -947,16 +952,17 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
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
@@ -968,15 +974,16 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
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

