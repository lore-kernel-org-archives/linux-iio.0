Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793386413;
	b=cjFsD5CvTJORGlBOdOPsc7QUszbpEKSi6rb6Q35TFYIEuDOREDtbaYiPI+rFucOpSHkl
	 5D1ELvU6EgkV3GO58y8ePU/LyIJxHPatqPmg+iKbdDzUVBxLwaJ2E44/lQ65oOtU3g2bQ
	 DpDKoongrY+ZDHABf9OjIyffMna7SqY5opmyiXZ5IWM0puBLtBlAjzM1z8HshWaPCuOt4
	 mqNpIimYuus4vSBMzDMH8PFOOWXTGcg0BcIceqEQ24BottbZy87CAFddOc60SAy2F3rc1
	 pihxCMESOxe5zXRw3GUn4pvAnAd4454S+TR+S0y8TYWZDVpD9Y2GuNxxx9ZXgnrAebA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386413;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=93l3PbwxMNXva8shrLD9Yp2oURR70euJx91TNEBL23k=;
	b=WNJpC2x0zRxKWBz6HroLLYixCAy9at+3/exVfMBGwuW6yJcEmb5akIOB/4/I6l4d+L5B
	 VPtSwEDBqFn7bSnSrYvEQqvEL7MX5NZmLjLUP1XX0bXKlO03D+KoiE7ClDXfbM0GrtV/M
	 D94gGvmKjHy8jOTCgJAhaMw0pse2Pym0T0z9JEZZ6KN3NP06t9bo0gLTds7gw1Do+AQzd
	 kKK0YXHrlU41XmPinSlXjq1lRGEm1aN+o1tEKeS7KoGvfBDxSxPEoTOKz73cvJ1BR8oIG
	 GzjbuN0TXfIeC3Hq3U8rZXqxAjApn/irtFmEzCliLdlDKzfm3xRojCegrCxOOcTSk1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYCPV4bA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE42606A32E;
	Fri, 30 Oct 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYCPV4bA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793386412;
	b=WqEPLysyfi0MHdOpB2205mpstxutfPDXYU8RCw24ZYB6/FtI48R4hSQtAZOS/h6pBjjf
	 zrXxzDzewhZ34M2+0fdjqy5uwHagAC0O1q6f2k6WSwY0CHdF4Lh3vojMSSlwK1Oh+9Ysu
	 5lkz07GBlI5zVizw0ogyLtpcr3fbAoHpGYzAcBAh+08/UdEOdmre27rwWljL5OlK2rLbT
	 2+jN16bbgSqk9DD2YKNgModDmhUTue01gsBFQFmD5JKbvC7j3Tsx+M0wH6TBWt2uLx3wk
	 +wXdtlRd/vBJkqJBgO6u3UNGxVvDy89ttwDeZ1V6kKaIHO3G+7htTld5HcqGNz4/hlA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793386412;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=93l3PbwxMNXva8shrLD9Yp2oURR70euJx91TNEBL23k=;
	b=ccUnwuukADAHVLsgXYWg2/aX4UgJH9AgBIXkUTMW7hm/n3eER07qp2fgjatZhlAd5d7b
	 LiASNJxAFbDXliqo9UU+FACNV2OP3nz8Y8BLjeisCqp4IK3rX5iVa27XhcqgdYsLG8gJy
	 WQe9VO9CX5tBG3ct3H8i2ySzmoPxQoi3d1Z/3qLoYTYSaEeTVi6Dfbg+EPW2rLx+zI7Au
	 2Ha9HvpQWcHrIPNk6iWs2hjQ3dVkhhgTY7nZLz+qG3KTXCGTr7EViYyUOJVzz/H5yw8DS
	 fGw6v4C6VoaYah2Bj1dtwkp2X6CSSevgYDV9POCtmb4Tm0PCN/VPMAtixTez5AK4Vgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9AF0A1F00A02;
	Fri, 30 Oct 2026 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386412;
	bh=93l3PbwxMNXva8shrLD9Yp2oURR70euJx91TNEBL23k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gYCPV4bAyR0oLuPWzbOVuc8uLLSfhmg2YfkoBw1Z2Cc/bhoMyCkFarTXoUjUW7zLh
	 +lGhLtUA/5nd+MynjNghVx0DjO1bUickdVIokings/8+Cnw+zhTuIYmp7c2t1mflbR
	 Zi6Ej8HkBi03j2NEemkEpgQnTpijtNhHjDq+UJzbDHWYpAUDnlXymj+U1P1JNCfEGK
	 6ka3ZnUXGH5jhrfG5ab29NFE+AWJJiybwy6t7bmZqBfTEHchuCqxWw9g3IcqmAXtbP
	 F+nvhrfb1yui2902rxQ3ZLbQVPpaDdgKxQh9twObCDMXGKsStvPyN9GfFhjc1jlRZE
	 AjeLtUZzoIV4g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 20CEC4424D;
	Fri, 30 Oct 2026 18:53:30 +0000 (UTC)
