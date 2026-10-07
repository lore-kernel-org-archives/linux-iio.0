Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFD412BEF
	for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2026 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406296; cv=none; b=K2AkgGtpjVEc/sDuWrl1J21AFCbdAdGDteddFcF2y1OEmnb1O5Q2m2Noq1DyytExxrANYBO+F9HLtxR7ufHOSLZSe1GZ1Di/wfWFikB0CP5pfx0kRoAj7sSxh45OQSeMXlLnoSyKQZrVms5oE+0gNn2SMRfjMMS29+2i2AG0JrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406296; c=relaxed/simple;
	bh=IUjTvutruskVLIPCocxsMq3AMnCG8k4rLuzXgXxgVHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se7VPIBcFf3+e683asgqHKgLc2Fx2+vxQKpWh/uKtZoMn9MVvDfXUYVm9onINPVfj775y91nhOb2vAa5kKqBEwKlYNotbOkJxk4bCQkKwHoZUM7iEQuupkhVVZilnHJXtrcMS+dgAu4e8DaMcdjP2a/ZPsuSd81LbGu/3dx/U5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=i5fqr419; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i5fqr419"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406291; bh=JD4y8Fqge2keXRF5cOCIjxyZUSCTIElbFz1vI3BgQPw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=i5fqr419sM/6ssbR/iSszoR4ANuvysNAHt98gv6aoD4KH1dXzipoFoNOLePjzyzmGMKhqdd3HQekmZLkK75fXIIVNwFReNGg9SeVPOzEySgON4p+NP1ptjd7HuzUlk31rbn7x7+8rYHmYq+tuXNnxSJ5Dl5owWRAftQ6PqjBowjKXL/7yr9HYCcQww+TOy/dWQM7zKkz70C5hN6fpnubG/2DQzXzi+3kA5QVlYYNBhbAR32vNXBJsl1TMdf+TKIdcxtubg2rFmAtvDQZB1dPYx6nrwrvozfml5bNguF/gh+e84mvD99TtuFqz/Fn7bytZayq0G0P1zIAsgEos01h3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406291; bh=0vZsfiVu15MGIAUX53NXcYLkl15tzYVHTSS6ZWsu91r=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=p3klgAIsoG0vTQNdwkVaz9obITuD/z2DAMyS8QxhyuMAujEuJzmndnvK0ng/BnSbQ02jZHeo8uM6UkeAQzDkSiLQTf94FlyS27Vue0u2tJV4X+6XIWPbA/mE0j7NfJW+hBWI4fZvDoKPx/L+PxxlPROgmbGMf6nsIbA+qH/4UJfvX3ayDnavfK8HSfBtL3mORM4x9nXP26OWy5yRsYAoyrU1Bwvm5GX6oOdu4AliR1hfj8DDeC0IzUlscaZ15TSCnuaCkYL1FtWxpu+qC/ByK+GMmlbV/xKSe7J6bnbuZDR25GIMY65YR/ZaGwCRZCWmi9/2YWi0nxtKEo4Ng7OlFQ==
