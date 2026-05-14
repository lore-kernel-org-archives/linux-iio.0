Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4083191CA
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788996; cv=none; b=JflM5c5h6N6tG1AUjtoBHmnbn4B2N/G+3wHAASsnHSsp5e+oyMXldDFc7tyz9knvo0J7qCZ1vaHWPO3GzT0VQzhXvjI9OxIkrbetxsTIGzUxFYS9ceo21DVdvG1EyvsFmCRhqjgUTk/8btg4S61j13ajeDTjLbsL/tk6GRbTKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788996; c=relaxed/simple;
	bh=JyaFkUWgtfBo+oIhi7/QYewpDXo+BM1/a5j4udwAjiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCz4d2GuT92X79kBF8syb01DDU1WkSowtOW0u20cBeKLwAaJtEwSW4E38FZabY1gB2+vJVR1naadZUF17EX6kVq9m1e0G2DcOgsEom0PxQ1JkcyolEPpMBX06ZOQgm8f+RL51NNRcrBrD2LMOQ/LPB8q0bwN6cDYSa0xEqiOF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbYcA7/9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbYcA7/9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a62f43b76aso7405339e87.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778788993; x=1779393793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqdLGbe9sGAYV6Jg54APm3n/EVTOhUOxE0f13Hm3Zss=;
        b=MbYcA7/9+LdtAu5vOqfqScpNiyb07CMiPQwP8E3r95Ly5hFJXixVtn1m10qN1doydJ
         2HDym+RlX6X9h0VVk10nOSc2PpTwjNx945oscql6p7tIcnD9Gn82kB9wmKm2CAVR4QFA
         lTsEA//5EV04HlaWGhX+Pyw00+QEyAtDVE7M22/sSoFeaphqLMCha3x/px0OX3SFt6NP
         8EmBOpmXYR5JtSnsBaP5V1oie1eZXve7BIqeietu27ih5fRTB4UPNxIHtGT1pZZiehHi
         OTszPVOHb4GpJweBLyx0bpJMSq45Zwh54Hu4k4q+zCC2RJ5vKqAQ56xywUHf1RfUbGzi
         gFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778788993; x=1779393793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqdLGbe9sGAYV6Jg54APm3n/EVTOhUOxE0f13Hm3Zss=;
        b=KRx+jYIPnkqelhKRhmssxtASWi4oCS9OwQVj9EvF4evzi8eEx8yiXGd0Ycz6Yaz2mw
         CX6KYP0aIcGSDx+kXMid/yd8NbUDi1Ab7+NWRF3LR0oAgdOtlX+ekytsf9kML+sOs3et
         MOhTlaWmYJynSOvZYa81Fm3NhnnjtJJTujg0eVYO2m9yd7/vURUTq70deEZQNdYTTE0N
         jjN3LVyRj/50PTQKplscoXnPB0xI3fSZ2Wh9v9+Ds7rKvC2ge5CzlBOqgmRpOhDIRfTv
         yO8Q70by3IMVWqPi36LpYsfXIWfjvbkHBg9vaJTprX9fxgyoyocvUs7S9gaMFBnsPGS3
         gTOw==
X-Gm-Message-State: AOJu0Ywfq77Ck7K5o8m6+tBrOke8y9J1yCSdUYPjlLw42Azmjm3i1HlO
	CNXEE6/FPlS7Hx1nLmK9KwGQTKObse0jEurvO1tMF+KFbnBmPwxSXNsMvSb7tTL/
