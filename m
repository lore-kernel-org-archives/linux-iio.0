Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BB3793D3
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857590; cv=none; b=Sw2QSKiYsiYHC3gyHrSMmilAl1ADyy1g/PGAj9XfL4ve7f5S0aWjZXYp7U8pj7QImtR4xduFQVDtqu/X4g1nTtA2E8P5dIqvXayPFBEaSdBb4uAlj8ksGYHCnJl4gnuBgu/dMS3MCrJlAbDHo0qJg0DUEF7tAqSJxA6q5v2YWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857590; c=relaxed/simple;
	bh=qV6SZZAYcSSwnLjK7WRAo3125KdzZGMLhBMogO24/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBcoYJMArrPT1JjL0VTyn/DWbYpKNjIQVyimxkLxnCPcuxlj5PJRr+ELjZAFLgNRfjP7JcZQ6d/ICD5OMQmXo8o+WJLCkBvAfE75cMhjJz7Srw8IQ9k/D6/xOYhrnleo2E0gXRfDoZ5gTlQe18k5OesbhTI1/zVEpx1g9SdvesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WY2KMsTH; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WY2KMsTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789857581; bh=nLm0XLvGk2KYoYg8zfQcXjQv37hTT9S6GCixe0w6YEM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WY2KMsTHRB+SL2ZPWI7LqBQ9+3snmpzPfpj/YKrsZke4OyyVu3Y8m16xlkRK1yfWqtZMwapg4yFPUqPjOyX5vmjg6Aw1NBmCxMOB5fJpmTdqHk0pkK+HU43eM3IeoMQje2//Pd8OiEah/2b8jXB/iXaZ0hHUSp4/41mvLUt1nZm3c50zcpRozXAcqq+5KvrbHuriVOUkitHFuceMWfvSjsLHNl5sG50m8tNwTxAqxwC5AQRTjgN12ZAbS3evFzZAn1dfDpYyVeMHo+WfF64G4dSpngHtheswmmJT17Kz4qietUec9AdySCzsA+GipsrG/E62TJF0hFWS39/aChjohA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789857581; bh=NwM1/Hz6AEi8bOySVKKcMWzuNxfLdCAp1k/jm7SpGTq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iT8R06bc4+FZcRrgP0HFTgtlP61174/Us4YBQS6NRoRyM3k3GoAOyY395+pF3tWHlfA1LVXwU9YgAaKB9R51HRiORF3glKD/9DEhAW3cR0HZOSyyjGJArs+PRa9UDAzRJ+JsVxvVH1AekGhC8l/2KKU/wffH263ehYpocXYGpEeUr52dlYQqp7hL33KWOplcFi9R84qHN/G7tAoi0rXwaDbVucla0vjJjk0zhGoZZnfbNmLc0t/XWpXj7GAgGKEi1tnimIDS4KqwvFpC+bFBOosTtMqkfaEWq3a4jAkZS0kPa3FU62t6roSSzGrZymPo5jcs7K3LZDJv6XtciRnbfA==
