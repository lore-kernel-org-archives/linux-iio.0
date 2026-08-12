Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64C39937C
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566481; cv=none; b=bj1hDZhwMiutfSMn3STeEu+Cv1ZDOi4Ds/YHbZU2oxzRcqgW8JBDU+CU3bZ+rZmjJclJPLUTQ0umRBgH+mr0eoUUmiJSl5C7/rgNkaA6D3A2IJXHbuaID8IdK0dqtWd3gOyhZm43I/fQ+C3nl+NL4Xg4mCuV+9gPNl7V/oZomAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566481; c=relaxed/simple;
	bh=mZWcrlYjY//9rQAddGilLIxqCK5ZjF6fhciasIp8Ero=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6vkLRBurlXvSCCLiRSxD+snBxRlFRV0GMgeVbIQTJGF/B4dFNDBTBtDbXI0KmUalGnrxU0VvxjL/i/oCCL6dp4jKs7cmRUFoHZMYMOUojHsaNNiRr8AdpMhBK2B68pUxkWEO/PLv1tkprRzNjFZQX/p9fzUN19nYigfQBTOvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QETLWmc6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QETLWmc6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so1552975e9.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786566478; x=1787171278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c68EQofm7oM0lVUYZUc75pHfBtTFDbVVctq7EgUpEL8=;
        b=QETLWmc62iRZzOHDG5TdBhiLi6z47x1fkijpsKge+seqOvrIHrlpQ5vm6v/l/y+SS2
         jDilTpdfAHi/ywGmlx7xEuQu5Kt2yDmiZnKiz+oH90homq5s+zQkwSDQNYotRAUnAy5Y
         6Vy+eZmqGLvt8VamYXVCIECO8AESVxACLEEGrpDV9lre+i8hoJPM4o8Ax7ZIIgSZgu3y
         A3rrHO0vA0CQhNPrbH58Bhlm1CMLX0Vld6ZokUL9+jPDb2FkQlcVmIYPaVLxUrXOG34d
         PF4p2dIqDlbrwGA+y5jcEc3Tu3T8h42bRDWJle9G8kTWsjQwUt0PVf240HrN+29lFWzA
         5h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566478; x=1787171278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c68EQofm7oM0lVUYZUc75pHfBtTFDbVVctq7EgUpEL8=;
        b=iedBh7LiUL5S3hcMXik24RqbFBF6emIMhsuNr1xw9RGpDABXfOZUZHz/fOu3VpjWGr
         8YV/VrnIy/gXFP74X3JkFr7sdGrqRJ+79/FbZV1QOPPiRixZYi/1ufFnQfv7uV457eNs
         3o5meXyT/kiMPVCIUXRK41G6xXWh4XJcGv+ZODLmzM5INTqWkDiNpkbSooXcsuvmyZKb
         CfMmuYC5iUQMS4VVxPa3NBxDMO2rMzmp6GUpgq/4yQDnRZDRM0Cd7kc8slYzI6KamVHA
         FbObSS9oRjkND0HH16LIJloMT+yrSmqrkQHoGW+uXWepqiAa8k2D4hxhdPKzERLmhcbN
         LJvw==
X-Gm-Message-State: AOJu0YxVpQhLDNxs03xD48yHMxV6LYnZXBk2+w3navoy13U8gw0BN8bQ
	kYm8EHoJPLlFdCkF+EHt6+lNkF0s/RyHIF5GhJSvD/23u6gM1DQI0cfZ
X-Gm-Gg: AR+sD11RhO2WJUDCsDxCe2Wr05I18JD6U1n1Xlil36kTErt40f9Osm6kd3oUq96R4sQ
	zkVhe4hM70Ksqe3Wpt5ctgkujm9oSq+cD6b8AOc9wuLgH0qJy4NEmAJ5mGZqMGkJbYGJkdvSkzY
	+BNvD/GRyNflYgDeu0oNKHGyIQGb2TIT+dA6f1l2UcqGUEONWaMB3Ht/9yo6AHSWw87UjzskhBs
	reLQ0wgP/FJTEXnuvLU2dfOv9P3Hprm7y7FIRONlK4jUWY7GukNSzT8zeJRcTiPq5LTgBW/qKST
	JDj90Q3O712GMeHZbK9KBpyMRiWnbMXPuI05za5UWxizdXhN6/m4CeLf+Ph4D4Wlh6QFKVFGqpg
	i+RTofghobBsXLCd0AgoviAV76+iFc5gGqHf7NjvwlOtl6lTm/Kw0ga33IQ8/SBeNJ50JSFeWYc
	fU6hdYGvjc0V5hPPjEAmZijRvDCTfJSGfjyV4ZJAhYTNBj+PBaXJUQqM4R7b9AmDZeH7hz0hW7b
	w9T
X-Received: by 2002:a05:600c:19c8:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-4998220c7bbmr1684675e9.8.1786566477645;
        Wed, 12 Aug 2026 13:27:57 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16f:15e0:179c:a67f:8487:260])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b03e70sm13911725e9.3.2026.08.12.13.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:27:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 12 Aug 2026 22:27:42 +0200
Subject: [PATCH v6 3/4] iio: light: veml6031x00: add support for triggered
 buffers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-veml6031x00-v6-3-7eef6e4ce290@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
In-Reply-To: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786566469; l=6202;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=mZWcrlYjY//9rQAddGilLIxqCK5ZjF6fhciasIp8Ero=;
 b=zScNwt7GUsruoRxLmTZSMCFZ+JNKQHf0jKi353MfKqfPQs+KWe7BrsEg/YtV0PxwFdqS8cB00
 7vAwj7Ku2vdD7L3ezDBPwTMInth0OaOLhmX6PgKoRil7Go6pfvA3NaV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Add triggered buffer functionality for the two channels the device
provides (ALS and IR).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig       |   2 +
 drivers/iio/light/veml6031x00.c | 117 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

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
index 021bf726c60b..43a701f62aea 100644
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
@@ -137,6 +146,13 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
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
@@ -144,7 +160,15 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_IR,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
+		.scan_index = VEML6031X00_SCAN_IR,
+		.scan_type = {
+			.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
 };
 
 static const struct regmap_range veml6031x00_readable_ranges[] = {
@@ -388,6 +412,10 @@ static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
 		return -EINVAL;
 	}
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	guard(mutex)(&data->scale_lock);
 
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(data->regmap), pm);
@@ -451,6 +479,10 @@ static int veml6031x00_write_raw(struct iio_dev *iio,
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
@@ -482,6 +514,82 @@ static const struct iio_info veml6031x00_info = {
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
+	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 2) = { };
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
 	struct device *dev = regmap_get_device(data->regmap);
@@ -587,6 +695,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 
 	pm_runtime_put_autosuspend(dev);
 
+	ret = devm_iio_triggered_buffer_setup(dev, iio,
+					      iio_pollfunc_store_time,
+					      veml6031x00_trig_handler,
+					      &veml6031x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register triggered buffer\n");
+
 	ret = devm_iio_device_register(dev, iio);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register iio device\n");

-- 
2.43.0

