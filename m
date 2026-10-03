Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE047887E
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043830; cv=none; b=oGxJkEDGwoCo3DuAYP84lvs7f7gRJG+ygplHmg8RIZ/6h0/in6vJ8BMXWO7bryz68k9KrX5Ehy4rW6f13jn3RIYp/s+m/MbV8YZvB83zyXj461Xh1MmxR0c9IEbTG+L+8lHJ7xApKsjWeu0qxTDPB27FyliZ/unKKgPA5Tkj1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043830; c=relaxed/simple;
	bh=u8NpCeWv2pqAArlqPqDjdyuOGuqLZryWBqNJesLo3Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh8YLBqZExzE9yKZipinw0mUscdlnoDNTl1QxCOYx+EjuUTST/ukwiFKtCq4d9aC04al10HSFHE1SiO1tPq/+B2phkCu1adC31+HqDQghugEQKPOmLZNflZv8+hXB0ux9V9tWZhNeQSugRsZVbMBvC2Fr/gk/+uMs6tN7q8nsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NpDfetIb; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NpDfetIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791043822; bh=/52KWlohJvaA6hbK6X7G5kluvxVyRMiQBxpgU8KMjKw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NpDfetIbpTMJgNhpbVc+9vx6sKkXxVoOW43Y/da9dnPQFxF5OvhpQZBIiwG57u9laZDKh45z7c67stoqZRqHW1h5P1JKRHUz5ngIwq4RfBIAHWyMR3g0oPUQNAlZQ62Sf9qgKmKd/BKrtEP9GDNxFFLVdzzinKB23By+y1m+1lGYTfcbZYkC7Yh+B9T4H82fo05bjVKTqzitEsgVSgVpISMgye+hB7SWkhr2/FgAYFWp2vqK9W760rZLSLF3PzGDRjPBNTVxawkXqb4/tKEcFTQWos9yjySaI+kJkM0nhLZIwr4tmU5lGfsC8Ag0kd8hBIsSKbnGemtTao9kv2dLwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791043822; bh=q2nTM5rTjcG8d03dII+nQxPoFcpJhE6X47uXGiQOMwn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=stMkjpZuMSaVEX/TY8kZaLzoLHTspLWi3I9Cb9Nha5TgpkIYfA7aS9MMZb0W5PtO1MCUD01jnd1dQiTyHX8CT7Y1cNqaHVaGBqYhIqTLHGn6vsCH400zgMOzwWS+hR8/PZKCER0R1bViP8iFymBHkTlgqk9dw+uJE0Na3PsmCPaOPoQKtGuIGU/I7EMxLmdvwP0A6NqmMzxSytH6ZoTsTxvPwo9VTaX881XNebuvFPGoiFq9o/Zifq7GGN8Mkgxi22L/65dsuC2kK32cGro4E4DWiK1EGJqGSTlIkspcY8R5YoZYmpN0AJ7hgeW6+/G0IZ33jQzvll1+MjnOiH3KNw==
