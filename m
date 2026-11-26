Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693510;
	b=lEBHKOkikea6g2ZXQdVrp9Ot5CIZaGoUivXFXhtg0nTRKeUP6mq5dmImZJ1eqOYszQt1
	 idq9Ut/HDwXS3OpRNIgaMxEwkYk7oPme8USvdBlfIjPFbQqM62PVnmDgCNBbdinRxarwU
	 xqobZg/AO/c2xoWCq4SDXxu21jQJvwZxNpyN1JMFAW8lJ8X7Jf7DTHLe5bpV9XDoR4JTj
	 ehdRp6FZo8907xfDO5A+JPdrUpoq52S0L/3ofMqA2HO4mJniLW9S480fxmFcIHeKp2BvF
	 g+G31BpPwfFA2CxkKv9oWl39TpZfNzupLrdnOTzJWm1BIQNCwrpSsbaFEAKGDb6rlGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4pyUXZ88CM2WlQwTXEmpnQUn1K2PGCvOHFGbd3rwe64=;
	b=PyIEHIOuaSIz7SAgROuPmE1inZ1y1LbeK7zr7tlysyhNMiyOF2mTh+Y6gO8SpzxEcYJh
	 BCrKg00NRKNKuk1j4YnZhNpBvvuZqaZhj+TZhgBC4/wSLtodVxZp1wh3nBuXwkwc8Ur52
	 aaVzZ4xu23VXzUCP9831AQl/LTXxwwkAVSfBBLxAjWEWRAoQLIhMJQbJoZJeha8EEZ8Ah
	 vdpSzps4/zkuKlMRDg4z9GLnDCpuof7j2fFSVIJV/YOvwidwWuPll616WEfTZfb9yVuk/
	 b3Ilf0flCyQWJ9vEvb02N6INFI8FBbegY/pFVvUmbCRz4AsDPAAr2KIcnQScrPVp0mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DIGPzkW2;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D39606A32C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 11:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D39606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DIGPzkW2
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3937824a91.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 03:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693509; x=1796298309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pyUXZ88CM2WlQwTXEmpnQUn1K2PGCvOHFGbd3rwe64=;
        b=DIGPzkW2RgccK9gut/XTKCAxEP4RZv/kvOosAwDDIFRyhZBXfFxZTFmiNeZfiL0RV0
         O0XRxPD/rgIAiOWGfoigtvr01ccteEdlmIdwSu/HmL0e1jxSrvyqI2AqYwb4OcfYL8MT
         6bHdYK6ZgWw8PaJ5ZPrUbdgLapC0gutTHw52z1n7tznmDKS7rR/QIvjEHyJd43H5Gb0t
         Y4wYzmTvVAvlVqYvtnBYQ6PUMi+ErlWifcWlv9wTeoHzS/aLRxYrnZVEFQT7FkylXSlC
         ndKfq+CUs5Ni4B/sDGYAL0NILn4wIi1zytyzbLxfoLaa24oeLoy8TQgiVpfmiu9FtA9f
         uMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693509; x=1796298309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pyUXZ88CM2WlQwTXEmpnQUn1K2PGCvOHFGbd3rwe64=;
        b=sABZU9xTXw2saOXquXH5r2QKr9r8gHmWZUdXKHxV09/V8B0DnSEywGn1mzaZ8hIuPi
         KLQ3/L9L/PKNWAScgiOqObat2Jby6REVIgd3ijX7udzvlUoV0xcQ6oOQQGaRuc1stV3o
         hux78BkqCnhQiMx8x6sFICrQGGZuDd+f5xlh8iAS/GvfuCLl8lVi5RXLNzhAz7c09sIq
         hajRNLeHIbbW4/98zRlnuiQBZwZwGwMrWXNFtjzzmNVdDJ1rVQ+KqdEG12wSnY5HZS/x
         HBMGAHzPzLUKm47DKdB9H1ldpACsh2UDJsb8TEJJKkbckOviocHBz0vjLVgAG5UYl3nm
         W0BA==