X-YMail-OSG: zFYr12gVM1lsAkWBJrsXIt_IwGiSf6k8F1IuoTvxZqhV_tyhgVWI.emqhbNFY7V
 7SusLji54zIiYWsczlyZBO00Frg2sTZbVb6r405lvqnOtd4sv6Vez.VOp61PE9OjTqVbTGPC_5Ij
 6LNdMlDyPPehHdC7Xrk4lksrIyGds5BGwHQ6Pk5GX7zRqb.JHLJQzt.DGz.9q8Klx5vD4x4MWGQe
 pHPBq3htYARIP3aP1PN.dld83aaTX49..K0wcGcsqdXIgZA3_cKiOdqoTV.VYVm9yYJYel75mesN
 Ev3vpyaHeK0GfJ4O_SU9SSHv355fWSlYtim5_3ADs5ZMi_MrFPSRruf2wUedbWsTqSSDloGDCgPW
 5i1tjJe_FGDJCTBTuWPOSq6a4pT4b3rwVW39OZCWg.sHFHSjJeOYn750IdVDkvApJfTOXGtWpt.C
 uS1IU1Rv9ZfmnJ7.LbwvsKjKeUXb5bCY3gZFNqmKhJMhz4twtVXdhShfjeDVYAbFuRKojXt6Yv2Q
 PCHaRe0yzxGyFURg576l1fcZ7DPAWHsmnL_G2RenvlSrAsA3w1QefTvxGgLret5iM7Y.lJ7loEpf
 yaQTbl9EKk.MjV_4YKzR2NF925kiHNsFSlhZxJmaAG0L5hU3OlsvFnUl21s5_VwnUbBlBlzFAKL.
 JOmLvlrG1D13nXVQKIiGVpAqPNJxTpasVrz3XDA_OW3maTDYcLrPzmj4uzsKCfwM67ayN4X2BhBF
 xIqffY5taXPBJMLAPvb4fTYJRTrLZmjvBG.su4M91hm332gbI9uOYYVGio.0GvYL2veB6vEFf0Af
 iLJ.YJojWEsiyOAWXnP0ksHN3tbO_oMmC.Qs0JjdkcKpdonQPvKIMKzX84f76PaYUH1wtSsthTwK
 AFLo20ml65sij03dwjWHyehOPFo7aa4BHvXxKu4RtauSPfVFBk8lTK7JUUfn5gzar619YmxviyC7
 OPSLlDrOKynhZ4J5NujS23L4O6KSq9BMh7ZgKNvJ0P9dmvOgk33ALezQDNqdr.Xey9YqSyBtZ6un
 RWyRMHPLBfv4pBmngnjU.ocYJxWW.BqLB6.xQ5wThdILppJQHixpgEumGH3XC3gzxKE1rEav2PCE
 WSMHVR6XJ2_OBsdYKsMsL11NUJGFVE1HuyIx1bN6XYNc0aWUMhFaeuoHwxqppcbKgO.2FMBsPQpK
 iGLYQ8sRCJ4xQC_5Nxh3A5s4kJSG7rBD2IotqRPeadfUDMBWjmGYJ_4Ze7y.dDA.Y5J4YkNaaw2u
 CDOHykjo8Qi3ynid3y3z58HDnv4bbxGlCKFWJqCf2h2D9BXxmGqNzybhNFGvcIyxObUGn25zmr1o
 poVssdx4FzlFvGwlOEu89ghV_fQATazfw7uLoHLNg9M9cMry0X_Qdf04Ljrn1hKpAYWzta6ygPJJ
 aGOeH6..I2eVknK8wmlKuefFnYTafMH0SO2KqlzlcueFKQtW5V6eqqGOOK8FS79ZMGmXTP1_0xm7
 PLQn2w.sTVpAJ9rxIkAO8xR4etQ.dfCdL7mRcHyzatR6GGTyvdZiEiVG7Y0REMKCi6jCdmafr3gj
 Rhob5Q.6L017UDS2GlADIo9yPtb4..kU.U.6V37zHDwavcFhlI8FSB8jszWb9qt_xdN9YdzP.Quw
 2XcgZLLRYSAJm_nQFuo_UDxFGtWhrT1qa_AJ3t6U7wGWERp2WuaAaUYbndfzTngGgQTOWAPvC8Pq
 a0OAdzs_SV7_N_2jaDmlNuDuDQ6oWVIzbdAgUYlcH2oJ7um5Taz2LClJLzjGibCfLoH8wk7GvA9i
 mdGWlAc6iYXHS1.X.6yXZ95FVunSpolhyz1UoAkxLp8VPDvhvbyDDROZa.1iw_E0Yq3MoQtxPsaU
 PiF2qcVIMgrZYcKYxOps7ld2AshO0KX5Bh5blf7Nisjuv03Dc94lkijP3twujN0W1LRy4W0rzsa5
 5AmRRhVPyzb5bfw4ceXF7BpzX.GLqxMAcaIa1Bj2SrWOO60DXWLhKIpyRbv16v.0IqWA3skJC6m0
 k.chbjNUhiSCPpraUD75Vlx9xgFKJEWsK4DR1oOqHCXbgYuG1CNUpiNZmXjqMIECRvV4fUQ--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 3f4b6918-847b-4314-8d28-bbf2319b44e3
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sat, 19 Sep 2026 22:39:41 +0000
Received: from dip84.lsn.bf1.yahoo.com ([67.195.177.93])
          by hello (SMTP) with SMTP ID be03fa672c94bb6c952363286c379f38;
          Sat, 19 Sep 2026 22:39:39 +0000 (UTC)
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
Subject: [PATCH 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Sun, 20 Sep 2026 03:38:54 +0500
Message-ID: <20260919223854.13437-3-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919223854.13437-1-m.abubakar365@yahoo.com>
References: <20260919223854.13437-1-m.abubakar365@yahoo.com>
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
 MAINTAINERS                   |   6 ++
 drivers/iio/pressure/Kconfig  |  11 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp31.c  | 194 ++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/iio/pressure/sdp31.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 214aeee76..a053a530e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24855,6 +24855,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 F:	drivers/iio/chemical/scd4x.c
 
+SENSIRION SDP31 DIFFERENTIAL PRESSURE SENSOR DRIVER
+M:	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
+F:	drivers/iio/pressure/sdp31.c
+
 SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
 M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
 S:	Maintained
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
index 000000000..934a3afcd
--- /dev/null
+++ b/drivers/iio/pressure/sdp31.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/crc8.h>
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
+	struct mutex lock;    /* serializes multi-step measurements */
+	u16 dp_scale;         /* diff-pressure scale factor read from the sensor */
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
+	u8 buf[2] = { cmd >> 8, cmd & 0xff };
+	int ret = i2c_master_send(client, buf, sizeof(buf));
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
+static int sdp31_measure(struct i2c_client *client, struct sdp31_reading *out)
+{
+	u8 rx[9];
+	int ret;
+
+	ret = sdp31_send_cmd(client, SDP31_CMD_TRIG_DP);
+	if (ret)
+		return ret;
+
+	msleep(SDP31_MEAS_DELAY_MS);
+
+	ret = i2c_master_recv(client, rx, sizeof(rx));
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
+	out->pressure = (s16)((rx[0] << 8) | rx[1]);
+	out->temp     = (s16)((rx[3] << 8) | rx[4]);
+	out->scale    =       (rx[6] << 8) | rx[7];
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
+		mutex_lock(&data->lock);
+		ret = sdp31_measure(data->client, &r);
+		mutex_unlock(&data->lock);
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
+			/* raw / dp_scale = Pa; /1000 => kPa (IIO unit) */
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
+	struct iio_dev *indio_dev;
+	struct sdp31_data *data;
+	struct sdp31_reading r;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	crc8_populate_msb(sdp31_crc8_table, SDP31_CRC8_POLY);
+
+	/* Confirm the sensor is present and learn its scale factor. */
+	ret = sdp31_measure(client, &r);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to read from sensor\n");
+	if (!r.scale)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "invalid scale factor\n");
+	data->dp_scale = r.scale;
+
+	indio_dev->name = "sdp31";
+	indio_dev->info = &sdp31_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sdp31_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sdp31_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id sdp31_id[] = {
+	{ "sdp31" },
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