From: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 00:23:30 +0530
Subject: [PATCH v2 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-tf-luna-v2-3-ce403579bb8a@gmail.com>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
In-Reply-To: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vidhu Sarwal <vidhu.linux@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793386408; l=10092;
 i=vidhu.linux@gmail.com; s=20260713; h=from:subject:message-id;
 bh=dRe8/rSjrRf76YJpJKIkmMgJVQEiToNTN9ONy+0ewgY=;
 b=tUDeR/lM7RO38qWt8iHk79LjcabFiTGeQPkcx9hKWTzQo+0FTdzzlc4P+xcmQy1syMtI9LY7V
 W+dHt9Urrb5DiaicbPZZwgYqhqS+ye6pbTfj/mcCfxmcX1UPisjwrFq
X-Developer-Key: i=vidhu.linux@gmail.com; a=ed25519;
 pk=xDu3Cbesz76CQXwY8lteI74n3ELVIV7wCsuYAvcX1Q4=
X-Endpoint-Received: by B4 Relay for vidhu.linux@gmail.com/20260713 with
 auth_id=869
X-Original-From: Vidhu Sarwal <vidhu.linux@gmail.com>
Reply-To: vidhu.linux@gmail.com
Content-Transfer-Encoding: 7bit

From: Vidhu Sarwal <vidhu.linux@gmail.com>

Add a driver for the Benewake TF-Luna, a single-point time-of-flight
LiDAR distance sensor with a range of 0.2 m to 8 m, connected over I2C.

The sensor is run in trigger mode. Each read starts one measurement and
waits for the timestamp register to change before reading the result.
In continuous mode a read can catch the sensor in the middle of updating
its result registers unless it is synchronised to the data ready output,
which this driver does not use yet.

When the signal strength is too low the sensor reports a dummy distance
of 0, so such readings, as well as overexposed ones, return -ENODATA
instead of a distance.

Datasheet: https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/proximity/Kconfig   |  11 ++
 drivers/iio/proximity/Makefile  |   1 +
 drivers/iio/proximity/tf-luna.c | 260 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24fa7cdf6a57..20e43a003bed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4667,6 +4667,7 @@ M:	Vidhu Sarwal <vidhu.linux@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml
+F:	drivers/iio/proximity/tf-luna.c
 
 BFQ I/O SCHEDULER
 M:	Yu Kuai <yukuai@fygo.io>
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index f3cec799df67..d16458ea4b0f 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -222,6 +222,17 @@ config SRF08
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf08.
 
+config TF_LUNA
+	tristate "Benewake TF-Luna LiDAR distance sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to build a driver for the Benewake TF-Luna LiDAR
+	  distance sensor connected over I2C.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tf-luna.
+
 config VCNL3020
 	tristate "VCNL3020 proximity sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 8a65e42fbea0..43741115a921 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SX9324)		+= sx9324.o
 obj-$(CONFIG_SX9360)		+= sx9360.o
 obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
+obj-$(CONFIG_TF_LUNA)		+= tf-luna.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VCNL36829)		+= vcnl36829.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
diff --git a/drivers/iio/proximity/tf-luna.c b/drivers/iio/proximity/tf-luna.c
new file mode 100644
index 000000000000..dbb56e7414af
--- /dev/null
+++ b/drivers/iio/proximity/tf-luna.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Benewake TF-Luna LiDAR distance sensor
+ *
+ * Copyright (C) 2026 Vidhu Sarwal <vidhu.linux@gmail.com>
+ *
+ * Datasheet: https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf
+ *
+ * The I2C register map is in appendix III of the TF-Luna product manual
+ * (SJ-PM-TF-Luna A05). Default 7-bit I2C address is 0x10.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+
+#define TF_LUNA_REG_DIST		0x00
+#define TF_LUNA_REG_TICK		0x06
+#define TF_LUNA_REG_VERSION		0x0A
+#define TF_LUNA_REG_MODE		0x23
+#define TF_LUNA_REG_TRIG_ONE_SHOT	0x24
+#define TF_LUNA_REG_SIGNATURE		0x3C
+
+#define TF_LUNA_MODE_TRIGGER		0x01
+#define TF_LUNA_TRIG_ONE_SHOT		0x01
+
+#define TF_LUNA_SIGN			0x4c554e41	/* "LUNA" in ASCII */
+
+/* Below this the sensor reports a dummy distance of 0 */
+#define TF_LUNA_AMP_MIN			100
+#define TF_LUNA_AMP_OVEREXPOSED		0xFFFF
+
+/* A measurement takes 10-20 ms in trigger mode */
+#define TF_LUNA_POLL_US			(2 * USEC_PER_MSEC)
+#define TF_LUNA_TIMEOUT_US		(100 * USEC_PER_MSEC)
+
+struct tf_luna_data {
+	struct regmap *regmap;
+	/* Serialises the trigger, poll and read of a single measurement */
+	struct mutex lock;
+};
+
+/*
+ * No register cache: the only configuration register written is MODE,
+ * once in probe, the other write is the one-shot trigger, and the
+ * registers read afterwards hold measurement data that keeps changing.
+ * MODE is also read back from the hardware, since the sensor can
+ * silently ignore a write that comes right after another one.
+ */
+static const struct regmap_config tf_luna_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TF_LUNA_REG_SIGNATURE + 3,
+};
+
+static int tf_luna_read_tick(struct tf_luna_data *data, u16 *tick)
+{
+	__le16 val;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, TF_LUNA_REG_TICK, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	*tick = le16_to_cpu(val);
+	return 0;
+}
+
+static int tf_luna_measure(struct tf_luna_data *data, int *dist)
+{
+	struct regmap *map = data->regmap;
+	__le16 buf[2];	/* distance in cm, signal strength */
+	u16 old_tick, tick, amp;
+	int ret, err;
+
+	guard(mutex)(&data->lock);
+
+	ret = tf_luna_read_tick(data, &old_tick);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, TF_LUNA_REG_TRIG_ONE_SHOT, TF_LUNA_TRIG_ONE_SHOT);
+	if (ret)
+		return ret;
+
+	/* The tick register is a timestamp, it changes with each measurement */
+	ret = read_poll_timeout(tf_luna_read_tick, err, err || tick != old_tick,
+				TF_LUNA_POLL_US, TF_LUNA_TIMEOUT_US, true,
+				data, &tick);
+	if (ret)
+		return ret;
+	if (err)
+		return err;
+
+	ret = regmap_bulk_read(map, TF_LUNA_REG_DIST, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	amp = le16_to_cpu(buf[1]);
+	if (amp < TF_LUNA_AMP_MIN || amp == TF_LUNA_AMP_OVEREXPOSED)
+		return -ENODATA;
+
+	*dist = le16_to_cpu(buf[0]);
+	return 0;
+}
+
+static int tf_luna_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct tf_luna_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = tf_luna_measure(data, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* Distance is in cm */
+		*val = 0;
+		*val2 = 10000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info tf_luna_info = {
+	.read_raw = tf_luna_read_raw,
+};
+
+static const struct iio_chan_spec tf_luna_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int tf_luna_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tf_luna_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *map;
+	unsigned int mode;
+	__be32 sign;
+	u32 fourcc;
+	u8 ver[3];
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	map = devm_regmap_init_i2c(client, &tf_luna_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "Failed to initialize regmap\n");
+	data->regmap = map;
+
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");
+
+	/* Boot time is not documented, about 350 ms was measured */
+	msleep(500);
+
+	ret = regmap_bulk_read(map, TF_LUNA_REG_SIGNATURE, &sign, sizeof(sign));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read signature\n");
+
+	fourcc = be32_to_cpu(sign);
+	if (fourcc != TF_LUNA_SIGN)
+		dev_info(dev, "Unknown signature %p4ch, continuing\n", &fourcc);
+
+	ret = regmap_bulk_read(map, TF_LUNA_REG_VERSION, ver, sizeof(ver));
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "Firmware version %u.%u.%u\n", ver[2], ver[1], ver[0]);
+
+	/*
+	 * In continuous mode a read can catch the sensor updating its result
+	 * registers unless it is synchronised to the data ready output. Use
+	 * trigger mode and start each measurement on demand instead.
+	 */
+	ret = regmap_write(map, TF_LUNA_REG_MODE, TF_LUNA_MODE_TRIGGER);
+	if (ret)
+		return ret;
+
+	/*
+	 * The sensor silently drops writes it is not ready for, so check that
+	 * the mode was set. A write takes up to 100 ms to read back.
+	 */
+	msleep(100);
+
+	ret = regmap_read(map, TF_LUNA_REG_MODE, &mode);
+	if (ret)
+		return ret;
+
+	if (mode != TF_LUNA_MODE_TRIGGER)
+		return dev_err_probe(dev, -EIO, "Failed to set trigger mode\n");
+
+	indio_dev->name = "tf-luna";
+	indio_dev->info = &tf_luna_info;
+	indio_dev->channels = tf_luna_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tf_luna_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id tf_luna_id[] = {
+	{ .name = "tf-luna" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tf_luna_id);
+
+static const struct of_device_id tf_luna_of_match[] = {
+	{ .compatible = "benewake,tf-luna" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tf_luna_of_match);
+
+static struct i2c_driver tf_luna_driver = {
+	.driver = {
+		.name = "tf-luna",
+		.of_match_table = tf_luna_of_match,
+	},
+	.probe = tf_luna_probe,
+	.id_table = tf_luna_id,
+};
+module_i2c_driver(tf_luna_driver);
+
+MODULE_AUTHOR("Vidhu Sarwal <vidhu.linux@gmail.com>");
+MODULE_DESCRIPTION("Benewake TF-Luna LiDAR distance sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0