X-Forwarded-Encrypted: i=1; AL+hErEE6seUGghxdMOWfq+JnHPLaE670l7Q2Np5BvNRHKCNc23sE9MukvXslm6yPJ6e2Qnw/iREB+yOG9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DkNssIjLtGwvGQBSL6ZUceYP9SIXz/aRb5lbGtC8x+AHzcTQj
	wOUf2CFOnqvlbzubWMWigV0KxZ1lhlZqmDMyK8pcgrkBykY/fqaVk3widMdnCyhL
X-Gm-Gg: AZFdTZfpqqmIJKg4I9L/7jYYJSHhaqN9UINvMp3HF0Pm1YJR+06N3sP+WbRNSC4EiDB
	JFM1cCLiqczZ97lO2RurQ5p9avhafskQcerYlNf51rfp8uRRZZ5j/zkiuLxnvCFfVg+hvuOQnWp
	b0+sEKd/28y35P4lkgyMfZrwoWeXcmElnInO/xxVduXu8hFg5CkqaTqbnJltH3FKcYKhLYon31I
	rCUEK7/ywEc2AhrUftG28crorJeMWsTktrPNcTb2IIRrOS7K5AdAelBJfUiMaSt3KCeoT2Jx962
	wfpKYqScqr0JRT9DkNNV6mzWmkZZ1qUA4s/ag20Bi3VPifUUldKefuuIWHmtiS/6RszlhqOhOE2
	ovkRpA8/hmFi75VnsgVUc5lS+vpJc11nMK/nqi21+1pAPbH7Ter4WJc1qfONre0Wq6Cy9KqFTXK
	GZ2uOsjC3eR/MgNVs4NroXoDFpxdpqDJ/5nWI2J+lX0N8HhsWYJ+RJXJICW/s4YpiQAIPErHWgk
	8bRIcPFdO3ArI/hwaXuwEqEO1MbzGfGcZ+dFRLRqC5Zi6p/ScAh2cLT5/ylQKv5gE8TbIl12T8M
	EceS2C9CjZHTqBypfnXuW6Mewxderwx7
X-Received: by 2002:a17:90b:2e4b:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b41c8e0ce5mr13005582a91.10.1795693509391;
        Thu, 26 Nov 2026 03:45:09 -0800 (PST)
Received: from omarchy ([14.139.177.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm32962809a91.2.2026.11.26.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:45:09 -0800 (PST)
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
Subject: [PATCH v4 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to manage locks
Date: Thu, 26 Nov 2026 17:14:33 +0530
Message-ID: <20261126114433.20674-3-vaibhav.chahar26@gmail.com>
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

Use guard(mutex) instead of manual mutex_lock() and mutex_unlock()
calls to modernize the driver and simplify error handling paths.

Made a new palmas_gpadc_read_raw_locked() helper function which
calls palmas_gpadc_read_done() on all exit paths before
returning to palmas_gpadc_read_raw() where the mutex is unlocked,
allowing the removal of unlock goto labels safely.

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
 drivers/iio/adc/palmas_gpadc.c | 126 ++++++++++++++-------------------
 1 file changed, 53 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f777986a6..fa1526e31 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/mfd/palmas.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/iio/events.h>
@@ -538,50 +539,50 @@ static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
 						     min_offset_error);
 }
 
+static int palmas_gpadc_read_raw_locked(struct palmas_gpadc *adc, int adc_chan,
+					int *val, long mask)
+{
+	int ret;
+
+	ret = palmas_gpadc_read_prepare(adc, adc_chan);
+	if (ret < 0)
+		goto done;
+
+	ret = palmas_gpadc_start_conversion(adc, adc_chan);
+	if (ret < 0) {
+		dev_err(adc->dev, "ADC start conversion failed\n");
+		goto done;
+	}
+
+	if (mask == IIO_CHAN_INFO_PROCESSED)
+		ret = palmas_gpadc_get_calibrated_code(adc, adc_chan, ret);
+
+	*val = ret;
+	ret = IIO_VAL_INT;
+
+done:
+	palmas_gpadc_read_done(adc, adc_chan);
+	return ret;
+}
+
 static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct  palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
-	int ret = 0;
 
 	if (adc_chan >= PALMAS_ADC_CH_MAX)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = palmas_gpadc_read_prepare(adc, adc_chan);
-		if (ret < 0)
-			goto out;
-
-		ret = palmas_gpadc_start_conversion(adc, adc_chan);
-		if (ret < 0) {
-			dev_err(adc->dev,
-			"ADC start conversion failed\n");
-			goto out;
-		}
-
-		if (mask == IIO_CHAN_INFO_PROCESSED)
-			ret = palmas_gpadc_get_calibrated_code(
-							adc, adc_chan, ret);
-
-		*val = ret;
-
-		ret = IIO_VAL_INT;
-		goto out;
+		return palmas_gpadc_read_raw_locked(adc, adc_chan, val, mask);
 	}
 
