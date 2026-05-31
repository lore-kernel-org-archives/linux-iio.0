Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EB33BBC5
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257522; cv=none; b=iqMocZ5efNAHILm6m9SF1tU8empL5LQZBX7ViHFrhebRb/AMhExlnKLZ1mIN9DTAVZa9gp4B05YtEfVQvJ1sJQDByEZLB15mWrm9w5JobMvvVF7CyQztrQTvs7tyWMj1PvbyyGKzM9DxqNBwvrQzZCKxUzW9uRq3mxHzwgFy1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257522; c=relaxed/simple;
	bh=3rMinnWkSWj8Yetpk6Terpb21cTv9q5faLaxxlD4tao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBe2uSmu57rCzYhNHJmmOq7aKnxQ8CidHXmOtON3rmG3rXtKwbNDnJGLzppReeue8nLOZViI9mHbbuQmgX5zm24dtO0G2iggTutluRQwiMHLv4dIQJHtMNiCUSTN9XiE75TGUyiP1BooIzAzldMD3RpxRHGfb1fWTOL4XqI4lGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyyqinfU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyyqinfU"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so1334785f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780257519; x=1780862319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RLJzSgogYFN8Zeh81kPrNPCUIj/QxMt/6mfJHqzi8Y=;
        b=PyyqinfU39OkDyLazwJCGI09ckLTvqPn4g69DpwHeMdchaxre2Bur9q8t/Zoojsivc
         UQVApTuKKRKHI8bGjli2lCdsGGYXr8TH5kRWopdtk2jYz/qxHVQBJ9LT0jgrr+36b9Xw
         aItcAmAeyKau2bWqrk5FUSRrzDk18Ud8/XHhIEZSzEk/ez+q0G7FgPFlA7YwiDCyZkGs
         +AVwTTz58MumBz6qA3vx+xbniUDCScNhIYMtwwo6EnkJOnBT4EE9Ge+EaiF9ooBGC72j
         FCgnMaEAX1eMEdckuizo6cuCWpK/7Sf7BaGukUuYkkDHru6WjGEzgdeZS8U26mPS6Dbq
         46GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780257519; x=1780862319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RLJzSgogYFN8Zeh81kPrNPCUIj/QxMt/6mfJHqzi8Y=;
        b=HDxlPn91uLc3W7MsTuwrKg12j43kVw/S3nExSGxWSuS026eHMyyqwQsHEyYeJy6rJd
         JiIuetoTmWaPWuSybp40VhiM5F++t0jZlOgSEjW+op+qEPZxwQiq2pZCgzu6//EA2cTh
         T2jDztVeR6UbaAj7loW3hNXqeIUjTOQyXqG7PNIeVrSuTv5PGh6qDt3gPbkP/oJRcMny
         zEotOfjQ/fMRJZW6ePQEht0c4pt97ER58RwAtgWPUhvmIy8e4D85H0rBNmxYcND1nQHS
         9RhlPvz5JpIfxizqwb+Jnq1RBgC4EKy91ZgYKDN+/dMY+9k11eoYowfbl5XJURZXg6tr
         vmpw==
X-Gm-Message-State: AOJu0YwGTdHc766ZiViKCXO/uGo/yeicXNaq+7I2Gyw9tbbN/iNq7YUO
	lgWKYk0fp6foC5ap1C1rxdSh+zfGIHzAGsYnC2so3TBD/UHfOPpnM9Fc
X-Gm-Gg: Acq92OEO45jZm1NXdEb/JmZb3tdkx8UTtLExSrpj7DcSu/IducgXGfVZNWnBBH6/gmo
	CUFKi0NYy3PyC74SB1JFWezYLNCJrgVnZbiF63EaSwZ1KMnaAwy7ek7zKeUm5spMlK6OBTiQKXK
	X/1DLahBzGFCuFUTq9cVfjvd1e2TidkgHSXOfIMFTcHt2J4VpcdTSBDoVo+1v3gFj+GUZbf62S5
	Sey1hV1PA4kxn+xlsEmdjl8ad+6/VqmqKMgAr2stXSdqDkOmFW/Fsr+XU+/UXElm/xKOvEnkztl
	gEOL1qEHiD6l1M6bPlJ+gTT5bzKxah8T8fgwOZblgsuCuBDfl5sn9KY0mZXp9ouO2bdUfGqbzgz
	wx7HapPG62LLUDevglJoXzWesl3yCGrfwgWoeqdtAk2uOGbLzNz1p0wnCGJ5krYLkw8H0eZHxkH
	6qzRfoV9819u/D+xNm6yqsoGxGfxGgP3sNA9rEKrTXy7u8oZJG7A==
