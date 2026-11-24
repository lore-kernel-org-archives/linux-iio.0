Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552905;
	b=vUVR8IcqSrtkUOL2/yi3593bpoHRWMHv9KC13NEFNoEFo6HI/sidnU4oOTVUEUU5scD1
	 /9J+mee59AzidEyxqlxn2ZR5oU7GZ8bJh5c4wOmau0kc2/urt7i6uwIsogs5oQR1GUHaL
	 VQsFGUKRmBuWanrI3Yigsacakna8Ww5OBzWAHJHUHIk/jr0qqwobCISraM22Q6rBHno0M
	 RygRBx7Lq9KBxbzp6PHTYxXoYVYwqO4EbM5wkWEDg/BJDkl4nbebnu/PI6w/420pE2j4M
	 MNEq2et8tOtGAta29F3/Sgw7IeFynQdJcwSKgY9ZA+JFzyGekOngaKECEwxBqUVu9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=osL2M/19coEMUU7Ga197ggH9O1oVOsCvfp/GhIbgW+g=;
	b=YPeTa2h1Xp4EW2aHbU+2hTF162xDDaY/WttAut9XPX664BpA8vemiFcddha/ch22xxec
	 +7Laex49y+bft1b6tngRWaTw1BehRNnzll+i+V9q/oB3ke764TNwd2fL8NXqq1fmy7xCx
	 TMgINLJQvuhmd+F4K4Vr6Dj6CdoB7S+aqlLPCGuGkiof3Lc7kAl1i7hapH1QacvOnS0y4
	 p2sHUQ16sifwP/8mD5JYI1+6XYFoTrjNIPTayE1fAvxA9l/2MlH+RU4x14HxFcJ6kEqJ9
	 qatudnkH1i2cuZC6FVrrGE4iocSGJVjGnKQ3yXzIp244iZ38VkEJ8sMgII+qIO5xYrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y4I55EeO;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E2606A686
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 20:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D85E2606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y4I55EeO
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15dd124bbe7so5558089c88.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552904; x=1796157704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=osL2M/19coEMUU7Ga197ggH9O1oVOsCvfp/GhIbgW+g=;
        b=y4I55EeOMZw0jTdWULjY9+XX+QbN5l0/VaCsw/JK9z0sSrIDTeW5rkktvkwE8E4Dwr
         3NGauEwYfsFm2F6zNy3EP1uhV0sCTz6IPTjQynEJztipaclXCTQ4CmsnjYkGm+IZ+wRT
         wHIVY7ynTSUHZAsMZ0uFR0xTENhnYmQEqWECo9BA4gyldUPxDfJ4S4wDzv6RtkxM9pOs
         67IidjdpSmi/XZEu5sNlLpCqNBad0qEdGcI6OSWPhwZJWO9Hx22uoyxS41HuWtmQb/Bq
         YeoQBFMDQGxiKrkHwqPF+N31edRsE0OoGbLIimJYPx61MTOPpQlJY35esa47xASsUhaC
         zR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552904; x=1796157704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=osL2M/19coEMUU7Ga197ggH9O1oVOsCvfp/GhIbgW+g=;
        b=YimzUVto0n4DaHH2LZBPJhEr6vQvdScqlHRmkiZIHfU5j8+ckX3qzqlwcnKqJBwRnG
         K1Pr3ItVRUgLXq4un//0yOR/RGQV68siD4Y+Q9anQcTwPN0jAottku76giniCSduGNYO
         edmeUdn3mrqXCslnoTUr+yqQB4VdL87alPxQRvyMUrvYdjYhnPzs8ZRzRXvFBYmo6tfN
         0hG/drIJmZwVfZX1G5pj5Y+uNoU98BdhiXGEZ6BNZBg9uu8Mn363B7VqUSUA/bvDfj/h
         GFEohCp9UyGZLcFj3CgOOJvLnXK8ybIWzYDoV929hdmQa+SxJj1Jsf7Hmxlmu39gYq9w
         16LQ==
X-Forwarded-Encrypted: i=1; AL+hErH4opcweNrc/N1GOiDYvSjIAuRTiY37CKSrXYEUIjAqakrnJ3ZaTLD22wGfwvhNpY4vyGPlF/JFK8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dLfb5Ssm4T+/fDH9MQLBsNTzmuIKiz3a/5Aret/c4raf8WMLf
	uX8gtNP0164CK6u6Ar+1mI+WAePAgdOMvrf6VgKfanisgo90tKoQRE+n
