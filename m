Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329175;
	b=KkUUBpRxQ9SYU4m/s/odT+RvEZ1HDZNMcdbR+IFO9AWjTIp1S6OYK7m3mopGSOJOsOIN
	 MKK+poqfNrYMA+hDzZpn8RPQ8sFHHxvKFkOC6p8BQIEiDuP3z+4rhcW04zpF/pr4NhJQm
	 rznQ8iq4d+outY3DFtqnvg53BGBnnIQ9FQ/6ZbtQhJeczrTETIzJ7zzIGy70KCtksl5Lr
	 HadUeAl9XrX2stNvhR2xsXj5IyWZnJwK1W1/yqlPv/UbxbtPGdipyX7bxt1Tprw1y4N0S
	 OLDpN2yes/dtfAFH0KXftHr3Gyb63qgltGKdobdMol+daHa+3X+jgxmABGvThFWpgIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329175;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P0nN2SWiKGZJM5hZ4aJ+VFJksbcfu6U88YHPYPXMZYU=;
	b=m0koFyWmeiMSLIcYbbSUSZ801TUwxx7EnXoZshL6y3EcVYZavgyTjx7Qdge42gyd01EP
	 1YJjvEwXDaHZ/WtsrC7i68uifr8+ZPmb+GI7h/RLYjBmF9agr+kDrwlRq9OWYXI+y6d6s
	 xbiiuzNWjjjZCwGQRQAjghUbqc3dM5VS7Lscmk6nax8BjRjov3eZBOeJNVgGprxCIfAW7
	 NBiwTXIRFdjZiVCJpJHpB63RdA3ES5t7YsBHYxGx8ln0+0npzL7NsuzjmIPKXpp3XMOkg
	 gblLyz01NJG3zeyE6okUqQeckIebdjsnOHDCfqEOUvxG+5e8hMuriTEmU/GJqWyEHUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Rjz/q934";
	arc=none smtp.remote-ip=95.215.58.149
Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41997606A32C
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 06:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41997606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rjz/q934
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p4MAVBJ/9Qo+GOQni+AFsXx5dg/8xxOFELEHbWDxpZA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795329172; v=1; x=1795933972;
 b=Rjz/q934G4BfNRu5mcLcvQw8LH1JaCgvn5XRCB10H0/teIWCc9pSPrHa7gEpW86sgVrY8DSZ
 KJVlSUY9duSycPMRZE26lItzKEOeyVLC+j44FZyDELs+yRJwmrGY2EqD/+YWXcOhPHg4Fak8cn+
 ZKjgix+B0eK1DLTgnusuYQhk=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b1f45693e1e80040;
	Sun, 22 Nov 2026 06:32:51 +0000
X-Mizu-Trace-ID: b1f45693e1e80040
X-Migadu-Flow: FLOW_OUT
Date: Sun, 22 Nov 2026 06:32:46 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, conor+dt@kernel.org,
	joshua.crofts1@gmail.com, maxwell@maxwelld.cc,
	u.kleine-koenig@baylibre.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	akhilesh@ee.iitb.ac.in
Subject: [PATCH 2/2] iio: chemical: acd10: Add driver for ACD10 CO2 sensor
Message-ID: <07fe3a575ad86493076d5061ed71c15e7b837a10.1795326744.git.akhilesh.patil@linux.dev>
References: <cover.1795326744.git.akhilesh.patil@linux.dev>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795326744.git.akhilesh.patil@linux.dev>

Add driver for Aosong ASAIR ACD10 carbon dioxide sensor.
Use serdev interface to communicate with sensor over UART.
Implement read co2, get software revision, get instrument number
commands.

Tested on TI am62x sk board on UART5 with 1200 baud rate.

Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
---
 MAINTAINERS                   |   7 +
 drivers/iio/chemical/Kconfig  |  10 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/acd10.c  | 365 ++++++++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 drivers/iio/chemical/acd10.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e8f06145fb54..a5d70cd11dda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3743,6 +3743,13 @@ S:	Supported
 W:	http://www.akm.com/
 F:	drivers/iio/magnetometer/ak8974.c
 
