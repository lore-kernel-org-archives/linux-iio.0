Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005035674E
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110754; cv=none; b=o27ii+pfQ2tmQT99o2MK8mqse7xbQQLu9dOexFvPgwKMfxKi/v+tzaVEO1LmCPYFipgCJkpA3eT2tMMQqEot5vkihDd1tg9CvRUqf5lyyzc6H3sG0coHwQEyT8Lq3w9YyO6NRBMxSueMdXEJYIzqI8cATJwUPZrTmRTHh5kGffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110754; c=relaxed/simple;
	bh=nGPW/Xf9IcxxowoH00WX/4TQBZQa0xEMX/JkrGRyPu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik12OMdo6NG4qReHraUB2FsFf1bZrnDbN0hCqsbk5a7sWvsq/0ftFx86lvVCZ3oTg1zssv5h5HPDtirIvIBv2T/FPpL3Xs5H5pXaNGCOvzZj2hCLsCDd58Tqv06hb6lRKsLSNHbGcCaZfZkyzCMJ9X+aOxprM8qeNPtor8IBZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrUAB6SC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrUAB6SC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fde295992so1776601f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110737; x=1786715537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p5hTRZ9L+NP9Zln6CIY1plhBe3Xn8XeTKDItuo0Wyks=;
        b=KrUAB6SCp/olbYXylJQ6Q8YgsFN0Iznll6U1YjDFEU5mutB7/++iG5VrIdiwxXbECM
         ddYA8UY/LpA6POPHPn8XiRJWo76G8cdeIWF2cmdJ+00wPJ/cr35oiTCZCB0VxbjAiPgX
         IXuB9T/ecuDNL7vkL+XGjrWnzj/TuQPcNru7qp9wP5N3+fUnrsoEcRm5UyKW2sxEo4M9
         T1w4rOSYxvwFTVLXn0Tg2c645Laa59+HHp73akqEYaxt6lGFXk6hHLSOqYBQLEs0qx+j
         w8hZBOCP4UMnbioNObuu8N+6rY94KIfK7W/MQjzF1eNu8RsLcd5JhHAyJeIjKW4ln8EB
         lpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110737; x=1786715537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5hTRZ9L+NP9Zln6CIY1plhBe3Xn8XeTKDItuo0Wyks=;
        b=c8u2ahFVg4h5Q/AH/S36HSXpzn5k5zkp+O2Jnk+wc+yVK1JjqTo/8JHkOh/Vm2CTCv
         FCuOxpseowOEeFwZym13iCpBesOtHvfHykqMQ9rtnQkIyiHsTux5LXh6x9mZfBag1Ofv
         e+IodL8T6x4b2fn29bCAzYF7H/DAS7dsFYRWIeYnc6XZ2rgNAp2eCwLj5WqZghsTQZfH
         dN7PLWqyO9oDOlI9CNJ0GCGOnlAxYHw1xBfi2RZfkRd3aqxs4+kt1zvomb41eQPr+omR
         IwILmFyp9VCXOAJLYeMQmv+H043rZXqzuoFgl6XamkDK/XP0H9uplT5tTBJwI8ms6Fde
         4wWw==
X-Gm-Message-State: AOJu0YwRz8SbdaxCF2hBMY+zl+X2yncN9xkUZbNT3rzA+6ygWst/VAIK
	eIpZvvSYtTRTT5JFzl1g8ncf9JPW0fkNJcgp3gwKioNSccbV4tsdUC3S