X-Gm-Gg: AZFdTZexWWcSncN1GYlBykFsn5DfFUZHSyU/2buO6Hh9baY3tFdZdkU250P2rJHoCka
	7E9WnDdUIrwfALvQ1ZqDlaca++sQAkgaYBF8FUUeicoVikDtDU9yN0dXqklZB3YjH1DBFWlWN6x
	RGOLBJQ0CylgrqpptHvhdI/uSzkJ42yBk0pNNEJosbQ8GlwlrL0NNTYfyp218HIeTMx9Wr6JRJy
	RGDesPQHm1P9kzHEKCEo89R6pttjA3f9/mN4D5ap/Z1BHcz/IoGS7AGhVMZdlO/qBJsmGEwwZ/E
	j7OGDa8XKuNKI4AweCP29p7KcOwwq+0DxPejnXvKIy65UmqA5bqkPVU91tQNpc7dzrih6hOHu44
	CCD0VXqeI3/aNdN59i/5l/j/BCW8x4Fv+wYimtwykYXhwi6OP5vzBhK11PLMBhDIT7KXAqFr/V6
	Lp7woiHU9wCB5VKpPNdGdmc1X2STOBCrau3b3oXXjTW7bfMxb5VsAkc6s6JUkvXfh59cyD09QhF
	KN4Q2U/EhIWBvW3N7dJKC8+fWhkC9dio5PZykNNCz+2vGiAsbi+orfAtG4hAlG1JIF2YCacpSKP
	l34wxyoPX4tjWPUbR+94R0/zulgicPOe
X-Received: by 2002:a05:7022:e80e:b0:1b5:3b6e:e1ed with SMTP id a92af1059eb24-1b55690bcf3mr18577671c88.32.1795552903922;
        Tue, 24 Nov 2026 12:41:43 -0800 (PST)
Received: from omarchy ([122.186.156.30])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm54214420c88.14.2026.11.24.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:41:43 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to manage locks
Date: Wed, 25 Nov 2026 02:10:54 +0530
Message-ID: <20261124204054.85634-3-vaibhav.chahar26@gmail.com>
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
calls to modernize the driver and simplify error handling paths.

Made a new helper function palmas_gpadc_read_raw_locked() and called
palmas_gpadc_read_done() after it so it can still run before the mutex
is unlocked, allowing the goto and labels to be removed safely.

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
 drivers/iio/adc/palmas_gpadc.c | 110 +++++++++++++--------------------
 1 file changed, 44 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f777986a6..00541e58a 100644
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
@@ -538,6 +539,29 @@ static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
 						     min_offset_error);
 }
 
+static int palmas_gpadc_read_raw_locked(struct palmas_gpadc *adc, int adc_chan,
+					int *val, long mask)
+{
+	int ret;
+
+	ret = palmas_gpadc_read_prepare(adc, adc_chan);
+	if (ret < 0)
+		return ret;
+
+	ret = palmas_gpadc_start_conversion(adc, adc_chan);
+	if (ret < 0) {
+		dev_err(adc->dev, "ADC start conversion failed\n");
+		return ret;
+	}
+
+	if (mask == IIO_CHAN_INFO_PROCESSED)
+		ret = palmas_gpadc_get_calibrated_code(adc, adc_chan, ret);
+
+	*val = ret;
+
+	return IIO_VAL_INT;
+}
+
 static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -548,39 +572,16 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
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
+		ret = palmas_gpadc_read_raw_locked(adc, adc_chan, val, mask);
+		palmas_gpadc_read_done(adc, adc_chan);
+		return ret;
 	}
 
-	mutex_unlock(&adc->lock);
-	return ret;
-
-out:
-	palmas_gpadc_read_done(adc, adc_chan);
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
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
@@ -740,18 +726,16 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
 	int old;
-	int ret;
 
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		if (val < 0 || val > 0xFFF) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
+		if (val < 0 || val > 0xFFF)
+			return -EINVAL;
 		if (dir == IIO_EV_DIR_RISING) {
 			old = adc->thresholds[adc_chan].high;
 			adc->thresholds[adc_chan].high = val;
@@ -759,20 +743,14 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 			old = adc->thresholds[adc_chan].low;
 			adc->thresholds[adc_chan].low = val;
 		}
-		ret = 0;
 		break;
 	default:
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	if (val != old && palmas_gpadc_get_event(adc, adc_chan, dir))
-		ret = palmas_gpadc_reconfigure_event_channels(adc);
-
-out_unlock:
-	mutex_unlock(&adc->lock);
-
-	return ret;
+		return palmas_gpadc_reconfigure_event_channels(adc);
+	return 0;
 }
 
 static const struct iio_info palmas_gpadc_iio_info = {
-- 
2.56.0