X-Gm-Gg: Acq92OFFDoJr7F6CerOrkanVcuSeK7yDpnOjVUo7Feg+XHw4ItQJMzYFo7DElRQGU5D
	OXbB6Sbc9jKIXmZbQLCxcOtxM0i1mrEetIeBUaH3KTxOVUwVfR4hljWFo2tp72er/3/Zs9K1kr9
	HD3SPuEXdixmtiaFWe2Ma/Gxuy41r5US6MdICm8xfqR+4ejVSg85fiPx8bYytCuYF3Gqh6u5IHP
	FfwoJBkQtArLtL7yHTiwhAaQf1gXifhlReMsE5cv5U2zYr0xB4SuA/euDVGYADqLK8EWkP/qzz3
	4Anbg4dUd5RviKOvLgrEuq5e+9TToUN0wsi3hROCgK6IhWQhTqIOT9ad6RkvaiU7SWFT/gM0nEW
	bMybXpS4Qz5pgVU/ryyOJX9GGjJp2OiH3DLu6iFx369up1T3gCoIGcoUAhUtCEmWyqePb+DVRDL
	sVW+UWB6sq7tfdkHtcuFdJhTlYTz0hE/9DRygPJdYi8erUbbeTeugUd2PeCmskmBAU
X-Received: by 2002:a05:6512:4016:b0:5a8:e5a0:e0f4 with SMTP id 2adb3069b0e04-5aa0e6133femr155683e87.12.1778788992644;
        Thu, 14 May 2026 13:03:12 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc166sm682710e87.46.2026.05.14.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:03:12 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: health: max30102: Add timestamp to FIFO data
Date: Thu, 14 May 2026 23:03:09 +0300
Message-ID: <20260514200309.1597-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The I2C DMA read buffer was not aligned to IIO_DMA_MINALIGN, which
can cause issues on platforms with strict DMA alignment requirements.
Fix this by annotating the buffer field with __aligned(IIO_DMA_MINALIGN).

Replace the plain processed_buffer[] array with a packed scan struct
containing the channel data and an aligned_s64 timestamp field. This
satisfies the alignment requirement for iio_push_to_buffers_with_timestamp()
and ensures correct layout when the IIO core appends the timestamp.

Add IIO_CHAN_SOFT_TIMESTAMP entries to both max30102_channels[] and
max30105_channels[] so the IIO core knows to expect a timestamp slot in
the scan buffer.

Capture iio_get_time_ns() per FIFO sample read and pass it to
iio_push_to_buffers_with_timestamp() so userspace consumers receive
timing information alongside the intensity data.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/health/max30102.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 47da44efd68b..447c4de8ff4b 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -24,6 +24,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define MAX30102_DRV_NAME	"max30102"
 #define MAX30102_PART_NUMBER	0x15
@@ -106,8 +107,11 @@ struct max30102_data {
 	struct regmap *regmap;
 	enum max30102_chip_id chip_id;
 
-	u8 buffer[12];
-	__be32 processed_buffer[3]; /* 3 x 18-bit (padded to 32-bits) */
+	u8 buffer[12] __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__be32 channels[3]; /* 3 x 18-bit (padded to 32-bits) */
+		aligned_s64 ts;
+	} scan;
 };
 
 static const struct regmap_config max30102_regmap_config = {
@@ -152,6 +156,7 @@ static const struct iio_chan_spec max30102_channels[] = {
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = -1,
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static const struct iio_chan_spec max30105_channels[] = {
@@ -164,6 +169,7 @@ static const struct iio_chan_spec max30105_channels[] = {
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = -1,
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static int max30102_set_power(struct max30102_data *data, bool en)
@@ -253,7 +259,7 @@ static inline int max30102_fifo_count(struct max30102_data *data)
 }
 
 #define MAX30102_COPY_DATA(i) \
-	memcpy(&data->processed_buffer[(i)], \
+	memcpy(&data->scan.channels[(i)], \
 	       &buffer[(i) * MAX30102_REG_FIFO_DATA_BYTES], \
 	       MAX30102_REG_FIFO_DATA_BYTES)
 
@@ -298,11 +304,13 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 	mutex_lock(&data->lock);
 
 	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {
+		s64 ts = iio_get_time_ns(indio_dev);
+
 		ret = max30102_read_measurement(data, measurements);
 		if (ret)
 			break;
 
-		iio_push_to_buffers(data->indio_dev, data->processed_buffer);
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, ts);
 		cnt--;
 	}
 
-- 
2.54.0.windows.1

