Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2D35E535
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563136; cv=none; b=LKxGhZykEa7TAK0Y4zq4QEdsdp2cuhLDV0m9fMQdS1YYC/QkYJNQdPCV86Few/IGAtjn/a32RlujZnGAsEsrUycmM/tCt9XkG6Mx6Ie+rFDjRKu1BOCFqsxFYYzFRkIopYRwmDC2HqC7+XhZ0lOkMesQGi6jmYRr4ojVnLpzr5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563136; c=relaxed/simple;
	bh=IUjmltrTFO4YbZQalOEcuCS0vZJiq0YFeUYJfges9VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtqfVqS1xN/H0PReYNwthnPwmOQS2/sGaVxJvHp0wh2mW3ZcDki5KR6a9CHl7ryQPQg0hT+//i5xex8xjcw6pB9XLcspkh9iaHJlf/e0m2jie69oCylzaq85OeSbsn9OvqLAWhA0Z8Zl7EtKpNZe9yFGUu4ZPe1FF1BoF+MtfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiA7IMYH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiA7IMYH"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so40145835e9.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 07:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563134; x=1771167934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8B3KYHW7oN1cE0ooieHtgCbkDaH2P1LrwaeA4680tA=;
        b=iiA7IMYHlTm7UsKVpJxtp0+YEd2qV0JRCY5IAXOwbKbOAr/R0twjCzQAyLSk4QCQME
         24Z0iCwqUgoaTLjZkQQZDpcH21PtusRoTwYJaA9/8Bcf4FqgO4Bl7djxPPZXdFZTPbrK
         9t8oUqoWm0eszeI95jBRXED9itKkSW9MiPcqZSJXmPMkT0KmbxSX3qtdXxP1MWiiWXmI
         +qEDNRf+dXezY0e+bkQMxPPnsjrGQcJ+N7xd+i+93fto8+skFTERlUQLN532obK0tMlm
         JacxDvUVnPsV3WHdYUPyJEGMe0JAI0+L9As1E8mbKa/a2fMsPcTN381xvtThLyf1gncY
         bgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563134; x=1771167934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I8B3KYHW7oN1cE0ooieHtgCbkDaH2P1LrwaeA4680tA=;
        b=V7q0OwlkFrPmLevUJMp+78YkCSAoqbVXXJwuhlInRVRAfG9aGbmXG4n1/RxuBafuNa
         BCwQYns+TfgFIgw9DwJU5JzLyyMF2R0K1to64wCe65BkoC8n2jR+blJiuo77FFv0+kCe
         wXm7OyqU8eOPbXojXm4YWLD661hLMl4GQVJHpK/PKzFXRcks95yvzqvxZI4uo3Z4NGYy
         QytU1MDvU0Iw3HAYOYTTBCSwDCoT47wkPUhmnS3sWoPIBeSVC48XwQHEED7eEatPr5FJ
         keV8dAO4ZK3PTRAG+gz5dtIFS/qmXmyKZgJsXZruM6PqYdbhXrGRIpBl7FRAEm5dXqd9
         8srg==
X-Forwarded-Encrypted: i=1; AJvYcCUeIIg2VPeO8EufqON6dAg2PkXu7Uaeas6ewq1B09TG6rWDMgV1wYCgOv+yenOxZlRZ7Y3NBZgb4dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6l3ah8vPZpWBlpTIuqOk3KEGVgGPbEUttK/AesQ8Ba5j203Bp
	amgpeK4FcJ4rfW8g3gFR4Rv+RFfiFrdhnOyzIwvgEyG2CusShekGWKkJ
X-Gm-Gg: AZuq6aIofvLuskmDSIpLicRJ/SZG+RmNk4SIPYVW4rVLUANub2idRAqXo2hkDGo9nE1
	X/qm1GZTe4L15M8BmIX9NKYUJ/LmjBsD2j5CszDaOPJRrGJsqtTGedE32FP5z9BDLkHrbY4N1vV
	FT/fbdmqW9SIjHfibW1uwPmK2XBVeSe/V0KWEp8a+tiPLsb9kAcz4En90/iZ++Ppfn3yl5apubr
	T+6bVjrLBCND7G7exl/du7A94fZzxTum47DqQWgOsiIBN5CPbR/DF5i6lVPRTthzeGaml0eKLLK
	5EMxVk3XaFDY3COD/KSHIQyYcvo89nh4YREM9P+AE8cJZ4m70UUnysZL5/Bb0lAqjEUJp+6A9eZ
	8HUUn9EmTF6HFKZNV8zXwaI48H6aie2HM8WwT0EOB6GjP/vFqO98FfvAkSxZGZ/V4/PrOHvk1M0
	eFj8wXDYPCfZ5uagI2oNJN2x8865HjFEdCy6GjRJOd/TdiyrbHUQ==
X-Received: by 2002:a05:600c:1d24:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-48320236b1emr108520665e9.32.1770563134446;
        Sun, 08 Feb 2026 07:05:34 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc7d3sm179326255e9.5.2026.02.08.07.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 07:05:34 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 3/4] iio: accel: adxl345: Implement event scaling for ABI compliance
Date: Sun,  8 Feb 2026 10:05:04 -0500
Message-ID: <20260208150515.14798-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208150515.14798-1-0rayn.dev@gmail.com>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
event-related registers. Previously, the driver reported raw
values without a scale factor.

Implement IIO_EV_INFO_SCALE for all event types to provide the
conversion factor (0.612915 m/s^2) as required by the IIO ABI.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 78e3f799ecc1..dfe3169ffc5f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -212,7 +212,8 @@ static const struct iio_event_spec adxl345_events[] = {
 		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
-			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_ENABLE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_VALUE),
 	},
 	{
@@ -221,6 +222,7 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_VALUE),
 	},
 	{
@@ -228,15 +230,19 @@ static const struct iio_event_spec adxl345_events[] = {
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_SINGLETAP,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
-		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
 	{
 		/* double tap */
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_DOUBLETAP,
-		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
-			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_ENABLE)		|
+			BIT(IIO_EV_INFO_RESET_TIMEOUT)	|
+			BIT(IIO_EV_INFO_SCALE)		|
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
 };
@@ -274,7 +280,8 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
-			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_PERIOD),
 	},
 	{
@@ -283,7 +290,8 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
-			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_PERIOD),
 	},
 };
@@ -1367,6 +1375,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				return ret;
 			*val = sign_extend32(tap_threshold, 7);
 			return IIO_VAL_INT;
+		case IIO_EV_INFO_SCALE:
+			/*
+			 * The event threshold LSB is fixed at 62.5 mg/LSB
+			 * 0.0625 * 9.80665 = 0.612915625 m/s^2
+			 */
+			*val = 0;
+			*val2 = 612915;
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_EV_INFO_TIMEOUT:
 			*val = st->tap_duration_us;
 			*val2 = MICRO;
-- 
2.47.3

