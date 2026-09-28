Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71172501F41
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632515; cv=none; b=HVpIOLt9ta5Qc9z87gKD0GYQdCvU7F2qM/9Li+lvXAkS0Zgdd7miS3FvNU2XWHQVxBXhUKRMKJ4+P5HqyaGn0uBlagRMG+QyO7pxCc/cw0f/69pac9UI1KkQqmW4U4y862b3x0xGMvU6rseD0Z6Kb2V9fZUjfm1as3quesFvmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632515; c=relaxed/simple;
	bh=zGrJVdOzWjkfx2WYIs129yNMHaK1Ln9UW7DlfJN/oUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBTC+3CLXFNQ/FtWUq964LC4TQB6Cbvq2DWOUPYJEFHG/lG9tKXdcVj2Y09hW4iJs9iT6cOvRWJsYVshTTwqGGT8uZztqDFw3T9QZ1zzU108TqkwCgy9moP3YGkvAoAxKF+FPLXx8BcfC6EKZKOeCPlqJPpbkqycZHzVdl9wLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Uk6Iflo8; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Uk6Iflo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790632501; bh=CkiLu01mARW0in5NkFKHsIqJlW8y08P07/La7De78gE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Uk6Iflo8Ua0izqdSZrxpcfBqe8WZYW/sQOhAy9cOUXBLt7L+evbkAX6W+TFBEwzb0ZvzqY5dRFPXAjUIVHdXA/DTOfqQ3UEr8jf/nyz14PLAmy0t4dkrvdD9V6flEsWV33Pie6AThMyg/8i1y8QJdMKum7SnKy12MCHGZ4LVwHkZBdpBm96b+sBgKhjJzQtmWI8O/jqcYt6qZpCRXgE+IpUWmq+WyfSj3Bzve9G4kLyLqAbnodCgSh5IGj+s+UpG7Bo6ADheqkdfRZVN+gCRcgsQsEDgL2NCznvh3Qtoe1WsEozK94iRtX6UFUNNwEIjNY5LRvI2/nnN6o6EBsXDxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790632501; bh=SZxLv7pU3DEnu1MkNrVxiv1Z/S5bKXeBqLhyCe4q3MS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XhynZ4Cp2LhFrsayA/mxwdoY6lFw3/1/gBJO7viYshZK3D48lvb1DItfZNrPyG3DAPXob9vhZGeJE+DZZeb+YjJSwDcJI2WGVHxfOAAItwYTConspbl+R/FiyXyUgsYMZ6NW8RyKqnJRwHJ0zLo0DoGVwUKAiC2mSHP6kZvCKipauG0CUU/lLcLDh4Sag+vUD8t7m6H4QM/+wfolTWoyzSCsjBmssvBx9ygmxAyi8ABggvZV+dxH4XdqvQiUbpI0klhE19UoG0wHRM2B6BHXJYdk2tUSC28RK9g/H271Ju7onTbY6NTwlTIOdslJF/XZL9N0jUZJatTkbefWwjU5Hg==