X-Gm-Gg: AR+sD12watYS3eb9onyc2DvobLMG/t3ioJEZTjpPYGSRV719Iuaey/Jt12xQJAvpA5b
	YqKPoc9Npe+L2cQNffUjcxR4bdjN/dPNqPksnSZC5vJf/7QMyqSM7zCO/UE92woyKy1C0EdEIHe
	cpfG1Vx5ymyHdcbDbNaP2DJDGkmkNLFEscShbvN/VkHzfKSgsx0jnsPQc779TdDQobo7Uy43ib9
	xsXf3IB6ElwWnssQIcFs3czHSrB8v7kRIXdhrxE205GaR00+htDvD4v0bfR7hgtA0gLV/I3lK8i
	9DZZB43da5g20UkVs/G3keW1UEHTy9Xt0HErEzgsCzc7LVHJmLAqNQAB4mLnzjK7wPsYm5bp6kN
	tnBD4nOCJSTpR3dH2wSfyumF77sPItJYvK0WOG2WURKOcKO/zAoDOqOU0tC3vY7WS6DuQ3gGJ8z
	5IhmQqJgEJfoNYSDUMPrz7SfGZGdE50hBbYT/WBxOFsEd2wpiQRG3bQrssRQfZd/vXq+jrFA2Q1
	cm6ZqbaN+bURLB/MnzlLkvzDrnD
X-Received: by 2002:a05:6000:40dc:b0:47f:e7f7:370f with SMTP id ffacd0b85a97d-47ff4e5a82cmr22168039f8f.10.1786110737330;
        Fri, 07 Aug 2026 06:52:17 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:13c:7c2e:7f0a:5759:2e0d:bf8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8b09sm6581333f8f.23.2026.08.07.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:52:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 07 Aug 2026 15:51:54 +0200
Subject: [PATCH v5 3/4] iio: light: veml6031x00: add support for triggered
 buffers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-veml6031x00-v5-3-e60876fb3640@gmail.com>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
In-Reply-To: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786110728; l=5240;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=nGPW/Xf9IcxxowoH00WX/4TQBZQa0xEMX/JkrGRyPu8=;
 b=ATbRd/h9NPsNfjL3VrLhq0JJwgOZbXPSgtOCDwxJSx+2YkakmbfIReoT9LajtrJhcEOcDQ/l9
 WG+miWYxcZTA39BHuOeeWTUwDTemdvAww3Xl3Iniv3LhSnajhvLyR51
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Add triggered buffer functionality for the two channels the device
provides (ALS and IR).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig       |   2 +
 drivers/iio/light/veml6031x00.c | 100 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 985b776e71d6..397b3e0d4408 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -742,6 +742,8 @@ config VEML6031X00
 	tristate "VEML6031X00 ambient light sensor series"
 	select REGMAP_I2C
 	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML6031X00
diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 30cccda51ca0..0cccd40d729e 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,8 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 /* Device registers */
 #define VEML6031X00_REG_CONF0       0x00
@@ -37,6 +40,12 @@
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
@@ -392,6 +401,10 @@ static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
 
 	guard(mutex)(&data->scale_lock);
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(data->regmap), pm);
 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret)
@@ -453,6 +466,10 @@ static int veml6031x00_write_raw(struct iio_dev *iio,
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
@@ -484,6 +501,81 @@ static const struct iio_info veml6031x00_info = {
 	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
 };
 
+static int veml6031x00_buffer_preenable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, it_usec;
+
+	ret = pm_runtime_resume_and_get(regmap_get_device(data->regmap));
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it(data, &it_usec);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(regmap_get_device(data->regmap));
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
+	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 2);
+	unsigned int i = 0;
+	int ch, ret;
+
+	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
+	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
+		ret = regmap_bulk_read(data->regmap,
+				       VEML6031X00_REG_ALS_L,
+				       scan,
+				       2 * sizeof(*scan));
+		if (ret)
+			goto done;
+	} else {
+		iio_for_each_active_channel(iio, ch) {
+			ret = regmap_bulk_read(data->regmap,
+					       iio->channels[ch].address,
+					       &scan[i++],
+					       sizeof(*scan));
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
 	int part_id, ret;
@@ -588,6 +680,14 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(regmap_get_device(data->regmap), iio,
+					      iio_pollfunc_store_time,
+					      veml6031x00_trig_handler,
+					      &veml6031x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to register triggered buffer\n");
+
 	pm_runtime_put_autosuspend(&i2c->dev);
 
 	ret = devm_iio_device_register(&i2c->dev, iio);

-- 
2.43.0

