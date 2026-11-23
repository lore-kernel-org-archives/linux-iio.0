Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454958;
	b=a+dzxEDxPOlfZQgZzP2X1G929UUPmPZXp+SkUEEXGta/nUA9hL41dJcqVPEHpalp5WiF
	 iIoiOBmUlcAr36+FpAQENW+splV+ISyNPq+oyGBq8IZB3FZrGr6MXTSJfFYiyjt8h8QOw
	 b6NKjjE/W6Yp1u50jxOPA/iibJfUNfvrsR+TuNvRqf3gry4wlA1C6tFb8xUw9k88RVX1D
	 as/rptNTmP0W6Jy6FaJ+sDttG8Z8xIGq6IyNPXmlnpdn7I7z8mA9G+na3w2SUJcpFjB2L
	 +Gys94jzQ5euiAMzO8acDURSXk66foLlxeDrCV158E1GuKFwlFdy/4WHLqKrYTBudVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7LTwfbafZgGIQPY1hJ1oWnepZBxy+zN8S1xyEXfSU2w=;
	b=ggEmAZp29gw0x28/Nb8GRYZHPgrV8QxMZAlsfesQHK0mzWI7vf1bIfL5QdblJ9Q7qg+6
	 daf2GJYLRWXLAeq5dg2Yad0eBzCVsMTJmTvUWTTKOcML3gw1Ic3aS0nz+VFymAfJK1Mbd
	 p/qMbifPv6HB6QnGSeXxEiNRO8i6NoJuaINkbKOa8k4BaCqk2DKRa4cEgjybXsRZjSR//
	 eHLVuN/ADwERgICQPAqAi/zGPUiwBwBWqwc/iCd5AwpiE8B9DSRwuJKLbk8Tg4LwSFGCz
	 /tP4Y3IVR7UYkigJ/ooC+aKcf3KosESGt4k94QjsIuRalC/rO+rAZoh8C1HYQCuBLMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LWSnHekp;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428E606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 17:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4428E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LWSnHekp
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1716946b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795454958; x=1796059758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LTwfbafZgGIQPY1hJ1oWnepZBxy+zN8S1xyEXfSU2w=;
        b=LWSnHekpmFN8i/+LL5R4/kj+6GCY2H2qwNIFckvSuw1Kxh9XgRWL8PMr8GpCIWki7i
         PGL0at7FzPG3fDewTTvdD3u6NeBydZ3bvjlCZAaWMF9fK2vEp6LtSAMy5mS6K+g7u37c
         DF9gNbJNFwt3ChPkbWMPgk707VhzL3cHngToVEOsaPgGyhK7HrxUwlpjRdE5HcbRoE7J
         XwamrQ1pLH3WpTxFVlX9Bi5huz+RrGOWV291PO2MyysWVs9j5cWEbClHJYNc/bmJnZ+G
         FW1+JfQIIy3MBoWYh6yrhIirQYSm0TC6nDYTqzy6Q9I/GfGdd4Qqw2AVoZLervY8ghAR
         +L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454958; x=1796059758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7LTwfbafZgGIQPY1hJ1oWnepZBxy+zN8S1xyEXfSU2w=;
        b=E1K3WmPifi6zukJqBGoiX9SkDbBIWkqLb8gu5mmLffvrktVyBwyO/Q0TtYxPPOcAzi
         uJ2HjJYGuOw0pa8zx7Esz8erArAx5yk4/jq4p+/zOUggp8CfkwxPl68Kb672GH5UaXrm
         ts6mHKZ0PXgqZIktT1Fjx1uFMPA2K6IhmuCDC8532h8ODGoiuN5545Hdv2/E4FniqltN
         fjUQMjbu/K5jP6Wjr60YNGji33176lt+vvMLeiH4JtPTHcMgHzuaMJ7NSe+6rDH9rPMT
         4d+kjd2qgksma120L4akDoLmhcnZ31GoJaOBOF5b+eJG3g+azy1/tohJO6SeearggDLI
         QzbQ==
X-Forwarded-Encrypted: i=1; AL+hErFCqr9pGg7f0cQhdtnh7KEdqdCjOJKl/Txps/seh6nwvFkWDEmVc+sBgayfAb2yh5a3Djhv+79Jusc=@vger.kernel.org
X-Gm-Message-State: APuU4Z96WYRPSoDxoyDStSsNcGqDHcoVw5CvSM6NEMMJU4Nnj2Tc/oPc
	YQ5PxAFyZBE++8HKhIvs2wxycjYfQX/YudDsyRBPwPJ8sh77Nwi9LkKc