X-YMail-OSG: ShlSD34VM1m7uTFzsaf97wH_CcG_GVLAUVtARjOeErKL9T7Kuy0FXVhW8Qtmyck
 IEaMNES5C_Jj2_2QIO8LgxArqxTRpsnBAMth._5Hg8Kmf5PmmyiwBXxq4WTNIZrhTKskYFjnmUG_
 L9zv_jq897u6Ll.KQgJ0XST.0htal.LuOPfX0gyBE0G03tdfO0ZlK2LPApCBE.1zp5EjOrSfoAme
 fUQ.T_gE15uqtOcJOs0cmCTgSI53RngnuTIjlqR7ICX2ahePIfIvgLjdyJwVqfQEzxHHuKQieEfY
 V0GAiAXZ0jxEwKqg3LwMWhBg9sRerPqdnZsnRKQzALK7P2KmFOBergor7gaIATPgsRiQwyMRNfee
 MiXwncy2qiDNyQp1tE1ww7z82jxTZvfTJFpl5fe_pZKOFfKtL7bkAinQgVkOemUrHZkmHhd7I6hK
 2IqAt3WXGvb3hjPLxIPlJjgdabGZM_Su5Q5rbvHXZ1qJklW4NrzTNTiNi4sazSpdbWwbDr9s8iyL
 qztuE0Gko._ThkheUHDpIlZT0jYxjq1gQwyYf2xsLQSoHTjPpXYLodKH3LROAye6JvhmEeuxwMSG
 gguI9tyegDpvyODDqZzBoV7sUEAoYMv9q73rYWg8C44o0jp3coPQ_dSO.aPuZRAIrt0oREH8Crod
 sId5ACyJXXdcAug65hsysIR0i_upaOAPTe3qrlYwDFydNn.ocGFMgo4IGVrRcO0riiJUjeVM8Y8T
 2NTXRWf0PFzogvVwDsmHbjZ7g5AAaHR6SmS6ssSTryJLNAsyRZprHHOKOgFFZKdRkZYhu1tXY7Dh
 jhRJPQoPQgxdx9wQy1sdE.WodXd.YNanWDTU7KHsIwGCNWlm9LD6tJH_PPbK9tXjXTJ1hQ7LgPlt
 xNJI.MhexEIL4wt5f5zBoJeX5vb8hipoa.hVaGcAOfYcWHcohUx8v79MHOuaApE6giVSJ_L1rYUd
 bVJ142zw6OdqSEUm_uftuxdo_4yEs3rp9y1cESGyv2r10GEyIP85C9zfvREWKEo0lfJwbLZ_izd0
 33kltDCrjZBKE5Cj1ssBWKSZFaMb2NwvgUTqKGxIKuea_6Sw66wmUOd8B0I_4gUq4PgCBiikx7qO
 noBawayLiVoim8b2TgXEKRV_9XlPdBoI1wwr_sKNK5KmMWwOQ95lmEaVxsY7MdX1fe9gJPJJyAkm
 8l9yVyDFytknex4ywg6slngop8ibgJfoiKXSfnYv6zzLeJFwZ4wOdRfbVeZZ2gpM.56eWmvFvHkq
 TKLNgIwFNdDfZke9nv607DKkc6p4ERGEHmJ_gP62KerUs6cEDQqnknNHGsAPb5puH2TGE9YxvzM_
 0TROSjbU_I2G7pNmSaF5Zj.7wVrZ3mWzeL_0.FixS905vNjpMf.RxHTyJwCXahAHdnQgukKgUMPX
 ocqH9nIxPfFLYMRTb68iZ6S3RDMigO8E8VLYVc6AAKEDO3aNbw4pyZoOmoSUkTJ0Y5J7_xPsfK6T
 4gzpS4fik5.CYXf2R6xHKzsDXmvyBiW3JoWSaeOYnqGF_MIEwh0sapCyc8b2UnGFVnq.pHLXJfWi
 Iee2O4kvSJk8Oh_g9nYMgpNE0b7CMThe_PlsLN1ESSn89W3iyQPdcwxVNg0RyhfjL32RFOy38n1N
 rNin32i8X_nt6iBWK8TZnOzizO1bOwFlLN2funMbJ3_Pm92fa3yLZ4XQdYTAJC.b572TclaKUyEU
 XirDLa6metDIGlRvV5zH2__GVMYg3qeQY3eyX8mq374AXdj5uYuqAlkcUsILPnJW7IdYXRwvAl.4
 frk4NCudQvkuqfA9maXeg6M2WO8KFkQyaBsoujp3IcJGyKmdpdHi17AmXhShkd16ybYmQkeeNP.1
 avoRF1ZSW6goqfgxBpoPwvWI8y4JGk6ipwHkVkssCjZUeS1CWBkA91pOWEYo.g9LnTPgKsxFqKVz
 86HpXCM7Oh7Y3Lm8qX6gv6BXaviYPgTdWuw779ndAXktpgqw.ynSkRDZCHQiiXQ3J59B7afWvUBl
 8F6Wlo6oEqDVtgTxiNGe4Q3PidiHyoaRILdPw1zT0zPxuW79OWotilSCehAqbsGdMEIPwDg--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 05e815b6-7f36-48b2-bfe6-97a724c65de9
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Mon, 28 Sep 2026 21:55:01 +0000
Received: from dip75.lsn.bf1.yahoo.com ([67.195.177.84])
          by hello (SMTP) with SMTP ID 76ff639862f4e2dcd2f1f2eb210a11ab;
          Mon, 28 Sep 2026 21:54:58 +0000 (UTC)
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
Subject: [PATCH v4 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Tue, 29 Sep 2026 02:54:22 +0500
Message-ID: <20260928215422.3720-3-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928215422.3720-1-m.abubakar365@yahoo.com>
References: <20260928215422.3720-1-m.abubakar365@yahoo.com>
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

Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/pressure/Kconfig  |  11 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp31.c  | 241 ++++++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+)
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
index 000000000..78ab776ab
--- /dev/null
+++ b/drivers/iio/pressure/sdp31.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Sensirion SDP31, SDP32 and SDP33 differential pressure sensors
+ *
+ * Datasheet:
+ * https://sensirion.com/media/documents/4D045D69/6375F34F/DP_DS_SDP3x_digital_D1.pdf
+ */
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
+	*pressure = (s16)get_unaligned_be16(&rx[0]);
+	*temp = (s16)get_unaligned_be16(&rx[3]);
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
+	indio_dev->name = client->name;
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
+	{ .name = "sdp32" },
+	{ .name = "sdp33" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sdp31_id);
+
+static const struct of_device_id sdp31_of_match[] = {
+	{ .compatible = "sensirion,sdp31" },
+	{ .compatible = "sensirion,sdp32" },
+	{ .compatible = "sensirion,sdp33" },
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

