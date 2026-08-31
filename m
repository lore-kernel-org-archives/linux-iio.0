Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967334AA1F3
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189207; cv=none; b=cg5/GAm3hxqeoaN/MUQWBGJ6ojMz6ODjg/fwMMGL09W7niCGroHKFeMQdAqw9hrgfcd4lINGfuPv6CIwySr19ko+r6TcIJunXgdaydmoED8vHrbyuasAJxUF514Ta9a93r+pF8oDQ2aHMPGrRloaBEeBC+/mCxcjWNDf5wIwso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189207; c=relaxed/simple;
	bh=zwt/Os71dR2Moyg/hVp+2GNSU9D5EsLxo2HUN4WM0G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r46A/YPQ4DjZXysLsvFggiOI7Iw8quS2StQeqI58b5qWAnNz+u2Tqneif7MXlH8lf7iCtzq0ilH0uMc3tuD+JZqy+MuleYxNEcIFAzB2DmlBW4L3rtkuF02IDuWLYyTmmlcUUaQQTIlrOVqHFyeJBhndwbtjw4icf5OBmodLci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZI92Kiz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZI92Kiz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so6227208a91.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189205; x=1788794005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kcOM4fONsDbyE5sqXtt4gD8Fj17tE+MsnJP6lJ1DE8=;
        b=UZI92KizBohykrodaPDBfyRvnehPgc8KWeyciflIlPkHYTKy7U2un2wbJUXk6y5x6o
         EO3ctYhT717lFteNl7Tx8TFbNULN7GLmPWP8ntSuoqNixO3+FTcIUdytYcMeFjNUTRcE
         VbqcSaHMtbte23zrpTbqg06FiR/BJKeEaG+Q2FyNdq234U9UFZw6d1TSoXATEUamNlH1
         5vg6wET4eks4gSafNII7isMPKt2A1x9yND5SZMkrrVjEl++7xPhCGQOk4OLgDyvKm3CN
         DjyXcz6eavh1aziZPvjyD3v8xt+BiLtfRpgNgvYFGZI2YVZfTmqi2B+ug2RDKdQsThVP
         q1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189205; x=1788794005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kcOM4fONsDbyE5sqXtt4gD8Fj17tE+MsnJP6lJ1DE8=;
        b=kaPhVCOxEM0oYzpNvn1wlbcYRBDNaSQ5zkd+w310xhUeio1fZSEulmvSmqZpINq08R
         AgLC2GdOTzuAK9hN010njNgPf5GIoo/kL0W2cuiZ7C0LApTsPjYY8tp3995OwpwTGtoy
         kFoMNUqi4QuIr9WrsPr8681N1vz+y0kfny92C5iJfwyO84abkZux4UI0BN19ScGDVD5v
         H3EdxLoLnnyp+f1JHkUxwQwjZMxEY4ftswXoxR9nKY6Xg63d9rLxl2ey6Y0FXoSMM7tQ
         WOf7427x4Th8IeUWEViNJJe1tK8ssIYPTmLmHzRAQj26lCrvCpsaeelvs5G8eA2BpgmP
         kvYQ==
X-Gm-Message-State: AFuF++k16WSpCvpzMf4pcqlO4+rZqz+zQuscRTIYZ8LwcQYuppLmOuD1
	CDEYTWupxAL6f15SDKdlqCsAHCuCyZ87vT/WklPwzMaGgRL9qLREDaq0CWQRr5SR
