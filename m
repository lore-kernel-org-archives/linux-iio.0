Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985173E9F9B
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060600; cv=none; b=m0zldhmuZh7DHEeoUKmPZ6kvnLp88ykC+QU8iRkNvkrBH6QEl7jULoTlqmTIMpF8W8P08xHQbcUntj7lewudPCmHlpq7hjx21fvOezd0hWjQmqQ3Ee0DMhJxOkY0ciTlnxawHsowQ/nirHuY3YQW1i/XoyOqqpzIfN7wdIHohK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060600; c=relaxed/simple;
	bh=2+rjlZIRA63grEnrCctTTX55LWNNJVSjsZdCutZlPVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsVVS+rE8vHVEWbeusWtjrWYYMu81he/TaASZ5Imll4ajquBBH5EV6T3brLbiZmnG/6EIMyBjhc85zhfGu8dzD4A9aPL8931nrZAZYEZpOYMK+vfRH1XaTz2Lxwi8tCAYnNfIfnOsmrsK44RENTEI8ToYSJgNlAwGSyTgU0PjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGLOgrfe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGLOgrfe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0046078so54227145e9.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060597; x=1778665397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//fZv9m4aqiXRdm3cWQw41INGXka3X8pR0Na3eJTV1Y=;
        b=GGLOgrfeIQ7nEaRWqNEYSUWe40e/uYKDrgFj/6QGLqhcmq1e0kRkx10AChI3JlyY3Q
         MTINxRWLMQukBPG5t18olNklFOVuzYkUM5OO8sg0hwci6hOFhY1WmsoKQ0+19G8pDZIh
         RoDtSOGWMF/bNFlc9zwgmONRwoi9myIzXjERLV9nDKFDvuzFZtZ5AQYKKkh1FcYjbNS+
         mOmDGHFfEWTy9jgMDYGYWksGqmQ6cvtYcqWm1ZwTjCIS+ydCy3XfgovlKTziL/3D+zzg
         KqyWjaWarZ59VvA/hVzIWd6nwcAKX7plB5+6R8VuKReFnfkJBy/LoT9by+Con8He676j
         +DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060597; x=1778665397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//fZv9m4aqiXRdm3cWQw41INGXka3X8pR0Na3eJTV1Y=;
        b=QQbwFGLJuZ8I7CDi35lpFHjnJNoKU05ob+P+/azB8QiT/mLWnycEVjW/RuIV61VpHD
         G+eCHKJb/S+Vp1Wx/BcAEOhnJlrf3QlN92ooFwHV3hU8yAalMjcl36Zi9KDQT6lvHsRz
         LLgu8COT//jlLUaK5xqLZb9qtiGvVxNH9Eqh0CfA6mp57RUv5fweFvJnh6R/fgLgL7Hb
         XGwlJ7vt6J3gcqrakoGq70Ko+CqLf0Ti8xJmlbEIp7gD7dfa6goM8qHeUItZmAxc9Y1z
         y7JEWmYtZhyjsr4DDp2xZGmwrv+GxYfBroELozL/iKp+kbdcqjUQVU5iQatXz+F6CXtD
         K42g==
X-Forwarded-Encrypted: i=1; AFNElJ8fk9ctRx+FRT8WYE2sIZp4PPvieJwWV/N4H1iBKVQUx59vesvD0eq+oYIEpYF7s2Lf3hRaM6iXics=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVdRYsA5HmQ/M1zgYoZQqQKismaUILzz/vkqpl3WD9YWJgAZ+
	dTZaWSuleK2PZfNUYaCJtc3J+CIVhofbk9XmK1me+hiyZ97j2b+KeY3XHwxg6A==
