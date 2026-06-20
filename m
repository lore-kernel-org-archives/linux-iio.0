Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F137267B
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781930418; cv=none; b=CDWIR/uqpXToCJ2KqxuTp5e3ZKj+hUrczUo5pgbx5yzevxHYy8Q2vdQEYu2p+BPwNEtzI+gd+9vJAtah3BR2qxxjs1f6Hr1Wyhk5THTeoUs2QBoRVJOBxS+6YjlM9lS2Y2TPO4WG0PyxlMPxeU7rtj4GQ4toHvpelRpgFxTJtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781930418; c=relaxed/simple;
	bh=7ib7/rADfFohmVQbZlzTr/W/hhSB5hu4E6oX1KTLBAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHAbK1WZvkzuAOCfYghF4PDCll6IcZIRhOLw2YuYXnSIeRds8p48Txe2cIVcJ5xic1kaMBBNtJosVTyYyDfzLxjr/RscPYWaIFUPJ1dp1yvwylfCQ9OlccVEGWyvoG/i475GhswkxgsaYQ8jKXYjX0nXK4MtKESGXHaevCH8MJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHwAX+S/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHwAX+S/"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6128bd9b3so1537461a34.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 21:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781930416; x=1782535216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H51R9sb1c1D+sWTFf7vsoOBxYXPqkP3MRwWVVpPmmU=;
        b=hHwAX+S/J/WKGjtMPjj/xVVWK4H3Ui4ZsCqu3g3GcpXUvmL6tyLl00G8ySd81deNnw
         sCJGupMMlBs5Jy5xTNam5UP10dMtiveJ/ZGp0UP1zj9JCo5KSOn/PmA6NIoHvNauC8lm
         pbJFqbwDcPPsll3OyySy8+igx37wzo1kxCFZZoPqQjveo6OJLcf4uFMrICBXsgK/iejN
         VcSBgR7Tmmu1/fdXPJ5cNS1CuaQXDVtGXouRlsXSXEVjTKkDRen8JYWm9qeG4CG//A3K
         t90GW5PN84Vh9DACXwf7PQhiUwZOMsIeSevq/npxhQ27hxCSSf6V96ikbJbpWwOXx641
         y+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781930416; x=1782535216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8H51R9sb1c1D+sWTFf7vsoOBxYXPqkP3MRwWVVpPmmU=;
        b=HeL9r9p5mr7BpD1naKi9qkJKhhBU1gxEWDeHQSfZemyY2zbqauIDUg6trfveZJJ607
         /VbhHcps4qCd78f9PtTFNJJj1gNr5e85YSloWBa7zTXDbsHRq7xJigNi2Aw77+F3pTM1
         Y1v4yrjE9rAaWU7npOyt6gAX0E7q9LwyzanLQvzQEL1lgzI0Kgd364uHld5JYu7o/CLC
         CHPun9seAjCBaK4cH+NN6LO6/ZTqnzUDz3j/ZUZ2qq22tmcUFqQisQHFC5YhqW8COcpC
         xSJX1KFD4ZIG6AYqDj2xLgMeeQjl4qT4TfoqUEu8h0DNpootZEMQXrkH0bHyRwaeAsSl
         hhuA==
X-Forwarded-Encrypted: i=1; AFNElJ9UzH8PZhWzibsEHk+dCgnrAQt7mW25rDrp/ZFvVCZRCjHwAAvW/JUoggHv+OKQ10pu89JxGs690no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8NOS+xl9kc4ewngE9XF7DoYhKYcJaoaWhaAw60XNXgmgGV2A
	2T+IcDk9YeneKW04WTHHomAQlBkq3dERaiwEWNZk+uYb3FhLg8BeTw02YWr20LCk
X-Gm-Gg: AfdE7clkOzp7ZJDpCA7eGc3qJiNmyNESMGjYVz3ZYjR4xyXUg7sTqQxNtix7jhlP6EU
	JyXwTvz/HRNWcOYGLy5bK7QZj8TrbUfBYo2a0AFaEFD8Gik453G3GpfKYM/mgmDpHZsDNjOvn6I
	aO6sr6dDAznsNveWumpL/lxxisIMzvgdX+6iQTSK0gyK73ZLxs1TwXIJMwQ8gobpvv/NfcLfScJ
	MBm+ZnxnDZEUUibcpWdjokix0yPxDK5626hqyFK67Zq/MTGYuL086BiE3+QgZP2E4S/zp2cHUuD
	EAD8Y8BxS0ixhe5EdZdf6xxm8JSFA3A5BSw1z3vuW/6NcirADDz1i0poNPtFycOLqiGzA7eksJD
	93ZXYWYbyb8/wBFv7oCB2RuA+I7nDHM0x+uKgTl1KIokVWrBGRyLxo+2N1Vo/CJnJqLmPwiTWoc
	hMBv02y5uuTkyVvui6bRf6v5uPoiepzN36v6Tz6JFRJx879qm0LQwPzq/eLA==
