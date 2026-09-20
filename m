Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B773AEF2E
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922921; cv=none; b=GG5XLFuUAGKxT4UiolLH/wEx+XphCtRy4o6SJM+VOJKrocUzyAG2qtdqhMHCeMvu9dD4/VVRMrDGiTJUqh3Ff043jLcQ8Heh+zJxFmSmHj7j9Fw6Dn6VHWVDTMQsDQU6OrOUCT4G/0Sc5wdkyOod01uARKKpTRU7WgFUOhIMrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922921; c=relaxed/simple;
	bh=M3TwVQSxzL8OTtoIgvRUVZ5XdCvSGNTwXSq0c8cgupU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkomLsXlS2edSg2WJN70fpbBjbK/Hf5RqjeXuQrQLQr2bUFc+tFP5PAdxbfpZ8+MZlMTNfqt/ae5wjO4B9SpNXh/OpyS4Ly8xgT0lvoR2+TvDRlKZ66DJJ4BF3lNw6sJHZSRtuZXWmyT7RY2W1UwPQZBq/nYOfzLY0OTIpRuGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=s4roq/Hx; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="s4roq/Hx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789922916; bh=VirRgdhWA7/WF4fUS2RhE//kdKRIQqItbSzIjEB9TXU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s4roq/HxjTxn4/vnh8kT47a0uUkUrsaPztvtK+1UrQdzmuCjdq7QsbkrBUE/u21uHlpVPxiim7jvscnu4sfAHJ5NPjYmyGXyt21ClFYcvsEjdLk99cnuOiG0jVS8mSdPqe8wh/be2pyCHKL9rt4dCW2fIz3oY1zpm81CMSQlwPtSGdzdGYgpZf1Nfu9azfn2YKQ2aN0XutmLEuF/VIdwTTYCFbXYjCwOAe3diqOuDmEnf1GC8QFPbZ2c5F4CeNKbUC2EtN4DU9DI0acXX3bc+hrybBPRub8ln6I/nwf4aVS9BwBxcTchxDrtbjyvKHEXnX5s9+9a7aLphexseeqw2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789922916; bh=Gh4/nIO0jl3MHnA+0tRI4sYM/IANXn6Axar+aA6uyEF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ICfyFJune9huwB72LJFZmtTEI0uWRQPT4abtK1f754jIcNduqsCsD2tMtsblTLCN3LQY9J4nmTgaLNxCYuiISmIpnjchQCWdMGsEU44ZNMis0zkbNMDZ8A/v5ilul18ZuwEJVKvMedKACYjWYm2wl9YuvUMnlDwWYHhPpNy/lx6PTmBJtrPqWqAg75GOBm3IW19KIvHMdrLKQrVvbXqtooNuF3b556ggWl8k4qOwm2U0Jm5rHpfii96/RyknexmsNeXKytDeSglcNsb+sr+ELs/UwOzRnZGC+sS9OEQMx0ymzy7IXXu9yoclHVDsY7Q/RycQkcDg/EHXiFTVLYIrGw==