X-Gm-Gg: AYBFou3v9XOBjaailO526F8xoqzFvEUosNhH++MyOO6HKd7hL3sElVeUx8fyRiOVmMy
	Lg4JRHnnfKesBkubR7xkE81OuRUdeBU8bbOARMtBbaDPdjpx282uaO3uNGdJt5TlsNcoQG4UUCr
	nQo1uDAdsO7/GnPCv7+bvyVy6zro3DkDOQPRAw0o0aQlFVJYu09RDfm9ruzO+ao9IUOf3I53C1y
	XTz9KpzUe3VgLTTrH+PBxHREjHgIZ+GrnCK8vSgPM4J7oiGUf0vxTrpD6CItHh53K4GF505UWl4
	Srp6wrUDBJdTOFAS/f4jllLDWKsMhtoLEvl8TKQ1ATVc4EU0bl8mrTCnLAVtRn1mGiSdQ3N7uhw
	Zy+Ji1twbTDrZPVUOcwlw9MvesfJtEXlC41QK/q3/zjgU3n9+N2YzyZRLiP20nTL6RzTlXwWH9l
	Mvb7eEUqXcA6OzvmE70JQP4bOY9wh/tkeSKgXhtpSs+lnQ9LPc9MYh2TWIjA2S3tCS/g4kbjpp6
	FQwL9q4LGWyRrFdF7DMBmykCG9hLusDwtA=
X-Received: by 2002:a17:90b:1d49:b0:398:d843:cad9 with SMTP id 98e67ed59e1d1-398d843cbaamr15085943a91.19.1788189204740;
        Mon, 31 Aug 2026 08:13:24 -0700 (PDT)
Received: from not-op-Victus-by-HP-Gaming-Laptop-15-fb3xxx ([2409:40d2:39:89dc:a2db:5440:8165:f821])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1ac3cbbsm21847197a91.17.2026.08.31.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:13:24 -0700 (PDT)
From: Akshat Chandra <notmissinge@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akshat Chandra <notmissinge@gmail.com>
Subject: [PATCH] iio: chemical: add SGP41 driver
Date: Mon, 31 Aug 2026 20:42:35 +0530
Message-ID: <20260831151235.64076-1-notmissinge@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
---
 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sgp41.c                  | 384 ++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/iio/chemical/sgp41.c

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2de8eb09c..c3b51d8ee 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -420,6 +420,8 @@ properties:
           - sensirion,sgp30
             # Sensirion gas sensor with I2C interface
           - sensirion,sgp40
+            # Sensirion gas sensor with I2C interface
+          - sensirion,sgp41
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion temperature & humidity sensor with I2C interface
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index b22afa1f6..cbb6a51b1 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -210,6 +210,17 @@ config SENSIRION_SGP40
 	  To compile this driver as module, choose M here: the
 	  module will be called sgp40.
 
+config SENSIRION_SGP41
+	tristate "Sensirion SGP41 gas sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build I2C interface to support Sensirion SGP41 gas
+	  sensor
+
+	  To compile this driver as module, choose M here: the
+	  module will be called sgp41.
+
 config SPS30
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2287a00a6..90041aaa4 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SEN0322)	+= sen0322.o
 obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
+obj-$(CONFIG_SENSIRION_SGP41)	+= sgp41.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
 obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
