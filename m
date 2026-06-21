Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B822D4E9
	for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782002797; cv=none; b=U7k+NsDB7Xfs3toNHJtNQzWU6h1S/8BF4NhX2Wdqx2JCQIuoyRLbvPemWdPwBWXHfeJknU/ZJM/bmgeqPoBge1VY4SK9XIkths78CKO3W/5JlGPh/srgvTJ5nBGTnpbLdCuX1N8eITkF+FxxdmAWa57EAxsfeauefIJCsI9m8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782002797; c=relaxed/simple;
	bh=l7mHdO04LVSS3d8xjKFPHHbnSH0Vip0EhaqadJeukpM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUFmucH6gFUmbq+Ff91iy+/NQ15S7YC9Sp7SrvN6mFQGqNrL4+sHmxmLTIW3CwuwCst2TzeCNcVCvDGb+viZOaqjPLlf0Et4S/pKSIPE2dTH+vpMHbY71D/dqT+7volQ5qXAxhAjvbEIK+bHZnfA2D0P2f0sgL2JJDOYIqPm7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3RBLezp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3RBLezp"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69e46524711so2407799eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782002792; x=1782607592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhmKD0rjdssQNbMQQrxwrasxhIABHPuvnpVZkgFEOmk=;
        b=k3RBLezplPB7zmas29z18bfQ+1bGn+gT3DpYd6NYioe0BXSLknyOgFWLg5G9WEugq5
         ZUDsVpHNLK+B0JwibWp+Nxl6XSoVx5KzGmrIMZoi/eF5KGfKTBpwpbOGSBOCpN81AcrR
         AV8rekOvsWJ0u0GBoJPco20EZ4FadZDTbNQjaGf188EbIlVT9CvY3yz3i/cTjN1pnNx2
         eEeWUttD7C3OtWK7R1VuWhe4uKd8u+VytLHr1kk/PNIJU0M7nfvTpCQiEaXCRJ5T5Wht
         06RonQhcTJkeAcmbkG080QFjlag0peph+OVKetyzhyqFJr+oS0mEQoTNZuYTAFwGs10S
         M5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782002792; x=1782607592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IhmKD0rjdssQNbMQQrxwrasxhIABHPuvnpVZkgFEOmk=;
        b=WWZcPutEvGyKV0SFzSHpes+a0AQUxk6P0FYoB6nKed1BEB1pj8JsdspUEtI2UsSQR9
         wz1tAxxIz13tRi8aj4BftXnVMLCsEsuXGY5bGGnb5zy4TP7ZqU/oysv2GRwOUvqwAYEm
         dRGcO+p7EvnQgE1uMzsyvavuY0wI+2nyIW4FKSTJu35WVC3fIEQ4iS17vwL2sbIukGGt
         mDEXIGDRbggcA7U3O6Kk+R7Xmc6yzqYmF0ClI49qHGMvt6PbjJC01uFDBIIM4ECpqMic
         oVFE2NpRn7ywPOpezRCy+6KELjs9eqq0LjSg4zf777v+AGxS0Qx0p/Gg9leFYf1t1Pt5
         e8Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8KueUkC4uT/pmuvdUIhnG6MjUblQJIEqTU2CXCNzbdCmPlQ5I41Fhoco+kWVIwUJzn9X4IXQdFVc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBQiwewoCNFOIfBChFRtn7pfX7nAYsYryT305fVIPWLei6N4K
	FKFn/0ypiJzNFghCodDw40eorN66oVduntK5O7UWqgCQTv0LCgoxn2mr
X-Gm-Gg: AfdE7cl8qsFBA6DCa67CWICtDk32wjHkfY0DWS3JF06vgzdbc+iWYdVtzg8+/RJ02he
	uSuzRj6i0Mavwh68hrGUFdy3RU4nBGlJf94Tp5gGfsMxoUFDSah5K6q3XR61ejh8Z7oh+x8/pEv
	1OCCX7oeBsqErJgZ/8sCHeXrQLU7VnxbmsKYS4ZeuV3Ce0oPd0lBQaJP73D9zw+3rgpfnyGwrTM
	7FAuQqPmWGlszqNKuU6NKTMwb1iy8OK6Cm4h+Z2uqtXQRoXxqIAmkR9Pawum6K/mxHQ0L2asMdY
	6g6kzJdcHHytBCm2tRvF3pBNsOOvZBehUU5WC7c1SghFU6/EgaoJdbOMkyrGTjYYwfP/vPzkX4d
	WcwNZMJUJSksgL2UOgp9yLMLcfZhNGXQS6cvpelTHLoRzxbb/r+EhPQq6mVsz5fJAuMV9kHRkfc
	ocpi3Ulij/90XiQ3daIpTUkie1yOXGh3lVHvw3qyyXg4+gjwO0uacBPWyjpQ==
