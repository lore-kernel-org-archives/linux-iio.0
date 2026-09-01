Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F63EFD07
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267959; cv=none; b=uBQ5V/tpCMVpVkQJ0SctaLoW9LJaBncaWg/8hImZ8+BMjyXWj2yyYawJ7oq7wr44m1i3qhQgk8v1w1MMSW8F+AVUtiAsZzdICQMG3o9yhVUpbHgvZy4nmMsMCgporlfYBMyO8T+ylMLddwxQ7x1RZF5myGUjtcxFLXL09Q79JmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267959; c=relaxed/simple;
	bh=QCLyoNALvtQOVUWWgKT4N38ewa9Qau0InNlSI5vyyo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPBpPTPCknlwV4FZRqiPraLu4bf364iGcIQsd1gDf/R7NwOpk67Zku3ZQ9DqZum4kfzjWRZ3+4srgYegW9J3gdsEZYq8JnO5di/fiyCEbOHEFKj5wFrKX3NQhB/SgBZvaEoThmsTaWGLY+aEpyx/TTa3by/OqWhySlgkuShYCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR4UxFbd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR4UxFbd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso32230205e9.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267956; x=1788872756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRwhjp/IBhSw3Lk79MEayOHDigt6p4gE2z38qX/b6Cc=;
        b=OR4UxFbdKBzkNu0SDdVz81J1UGsihGFi1tWzeRNij7VaFfJvW3QlVPz/lQIL7ljPPt
         6nmGqq+I0+MEubKBSqcfDtPcRsWq8V+tgnVQGUXReXnXxrc2G36e39F6JpqQnR0PfFzJ
         g3TLW2ljLOPSCdvmXSdHGro4ju9nIakdddVIU2q8n37yos0zXxuO4udw9eRxgsynnjNm
         lxCLckye9alhu2ugm9Fatz4pn71CdSCFcDCNFxnWGIc+IxjFmLjbgiLAGokoDHkplAJU
         sGw264Ey8WEyusZjnxjDLeGVhEPhz2X5gJIH9UG9Pppwpwcv5z4i+tLHUZxXpUMNniOT
         2M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267956; x=1788872756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRwhjp/IBhSw3Lk79MEayOHDigt6p4gE2z38qX/b6Cc=;
        b=QeKdOe11368mHOxPgBPnmetDBM94BvAdzVzWUN0b+62RcCwnmsm3uaNPGB0zX7Xa9N
         4kir3eSRimJrEEpql3FpwRywtIZOQsq9VLmAs3bmiX5K/45LTd703Yi6uYzA2vn6By9o
         AbOqRXCSZ/CAo0ERhkQXVI2jdA7eRa4AlDAe1+cmukIiPJHxIMWuCPEak+6kc7nqeJrC
         q+bkIm2BzhYpzzVZhA68g/KGLaVH2gIXmR1GWScre83zqAPPOa+GZpv7qCEXRhpWi8Yv
         R2PaPx4yX/wB10yFsiLZCcE380FhLZeVIO0rq3wcsOHHQPRlcKzA+pozfh1olg3HL2W2
         a/5w==
X-Gm-Message-State: AFuF++mYVBs1ByX+1B6NrN7LvesoQe+B7xTlzqB+thQOYz623Va0Uoac
	1TxcV42YTaAyPLhcWMCnH6wVPALkkfEEQG/zUOfVSqxDuhOdIselQBd+
X-Gm-Gg: AR+sD110tu9YOO2wzrzxvMsgqmjjVU+S9xBUoN/1YzuX8QNShvw1hLceEMBoE36qy6g
	s+LL0yGwgZ8bxp/mUoHnfwmT0ZUv0xl2EtKqWYW/25Jz0a77oze0I1AiR6rAxTQCtf0JR1HUcdS
	2HwzV7Q0vqsNJ27vfK1focExi/h3HP3c0jkHv4rhonbOUjuO7SxcLGSo1piHZYOCsioRYb4OvDC
	Q1+hpdPsWtnwpH3bE/p9JqSk16alHB3bZheLtdyXxFU5DEHgPAcPMlXR6x4RlyvHPVzZtGJSTI2
	AgyXKkM0s5EWy0qns6CrN9DEC5RLQMMNotckc40MFd/NmsMJTtXeHT3EBsuvQcX2M22jKHla+Up
	KbTyiaXm2vpQv7YKC5CGK/xcnC5gzGW2uT8QajRS4YGYGGSyT3Hn/NixYsw4Tdyp8RfNUM29K2U
	h5Rik1jAsuJHiZoL1sOOT1qiw/Cl2P1keUu49DbTJYUGWsrgJhWjpj8CvkRvDTe/hJ5r1UwwLTg
	xdu