X-Received: by 2002:a05:6808:3309:b0:48a:256:3a6a with SMTP id 5614622812f47-48a025645e0mr4582002b6e.18.1781930415575;
        Fri, 19 Jun 2026 21:40:15 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0ddd7bsm679754b6e.7.2026.06.19.21.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 21:40:14 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/3] iio: temperature: Add STS30 temperature sensor driver
Date: Fri, 19 Jun 2026 23:40:06 -0500
Message-ID: <20260620044010.1082621-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620044010.1082621-1-m32285159@gmail.com>
References: <20260620044010.1082621-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the Sensirion STS30 family of temperature sensor
drivers over I2C. The STS30 family of sensors includes the STS30, STS31,
and STS35, all of which are supported by this driver, since they all
share the same commands, etc. and only differ in accuracy and tolerance.

The driver currently supports single-shot non-clock stretched readings,
by using a specified delay based on the repeatability/delay specified
by the user. The repeatability/delay can be changed at any time through
sysfs.

Additionally add Kconfig and Makefile entries for the driver.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/temperature/Kconfig  |  11 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/sts30.c  | 321 +++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+)
 create mode 100644 drivers/iio/temperature/sts30.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 9328b2250ace..c23a9c40c725 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -88,6 +88,17 @@ config MLX90635
 	  This driver can also be built as a module. If so, the module will
 	  be called mlx90635.
 
+config STS30
+	tristate "STS30/STS31/STS35 temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  If you say yes here you get support for the Sensirion STS30,
+	  STS31, and STS35 temperature sensors over I2C.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called sts30.
+
 config TMP006
 	tristate "TMP006 infrared thermopile sensor"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7..9c9bf8d1b70e 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MCP9600) += mcp9600.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_MLX90632) += mlx90635.o