X-Gm-Gg: AeBDieuQpjQQpUkqNPYd2aaQKL/4TaWsLG4ys8bwWEPuqWjIXwd+E+abDX4JDNPALco
	HlnE1nEsFa3JLolz25KxXGDeZKuKtwseFoILKovva5OHZrHNOS5jKnw/HiCQJ5tm2/KQM4DL3Ao
	SH9wEIzjXg4GAQS8/aNJEzUNvxwUe9cpBW96gwTgwJub/Vio88/FfMf/LYx02L2bIxW80JT9HRf
	x2Vs54bLlFJH90FXO+Qfy59THxaK9/jVuuLZTLBCuDZH8TT/cJyddeqyDBlKO3MhX5wHyjvCT1z
	6e2mVvdnS/TmC5K4qJOOcJqWqxRlii/ge9TDjPbexA/sUkdPURBBZxNsZvFQsnnm2g/4y7q1f9b
	Bxs48MBJ/muW2Fa/XWwEtlZ/DOl+Dy236JMNlJSswcAT42OUXa0a3PgAjlLiqPqcIsef+QRYeVF
	0t5klaPHF3LttKuq1+4TsTEb1xXKyki79aZQLnbdBRrmrTDo61E0z4kD5YRdx8ZfhFIIQP72864
	Q==
X-Received: by 2002:a05:600c:2e0c:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48e51e0c833mr27253085e9.5.1778060596883;
        Wed, 06 May 2026 02:43:16 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524831cdsm12362230f8f.5.2026.05.06.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:43:16 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 3/3] iio: light: tcs3472: Use guard(mutex)() family over manual locking
Date: Wed,  6 May 2026 11:43:11 +0200
Message-ID: <20260506094311.222500-4-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506094311.222500-1-aldocontelk@gmail.com>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert tcs3472_read_event_config, tcs3472_write_event_config,
tcs3472_write_event, tcs3472_powerdown and tcs3472_resume to use
automatico cleanup with guard(mutex)() instead of the old manual
locking method.

Found by code inspection.

Tested on a Raspberry Pi 3B with a TCS34725 at 0x29 address.
The following fields were read and written without any issues:
sampling_frequency, integration_time, calibscale and the
threshold event interface.
The unload of the driver works cleanly.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/tcs3472.c | 39 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index de51eb61f42a..90552f47a373 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -393,7 +393,7 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 	int period;
 	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		switch (dir) {
@@ -404,18 +404,17 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 			command = TCS3472_AILT;
 			break;
 		default:
-			ret = -EINVAL;
-			goto error;
+			return -EINVAL;
 		}
 		ret = i2c_smbus_write_word_data(data->client, command, val);
 		if (ret)
-			goto error;
+			return ret;
 
 		if (dir == IIO_EV_DIR_RISING)
 			data->high_thresh = val;
 		else
 			data->low_thresh = val;
-		break;
+		return 0;
 	case IIO_EV_INFO_PERIOD:
 		period = val * USEC_PER_SEC + val2;
 		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
@@ -425,18 +424,13 @@ static int tcs3472_write_event(struct iio_dev *indio_dev,
 		}
 		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
 		if (ret)
-			goto error;
+			return ret;
 
 		data->apers = i;
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-error:
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int tcs3472_read_event_config(struct iio_dev *indio_dev,
@@ -444,13 +438,9 @@ static int tcs3472_read_event_config(struct iio_dev *indio_dev,
 	enum iio_event_direction dir)
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = !!(data->enable & TCS3472_ENABLE_AIEN);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return !!(data->enable & TCS3472_ENABLE_AIEN);
 }
 
 static int tcs3472_write_event_config(struct iio_dev *indio_dev,
@@ -461,7 +451,7 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 	int ret = 0;
 	u8 enable_old;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	enable_old = data->enable;
 
@@ -476,7 +466,6 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 		if (ret)
 			data->enable = enable_old;
 	}
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -580,15 +569,13 @@ static int tcs3472_powerdown(struct tcs3472_data *data)
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON |
 			TCS3472_ENABLE_WEN;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 					data->enable & ~enable_mask);
 	if (!ret)
 		data->enable &= ~enable_mask;
 
-	mutex_unlock(&data->lock);
-
 	return ret;
 }
 
@@ -722,15 +709,13 @@ static int tcs3472_resume(struct device *dev)
 	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON |
 			TCS3472_ENABLE_WEN;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable | enable_mask);
 	if (!ret)
 		data->enable |= enable_mask;
 
-	mutex_unlock(&data->lock);
-
 	return ret;
 }
 
-- 
2.54.0