X-YMail-OSG: vFObj6cVM1kmt3LeqHxbDsZqnPZVUgwFZlb.65BVS18feQ5B7bu.ZiV5WWt5RWL
 xaZC1uYD2RHutVOfoh0KYSDTU0WHmVmKSs9c9IM7fro_uQxhdP6oy_C6v8V4e2jVHuPRWDUceDQl
 nOfIz9Y2K__l9rsVPpFxW73Wpic_tVCb.Clu4MR5Q4s7oprqwSHfgYKRRx1l6sBV1Z_b2xKgohvd
 S4Q0gRfCzJssO3JZGqXMVnyPZRHWffAFxnuWbYuHYqfSalKJ9xA4ph_9joepjgwhnUw8RcEARQgA
 21rWTlU1ZfaazRk34EwL_Mo2nIaxTQmTFLh0c67FjjUOmpkOkotJfYlzhLLunmkvqDxTaH1MnDlM
 KUoPqBkai_aKuvrUac7d_jX55gdew1nVvvuT8wDnwTJJsoPJl17HdtaLvCC6rxvBcoLrgtOIJSdl
 JLr0bc0oDEbpgcuJ7z2rTZ_1kGGTShVLHkYd0GPmY9gFtXoZIItruD_Z6SdWsREhCgmdkRkYDOo8
 WbnF4mYAMYywrsqahkn8B0afoKXMHlIEpto4gLwoNARGheO82OFw36J7hME61kTgdQeIzD5Bujiy
 uN21rGDhkqg_hYzDhd8eWsld06DKun0hheI8jLyFWN0v4iOTGIz8gGIXHdcbQXIAoPv7QQjfUGHW
 DJ8F4Nr4EyfHvsIMDvT43gHn2DfomaRLFu5FgxemhDDcNt0t8pv3JADPKKFvHRKvGn3bEYS9q6uP
 urZW0ldrllyyea1.2GTNijWy6Rc9SwVlttO2EEYMd6u4sOH1DywKfn0c2aW2JOUHQFIx7Jo7Ic8o
 ayJpqO205S0Le4QzN2Qq4rW86NGw8gMaSrGNelnviBygnX2nCGoWW__87j_JOzqaqzkE3t0sLEVx
 M1ux7myeIlOJxeQbVp_hV4i_fIkdNj_5nFIx9wN6i9siOsaoY1LXLxCwke2k_Pf7leadclCH2yty
 F17NRf0COvxkiL53jpV8_XpRE4IqogGvKEqXHgfw89tlumgU.htCB7EIbLgD_qJF7dxKESjmu.Zs
 l8Vuko32EdehmuZKQOXsXZaToYtqO1x5VSatUXl9H8Zr3FDIZoDBs5KlWFdrnoEcoZ_Nnq.C0WR2
 vIpKkCyCS_zW7qWTYhgv9.dmaZBs9To6ewgoWg77lZ_4Fbx9mavqP478gkFGtiW8JUWSNscb9fAC
 8L2iL.mpIxj.hNYkQ6lrrji995qSHSXA9rvCGYA8yWyokFxfvdfLr.IcetvYYgAIuupwPCIdqHin
 .gC6CAyUmFkejpqcwTjjDyjXe.PuVZ8MPARd4WgmAR0_2wqHbw8IoWUiNY0JP2yu3h9cQYjQjyAL
 EJTnDdxvIbkAiMdxlFDv9Mmsi4ZtIJCuMnigV3luCv1U2Ah478vDAm_R_OL_O9UPyHZ1wizsDq7_
 IXhdP3DP9N_4QrNRCw1ExtJfI.BgQd_l0B3yYMsqZAyN3AUEwCEEXb6gomS1ezR6ZzqCyHKihBW_
 NozwDdsFLG9irf2a1TPG1w46XN_vC_ljtHLFS7GswskAhedlRbhzJ4MLNnXeG4.7jgh31c1sYcSS
 4L5sb9Y5bCTjr44ZG1JweIXF22hqf7qqLNcnpehhcblLIyMTOeDs7Jd8EaKiWctCG_UuRLOMTGAY
 ErsJBnDJSnKWOKEHxMBrNrDkaeqbvJVmehlxCi_ZAubwdvrjGlDmYBUEUlkwGLD17_fj8hVWVTzX
 10JzX0XFSjyTDujnk_ZArdS0iDapaPNKZfzPHsqRlA2vAo2Fn6Q71fMA7HSDRCoedqVCQWvrUaTR
 nBhczFwb0onRyB5mid_w_2kD2c0hXWamXn_H8MCuNL54cF9qtHhSboKdhd2Gi3LQz0W1u.rlwpmq
 uOmZBtn2pXrppoTcgvdixBaoCZMBR1X1WjzBfymKOUCbr8nCWFW9v5ZolDMG7QBkJT.dILfptJes
 M01a.yuEazlKID87YjsnJaGq.c_ewSGOLCbPAQen0OLR8Y_.tL9PH8DCWcgEr4VlUPeJMdtDaJ5P
 fZqzrZ3ojGWFd9vIH..QvwNGl48JOXqRDbrzURsfej72puTNNlJW44md7H4CHJaRP5I.1
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: fa57b3b1-a222-4adf-903c-91dd7603ee42
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Sat, 3 Oct 2026 16:10:22 +0000
Received: from dip88.lsn.bf1.yahoo.com ([67.195.177.97])
          by hello (SMTP) with SMTP ID d1c6d9a7cda80a7ad7051028df1df544;
          Sat, 03 Oct 2026 16:10:17 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.abubakar365@yahoo.com
