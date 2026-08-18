Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1746D0A4
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052882; cv=none; b=IT9qqUGw1rAVNfnbQ1HQ5lswHUaGIDzdaxeDFuCn11cGaZzq5AzBF8SANewuZ35eX37hHnD3ivTH9um2aF3lyErUjYpWtYAp9SG2XbXMKu9VEADrLirJlIClMQaLFs02CD/U8PIo3rPyvzEIf36PL60m6VS23DRUSLk3yDrh7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052882; c=relaxed/simple;
	bh=K16GBBNquIC2qzGSiHgzgtQbVN6shjltxfkR/Pe9NdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQhbexfDAOpDmo4gmI4W2U+58/8SZNNOJn15Hby3OxTyK7/y/j9i8WTiNoS9a12127YqsSAVyiha2J6u7Mczs7s9gP1z/HX/isu9gxTP/opwGGXBHDx6954az9IDoBJe8Sg0ufm4rKXJvk8Ykq/KuckGcWWwZjVyD9tZQvsyFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ4yKUJi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ4yKUJi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c16794450aeso584545266b.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052879; x=1787657679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rPJLPid5VUGtJzdjf6ogs9lORjakAAyd0gi2Bx70eo=;
        b=iJ4yKUJiZ746paopKKS2GZJ9HdEPTiD8TlcIft+IH2IRVBNAArjV7hkukMGo3qsIch
         YWsDg8sBnWN/OwYqwXgcu/S96kA7oiglXTt+qZvOXlBxB2JOClmQFU9mWz6wPdpnqf7I
         BBaaG7DOjBAlcKCUBqqaKwo3NzoaCFgd8VbbpO4pj6fXYeVVX7/Z/iNIraIqcAoo8Z86
         urX8wQ2EcsZzVj6n6urBqF0OPsnY41+eILQkPpwdF8L3pgH5wyVPmELujVKcOhSPkuAs
         AAxvEE50F0xB8QYB2v0QaI2NC+HXv0hDrKK19zqllONfTipkzRfjH3/vSbb8CAgvJZ4Z
         +hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052879; x=1787657679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1rPJLPid5VUGtJzdjf6ogs9lORjakAAyd0gi2Bx70eo=;
        b=tN9NTeADvvO5c0iD5MHlcMcTUhUGt7M4g22dQC298zyyGKTXInUb3/PDeJCn+S2xUp
         nmD03swsUY6/ur9Ms1qxvRleVMad/zaoPLVnSgzV0vEY3clNf0D04ckoAAzNO9CrxZKQ
         ZlHKH8pAzMqlKJ0oHDpUdERWgTS6T34GbBu7cfKYp8txwVKQTF1mMig+YWbznXRSzgzc
         f+4SLGHy4gp2+sTbq7kcztbYEx96iHQNoOCmiNYF7LXnmEJ+OldhOho9tlPwJtBZxFYH
         PKZblWigU0Hxh6nEbIZiNbmO7WzkkAOA0EAYfWzl2LaKWN1QtsehMOHK78+v2FkHoW1X
         zNdQ==
X-Gm-Message-State: AOJu0YwhDhqhaMOjsKcNYjAqTj0+krvfH6vUUnTgqfF0nZ5EafaAsujh
	8+jC2VCa47TU4UwWuC/Gh6Bps0Orc9dDlwFCrN1eDPGd8yCkS2t0Cjc5
X-Gm-Gg: AR+sD12MTVfpiLFSXtZ1X18kVfRAWeE10Kmum5smpcXXXsRJLLgbAHu7Qdg0cuF5GnZ
	5vjDO4oziGzmxtWbSAIinWZ2LG27Wj8j+rEbYvNkFUmOvlV4rVOaS5SordDE8EbnNqqLY89AUBw
	3U+kp6RrcP07C9dBJmF7ypETuESPvWPqN0IiqxMSRuASfgvPm6c40AhmCtt7NdIlotLhA9rIiJ1
	jbPSOdVr59bKkQO/OIuilK/kHb4Ulsrf3i3ORa8nOKlwbWjwde3NH/nlmF4GdR3dIjjt/OcDriI
	fNhepKCgQ41ON26A8MwISGfEzI7e7ipk/5t7JQShloU+ELGYhXSL5TNBjsdVcCyCzeIjl4Dt/PS
	blPBpDIsaBGgswcZ20rWWqKlsc+MSr3ohKY+OTQUS2J8AMDwbgVbpleuLJprAU+ypJ92CxHZp0B
	aF2UhkyWtGw8raxFWvQweJnfzgnHKgtJ6EuqMPO6B15C+Kg56LNw94qryuvX2poEdY8UT2E/uYA
	77MxxxKTcBCfFCr
X-Received: by 2002:a17:907:3d4d:b0:c15:ee0d:9a32 with SMTP id a640c23a62f3a-c2188a9ca9emr505442466b.21.1787052879170;
        Tue, 18 Aug 2026 04:34:39 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:17a:e1ae:f7c9:8a7c:d206:62fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b73db1sm137901966b.40.2026.08.18.04.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:34:38 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 18 Aug 2026 13:34:28 +0200
Subject: [PATCH v7 3/4] iio: light: veml6031x00: add support for triggered
 buffers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-veml6031x00-v7-3-2b0de0f20edf@gmail.com>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
In-Reply-To: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787052868; l=6166;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=K16GBBNquIC2qzGSiHgzgtQbVN6shjltxfkR/Pe9NdQ=;
 b=mUn93/RcpAFopKrWy4SlTY7QTrzpovWR4DoZoAlhgxsa93MheL+T6shtr6gtySHCx1ltc0tnq
 pvkrizzXKubAE16HUYazZbjQ8tugqVEcLbVJWq1s2wOZ85RVTzdXr7F
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Add triggered buffer functionality for the two channels the device
provides (ALS and IR).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig       |   2 +
 drivers/iio/light/veml6031x00.c | 112 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

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
index 348bc28859d6..e6ca98414a01 100644
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
@@ -482,6 +514,79 @@ static const struct iio_info veml6031x00_info = {
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
+	unsigned int i = 0;
+	int ch, ret;
+
+	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
+	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
+		ret = regmap_bulk_read(map, VEML6031X00_REG_ALS_L,
+				       scan, 2 * sizeof(*scan));
+		if (ret)
+			goto done;
+	} else {
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
@@ -571,6 +676,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
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