X-Received: by 2002:a05:600c:a01:b0:490:46df:a87a with SMTP id 5b1f17b1804b1-490a2a847edmr152590355e9.1.1780257519146;
        Sun, 31 May 2026 12:58:39 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:152:df59:bc17:a305:8902:fb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm220323775e9.15.2026.05.31.12.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 12:58:38 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 31 May 2026 21:58:23 +0200
Subject: [PATCH v4 3/4] iio: light: veml6031x00: add support for triggered
 buffers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-veml6031x00-v4-3-e64f7fdce38d@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
In-Reply-To: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780257511; l=5898;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=3rMinnWkSWj8Yetpk6Terpb21cTv9q5faLaxxlD4tao=;
 b=bgW5mAvM2uIi2Bcq0yv6vNGjRV1wg7bZm4RdzeK0rUdBHdL+FdE9xtXhDxSomsKi3t86TktKd
 LGzVW3WekG4A/VF4LqSyBfVgkJp5ArRIOUAPKr5C1wgUboW6s9BvkOZ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Add triggered buffer functionality for the two channels the device
provides (ALS and IR).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig       |   2 +
 drivers/iio/light/veml6031x00.c | 114 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 99a6ed80c7db..ff71de8454bd 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -717,6 +717,8 @@ config VEML6031X00
 	tristate "VEML6031X00 ambient light sensor series"
 	select REGMAP_I2C
 	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML6031X00
diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 6f9a7bad44d4..facb1b8e4241 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -16,6 +16,8 @@
 #include <linux/units.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 /* Device registers */
 #define VEML6031X00_REG_CONF0       0x00
@@ -31,6 +33,12 @@
 #define VEML6031X00_CONF0_SD        BIT(0)
 #define VEML6031X00_CONF1_IR_SD     BIT(7)
 
+enum veml6031x00_scan {
+	VEML6031X00_SCAN_ALS,
+	VEML6031X00_SCAN_IR,
+	VEML6031X00_SCAN_TIMESTAMP,
+};
+
 struct veml6031x00_rf {
 	struct regmap_field *gain;
 	struct regmap_field *it;
@@ -136,6 +144,13 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6031X00_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -146,7 +161,15 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.scan_index = VEML6031X00_SCAN_IR,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
 };
 
 static const struct regmap_range veml6031x00_readable_ranges[] = {
@@ -378,6 +401,10 @@ static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
 		return -EINVAL;
 	}
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret)
@@ -438,6 +465,10 @@ static int veml6031x00_write_raw(struct iio_dev *iio,
 				 struct iio_chan_spec const *chan,
 				 int val, int val2, long mask)
 {
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		return veml6031x00_set_it(iio, val, val2);
@@ -469,6 +500,82 @@ static const struct iio_info veml6031x00_info = {
 	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
 };
 
+static int veml6031x00_buffer_preenable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, it_usec;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it(data, &it_usec);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(data->dev);
+		return ret;
+	}
+
+	/*
+	 * Wait one integration period + 10% margin so the first triggered
+	 * read does not race with the sensor completing its first conversion
+	 * after power-on.
+	 */
+	fsleep(it_usec + (it_usec / 10));
+
+	return 0;
+}
+
+static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
+	.preenable = veml6031x00_buffer_preenable,
+	.postdisable = veml6031x00_buffer_postdisable,
+};
+
+static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ch, ret, i = 0;
+	struct {
+		__le16 chans[2];
+		aligned_s64 timestamp;
+	} scan = { };
+
+	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
+	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
+		ret = regmap_bulk_read(data->regmap,
+				       VEML6031X00_REG_ALS_L,
+				       &scan.chans, sizeof(scan.chans));
+		if (ret)
+			goto done;
+	} else {
+		iio_for_each_active_channel(iio, ch) {
+			ret = regmap_bulk_read(data->regmap,
+					       iio->channels[ch].address,
+					       &scan.chans[i++],
+					       sizeof(*scan.chans));
+			if (ret)
+				goto done;
+		}
+	}
+
+	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), pf->timestamp);
+
+done:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
 {
 	int part_id, ret;
@@ -576,6 +683,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
+					      veml6031x00_trig_handler,
+					      &veml6031x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register triggered buffer\n");
+
 	pm_runtime_put_autosuspend(dev);
 
 	ret = devm_iio_device_register(dev, iio);

-- 
2.43.0