diff --git a/drivers/iio/chemical/sgp41.c b/drivers/iio/chemical/sgp41.c
new file mode 100644
index 000000000..717113e95
--- /dev/null
+++ b/drivers/iio/chemical/sgp41.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define SGP41_CALC_POWER		14
+
+#define SGP41_CRC8_POLYNOMIAL		0x31
+#define SGP41_CRC8_INIT		0xff
+
+#define SGP41_COND_ITERATIONS		10
+
+DECLARE_CRC8_TABLE(sgp41_crc8_table);
+
+struct sgp41_data {
+	struct device *dev;
+	struct i2c_client *client;
+
+	int rht;
+	int temp;
+
+	int vos_res_calibbias;
+	int nox_res_calibbias;
+
+	struct mutex lock;/* Protects sensor state and I2C transaction.*/
+	bool conditioned;
+};
+
+struct sgp41_tg_measure {
+	u8 command[2];
+	__be16 rht_ticks;
+	u8 rht_crc;
+	__be16 temp_ticks;
+	u8 temp_crc;
+} __packed;
+
+struct sgp41_tg_result {
+	__be16 voc_res_ticks;
+	u8 voc_res_crc;
+	__be16 nox_res_ticks;
+	u8 nox_res_crc;
+} __packed;
+
+static const struct iio_chan_spec sgp41_channels[] = {
+	{
+		.type = IIO_RESISTANCE,
+		.channel = 0,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type = IIO_RESISTANCE,
+		.channel = 1,
+		.indexed = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type = IIO_TEMP,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static void temp_rht_payload(struct sgp41_data *data,
+			     struct sgp41_tg_measure *tg)
+{
+	s64 ticks;
+	u16 ticks16;
+
+	ticks = div_s64((s64)data->rht * 65535, 100000);
+	ticks16 = (u16)clamp_t(s64, ticks, 0, 65535);
+	tg->rht_ticks = cpu_to_be16(ticks16);
+	tg->rht_crc = crc8(sgp41_crc8_table, (u8 *)&tg->rht_ticks, 2,
+			   SGP41_CRC8_INIT);
+
+	ticks = div_s64((s64)(data->temp + 45000) * 65535, 175000);
+	ticks16 = (u16)clamp_t(s64, ticks, 0, 65535);
+	tg->temp_ticks = cpu_to_be16(ticks16);
+	tg->temp_crc = crc8(sgp41_crc8_table, (u8 *)&tg->temp_ticks, 2,
+			    SGP41_CRC8_INIT);
+}
+
+static int sgp41_run_conditioning(struct sgp41_data *data)
+{
+	struct sgp41_tg_measure tg = {
+		.command = { 0x26, 0x12 },
+	};
+	int i;
+	int ret;
+
+	for (i = 0; i < SGP41_COND_ITERATIONS; i++) {
+		temp_rht_payload(data, &tg);
+
+		ret = i2c_master_send(data->client, (const char *)&tg,
+				      sizeof(tg));
+		if (ret != sizeof(tg)) {
+			dev_warn(data->dev,
+				 "i2c_master_send ret: %d sizeof: %zu\n",
+				 ret, sizeof(tg));
+			return ret < 0 ? ret : -EIO;
+		}
+
+		msleep(50);
+
+		if (i != SGP41_COND_ITERATIONS - 1)
+			msleep(950);
+	}
+
+	data->conditioned = true;
+
+	return 0;
+}
+
+static int sgp41_measure_raw(struct sgp41_data *data,
+					u16 *voc_raw,
+					u16 *nox_raw)
+{
+	struct sgp41_tg_measure tg = {
+		.command = { 0x26, 0x19 },
+	};
+	struct sgp41_tg_result tgres;
+	u8 crc;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	if (!data->conditioned) {
+		ret = sgp41_run_conditioning(data);
+		if (ret)
+			goto unlock;
+	}
+
+	temp_rht_payload(data, &tg);
+
+	ret = i2c_master_send(data->client, (const char *)&tg, sizeof(tg));
+	if (ret != sizeof(tg)) {
+		dev_warn(data->dev,
+			 "i2c_master_send ret: %d sizeof: %zu\n",
+			 ret, sizeof(tg));
+		ret = ret < 0 ? ret : -EIO;
+		goto unlock;
+	}
+
+	msleep(50);
+
+	ret = i2c_master_recv(data->client, (u8 *)&tgres, sizeof(tgres));
+	if (ret < 0)
+		goto unlock;
+
+	if (ret != sizeof(tgres)) {
+		dev_warn(data->dev,
+			 "i2c_master_recv ret: %d sizeof: %zu\n",
+			 ret, sizeof(tgres));
+		ret = -EIO;
+		goto unlock;
+	}
+
+	crc = crc8(sgp41_crc8_table, (u8 *)&tgres.voc_res_ticks, 2,
+		   SGP41_CRC8_INIT);
+	if (crc != tgres.voc_res_crc) {
+		dev_err(data->dev, "CRC error while measure-voc_raw\n");
+		ret = -EIO;
+		goto unlock;
+	}
+
+	crc = crc8(sgp41_crc8_table, (u8 *)&tgres.nox_res_ticks, 2,
+		   SGP41_CRC8_INIT);
+	if (crc != tgres.nox_res_crc) {
+		dev_err(data->dev, "CRC error while measure-nox_raw\n");
+		ret = -EIO;
+		goto unlock;
+	}
+
+	*voc_raw = be16_to_cpu(tgres.voc_res_ticks);
+	*nox_raw = be16_to_cpu(tgres.nox_res_ticks);
+	ret = 0;
+
+unlock:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int sgp41_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val,
+			  int *val2, long mask)
+{
+	struct sgp41_data *data = iio_priv(indio_dev);
+	u16 voc_raw;
+	u16 nox_raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_RESISTANCE:
+			ret = sgp41_measure_raw(data,
+							   &voc_raw,
+							   &nox_raw);
+			if (ret)
+				return ret;
+
+			switch (chan->channel) {
+			case 0:
+				*val = voc_raw;
+				return IIO_VAL_INT;
+			case 1:
+				*val = nox_raw;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+
+		case IIO_TEMP:
+			mutex_lock(&data->lock);
+			*val = data->temp;
+			mutex_unlock(&data->lock);
+			return IIO_VAL_INT;
+
+		case IIO_HUMIDITYRELATIVE:
+			mutex_lock(&data->lock);
+			*val = data->rht;
+			mutex_unlock(&data->lock);
+			return IIO_VAL_INT;
+
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sgp41_write_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int val,
+			int val2, long mask)
+{
+	struct sgp41_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_TEMP:
+			if ((val < -45000) || (val > 130000))
+				return -EINVAL;
+
+			mutex_lock(&data->lock);
+			data->temp = val;
+			mutex_unlock(&data->lock);
+			return 0;
+
+		case IIO_HUMIDITYRELATIVE:
+			if ((val < 0) || (val > 100000))
+				return -EINVAL;
+
+			mutex_lock(&data->lock);
+			data->rht = val;
+			mutex_unlock(&data->lock);
+			return 0;
+
+		default:
+			return -EINVAL;
+			}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sgp41_heater_off(struct sgp41_data *data)
+{
+	u8 heater_off_cmd[2] = { 0x36, 0x15 };
+	int ret;
+
+	ret = i2c_master_send(data->client, heater_off_cmd,
+			      sizeof(heater_off_cmd));
+	if (ret != sizeof(heater_off_cmd)) {
+		dev_warn(data->dev,
+			 "i2c_master_send ret: %d sizeof: %zu\n",
+			 ret, sizeof(heater_off_cmd));
+		return ret < 0 ? ret : -EIO;
+	}
+
+	dev_dbg(data->dev, "heater turned off\n");
+
+	return 0;
+}
+
+static void sgp41_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct sgp41_data *data = iio_priv(indio_dev);
+
+	sgp41_heater_off(data);
+}
+
+static const struct iio_info sgp41_info = {
+	.read_raw = sgp41_read_raw,
+	.write_raw = sgp41_write_raw,
+};
+
+static int sgp41_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct sgp41_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->dev = dev;
+	data->conditioned = false;
+
+	crc8_populate_msb(sgp41_crc8_table, SGP41_CRC8_POLYNOMIAL);
+
+	mutex_init(&data->lock);
+
+	data->rht = 50000;
+	data->temp = 25000;
+
+	indio_dev->info = &sgp41_info;
+
+	if (id)
+		indio_dev->name = id->name;
+	else
+		indio_dev->name = "sgp41";
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sgp41_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sgp41_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		dev_err(dev, "failed to register iio device\n");
+
+	return ret;
+}
+
+static const struct i2c_device_id sgp41_id[] = {
+	{ .name = "sgp41" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, sgp41_id);
+
+static const struct of_device_id sgp41_dt_ids[] = {
+	{ .compatible = "sensirion,sgp41" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, sgp41_dt_ids);
+
+static struct i2c_driver sgp41_driver = {
+	.driver = {
+		.name = "sgp41",
+		.of_match_table = sgp41_dt_ids,
+	},
+	.probe = sgp41_probe,
+	.id_table = sgp41_id,
+	.remove = sgp41_remove,
+};
+
+module_i2c_driver(sgp41_driver);
+
+MODULE_AUTHOR("Akshat Chandra <notmissinge@gmail.com>");
+MODULE_DESCRIPTION("Sensirion SGP41 gas sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.53.0