X-YMail-OSG: Oq1WP0kVM1ke5HTfILwXWquzN_XITO5ewqOZwvbbasfz3zEBanKZH.bjkBWBLtW
 mN_.cQgzjUdiE2wTebaHdgPROxnXRXe.eEEfQ4G8sTb8VpAn6MUpEYhVWq7CU.fti71tbka.9fgC
 tfix24giX0bg2pv5JWLOghaq5Rw5f4Zq4Jw0n6xR2DC9PJIKl0loGVs9Po_Oj8rKKlOLpGcDgFj3
 WRJAjFUeQIFfr32USHnhTuNfFL9Zz_rT1ShkOOQz44Ic43d35jxg3S2S2FSrJ9z_kjc2ZjbVe6CV
 FWtQ8V6OLPUNQ5cwfiiMXeVk9LxvET9b0dnKbl3TyjIz3l.rzXwEo.nO4ZuHk8FLiYBlGtI3FUsW
 KB1rY11vFGkUXX.e_Bh.H1QNWaoG_MSNXeOihmq.abf03fd04rzOPkgblpWFgwvI_l8WvolUTVL9
 S_PcbHyasRtMQsbC2BpYfEH918Ob5KK_zPQF3DoRvB3IsmvuWclbc9lxFmMpu2eWkytNj0PGj9RL
 yIUw_nYlT4oT3ymy5ftQirGmhNkLS.bi91jSPerHnh.YZ4h9PJSczV7bGSmE_Ni_BaIpPjycupsE
 9.9yCs9JpiufeldKXpNQ0Z9zscYcKyeskmFtbmsiNGIiMlkqxzNc8BR8EwiCNnEG9MWADNHHPq9A
 eg77ZCcd2oUxBxQ2bDsA5tqex9bqInmydUYHtuScG_1s3OborqgVsODWk0Vsbdi3tJCTlXl3v2XP
 mjTWxHmsOZmBFFhy2.Zmlssu5U2.JvfZRD9RpXY00fGj0sdBd6kc0NgXWx0Mzr__QleGQteX3w7V
 7g8_4lRNxl6YZvjC1EKdAk4MRHHlji3MjtPlaFdae_vWW1BzyTc7jkKftkEADH_QZumTJZaVA.wk
 ZIfCyEWr1zWceu_zFIb6BAKel.fnIUe3_Pv5x3Lg1xMQS1kLKIoR_QW97SVqYpZUhvJRS25g6zEi
 ByiokjKG7Vdqpcf4j1J8bK.vNWWD7XGNZZvvuSJcy6xWdavdqa8DfASYBg.TLUfYGxZE_CjAnK6i
 onIDFINY62ejOb0MAh.NXZltjcvJx3wmsK.RzFWGBCuXgZZTAZkXWIpe36IMCgevSrU3Lh11olU9
 OQR3zxqfQ09LDhgf2eLBdgYUQUKQcvH.Fj_rVgDKrsgJO9wuITjwG8qVFwrz3VQKIJW4cl43ZnRp
 vx63Iuvh7Aa.107kRJQIqJH2NKJ.5A5mp3MDAg8_GGNdQliMJUKcOOn7mlLCZfEQ2bqGz_OYOwkj
 wubWxuhfi0xzlzHX6lkExoWIPLF2QFKFqQWXC9aRTgNmhAXZQnmDL13CKwgwYXY.kWjL1Q0IIIHD
 DBwt0y2oiuOfJPwbhdHIUGigrMtSG0.DnDjsJXrNcGwU7D5lCpkebcaiFsQLKDazxBbYzyy12Env
 R1zaN_Q4H_8ipFizcYQgNY_b94EZVENnRUN3LUdSNdZ9OQhUzgoSErRhn8qadaEC3z7STVnLUXbg
 7tJsN94o0vBxtcvYZll2nHtjGPoGeA50j5zZWoCpVBY5f5ZTKHjHR8Py.8v5u0z0bsA5JaPJqLS.
 HwKXzWrfVmVXypP1ce_NhkVJ6hE37q8G_o2RWw8yxreXRDlFWdxtqwD.vNGeE3OBFrmaVP5qn6U1
 Q8fbCns7peH7A5hHVKXZF_W5YCRMrwpuUHG8Uk3JTGBXfGzEjX0trZmDJDUA6qSBA4XpKgn0ZEm2
 2PU_oX0Dd6TWPE6qJ53K_d7ei2n4m_MVeCk8YI56ngUgeFdEceHIKz1521ihxujV15giQZ7kQfol
 KGB6ctIlUcv6pzet9QOjqD4M.ZWfPedIpnjsl3Mq05XOgtEH4GdxWPE502QigJStJAsAQ5FF4Tif
 norM0LxbhGLQ3F3c3iIbh5Au3N9uFYhbyP_myUCuBlcwk570WAyUZU7.Tc9ZJn_2Gu8qYqSk6NQP
 sQhHSsZLMehnDF2.Wvsff8X7bCVFgPifkjJ1_8smmCCpMF5rw5Pgq9SLTIKPVMbmHGb6Yor_Vy8N
 aqrFWWOhfmQK944vRLaiDJumR9IuBMQtOqBneJUcQ.M7Oa2tpDVi4M5ixzuyblLo_nfLX
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: aefa5b42-fc18-47f2-b05f-e46382c86173
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sun, 20 Sep 2026 16:48:36 +0000
Received: from dip55.lsn.bf1.yahoo.com ([67.195.177.64])
          by hello (SMTP) with SMTP ID 523daeaa0215dea57efbd4c0222e20e0;
          Sun, 20 Sep 2026 16:48:32 +0000 (UTC)
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
	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Subject: [PATCH v2 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Sun, 20 Sep 2026 21:47:24 +0500
Message-ID: <20260920164724.32019-3-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920164724.32019-1-m.abubakar365@yahoo.com>
References: <20260920164724.32019-1-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an IIO driver for the Sensirion SDP31 differential pressure sensor.
The device is accessed over I2C and reports differential pressure and
temperature. Each measurement is validated using the sensor's CRC-8
checksum.

Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.

Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/pressure/Kconfig  |  11 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp31.c  | 209 ++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)
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
index 000000000..e661a7af8
--- /dev/null
+++ b/drivers/iio/pressure/sdp31.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/once.h>
+#include <linux/regulator/consumer.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#define SDP31_CMD_TRIG_DP    0x362F
+#define SDP31_MEAS_DELAY_MS  50
+#define SDP31_TEMP_SCALE     5
+#define SDP31_CRC8_POLY      0x31
+#define SDP31_CRC8_INIT      0xff
+
+DECLARE_CRC8_TABLE(sdp31_crc8_table);
+
+struct sdp31_data {
+	struct i2c_client *client;
+	struct mutex lock; /* serializes access to the sensor */
+	u16 dp_scale;
+};
+
+struct sdp31_reading {
+	s16 pressure;
+	s16 temp;
+	u16 scale;
+};
+
+/* #2: build the command as a be16 and send it directly. */
+static int sdp31_send_cmd(struct i2c_client *client, u16 cmd)
+{
+	__be16 buf = cpu_to_be16(cmd);
+	int ret = i2c_master_send(client, (u8 *)&buf, sizeof(buf));
+
+	if (ret < 0)
+		return ret;
+	return (ret == sizeof(buf)) ? 0 : -EIO;
+}
+
+static int sdp31_check_crc(const u8 *word)
+{
+	if (crc8(sdp31_crc8_table, word, 2, SDP31_CRC8_INIT) != word[2])
+		return -EIO;
+	return 0;
+}
+
+/* #3: takes sdp31_data and holds the lock for the whole transaction. */
+static int sdp31_measure(struct sdp31_data *data, struct sdp31_reading *out)
+{
+	u8 rx[9];
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
+	ret = i2c_master_recv(data->client, rx, sizeof(rx));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(rx))
+		return -EIO;
+
+	if (sdp31_check_crc(&rx[0]) ||
+	    sdp31_check_crc(&rx[3]) ||
+	    sdp31_check_crc(&rx[6]))
+		return -EIO;
+
+	/* #4: use the unaligned big-endian helper instead of manual shifts. */
+	out->pressure = (s16)get_unaligned_be16(&rx[0]);
+	out->temp = (s16)get_unaligned_be16(&rx[3]);
+	out->scale = get_unaligned_be16(&rx[6]);
+	return 0;
+}
+
+static int sdp31_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct sdp31_data *data = iio_priv(indio_dev);
+	struct sdp31_reading r;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = sdp31_measure(data, &r);   /* locking now lives inside */
+		if (ret)
+			return ret;
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = r.pressure;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = r.temp;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = 1;
+			*val2 = data->dp_scale * 1000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			*val = SDP31_TEMP_SCALE;
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
+	struct device *dev = &client->dev;   /* #5 */
+	struct iio_dev *indio_dev;
+	struct sdp31_data *data;
+	struct sdp31_reading r;
+	int ret;
+
+	/* #9: get and enable the sensor's supply (auto-disabled on remove). */
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = devm_mutex_init(dev, &data->lock);   /* #6 */
+	if (ret)
+		return ret;
+
+	/* #7: populate the shared CRC table exactly once, race-free. */
+	DO_ONCE(crc8_populate_msb, sdp31_crc8_table, SDP31_CRC8_POLY);
+
+	/* Confirm the sensor is present and learn its scale factor. */
+	ret = sdp31_measure(data, &r);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read from sensor\n");  /* #8 */
+	if (!r.scale)
+		return dev_err_probe(dev, -EINVAL, "invalid scale factor\n");
+	data->dp_scale = r.scale;
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
+	{ .name = "sdp31" },   /* #10: named initializer */
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
+MODULE_DESCRIPTION("Sensirion SDP31 differential pressure sensor");
+MODULE_LICENSE("GPL");
-- 
2.43.0