+obj-$(CONFIG_STS30) += sts30.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TMP117) += tmp117.o
diff --git a/drivers/iio/temperature/sts30.c b/drivers/iio/temperature/sts30.c
new file mode 100644
index 000000000000..b49deb1d62c2
--- /dev/null
+++ b/drivers/iio/temperature/sts30.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Maxwell Doose
+ *
+ * Sensirion STS30 temperature sensor driver
+ *
+ * Datasheet: https://sensirion.com/media/documents/1DA31AFD/65D613A8/Datasheet_STS3x_DIS.pdf
+ *
+ * Author: Maxwell Doose <m32285159@gmail.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+/* Amount of bytes received from the STS30 after a read command */
+#define STS30_MEAS_SIZE 3
+
+#define STS30_COMMAND_READ_HIGH_REPEAT 0x2C06
+#define STS30_COMMAND_READ_MED_REPEAT 0x2C0D
+#define STS30_COMMAND_READ_LOW_REPEAT 0x2C10
+
+/* Soft reset command */
+#define STS30_COMMAND_RESET 0x30A2
+
+/*
+ * sts30 includes a CRC8 checksum at the end of its i2c responses. The polynomial
+ * is used to generate the CRC8 table and the seed is the starting value.
+ */
+#define STS30_CRC8_POLYNOMIAL 0x31
+#define STS30_CRC8_SEED 0xFF
+
+DECLARE_CRC8_TABLE(sts30_crc_table);
+
+enum sts30_read_delays {
+	STS30_REPEAT_LOW = 4500,
+	STS30_REPEAT_MED = 6000,
+	STS30_REPEAT_HIGH = 15000
+};
+
+/**
+ * struct sts30_data - data structure for STS30 driver
+ *
+ * @client: underlying i2c client data structure
+ * @lock: mutex for serialized communication on the i2c bus
+ * @delay: measurement duration for the current repeatability mode
+ */
+struct sts30_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	/*
+	 * sts30 has three potential repeatability/measurement durations. We need to
+	 * account for them while reading the i2c bus.
+	 *
+	 * See section 2.2 in the datasheet for more info on processing times.
+	 */
+	enum sts30_read_delays delay;
+};
+
+static int sts30_verify_crc8(struct sts30_data *data, u8 buf[STS30_MEAS_SIZE])
+{
+	int crc;
+
+	crc = crc8(sts30_crc_table, buf, 2, STS30_CRC8_SEED);
+	if (crc != buf[2]) {
+		dev_err(&data->client->dev, "Expected CRC8 value of 0x%02x, got 0x%02x\n",
+			buf[2], crc);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sts30_read(struct sts30_data *data, u16 command, u16 *val)
+{
+	u8 tmp[2];
+	u8 buf[STS30_MEAS_SIZE];
+	int ret;
+
+	put_unaligned_be16(command, tmp);
+
+	ret = i2c_master_send(data->client, tmp, sizeof(tmp));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(tmp))
+		return -EIO;
+
+	fsleep(data->delay);
+
+	ret = i2c_master_recv(data->client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
+
+	*val = get_unaligned_be16(buf);
+
+	ret = sts30_verify_crc8(data, buf);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sts30_write(struct sts30_data *data, u16 command)
+{
+	u8 buf[2];
+	int ret;
+
+	put_unaligned_be16(command, buf);
+
+	ret = i2c_master_send(data->client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
+
+	return 0;
+}
+
+static int sts30_reset(struct sts30_data *data)
+{
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = sts30_write(data, STS30_COMMAND_RESET);
+	if (ret)
+		return ret;
+
+	fsleep(1500);
+
+	return 0;
+}
+
+static int sts30_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val, int *val2,
+			  long mask)
+{
+	struct sts30_data *data = iio_priv(indio_dev);
+	int ret;
+	u16 tmp;
+
+	guard(mutex)(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (data->delay) {
+		case STS30_REPEAT_LOW:
+			ret = sts30_read(data, STS30_COMMAND_READ_LOW_REPEAT, &tmp);
+			break;
+		case STS30_REPEAT_MED:
+			ret = sts30_read(data, STS30_COMMAND_READ_MED_REPEAT, &tmp);
+			break;
+		case STS30_REPEAT_HIGH:
+			ret = sts30_read(data, STS30_COMMAND_READ_HIGH_REPEAT, &tmp);
+			break;
+		default:
+			dev_warn(&data->client->dev, "Repeatability state corrupted, got: %d\n",
+				 data->delay);
+			return -EINVAL;
+		}
+
+		if (ret)
+			return ret;
+
+		*val = tmp;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * We use this constant -16852 as calculated using the formula
+		 * in the datasheet. See section 4.12 in the data sheet for more
+		 * info.
+		 */
+		*val = -16852;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 175000;
+		*val2 = 65535;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		*val2 = data->delay;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sts30_write_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int val, int val2,
+			   long mask)
+{
+	struct sts30_data *data = iio_priv(indio_dev);
+
+	if (val)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME: {
+		guard(mutex)(&data->lock);
+
+		switch (val2) {
+		case STS30_REPEAT_LOW:
+			data->delay = STS30_REPEAT_LOW;
+			break;
+		case STS30_REPEAT_MED:
+			data->delay = STS30_REPEAT_MED;
+			break;
+		case STS30_REPEAT_HIGH:
+			data->delay = STS30_REPEAT_HIGH;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sts30_info = {
+	.read_raw = sts30_read_raw,
+	.write_raw = sts30_write_raw
+};
+
+static const struct iio_chan_spec sts30_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+};
+
+static const struct i2c_device_id sts30_id[] = {
+	{ "sts30" },
+	{ "sts31" },
+	{ "sts35" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sts30_id);
+
+static int sts30_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct sts30_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->name = client->name;
+	indio_dev->info = &sts30_info;
+	indio_dev->channels = sts30_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sts30_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->delay = STS30_REPEAT_HIGH;
+
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = sts30_reset(data);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id sts30_of_match[] = {
+	{ .compatible = "sensirion,sts30" },
+	{ .compatible = "sensirion,sts31" },
+	{ .compatible = "sensirion,sts35" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sts30_of_match);
+
+static struct i2c_driver sts30_driver = {
+	.driver = {
+		.name = "sts30",
+		.of_match_table = sts30_of_match,
+	},
+	.probe = sts30_probe,
+	.id_table = sts30_id,
+};
+
+static int __init sts30_init(void)
+{
+	crc8_populate_msb(sts30_crc_table, STS30_CRC8_POLYNOMIAL);
+
+	return i2c_add_driver(&sts30_driver);
+}
+module_init(sts30_init);
+
+static void __exit sts30_exit(void)
+{
+	i2c_del_driver(&sts30_driver);
+}
+module_exit(sts30_exit);
+
+MODULE_AUTHOR("Maxwell Doose <m32285159@gmail.com>");
+MODULE_DESCRIPTION("Sensirion STS30 temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.54.0

