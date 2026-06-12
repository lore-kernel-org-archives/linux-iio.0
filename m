Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BC22D4E9
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271101; cv=none; b=Pa6FFjyQq/as7wrVZ7mEnhUJYP2pQ1DncPTAq93Da6+xIuCVRZZ4kLN4eCAnJpjHNQU0SgHTR+PCyvSGrB0ZaS8ldiWhjP5jtpgNYLWb20Tgr9jT2fo7GZTWghX6LF7EDLrvaSXGLYR7BDYmNZ3m+MCm9FcIvOIdkIHvu9hK1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271101; c=relaxed/simple;
	bh=NayzZEP56LJXeu+ZySLJNT/nqxiGsE/qF9noP870F1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMFCjuP/ppzls2wSDlQzvgFDbWJ2h77osHml8H2Hwuv8oi2wun0lSyv8d1SqXr3SgfZ86xU+rv2krBp18pp5DzTVLgnyFr5EzeZ4jYWvthVf6+DCuExx4AA6N6BDV2jWAB4vcuE8UUBnOnL9m6KStyxpm7Kn4WfsbKpXpuIx5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bis-linux.com; spf=pass smtp.mailfrom=bis-linux.com; dkim=pass (2048-bit key) header.d=bis-linux.com header.i=@bis-linux.com header.b=WElNFyHo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bis-linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bis-linux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bis-linux.com header.i=@bis-linux.com header.b="WElNFyHo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bebc80100efso104033466b.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bis-linux.com; s=g; t=1781271096; x=1781875896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ0GYsR9AYUdZNHh1uUFHXvl6cG+Y9gRRyo/afNPA1w=;
        b=WElNFyHoTHrIljUnLQ6URElQ51XlRRPrnj8KMMdtRuOpYGuxphN80pCXzTqyhfwD31
         /l9iqtPyMLxoygAvl5dH5eE8FNUI7Q5RTumREo1FyeDcmKH/FCIrI2Nmbzx195n0sEbY
         S0sCYalltGkhA0JnOHWbNDacGNYN+MCO2yNl+yJgimQw5V8BCwp9R4P/covzME3ilyI3
         kUFQTx1BafV3HHVorydIXs7aN899m0KsQAzsBrSytdll+5ovud31CQutiOHpfFaQNuGZ
         FrNVvh+ooEhcVvg6iq+ZZCDP5DIIdPfuFFWuc5MdVFkxg5olR4T1Zm8zspI6wrj31Zxb
         j4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271096; x=1781875896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ0GYsR9AYUdZNHh1uUFHXvl6cG+Y9gRRyo/afNPA1w=;
        b=E9vtzZCWGLPeid8ny4YfqP1hV1g7k++C2xsR/DOOhlcexcZ4YP/8u4//P288+Py7Zb
         Oz3bMdJF//6vYnc9PWilnfMMcIvgi9rPdX/nFy4vmEQsS28pY4aiWckTvrO3WoOlCxEQ
         MhBH06qhKDZBqHj2ynDyYCgiZ3oIAa+IMosKVx7u572XAQ77PZYFMSDr2xWbmFRloXxl
         efIlI4AFUDpehE7NMaET50y5f4N58PobBPPWgS/w51kUwx38jP9WIxqqbkqcupRQVATY
         EeMdxAw8N+IXx1aJt1KOnhe+H0RxKJjrYmeM84LgODeQKWtQEuh8xZDy9sXIVK9ngDXN
         rMzg==
X-Gm-Message-State: AOJu0Yx/WUsYMveX6dNpFhwQt0FnvGtiII5TMZwtBqSg31SeG9vn9xCB
	icRhcgP9PTs9DnbrSSVrA1PXPA7csATWGHKxvGOIckL+dVBc7eXETuLIKCP4pC1zEw2+bmLhoj+
	O7Lc=
X-Gm-Gg: Acq92OGuECnUF8JGpG3JAOTz61eIOi9D0JOvhe597xfinKVCSqcD7/TXQF14JP/C8ub
	wc9cMm3KqwYRSdlFFQ7jPCTqte5YGIppuf135vI2UGXOzYxWLwX7QfARmAcYAhq/MkCStNmllL7
	wsKAef0FUcNcryjWt4RzBSY0TNiv0EnmxYSxaSRiQ8G1lZIBiCBDWJt5a26QO9bNcfjd852xo5W
	kKSoIRmg2iNtHgoM8jq0wsIo67HzNOlbhcSts4dgGHjk93VyUGxZfMSBsUXwJ2WSJIRcJHvDmMj
	QM6btTuZtSNMI2R2uqkZNZKDe/dY5f5su1buRwShfND4srnPxs53b6LwIWSInwC94nzAdhWMHhe
	h2FTD7hD8/WdzPaiq4O6mUJffNd2wusZ4H7IaV2CoXHxtSSwmxi57EzG7Unx+yiuWPo+PM0ThW0
	BZKeAIiCZYjXcMXrXiMa+KAIrTww0=
X-Received: by 2002:a17:907:e143:b0:bfe:ed16:2841 with SMTP id a640c23a62f3a-bfeed1638f4mr30928666b.53.1781271096427;
        Fri, 12 Jun 2026 06:31:36 -0700 (PDT)