Subject: [PATCH v5 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Sat,  3 Oct 2026 21:09:49 +0500
Message-ID: <20261003160949.4657-3-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003160949.4657-1-m.abubakar365@yahoo.com>
References: <20261003160949.4657-1-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an IIO driver for the Sensirion SDP3x family of differential pressure
sensors (SDP31, SDP32 and SDP33). The devices are accessed over I2C and
report differential pressure and temperature. Each measurement is
validated using the sensor's CRC-8 checksum. The scale factor is read
from the sensor at runtime, so all three parts are supported.

Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/pressure/Kconfig  |  11 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp31.c  | 244 ++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 drivers/iio/pressure/sdp31.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e285147be..a053a530e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24859,6 +24859,7 @@ SENSIRION SDP31 DIFFERENTIAL PRESSURE SENSOR DRIVER
 M:	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
+F:	drivers/iio/pressure/sdp31.c
 
 SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
 M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 838a8340c..58172639c 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -286,6 +286,17 @@ config MS5637
 	  This driver can also be built as a module. If so, the module will
 	  be called ms5637.
 
+config SDP31
+	tristate "Sensirion SDP31 differential pressure sensor I2C driver"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build support for Sensirion SDP31 differential pressure
+	  sensor I2C driver.
+
+	  To compile this driver as a module, choose M here: the core module
+	  will be called sdp31.
+
 config SDP500
 	tristate "Sensirion SDP500 differential pressure sensor I2C driver"
 	depends on I2C
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index bc0d11a20..5279a0ebd 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
 obj-$(CONFIG_MS5637) += ms5637.o
+obj-$(CONFIG_SDP31) += sdp31.o
 obj-$(CONFIG_SDP500) += sdp500.o
 obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
 st_pressure-y := st_pressure_core.o
diff --git a/drivers/iio/pressure/sdp31.c b/drivers/iio/pressure/sdp31.c
new file mode 100644
index 000000000..7998d3838
--- /dev/null
+++ b/drivers/iio/pressure/sdp31.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Sensirion SDP31, SDP32 and SDP33 differential pressure sensors
+ *
+ * Datasheet:
+ * https://sensirion.com/media/documents/4D045D69/6375F34F/DP_DS_SDP3x_digital_D1.pdf
+ */
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/once.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#define SDP31_CMD_TRIG_DP     0x362F
+#define SDP31_MEAS_DELAY_MS   50
+#define SDP31_POWERUP_TIME_MS 25   /* datasheet t_PU (max) */
+#define SDP31_CRC8_POLY       0x31
+#define SDP31_CRC8_INIT       0xff
+
+DECLARE_CRC8_TABLE(sdp31_crc8_table);
+
+struct sdp31_data {
+	struct i2c_client *client;
+	struct mutex lock; /* serializes access to the sensor */
+	u16 dp_scale;
+};
+
+static int sdp31_send_cmd(struct i2c_client *client, u16 cmd)
+{
+	__be16 buf = cpu_to_be16(cmd);
+	int ret;
+
+	ret = i2c_master_send(client, (u8 *)&buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	return (ret == sizeof(buf)) ? 0 : -EIO;
+}
+
+static int sdp31_check_crc(const u8 *word)
+{
+	if (crc8(sdp31_crc8_table, word, 2, SDP31_CRC8_INIT) != word[2])
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Trigger a differential-pressure measurement and read the first len bytes
+ * of the result. A short read is ended by the usual I2C NACK + stop, so
+ * reading fewer than the full nine bytes is fine.
+ */
+static int sdp31_trigger_read(struct sdp31_data *data, u8 *rx, int len)
+{
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = sdp31_send_cmd(data->client, SDP31_CMD_TRIG_DP);
+	if (ret)
+		return ret;
+
+	msleep(SDP31_MEAS_DELAY_MS);
+
+	ret = i2c_master_recv(data->client, rx, len);
+	if (ret < 0)
+		return ret;
+
+	return (ret == len) ? 0 : -EIO;
+}
+
+static int sdp31_read_measurement(struct sdp31_data *data, s16 *pressure,
+				  s16 *temp)
+{
+	u8 rx[6];
+	int ret;
+
+	ret = sdp31_trigger_read(data, rx, sizeof(rx));
+	if (ret)
+		return ret;
+
+	if (sdp31_check_crc(&rx[0]) || sdp31_check_crc(&rx[3]))
+		return -EIO;
+
+	*pressure = get_unaligned_be16(&rx[0]);
+	*temp = get_unaligned_be16(&rx[3]);
+
+	return 0;
+}
+
+static int sdp31_read_scale(struct sdp31_data *data, u16 *scale)
+{
+	u8 rx[9];
+	int ret;
+
+	ret = sdp31_trigger_read(data, rx, sizeof(rx));
+	if (ret)
+		return ret;
+
+	if (sdp31_check_crc(&rx[6]))
+		return -EIO;
+
+	*scale = get_unaligned_be16(&rx[6]);
+
+	return 0;
+}
+
+static int sdp31_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct sdp31_data *data = iio_priv(indio_dev);
+	s16 pressure, temp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = sdp31_read_measurement(data, &pressure, &temp);
+		if (ret)
+			return ret;
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = pressure;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = temp;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = 1;
+			*val2 = data->dp_scale * KILO;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			/* raw / 200 = degC, so raw * 5 = milli-degC */
+			*val = 5;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sdp31_info = {
+	.read_raw = sdp31_read_raw,
+};
+
+static const struct iio_chan_spec sdp31_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int sdp31_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct sdp31_data *data;
+	int ret;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	msleep(SDP31_POWERUP_TIME_MS);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	DO_ONCE(crc8_populate_msb, sdp31_crc8_table, SDP31_CRC8_POLY);
+
+	ret = sdp31_read_scale(data, &data->dp_scale);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read from sensor\n");
+	if (!data->dp_scale)
+		return dev_err_probe(dev, -EINVAL, "invalid scale factor\n");
+
+	indio_dev->name = "sdp31";
+	indio_dev->info = &sdp31_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sdp31_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sdp31_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id sdp31_id[] = {
+	{ .name = "sdp31" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sdp31_id);
+
+static const struct of_device_id sdp31_of_match[] = {
+	{ .compatible = "sensirion,sdp31" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdp31_of_match);
+
+static struct i2c_driver sdp31_driver = {
+	.driver = {
+		.name = "sdp31",
+		.of_match_table = sdp31_of_match,
+	},
+	.probe = sdp31_probe,
+	.id_table = sdp31_id,
+};
+module_i2c_driver(sdp31_driver);
+
+MODULE_AUTHOR("Muhammad Abu Bakar");
+MODULE_DESCRIPTION("Sensirion SDP3x differential pressure sensors");
+MODULE_LICENSE("GPL");
-- 
2.43.0

