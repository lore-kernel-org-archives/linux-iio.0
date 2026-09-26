Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB39481658
	for <linux-iio@vger.kernel.org>; Sat, 26 Sep 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437336; cv=none; b=kKmtVBtgk2nXRmLqy3DCq1kQlQ7IGq8DU49hIRvJSYnJanaA7YXNzw/MkY7SE1QoVY+6AXCPJlA+vpLE4OgA5v8XGCZLVRiEZw6lU9fgrJFDAokorrmVZ/U1LF574sYVNU944EA/99z7CD6ktjC8/uw4Pa7a+USflyeHcqfLJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437336; c=relaxed/simple;
	bh=GGFZRczLKVP0A0XcAG8ysmUq5asMxAJFXZq97ftce60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik2DXG5tZImEW7ZiXg6hpBSfI2lwwDiHkm3o1rx11Mj3ZBTPWdS2QMKSwskD+SXhRl36XLPVlhlWUiXE4Z2Mad3zUCwof6QoQStslmcT8K66FZ/L8P8fdKyyP3QomU4Rt/WF2iDsq9Pbva7DRKTyqQUD5nL5QhOedWiDc7uxe8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=J3DyuvJC; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J3DyuvJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790437331; bh=1KuKgIkJ4fllJ8ldBewxcuP1pheGl0JTELBmfX+tCeM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J3DyuvJCP5FTKiSOizWkF5YBw02pfOlFMOU2pYfc2iUCOJPb7J74vXMkewn/oDpWFaAbLqZ2UJubnpA09Ioz0aCXGhqTJ0oqYq2RxIWvgORumWTwblfmb3ASam9S6DgHfs7MPEfWz6r4pfRooYgPXDTh0ReeU4qQLNlX/jgFqzthgwJbYmHHGSu+RKz1da3Xf7I7qz0MQY214V4Yvn5adEt733B/QtAUsphHe2jkKv/e0iLiCWsLSg/ZeFamXQ4DX8cae9BLyCwDj5/W2FGejJLd0+5MqxGjxb0vrVZR1bfJ5HzjVqxp8AALQeejCJHBErfvCArm5M4Xi0ANjV2TSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790437331; bh=AiKMbQbePnHUcKpjC4QkMeBsc1uBHK90J3XLl+aoo7o=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=H0pu80Ax9WCnlBG3x9qXgJn8eLoihAUwcV8bW0o0Y2usQFcQK0eI4rCPkBACe6XZ+Qut8/41m/9PQc80VJgEhqZvrcYHNUInUT/27/GRdHXQWXojyqtnfXSfjGj/Wgx12Hgd1YfnGO19WAlKqjH/QVAELznIReffcFlE1Gi0iSSCK8rlKjIhf6c3Y2WUEN2/K75uHj0BtC+TZiPRWeEUY7IT2V7eOnDRKnajyV9fFKssl7b9E40wOUqC5Ev+nthFn3u/coutQk0Wgm86grBb37pK+x584ZUaXDQrX4RZHRcwMCSX+sp4OEFwPRYYVLK4Xb7R6FrUcTc9bSDTf0j/3A==