X-YMail-OSG: s2eUqk8VM1mydC8K_qJZY7qMv_052jQrbez8LclKjxFl43HCNu3o5F4vl1LReal
 RalfLyllYGYWnk8WWdwQrLDLHQGwMoFmpuct355_sXFUicYq5J3nyc1Tej9eNM2VuRWRnVIiyEq.
 7lBxI_i8q9CNu2Rio286sCkvA1lM7L8vGGK8EXTy4f7oCo8YvtTjPc0et7Ln.UP0qCwQcqs_oDXu
 QIJciYiOb.wWNbh7MmD1qUFcqCULxtaXipFOHyeTFXJoYoalj3zDmHw71FbKZ8mfzqnj9C40vrGb
 q.SGrqMOhj.IrmJ_O1uX1BiQ85jqfAK2NIe6BYh1dOUha2mHjBvTHzXwa_PWDyYGsokNHz0bTV4A
 k6EohXA1A5IYGtOMYLuJ1NFJ2irvn3X3jp7yTAWlWKDu46SLf9a4jYMa_v2WfUoyf.FNkaFpoqfr
 KLM3e0ok3pyd14CpGvYA1Wks9saTjeaun4elZgFnuX.YZVWg7N743Bxae_g1qX4DRZyQuriUZGxD
 XV1tsOa_80f.1QkB7x2BFshihVXjPCca10SoWSVEP02x.UvIk09978BfCMD9BsrwZwaPCf9aHm4i
 xWH31cSaMFgBLFI7EKFpeG.xF6caYstw52imhepx4xTEj5QsnI3SRug8wRnBQbOrglwySfrJx5io
 2MH71IyeknL7YavGvSx9G794uQg9sl._9h3.7Q96QDc60wQFo5QcebqQV1fjxw6gkTECPPA2LK.n
 a7zUddZcffVSpCDEW.iSSbvIDbjz4PINBCG0TiFfcPXyoRq.5WrArw5RQqJxZspBB8PGmxlyqMPR
 iwo3wctafCZq5Ok5twK9e_8EJIod1SM5cBzmU.pt5zaaNHgiQoC8S3MGCl0ShYmpFfIeZZUyp2j5
 Q4gWWdcouQpmVSYGdCLwQ1qltB11uQOJrv.ulIc6anH7A3xQiZv1LaGxbnP5q.ciCz8qi44S9Iys
 h5bWENaqdBM47Z.V9ozt4f_9XiV1lrNE5BcpmnXZecSJUfRNCSSwYUZ.ALeCiwGs.GOJPCASUpAF
 0zM7D6EiB02eGtzk2726sot9.miQjV5.00LyFE_6Iyl0iiT0R6dWMDvSDRM2MqIjX.rv1_feVzGk
 3cUrKZAF6iLjKMTt2ZJWPEm2nx0arRd6BoxvZPcr3ozR0ieXS4lQHUje3oS2LAjRdCd9v4af6lj2
 f.5gYwol_Gt99IQoiahfvx0VCx4oXFApwzkR8QigHSg_X8xepJdIcShaUl2W4GgSB6XQIHLzxEcw
 WZuPUMpgzBomrKV0C5HkstDmkDcvPctHLTdH1GXGHO0T9y2qt9M68D_zOLOnb35HhVQ.pnNw4KDR
 jlE8SuoG1l7HnrXN6sImuw9Q85R5RHHij3eq5ikrWyuLJlFnti88K6LXfEZEehoiOUG54dkjOCy2
 OWmnwer5VNvKTvQeFdLmWxAH.ZAFgiiZVOR3soRJ9zIcWZXbqHbfsoKUPAfaAT83KLvHjxRSIwzJ
 cy.PbQFjVcTekzUPUCOmPJDe4QsR13CCuqIhqAvaJBGBbBHaXXHnhY7xAyn5wxP2PkOddj2UwfVu
 Q6cWD_2Hc7O9MAdUMSCaMp3k8MzQZg70J3sUhmGVyLcBfUrYlbpqMvcqYQ.MBPTG6GirofeEuufJ
 58AqT4sHt6yH2pXgceHB2qHv_N4bAIe_nhbRyR10w7rEeuc4dUmS4LypW9bKHG7k8yJeimP8qhp3
 GItWYjzQ9f9Cj8yFeR2jevOR1IwZhXkpJ9CJiTLls1.TIAhqqgq.JrnKBsbWfbPTpRQCjK4W_VEQ
 smJKJ1ovVS7_lnk6G3rBg_JaZbGR4CNqKYKMIpuSY8kFBimzQ2nBO2lQf.lXRENjAobfV0So4EUU
 8y2WmtM61a4EPhoisaD8TEtKUC3CH9RZ68n5AX8SvpdL.COvuwpqDqFAiak38_JczjBNFgV7QRF6
 _XtLngZKIdory3aR9rEMyylecesL.2Q7f_SFQTOmUTUS_SzQlzM1m2VCwg14FXgGnyycyqwIJiqg
 gFhhJJUHydDAbGqZcf72K5fpfLdiFeiNcaxCUDaaNOdvK9Qthe4bDBxuxfqXA7fuGnqEE3hw-
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 68559b8e-2174-4ce8-bf7c-8f56cfd5d1e9
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Wed, 7 Oct 2026 20:51:31 +0000
Received: from dip106.lsn.bf1.yahoo.com ([67.195.177.115])
          by hello (SMTP) with SMTP ID 91bb27b55516d1fb42642a09b5dc36d3;
          Wed, 07 Oct 2026 20:51:28 +0000 (UTC)
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
	m.abubakar365@yahoo.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Thu,  8 Oct 2026 01:51:04 +0500
Message-ID: <20261007205104.4694-3-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007205104.4694-1-m.abubakar365@yahoo.com>
References: <20261007205104.4694-1-m.abubakar365@yahoo.com>
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

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/pressure/Kconfig  |  11 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp31.c  | 243 ++++++++++++++++++++++++++++++++++
 4 files changed, 256 insertions(+)
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
index 000000000..cd4c74899
--- /dev/null
+++ b/drivers/iio/pressure/sdp31.c
@@ -0,0 +1,243 @@
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
+static int sdp31_read_measurement(struct sdp31_data *data,
+				  s16 *pressure, s16 *temp)
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