X-Received: by 2002:a05:600c:1d0c:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49b91c3e67fmr489514715e9.9.1788267955403;
        Tue, 01 Sep 2026 06:05:55 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16d:f647:6bd8:c024:aa73:750e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e0desm70343395e9.11.2026.09.01.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:05:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Sep 2026 15:05:48 +0200
Subject: [PATCH v8 3/4] iio: light: veml6031x00: add support for triggered
 buffers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-veml6031x00-v8-3-532cb4f2168a@gmail.com>
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
In-Reply-To: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788267947; l=6221;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=QCLyoNALvtQOVUWWgKT4N38ewa9Qau0InNlSI5vyyo0=;
 b=45pXl1Zmx0cYiDFZJA6neNINiqlrHErKRQfnIhU3kt0Viu2CRV23p8O3PvElU2258YZj8BoqZ
 rtPtRRgezweA+CasR5QVZqH7z1i0GKLKqWF3Ibr8Pgy4+DTPJin2+eJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Add triggered buffer functionality for the two channels the device
provides (ALS and IR).

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig       |   2 +
 drivers/iio/light/veml6031x00.c | 113 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 02291abeff60..462fff1ddef2 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -745,6 +745,8 @@ config VEML6031X00
 	tristate "VEML6031X00 ambient light sensor series"
 	select REGMAP_I2C
 	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML6031X00
diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index f3772577a05d..3d5a27a0baae 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -25,6 +26,8 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 /* Device registers */
 #define VEML6031X00_REG_CONF0       0x00
@@ -42,6 +45,12 @@
 
 #define VEML6031X00_GAIN_SEL(pd_div4, gain) (((pd_div4) << 2) | (gain))
 
+enum veml6031x00_scan {
+	VEML6031X00_SCAN_ALS,
+	VEML6031X00_SCAN_IR,
+	VEML6031X00_SCAN_TIMESTAMP,
+};
+
 struct veml6031x00_rf {
 	struct regmap_field *gain;
 	struct regmap_field *it;
@@ -135,6 +144,13 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6031X00_SCAN_ALS,
+		.scan_type = {
+			.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -142,7 +158,15 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_IR,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = VEML6031X00_SCAN_IR,
+		.scan_type = {
+			.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
 };
 
 static const struct regmap_range veml6031x00_readable_ranges[] = {
@@ -390,6 +414,10 @@ static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
 		return -EINVAL;
 	}
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	guard(mutex)(&data->scale_lock);
 
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(data->regmap), pm);
@@ -453,6 +481,10 @@ static int veml6031x00_write_raw(struct iio_dev *iio,
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
@@ -484,6 +516,80 @@ static const struct iio_info veml6031x00_info = {
 	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
 };
 
+static int veml6031x00_buffer_preenable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret, it_usec;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it(data, &it_usec);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev);
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
+	pm_runtime_put_autosuspend(regmap_get_device(data->regmap));
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
+	struct regmap *map = data->regmap;
+	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 2) = { };
+	unsigned int i;
+	int ch, ret;
+
+	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
+	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
+		ret = regmap_bulk_read(map, VEML6031X00_REG_ALS_L,
+				       scan, 2 * sizeof(*scan));
+		if (ret)
+			goto done;
+	} else {
+		i = 0;
+		iio_for_each_active_channel(iio, ch) {
+			ret = regmap_bulk_read(map, iio->channels[ch].address,
+					       &scan[i++], sizeof(*scan));
+			if (ret)
+				goto done;
+		}
+	}
+
+	iio_push_to_buffers_with_ts(iio, scan, sizeof(scan), pf->timestamp);
+
+done:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
 {
 	struct regmap *map = data->regmap;
@@ -573,6 +679,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init IIO GTS\n");
 
+	ret = devm_iio_triggered_buffer_setup(dev, iio,
+					      iio_pollfunc_store_time,
+					      veml6031x00_trig_handler,
+					      &veml6031x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register triggered buffer\n");
+
 	ret = devm_iio_device_register(dev, iio);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register IIO device\n");

-- 
2.43.0