X-YMail-OSG: 1ghM_BMVM1n4md7AtnTuHq1bC2KhwQwgrxpp68UThVj3A8Ti2WezhK4e8z3rRdy
 tNfeO4bLUfjDOaMqevStZDuhGKYv9H4IDzheOsxmhuBhdIhGcmDjDL.W.tEIa_Qf422qpw5qagd1
 yONQtfFqSl51b_L9sOnvWeYRNiY29_k5heQhzreBn_KZiJ.G5wAYZhhkL0lnvOAFYWd5reTLY2ob
 kK3IqF.SJylObxd8L9rkPYhaNIe8Omxfu7fpwmssOcGXZC4NY7aGcvFaTsaVL5IreVr2VpZkroKE
 FxKOUZ2.ET3kPiNcrsERrNpfwX0yWOpbZV.cpVo5q0IDI004mckeLCVl6Nq5xDo2w2LhzccYSP.8
 4R5KTXuzm56hKHeQTQuAQi46sJ1GemCR.hGoPJaOcR1CV1zjc8s8LaYiJqnjf9o1Qbnw16Qq0jTA
 VTZS.xCSC.SB9ghhMB8QWrWASR6wKLxar0g1yWFdLnORM1z.nVjUQ7ld2_27GBSYz.Z6hvu0J8Jo
 uOIfvxp3kJJ.vxsabqwP9LalhZESQgpGHW4p5Pvpp0mfQl8H3cjJF3KyD4HLf.Yx66ReBu.JcLeg
 kKpirUvZkxT9Mh1ck.r3a.EoU84aqz9YxyQ5cF23dUwAiKubgCS2acbwtGSiDyYIAQ4IlZaRbkig
 l85mrNoYm6WL5vDllrhRor1LHjkehJTjygTZTH4.XHL6ruk9eL9mx_g.oNx2ck39WOG7JtpRYEgP
 oIfDv01YlmDQ_WB0TR68vDJaElkWbTh.D0M3dxHwRv3UTa66c0kEzTk1B9dbyrVz0QobX9uwoDpy
 EIERE2FjGzdENVRfJPUGxZpo98ypQEqLcOArTuI5cqaUIwvEPQs_AFCpmom9ksLOvqQxMpSK9KYB
 H6C_x8zdUqU7TRAsrIfAU8SYLOrT2guBLqgFEAHMLQ8QfyED5Du7jrWBSxtDY.BF0LnxqCU9kXFy
 gihr5NO79TI9SlhmM92mjl5KoIy04uZk3yUI9Wp1AS3DtyI0aa.ApKUg7T3lwE6iR4Jw1Mun8o1f
 k9.5CKKb1dD70iHQjDCEp0ChrF7MKSja7sGnMqYVbiSLnwrVGN_xR1aKDaby6B2dstaPxck.qq5f
 7DTUlVK.xRDC.azaDNEMaIpE9LIGSyRy71brXodQjU2XlZ.rx96TlOGss59_yG3IbJmcvGl38CB3
 sRmXZnx9HSKUSKCTQSlhkXvNsOqUPvhX6cya1eaObmsjm7SDkYFrD0BNLSnDvXx7jrQpZ99rFWby
 D_7KE6h5T4O2EwXAX_cYF1AQHJe12D9H82rAJG9DFCCOfoZ4m8zBmC0lX_8arYu.RDWgw0nM.xM_
 w2ct6URDkKQNStj4ZHLg9aNqZ8FPW_65J5HgQtqFpw.ZKeM9_enG4UMVn3KlRD3ldJqxTSSDO5zn
 hVDVywM9cT1rlKR0lqXcu9QCpgEpQsjFGJYvNXUYaNcnfSmbgueVaXGW.aJWn2w775tl7.XtdEiC
 6HmKikJTVma6LBY1l0UiuEGy8t3xIbMs8b6548Q_CzRMcDAms6ayH3bnTp35rsdamLtfHQixIy91
 e07eKJ_gsxNrr.184uZRg.8sGlLtLiJxHVxbLdqrwtjhNCqKN9AaoiK1QQfFZjxDrvRzBuU3Yd9E
 7spBai2xDJ9tI3wNLo7su8oWpeIy3AfsCXmXGiHvN_tnheV99T1rii6yEClsevJIq5Hg62D36n9y
 u_kS2kg.6TlRDVfcdk7PWPH0bZ_DfoNSeQF3zHx3Wb314Muq6sNHcEl7woNqH87jqk7hO7JaQEgo
 kgM3LHU0RebeZn_qLkQlhMFJuvQ5YbNe7LHehA0N53.y_M8zuxDxzaBmdO1_kNTYHNYdo_6Uyh6N
 IQGPyl2tIcD.zOGA61SZHDBi6ytrKeSueXZji8rbQU9GQ1osJZIcq6I_6XkeWAXUCh04ttOUZKBO
 Ohvc7i7FdeL7wXICYJP9HoRljGOpCy_A0KCtDC2QSfwv84HRA1kYB1F_BtMedcz0u0dgWxOJemoz
 RQd92eO84_nprHfLxkZwFAUUkwQG4BxLdVxBYrmOoM57CmgVxl_deY6c3Y9ikzA1EjeaRig--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: e2064eb0-13e2-439a-8318-721aa1803b7c
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Sat, 26 Sep 2026 15:42:11 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
          by hello (SMTP) with SMTP ID 46afa743fbae7daefe6e6367ec9b72bd;
          Sat, 26 Sep 2026 15:42:08 +0000 (UTC)
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
Subject: [PATCH v3 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Sat, 26 Sep 2026 20:41:18 +0500
Message-ID: <20260926154118.5471-3-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926154118.5471-1-m.abubakar365@yahoo.com>
References: <20260926154118.5471-1-m.abubakar365@yahoo.com>
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
 drivers/iio/pressure/sdp31.c  | 213 ++++++++++++++++++++++++++++++++++
 4 files changed, 226 insertions(+)
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
index 000000000..fd7cac027
--- /dev/null
+++ b/drivers/iio/pressure/sdp31.c
@@ -0,0 +1,213 @@
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
+struct sdp31_reading {
+	s16 pressure;
+	s16 temp;
+	u16 scale;
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
+	out->pressure = (s16)get_unaligned_be16(&rx[0]);
+	out->temp = (s16)get_unaligned_be16(&rx[3]);
+	out->scale = get_unaligned_be16(&rx[6]);
+
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
+		ret = sdp31_measure(data, &r);
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
+	struct sdp31_reading r;
+	int ret;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	/* Wait for the sensor to be ready after power-up (datasheet t_PU). */
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
+	/* The CRC table is shared by all instances; initialise it once. */
+	DO_ONCE(crc8_populate_msb, sdp31_crc8_table, SDP31_CRC8_POLY);
+
+	/* Confirm the sensor is present and learn its scale factor. */
+	ret = sdp31_measure(data, &r);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read from sensor\n");
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
+MODULE_DESCRIPTION("Sensirion SDP31 differential pressure sensor");
+MODULE_LICENSE("GPL");
-- 
2.43.0