X-Received: by 2002:a05:6820:1b14:b0:69d:e2fc:361a with SMTP id 006d021491bc7-6a0d90260f2mr7086804eaf.35.1782002792361;
        Sat, 20 Jun 2026 17:46:32 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ec5fd4csm3080457fac.2.2026.06.20.17.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 17:46:31 -0700 (PDT)
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
Subject: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor driver
Date: Sat, 20 Jun 2026 19:46:24 -0500
Message-ID: <20260621004626.66629-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621004626.66629-1-m32285159@gmail.com>
References: <20260621004626.66629-1-m32285159@gmail.com>
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

Additionally add Kconfig and Makefile entries for the driver as well as
a MAINTAINERS entry.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
Changes since v1:
- Squashed parts of the MAINTAINERS commit into this commit.
- Fixed a mixup between the clock-stretched and non-clock stretched
  commands.
- Fixed an issue where the return value of sts30_reset() was ignored.
- Removed redundant "Author" line at the top.
- Added comment at the top for the formula used to calculate the
temperature in Celsius alongside a macro.
- Added a dedicated macro for the temperature reading size.
- Separated the generic linux headers from the iio specific headers.
- Removed kernel.h from includes.
- Removed unneeded comments.
- Used named initializers for sts30_id and moved above _probe().

 MAINTAINERS                      |   1 +
 drivers/iio/temperature/Kconfig  |  11 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/sts30.c  | 329 +++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/iio/temperature/sts30.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f94b8cac3e2..6bb361ac213f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24491,6 +24491,7 @@ SENSIRION STS30 TEMPERATURE SENSOR DRIVER
 M:	Maxwell Doose <m32285159@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
+F:	drivers/iio/temperature/sts30.c
 
 SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
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
index 000000000000..dcfe3435ae5a
--- /dev/null
+++ b/drivers/iio/temperature/sts30.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Maxwell Doose
+ *
+ * Sensirion STS30 temperature sensor driver
+ *
+ * Datasheet: https://sensirion.com/media/documents/1DA31AFD/65D613A8/Datasheet_STS3x_DIS.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+/*
+ * STS30 measurement to Celsius conversion formula:
+ *
+ * T = -45 + 175(S[T]/(2^16 - 1)
+ *
+ * Where S[T] is the raw sensor output. We use this formula to calculate the offset.
+ * Using this we can calculate the offset to be -16852.
+ *
+ * See section 4.12 in the datasheet for more info.
+ */
+#define STS30_TEMP_OFFSET -16852
+
+/* Amount of bytes received from the STS30 after a read command */
+#define STS30_MEAS_SIZE 3
+
+/* Size of the temperature measurement data received after a read command */
+#define STS30_TEMP_MEAS_SIZE 2
+
+#define STS30_COMMAND_READ_HIGH_REPEAT 0x2400
+#define STS30_COMMAND_READ_MED_REPEAT 0x240B
+#define STS30_COMMAND_READ_LOW_REPEAT 0x2416
+
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
+struct sts30_data {
+	struct i2c_client *client;
+	struct mutex lock; /* Mutex for serialized communication on the i2c bus */
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
+	crc = crc8(sts30_crc_table, buf, STS30_TEMP_MEAS_SIZE, STS30_CRC8_SEED);
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
+	u8 buf[STS30_MEAS_SIZE];
+	u8 tmp[2];
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
+	/*
+	 * Datasheet dictates that the maximum time for a soft reset is 1.5ms.
+	 *
+	 * See section 2.2 for more info on timing.
+	 */
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
+		*val = STS30_TEMP_OFFSET;
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
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id sts30_id[] = {
+	{ .name = "sts30" },
+	{ .name = "sts31" },
+	{ .name = "sts35" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sts30_id);
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