Received: from mbtp.lan (nat.piap.pl. [195.187.100.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8e1db3esm105645966b.56.2026.06.12.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:31:35 -0700 (PDT)
From: Marcin Bis <marcin@bis-linux.com>
To: linux-iio@vger.kernel.org
Cc: Marcin Bis <marcin@bis-linux.com>
Subject: [PATCH 1/2] iio: dac: ad5337: Add driver for the AD5337 DAC
Date: Fri, 12 Jun 2026 15:31:21 +0200
Message-ID: <20260612133125.196208-1-marcin@bis-linux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add driver for the AD5337 dual 8-bit I2C voltage-output DAC.
This part uses the pointer-byte protocol and is not compatible with
the AD5337R nanoDAC+ driver (adi,ad5337r).

Signed-off-by: Marcin Bis <marcin@bis-linux.com>
---
 MAINTAINERS              |   5 ++
 drivers/iio/dac/Kconfig  |  12 ++-
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5337.c | 159 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/dac/ad5337.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..614589b6efa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -438,6 +438,11 @@ W:	http://wiki.analog.com/AD5398
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/regulator/ad5398.c
 
+AD5337  ANALOG DEVICES INC AD5337 DAC DRIVER
+M:	Marcin Bis <marcin@bis-linux.com>
+S:	Maintained
+F:	drivers/iio/dac/ad5337.c
+
 AD5446	ANALOG DEVICES INC AD5446 DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..de2bc2ec2269 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -62,6 +62,16 @@ config AD5064
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
 
+config AD5337
+	tristate "Analog Devices AD5337 I2C DAC"
+	depends on I2C
+	help
+	  Say yes here to build support for the Analog Devices AD5337 dual
+	  8-bit I2C voltage-output DAC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad5337.
+
 config AD5360
 	tristate "Analog Devices AD5360/61/62/63/70/71/73 DAC driver"
 	depends on SPI
@@ -247,7 +257,7 @@ config AD5696_I2C
 	depends on I2C
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5311R, AD5337,
+	  Say yes here to build support for Analog Devices AD5311R, AD5337R,
 	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
 	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
 	  Analog converters.
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2a80bbf4e80a..1adf80dde4cc 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AD3530R) += ad3530r.o
 obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o
 obj-$(CONFIG_AD3552R_LIB) += ad3552r-common.o
 obj-$(CONFIG_AD3552R) += ad3552r.o
+obj-$(CONFIG_AD5337) += ad5337.o
 obj-$(CONFIG_AD5360) += ad5360.o
 obj-$(CONFIG_AD5380) += ad5380.o
 obj-$(CONFIG_AD5421) += ad5421.o
diff --git a/drivers/iio/dac/ad5337.c b/drivers/iio/dac/ad5337.c
new file mode 100644
index 000000000000..b983baa203fe
--- /dev/null
+++ b/drivers/iio/dac/ad5337.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD5337 I2C DAC driver
+ *
+ * Copyright 2017 Marcin Bis <marcin@bis-linux.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+
+#define AD5337_NUM_CHANNELS	2
+#define AD5337_RESOLUTION	8
+/*
+ * AD5338 - 10bit, AD5339 - 12bit
+ */
+
+#define AD5337_PTR_DAC_A	0x01
+#define AD5337_PTR_DAC_B	0x02
+
+struct ad5337_state {
+	struct i2c_client *client;
+	struct mutex lock;
+	unsigned int vref_mv;
+	u8 cache[AD5337_NUM_CHANNELS];
+};
+
+static int ad5337_write_dac(struct ad5337_state *st, int channel, u8 value)
+{
+	u8 buf[3];
+	int ret;
+
+	if (channel)
+		buf[0] = AD5337_PTR_DAC_B;
+	else
+		buf[0] = AD5337_PTR_DAC_A;
+
+	/* PD1=0, PD0=0, CLR=1, LDAC=0, D[7:4] */
+	buf[1] = 0x20 | (value >> 4);
+	buf[2] = (value & 0x0f) << 4;
+
+	ret = i2c_master_send(st->client, buf, 3);
+
+	return (ret < 0) ? ret : (ret == 3 ? 0 : -EIO);
+}
+
+static int ad5337_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad5337_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = st->cache[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = AD5337_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5337_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad5337_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if (val < 0 || val > ((1 << AD5337_RESOLUTION) - 1))
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	ret = ad5337_write_dac(st, chan->channel, val);
+	if (!ret)
+		st->cache[chan->channel] = val;
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_info ad5337_info = {
+	.read_raw = ad5337_read_raw,
+	.write_raw = ad5337_write_raw,
+};
+
+#define AD5337_CHANNEL(_chan) {						\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (_chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static const struct iio_chan_spec ad5337_channels[] = {
+	AD5337_CHANNEL(0),
+	AD5337_CHANNEL(1),
+};
+
+static int ad5337_probe(struct i2c_client *client)
+{
+	struct ad5337_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->client = client;
+	mutex_init(&st->lock);
+
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vcc");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	st->vref_mv = ret > 0 ? ret / 1000 : 3300;
+
+	indio_dev->name = "ad5337";
+	indio_dev->info = &ad5337_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5337_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5337_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id ad5337_of_match[] = {
+	{ .compatible = "adi,ad5337" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5337_of_match);
+
+static struct i2c_driver ad5337_driver = {
+	.driver = {
+		.name = "ad5337",
+		.of_match_table = ad5337_of_match,
+	},
+	.probe = ad5337_probe,
+};
+module_i2c_driver(ad5337_driver);
+
+MODULE_AUTHOR("Marcin Bis <marcin@bis-linux.com>");
+MODULE_DESCRIPTION("Analog Devices AD5337 I2C DAC");
+MODULE_LICENSE("GPL");
-- 
2.43.0