X-Gm-Gg: AZFdTZdcyL7HIzymwoJUZYvpaZ2Hj04Np4jm4KyFrUJWYYc2p8v3DTb6/Vb7hrQSqRE
	ze2gKvPbcFkdyR5XqJAPiEFxefbyGnPfxuPVYLRlCIXoyK5Cs1AFODKIshDLsAG4NpcDmKtNKx3
	czxQPPP7CutyShH/j65AJilaeOtnEB5Im8P6ABcn4br7A+a8Ht1tqLnvp6KzLrD1gyGaNahiLB/
	E5BWl3RElSbU1pO0eSoX7OpgYRy1XL36zPdbS/IDuE7/1s0hW+h6fikZDRqG9mtxa6IkFX6pIST
	IktmzX5OXSsgfnVBRnqroFVPhkNRwaA2vwjVdOzMwjzlTZlPGvpKYJIZu5fsux+t9kKGM8ySfHU
	ZN6e9Lx7PCco+g7WQFPmOVDx+AzAiGLHlyzXxF0Vwf0QgHpogVy0ugQyy9oGx8j9RUUSSy39pjD
	VMCXiKzwfX4bvjTi7P2+YpxtG5YuFXnPXGdPTuQJp9lAVzAxYzP9Qr2CbhU064Cp5U+rbmmVYV5
	2losfSTAVhAJ8MUx1vYVBRLMZOYRA0905crJvUtinYEhnHXWevSjTnHTUqE2ysZeSDKOF5YfzsR
	Vnx77XvUzHgLryEQri6eB/emuMzMA7Qv
X-Received: by 2002:a05:6300:614a:b0:3e9:27a0:e9bf with SMTP id adf61e73a8af0-4014cb3952bmr10918154637.23.1795454957588;
        Mon, 23 Nov 2026 09:29:17 -0800 (PST)
Received: from omarchy ([122.186.156.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm5552489a12.13.2026.11.23.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:29:17 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: jic23@kernel.org,
	marius.cristea@microchip.com
Cc: crofts@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to manage locks
Date: Mon, 23 Nov 2026 22:58:36 +0530
Message-ID: <20261123172836.130440-3-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
References: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
 <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
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

In palmas_gpadc_read_raw(), moved palmas_gpadc_read_done() into the exit
paths inside the switch block so the out: label can be removed while
preserving hardware teardown before unlocking. In
palmas_gpadc_write_event_value(), use direct returns instead of jumping
to out_unlock: label.

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
New patch in v2.

 drivers/iio/adc/palmas_gpadc.c | 46 +++++++++++++---------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f777986a6..fc528fc0b 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/mfd/palmas.h>
 #include <linux/completion.h>
+#include <linux/cleanup.h>
 #include <linux/of.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -548,20 +549,23 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	if (adc_chan >= PALMAS_ADC_CH_MAX)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
 		ret = palmas_gpadc_read_prepare(adc, adc_chan);
-		if (ret < 0)
-			goto out;
+		if (ret < 0) {
+			palmas_gpadc_read_done(adc, adc_chan);
+			return ret;
+		}
 
 		ret = palmas_gpadc_start_conversion(adc, adc_chan);
 		if (ret < 0) {
 			dev_err(adc->dev,
 			"ADC start conversion failed\n");
-			goto out;
+			palmas_gpadc_read_done(adc, adc_chan);
+			return ret;
 		}
 
 		if (mask == IIO_CHAN_INFO_PROCESSED)
@@ -571,19 +575,12 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		ret = IIO_VAL_INT;
-		goto out;
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
-
 static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
 					  const struct iio_chan_spec *chan,
 					  enum iio_event_type type,
@@ -596,13 +593,11 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	if (palmas_gpadc_get_event(adc, adc_chan, dir))
 		ret = 1;
 
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
@@ -685,15 +680,13 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	if (state)
 		ret = palmas_gpadc_enable_event_config(adc, chan, dir);
 	else
 		ret = palmas_gpadc_disable_event_config(adc, chan, dir);
 
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
@@ -711,7 +704,7 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
@@ -725,8 +718,6 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
 		break;
 	}
 
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
@@ -745,12 +736,13 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		if (val < 0 || val > 0xFFF) {
 			ret = -EINVAL;
-			goto out_unlock;
+			return ret;
 		}
 		if (dir == IIO_EV_DIR_RISING) {
 			old = adc->thresholds[adc_chan].high;
@@ -763,15 +755,11 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 		break;
 	default:
 		ret = -EINVAL;
-		goto out_unlock;
+		return ret;
 	}
 
 	if (val != old && palmas_gpadc_get_event(adc, adc_chan, dir))
 		ret = palmas_gpadc_reconfigure_event_channels(adc);
-
-out_unlock:
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
-- 
2.56.0