+AOSONG ACD10 CARBON DIOXIDE SENSOR DRIVER
+M:	Akhilesh Patil <akhilesh.patil@linux.dev>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/aosong,acd10.yaml
+F:	drivers/iio/chemical/acd10.c
+
 AOSONG AGS02MA TVOC SENSOR DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index b22afa1f6d59..2bbf49135997 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -5,6 +5,16 @@
 
 menu "Chemical Sensors"
 
+config ACD10
+	tristate "Aosong ACD10 CO2 gas sensor"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here to build Aosong ASAIR ACD10 CO2 (carbon dioxide)
+	  sensor driver.
+
+	  To compile this ACD10 driver as a loadable kernel module,
+	  choose M here: the module will be called acd10
+
 config AOSONG_AGS02MA
 	tristate "Aosong AGS02MA TVOC sensor driver"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2287a00a6b75..29937988cbfe 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_ACD10)	+= acd10.o
 obj-$(CONFIG_AOSONG_AGS02MA)	+= ags02ma.o
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
 obj-$(CONFIG_ATLAS_EZO_SENSOR)	+= atlas-ezo-sensor.o
diff --git a/drivers/iio/chemical/acd10.c b/drivers/iio/chemical/acd10.c
new file mode 100644
index 000000000000..b92f01e7bf4a
--- /dev/null
+++ b/drivers/iio/chemical/acd10.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACD10 CO2 gas sensor driver
+ *
+ * Copyright (c) 2026 Akhilesh Patil <akhilesh.patil@linux.dev>
+ *
+ * Datasheet:
+ * https://www.es.co.th/Schemetic/PDF/ACD10.PDF
+ *
+ * TODO additional features:
+ *	1) single-point calibration feature.
+ *	2) Sensor preheat wait feature.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/serdev.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define ACD10_SERIAL_BAUDRATE		1200
+#define ACD10_SERDEV_TIMEOUT		msecs_to_jiffies(500)
+#define ACD10_FRAME_START		0xFE
+#define ACD10_FRAME_FIXED_CODE		0xA6
+#define ACD10_FRAME_DATA_START		4U
+#define ACD10_FRAME_DATA_LEN_IDX	2U
+#define ACD10_FRAME_DATA_LEN_MAX	11U
+#define ACD10_FRAME_CMD_CODE_IDX	3U
+
+struct acd10_state {
+	struct serdev_device *serdev;
+
+	/* Lock to acquire during CMD/RESP sequence */
+	struct mutex lock;
+	struct completion buf_ready;
+
+	/* Single buffer to hold tx and rx data */
+	u8 buf[16];
+	u8 buf_idx;
+	u8 rx_expected_len;
+
+	u8 sw_rev[16];
+	u8 inst_num[16];
+};
+
+enum acd10_cmds {
+	ACD10_CMD_READ_CO2 = 0,
+	ACD10_CMD_CAL,
+	ACD10_CMD_READ_SWREV,
+	ACD10_CMD_READ_INS_NUM,
+};
+
+struct acd10_cmd_info {
+	u8 cmd_code;
+	u8 tx_frame_len;
+	u8 tx_data_len;
+	u8 rx_frame_len;
+};
+
+static const struct acd10_cmd_info cmd_info[] = {
+	[ACD10_CMD_READ_CO2] = {
+		.cmd_code = 0x01,
+		.tx_frame_len = 5,
+		.tx_data_len = 0,
+		.rx_frame_len = 9,
+	},
+
+	[ACD10_CMD_CAL] = {
+		.cmd_code = 0x03,
+		.tx_frame_len = 7,
+		.tx_data_len = 2,
+		.rx_frame_len = 5,
+	},
+
+	[ACD10_CMD_READ_SWREV] = {
+		.cmd_code = 0x1E,
+		.tx_frame_len = 5,
+		.tx_data_len = 0,
+		/*
+		 * Note: datasheet says sw rev response is D1-D11 with D11 reserved.
+		 * However, sensor actually sends only D1-D10 (10 bytes).
+		 * Hence, rx_frame_len is 15 and not 16.
+		 */
+		.rx_frame_len = 15,
+	},
+
+	[ACD10_CMD_READ_INS_NUM] = {
+		.cmd_code = 0x1F,
+		.tx_frame_len = 5,
+		.tx_data_len = 0,
+		.rx_frame_len = 15,
+	}
+};
+
+static u8 acd10_get_checksum(u8 *buf, u8 len)
+{
+	u8 checksum = 0;
+
+	for (u8 i = 1; i < len - 1; i += 1)
+		checksum += buf[i];
+
+	return checksum;
+}
+
+/*
+ * Do transfer based on command and fill drv_state->buf with received data.
+ * Caller of this function should use mutex drv_state->lock.
+ */
+static int acd10_serdev_transfer(struct iio_dev *indio_dev, enum acd10_cmds cmd)
+{
+	struct acd10_state *drv_state = iio_priv(indio_dev);
+	struct serdev_device *serdev = drv_state->serdev;
+	struct device *dev = &indio_dev->dev;
+	int ret;
+
+	/* Prepare transmit buffer along with checksum */
+	drv_state->buf[0] = ACD10_FRAME_START;
+	drv_state->buf[1] = ACD10_FRAME_FIXED_CODE;
+	drv_state->buf[ACD10_FRAME_DATA_LEN_IDX] = cmd_info[cmd].tx_data_len;
+	drv_state->buf[ACD10_FRAME_CMD_CODE_IDX] = cmd_info[cmd].cmd_code;
+	drv_state->buf[cmd_info[cmd].tx_frame_len - 1] =
+		acd10_get_checksum(drv_state->buf, cmd_info[cmd].tx_frame_len);
+	drv_state->buf_idx = 0;
+	drv_state->rx_expected_len = cmd_info[cmd].rx_frame_len;
+	reinit_completion(&drv_state->buf_ready);
+
+	/* Transmit the buffer over serdev */
+	ret = serdev_device_write(serdev, drv_state->buf, cmd_info[cmd].tx_frame_len,
+				  ACD10_SERDEV_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (ret != cmd_info[cmd].tx_frame_len)
+		return -EIO;
+
+	/* Read the received bytes in buffer */
+	ret = wait_for_completion_interruptible_timeout(&drv_state->buf_ready,
+							ACD10_SERDEV_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ETIMEDOUT;
+
+	/* validate frame header */
+	if (drv_state->buf[0] != ACD10_FRAME_START ||
+	    drv_state->buf[1] != ACD10_FRAME_FIXED_CODE) {
+		dev_err(dev, "RX frame invalid\n");
+		return -EIO;
+	}
+
+	/* Maximum data len can be max 11 */
+	if (drv_state->buf[ACD10_FRAME_DATA_LEN_IDX] > ACD10_FRAME_DATA_LEN_MAX)
+		return -EIO;
+
+	/* Validate command echo */
+	if (drv_state->buf[ACD10_FRAME_CMD_CODE_IDX] != cmd_info[cmd].cmd_code)
+		return -EIO;
+
+	/* Validate checksum */
+	if (drv_state->buf[cmd_info[cmd].rx_frame_len - 1] !=
+	    acd10_get_checksum(drv_state->buf, cmd_info[cmd].rx_frame_len)) {
+		dev_err(dev, "Checksum error\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int acd10_get_sw_rev(struct iio_dev *indio_dev)
+{
+	struct acd10_state *drv_state = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
+	int ret;
+
+	ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_SWREV);
+	if (ret)
+		return ret;
+
+	memcpy(drv_state->sw_rev, &drv_state->buf[ACD10_FRAME_DATA_START], 10);
+	drv_state->sw_rev[10] = '\0';
+
+	dev_info(dev, "Software revision: %s\n", drv_state->sw_rev);
+
+	return 0;
+}
+
+static int acd10_get_instrument_num(struct iio_dev *indio_dev)
+{
+	struct acd10_state *drv_state = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
+	int ret;
+
+	ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_INS_NUM);
+	if (ret)
+		return ret;
+
+	memcpy(drv_state->inst_num, &drv_state->buf[ACD10_FRAME_DATA_START], 10);
+	drv_state->inst_num[10] = '\0';
+
+	dev_info(dev, "Instrument number: %s\n", drv_state->inst_num);
+
+	return 0;
+}
+
+static size_t acd10_receive_buf(struct serdev_device *serdev,
+				const u8 *data, size_t len)
+{
+	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
+	struct acd10_state *drv_state = iio_priv(indio_dev);
+	size_t consume = len;
+	int i = 0;
+
+	while (drv_state->rx_expected_len && (consume > 0)) {
+		drv_state->buf[drv_state->buf_idx++] = data[i++];
+		consume -= 1;
+		drv_state->rx_expected_len -= 1;
+	}
+
+	if (drv_state->rx_expected_len == 0) {
+		drv_state->buf_idx = 0;
+		complete(&drv_state->buf_ready);
+	}
+
+	return len;
+}
+
+static int acd10_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct acd10_state *drv_state = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+
+		/* Read CO2 sensor value*/
+		scoped_guard(mutex, &drv_state->lock) {
+			ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_CO2);
+			if (ret)
+				return ret;
+
+			*val = get_unaligned_be16(&drv_state->buf[ACD10_FRAME_DATA_START]);
+		}
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 100;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info acd10_info = {
+	.read_raw = &acd10_read_raw,
+};
+
+static const struct iio_chan_spec acd10_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct serdev_device_ops acd10_ser_ops = {
+	.receive_buf = &acd10_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int acd10_probe(struct serdev_device *serdev)
+{
+	int ret;
+	struct device *dev = &serdev->dev;
+	struct iio_dev *indio_dev;
+	struct acd10_state *drv_state;
+	unsigned int baudrate;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct acd10_state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->name = "acd10";
+	indio_dev->channels = acd10_channels;
+	indio_dev->num_channels = ARRAY_SIZE(acd10_channels);
+	indio_dev->info = &acd10_info;
+
+	serdev_device_set_drvdata(serdev, indio_dev);
+
+	drv_state = iio_priv(indio_dev);
+	drv_state->serdev = serdev;
+
+	init_completion(&drv_state->buf_ready);
+	ret = devm_mutex_init(dev, &drv_state->lock);
+	if (ret)
+		return ret;
+
+	serdev_device_set_client_ops(serdev, &acd10_ser_ops);
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret) {
+		dev_err(dev, "ACD10: serial device open failed\n");
+		return ret;
+	}
+
+	baudrate = serdev_device_set_baudrate(serdev, ACD10_SERIAL_BAUDRATE);
+	dev_info(dev, "baud rate set to: %u\n", baudrate);
+	if (baudrate != ACD10_SERIAL_BAUDRATE) {
+		dev_err(dev, "baud rate expected: %u, got: %u\n",
+			ACD10_SERIAL_BAUDRATE, baudrate);
+		return -EIO;
+	}
+	serdev_device_set_flow_control(serdev, false);
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return ret;
+
+	ret = acd10_get_sw_rev(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = acd10_get_instrument_num(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id acd10_of_match_table[] = {
+	{ .compatible = "aosong,acd10", },
+	{ }
+};
+
+static struct serdev_device_driver acd10_driver = {
+	.driver = {
+		.name = "acd10",
+		.of_match_table = acd10_of_match_table,
+	},
+	.probe = acd10_probe,
+};
+module_serdev_device_driver(acd10_driver);
+
+MODULE_AUTHOR("Akhilesh Patil");
+MODULE_DESCRIPTION("ACD10 CO2 gas sensor driver over serdev interface");
+MODULE_LICENSE("GPL");
-- 
2.47.3