-	mutex_unlock(&adc->lock);
-	return ret;
-
-out:
-	palmas_gpadc_read_done(adc, adc_chan);
-	mutex_unlock(&adc->lock);
-
-	return ret;
+	return 0;
 }
 
 static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
@@ -591,19 +592,16 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
 {
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
-	int ret = 0;
 
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	if (palmas_gpadc_get_event(adc, adc_chan, dir))
-		ret = 1;
+		return 1;
 
-	mutex_unlock(&adc->lock);
-
-	return ret;
+	return 0;
 }
 
 static int palmas_adc_configure_events(struct palmas_gpadc *adc);
@@ -680,21 +678,16 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
 {
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
-	int ret;
 
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	if (state)
-		ret = palmas_gpadc_enable_event_config(adc, chan, dir);
-	else
-		ret = palmas_gpadc_disable_event_config(adc, chan, dir);
+		return palmas_gpadc_enable_event_config(adc, chan, dir);
 
-	mutex_unlock(&adc->lock);
-
-	return ret;
+	return palmas_gpadc_disable_event_config(adc, chan, dir);
 }
 
 static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
@@ -706,28 +699,21 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
 {
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
-	int ret;
 
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		*val = (dir == IIO_EV_DIR_RISING) ?
 			adc->thresholds[adc_chan].high :
 			adc->thresholds[adc_chan].low;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&adc->lock);
-
-	return ret;
 }
 
 static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
@@ -739,19 +725,18 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 {
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
-	int old;
-	int ret;
 
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	switch (info) {
-	case IIO_EV_INFO_VALUE:
-		if (val < 0 || val > 0xFFF) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
+	case IIO_EV_INFO_VALUE: {
+		int old;
+
+		if (val < 0 || val > 0xFFF)
+			return -EINVAL;
 		if (dir == IIO_EV_DIR_RISING) {
 			old = adc->thresholds[adc_chan].high;
 			adc->thresholds[adc_chan].high = val;
@@ -759,20 +744,15 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 			old = adc->thresholds[adc_chan].low;
 			adc->thresholds[adc_chan].low = val;
 		}
-		ret = 0;
-		break;
+
+		if (val != old && palmas_gpadc_get_event(adc, adc_chan, dir))
+			return palmas_gpadc_reconfigure_event_channels(adc);
+
+		return 0;
+	}
 	default:
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
-
-	if (val != old && palmas_gpadc_get_event(adc, adc_chan, dir))
-		ret = palmas_gpadc_reconfigure_event_channels(adc);
-
-out_unlock:
-	mutex_unlock(&adc->lock);
-
-	return ret;
 }
 
 static const struct iio_info palmas_gpadc_iio_info = {
-- 
2.56.0

