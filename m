Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr30093.outbound.protection.outlook.com ([40.107.3.93]:50723
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726815AbeJ0Cwq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Oct 2018 22:52:46 -0400
From: Carlos Iglesias <carlos.iglesias@emutex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: [PATCH 2/2] iio: pressure: Add support for Honeywell HSC SPI sensors
Date: Fri, 26 Oct 2018 18:14:37 +0000
Message-ID: <20181026181406.14545-3-carlos.iglesias@emutex.com>
References: <20181026181406.14545-1-carlos.iglesias@emutex.com>
In-Reply-To: <20181026181406.14545-1-carlos.iglesias@emutex.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device driver for the HSC pressure sensors with SPI interface.
In addition to the main measurement -pressure- these sensors also
provide temperature measurement.

Signed-off-by: Carlos Iglesias <carlos.iglesias@emutex.com>
---
 MAINTAINERS                    |   6 +
 drivers/iio/pressure/Kconfig   |  10 +
 drivers/iio/pressure/Makefile  |   2 +
 drivers/iio/pressure/hsc_spi.c | 543 +++++++++++++++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/iio/pressure/hsc_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 556f902b3766..a4af4cbd4b0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6696,6 +6696,12 @@ W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/=
hpfs/index-e.cgi
 S:	Maintained
 F:	fs/hpfs/
=20
+HSC SERIES PRESSURE SENSORS
+M;	Carlos Iglesias <carlos.iglesias@emutex.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
+F:	drivers/iio/pressure/hsc_spi.c
+
 HSI SUBSYSTEM
 M:	Sebastian Reichel <sre@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index eaa7cfcb4c2a..593663d4ffa8 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -227,4 +227,14 @@ config ZPA2326_SPI
 	tristate
 	select REGMAP_SPI
=20
+config HSC_SPI
+	tristate "Honeywell HSC pressure sensors (SPI)"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for the Honeywell HSC range of
+	  pressure sensors (SPI interface only).
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hsc_spi.
+
 endmenu
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index c2058d7b2f93..b1db2116e9f6 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_ZPA2326_SPI) +=3D zpa2326_spi.o
=20
 obj-$(CONFIG_IIO_ST_PRESS_I2C) +=3D st_pressure_i2c.o
 obj-$(CONFIG_IIO_ST_PRESS_SPI) +=3D st_pressure_spi.o
+
+obj-$(CONFIG_HSC_SPI) +=3D hsc_spi.o
diff --git a/drivers/iio/pressure/hsc_spi.c b/drivers/iio/pressure/hsc_spi.=
c
new file mode 100644
index 000000000000..efe45a09da8f
--- /dev/null
+++ b/drivers/iio/pressure/hsc_spi.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * hsc_spi.c - Driver for Honeywell HSC pressure sensors with
+ *             SPI interface
+ *
+ * Copyright (c) 2018 Carlos Iglesias <carlos.iglesias@emutex.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/spi/spi.h>
+
+#define HSC_MAX_SPI_FREQ_HZ	400000
+
+#define HSC_TEMP_BITS		11
+#define HSC_PRESS_BITS		14
+#define HSC_TEMP_MASK		(0x7FF)
+#define HSC_TEMP_SHIFT		(5)
+
+#define HSC_STATUS_S0		BIT(14)
+#define HSC_STATUS_S1		BIT(15)
+#define HSC_STATUS_MSK		((HSC_STATUS_S0) | (HSC_STATUS_S1))
+#define HSC_STATUS_CMD		HSC_STATUS_S0
+#define HSC_STATUS_STALE	HSC_STATUS_S1
+#define HSC_STATUS_DIAG		((HSC_STATUS_S0) | (HSC_STATUS_S1))
+
+static inline int hsc_status_error(struct device dev, int val)
+{
+	int st_check =3D val & HSC_STATUS_MSK;
+
+	if (st_check) {
+		switch (st_check) {
+		case HSC_STATUS_CMD:
+			dev_warn(&dev, "%s:Device in COMMAND MODE\n",
+				 __func__);
+			return -EIO;
+		case HSC_STATUS_STALE:
+			dev_warn(&dev, "%s:Stale data - sampling too fast?\n",
+				 __func__);
+			return -EAGAIN;
+		case HSC_STATUS_DIAG:
+			dev_warn(&dev, "%s:Calibration signature changed\n",
+				 __func__);
+			return -EIO;
+		default:
+			dev_err(&dev, "%s:Invalid status code (%d)\n",
+				__func__, st_check);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+enum hsc_variant {
+	/* Note: Only the absolute range sensors are supported */
+	HSC001BAA, HSC001BAB, HSC001BAC, HSC001BAF,
+	HSC1_6BAA, HSC1_6BAB, HSC1_6BAC, HSC1_6BAF,
+	HSC2_5BAA, HSC2_5BAB, HSC2_5BAC, HSC2_5BAF,
+	HSC004BAA, HSC004BAB, HSC004BAC, HSC004BAF,
+	HSC006BAA, HSC006BAB, HSC006BAC, HSC006BAF,
+	HSC010BAA, HSC010BAB, HSC010BAC, HSC010BAF,
+
+	HSC100KAA, HSC100KAB, HSC100KAC, HSC100KAF,
+	HSC160KAA, HSC160KAB, HSC160KAC, HSC160KAF,
+	HSC250KAA, HSC250KAB, HSC250KAC, HSC250KAF,
+	HSC400KAA, HSC400KAB, HSC400KAC, HSC400KAF,
+	HSC600KAA, HSC600KAB, HSC600KAC, HSC600KAF,
+	HSC001GAA, HSC001GAB, HSC001GAC, HSC001GAF,
+
+	HSC015PAA, HSC015PAB, HSC015PAC, HSC015PAF,
+	HSC030PAA, HSC030PAB, HSC030PAC, HSC030PAF,
+	HSC060PAA, HSC060PAB, HSC060PAC, HSC060PAF,
+	HSC100PAA, HSC100PAB, HSC100PAC, HSC100PAF,
+	HSC150PAA, HSC150PAB, HSC150PAC, HSC150PAF,
+};
+
+enum hsc_meas_channel {
+	HSC_CH_PRESSURE,
+	HSC_CH_TEMPERATURE
+};
+
+struct hsc_config {
+	int pmin;	/* Lower pressure limit */
+	int pmax;	/* Upper pressure limit */
+	int rmin;	/* Lower transfer function limit (%) */
+	int rmax;	/* Upper transfer function limit (%) */
+	int knum;	/* Pressure kPa conversion factor (numerator) */
+	int kden;	/* Pressure kPa conversion factor /denominator) */
+};
+
+struct hsc_fract_val {
+	int num;	/* numerator */
+	int den;	/* denominator */
+};
+
+struct hsc_state {
+	struct device *dev;
+	struct spi_device *spi_dev;
+	struct spi_transfer spi_xfer;
+	struct spi_message spi_msg;
+	__be16 rx_buf[2];
+
+	/* Model-dependent values */
+	struct hsc_fract_val scale;
+	struct hsc_fract_val offset;
+};
+
+#define HSC_CONFIG(_pmin, _pmax, _rmin, _rmax, _knum, _kden) {	\
+		.pmin =3D (_pmin),				\
+		.pmax =3D (_pmax),				\
+		.rmin =3D (_rmin),				\
+		.rmax =3D (_rmax),				\
+		.knum =3D (_knum),				\
+		.kden =3D (_kden),				\
+	}
+
+static struct hsc_config hsc_cfg[] =3D {
+	/* Absolute range, mbar */
+	[HSC001BAA] =3D HSC_CONFIG(0, 1000, 10, 90, 1, 10),
+	[HSC001BAB] =3D HSC_CONFIG(0, 1000, 5, 95, 1, 10),
+	[HSC001BAC] =3D HSC_CONFIG(0, 1000, 5, 85, 1, 10),
+	[HSC001BAF] =3D HSC_CONFIG(0, 1000, 4, 94, 1, 10),
+	[HSC1_6BAA] =3D HSC_CONFIG(0, 1600, 10, 90, 1, 10),
+	[HSC1_6BAB] =3D HSC_CONFIG(0, 1600, 5, 95, 1, 10),
+	[HSC1_6BAC] =3D HSC_CONFIG(0, 1600, 5, 85, 1, 10),
+	[HSC1_6BAF] =3D HSC_CONFIG(0, 1600, 4, 94, 1, 10),
+	[HSC2_5BAA] =3D HSC_CONFIG(0, 2500, 10, 90, 1, 10),
+	[HSC2_5BAB] =3D HSC_CONFIG(0, 2500, 5, 95, 1, 10),
+	[HSC2_5BAC] =3D HSC_CONFIG(0, 2500, 5, 85, 1, 10),
+	[HSC2_5BAF] =3D HSC_CONFIG(0, 2500, 4, 94, 1, 10),
+	[HSC004BAA] =3D HSC_CONFIG(0, 4000, 10, 90, 1, 10),
+	[HSC004BAB] =3D HSC_CONFIG(0, 4000, 5, 95, 1, 10),
+	[HSC004BAC] =3D HSC_CONFIG(0, 4000, 5, 85, 1, 10),
+	[HSC004BAF] =3D HSC_CONFIG(0, 4000, 4, 94, 1, 10),
+	[HSC006BAA] =3D HSC_CONFIG(0, 6000, 10, 90, 1, 10),
+	[HSC006BAB] =3D HSC_CONFIG(0, 6000, 5, 95, 1, 10),
+	[HSC006BAC] =3D HSC_CONFIG(0, 6000, 5, 85, 1, 10),
+	[HSC006BAF] =3D HSC_CONFIG(0, 6000, 4, 94, 1, 10),
+	[HSC010BAA] =3D HSC_CONFIG(0, 10000, 10, 90, 1, 10),
+	[HSC010BAB] =3D HSC_CONFIG(0, 10000, 5, 95, 1, 10),
+	[HSC010BAC] =3D HSC_CONFIG(0, 10000, 5, 85, 1, 10),
+	[HSC010BAF] =3D HSC_CONFIG(0, 10000, 4, 94, 1, 10),
+	/* Absolute range, kPa */
+	[HSC100KAA] =3D HSC_CONFIG(0, 100, 10, 90, 1, 1),
+	[HSC100KAB] =3D HSC_CONFIG(0, 100, 5, 95, 1, 1),
+	[HSC100KAC] =3D HSC_CONFIG(0, 100, 5, 85, 1, 1),
+	[HSC100KAF] =3D HSC_CONFIG(0, 100, 4, 94, 1, 1),
+	[HSC160KAA] =3D HSC_CONFIG(0, 160, 10, 90, 1, 1),
+	[HSC160KAB] =3D HSC_CONFIG(0, 160, 5, 95, 1, 1),
+	[HSC160KAC] =3D HSC_CONFIG(0, 160, 5, 85, 1, 1),
+	[HSC160KAF] =3D HSC_CONFIG(0, 160, 4, 94, 1, 1),
+	[HSC250KAA] =3D HSC_CONFIG(0, 250, 10, 90, 1, 1),
+	[HSC250KAB] =3D HSC_CONFIG(0, 250, 5, 95, 1, 1),
+	[HSC250KAC] =3D HSC_CONFIG(0, 250, 5, 85, 1, 1),
+	[HSC250KAF] =3D HSC_CONFIG(0, 250, 4, 94, 1, 1),
+	[HSC400KAA] =3D HSC_CONFIG(0, 400, 10, 90, 1, 1),
+	[HSC400KAB] =3D HSC_CONFIG(0, 400, 5, 95, 1, 1),
+	[HSC400KAC] =3D HSC_CONFIG(0, 400, 5, 85, 1, 1),
+	[HSC400KAF] =3D HSC_CONFIG(0, 400, 4, 94, 1, 1),
+	[HSC600KAA] =3D HSC_CONFIG(0, 600, 10, 90, 1, 1),
+	[HSC600KAB] =3D HSC_CONFIG(0, 600, 5, 95, 1, 1),
+	[HSC600KAC] =3D HSC_CONFIG(0, 600, 5, 85, 1, 1),
+	[HSC600KAF] =3D HSC_CONFIG(0, 600, 4, 94, 1, 1),
+	[HSC001GAA] =3D HSC_CONFIG(0, 1000, 10, 90, 1, 1),
+	[HSC001GAB] =3D HSC_CONFIG(0, 1000, 5, 95, 1, 1),
+	[HSC001GAC] =3D HSC_CONFIG(0, 1000, 5, 85, 1, 1),
+	[HSC001GAF] =3D HSC_CONFIG(0, 1000, 4, 94, 1, 1),
+	/* Absolute range, psi */
+	[HSC015PAA] =3D HSC_CONFIG(0, 15, 10, 90, 6895, 1000),
+	[HSC015PAB] =3D HSC_CONFIG(0, 15, 5, 95, 6895, 1000),
+	[HSC015PAC] =3D HSC_CONFIG(0, 15, 5, 85, 6895, 1000),
+	[HSC015PAF] =3D HSC_CONFIG(0, 15, 4, 94, 6895, 1000),
+	[HSC030PAA] =3D HSC_CONFIG(0, 30, 10, 90, 6895, 1000),
+	[HSC030PAB] =3D HSC_CONFIG(0, 30, 5, 95, 6895, 1000),
+	[HSC030PAC] =3D HSC_CONFIG(0, 30, 5, 85, 6895, 1000),
+	[HSC030PAF] =3D HSC_CONFIG(0, 30, 4, 94, 6895, 1000),
+	[HSC060PAA] =3D HSC_CONFIG(0, 60, 10, 90, 6895, 1000),
+	[HSC060PAB] =3D HSC_CONFIG(0, 60, 5, 95, 6895, 1000),
+	[HSC060PAC] =3D HSC_CONFIG(0, 60, 5, 85, 6895, 1000),
+	[HSC060PAF] =3D HSC_CONFIG(0, 60, 4, 94, 6895, 1000),
+	[HSC100PAA] =3D HSC_CONFIG(0, 100, 10, 90, 6895, 1000),
+	[HSC100PAB] =3D HSC_CONFIG(0, 100, 5, 95, 6895, 1000),
+	[HSC100PAC] =3D HSC_CONFIG(0, 100, 5, 85, 6895, 1000),
+	[HSC100PAF] =3D HSC_CONFIG(0, 100, 4, 94, 6895, 1000),
+	[HSC150PAA] =3D HSC_CONFIG(0, 150, 10, 90, 6895, 1000),
+	[HSC150PAB] =3D HSC_CONFIG(0, 150, 5, 95, 6895, 1000),
+	[HSC150PAC] =3D HSC_CONFIG(0, 150, 5, 85, 6895, 1000),
+	[HSC150PAF] =3D HSC_CONFIG(0, 150, 4, 94, 6895, 1000),
+};
+
+static const struct iio_chan_spec hsc_channels[] =3D {
+	{
+		.type =3D IIO_PRESSURE,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel =3D HSC_CH_PRESSURE,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D HSC_PRESS_BITS,
+			.storagebits =3D 16,
+			.shift =3D 0,
+			.endianness =3D IIO_BE,
+		}
+	},
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel =3D HSC_CH_TEMPERATURE,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D HSC_TEMP_BITS,
+			.storagebits =3D 16,
+			.shift =3D HSC_TEMP_SHIFT,
+			.endianness =3D IIO_BE,
+		}
+	}
+};
+
+static int hsc_get_pressure(struct hsc_state *state)
+{
+	int ret =3D 0;
+	int error;
+
+	state->spi_xfer.len =3D 2;
+	ret =3D spi_sync(state->spi_dev, &state->spi_msg);
+	if (ret)
+		return ret;
+
+	ret =3D be16_to_cpu(state->rx_buf[0]);
+
+	error =3D hsc_status_error(state->spi_dev->dev, ret);
+	if (error)
+		return error;
+
+	return ret;
+}
+
+static int hsc_get_temperature(struct hsc_state *state)
+{
+	int ret;
+	int error;
+
+	state->spi_xfer.len =3D 4;
+	ret =3D spi_sync(state->spi_dev, &state->spi_msg);
+	if (ret)
+		return ret;
+
+	ret =3D be16_to_cpu(state->rx_buf[0]);
+	error =3D hsc_status_error(state->spi_dev->dev, ret);
+	if (error)
+		return error;
+
+	ret =3D be16_to_cpu(state->rx_buf[1]);
+	ret =3D (ret >> HSC_TEMP_SHIFT) & HSC_TEMP_MASK;
+
+	return ret;
+}
+
+static int hsc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct hsc_state *state =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->channel) {
+		case HSC_CH_PRESSURE:
+			ret =3D hsc_get_pressure(state);
+			if (ret < 0)
+				break;
+			*val =3D ret;
+			ret =3D IIO_VAL_INT;
+			break;
+		case HSC_CH_TEMPERATURE:
+			ret =3D hsc_get_temperature(state);
+			if (ret < 0)
+				break;
+			*val =3D ret;
+			ret =3D IIO_VAL_INT;
+			break;
+		default:
+			ret =3D -EINVAL;
+			dev_err(state->dev,
+				"%s - IIO_CHAN_INFO_RAW-bad channel (%d)\n",
+				__func__, chan->channel);
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->channel) {
+		case HSC_CH_PRESSURE:
+			*val =3D state->offset.num;
+			*val2 =3D state->offset.den;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		case HSC_CH_TEMPERATURE:
+			*val =3D BIT(HSC_TEMP_BITS) - 1;
+			*val2 =3D -200 / 50;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		default:
+			dev_err(state->dev,
+				"%s - IIO_CHAN_INFO_OFFSET-bad channel (%d)\n",
+				__func__, chan->channel);
+			ret =3D -EINVAL;
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case HSC_CH_PRESSURE:		/* output unit is kPa */
+			*val =3D state->scale.num;
+			*val2 =3D state->scale.den;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		case HSC_CH_TEMPERATURE:  /* output unit is milli Celsius */
+			*val =3D 200 * 1000;
+			*val2 =3D BIT(HSC_TEMP_BITS) - 1;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		default:
+			dev_err(state->dev,
+				"%s - IIO_CHAN_INFO_SCALE-bad channel (%d)\n",
+				__func__, chan->channel);
+			ret =3D -EINVAL;
+			break;
+		}
+		break;
+	default:
+		dev_err(state->dev, "%s - mask =3D %ld (INVALID)\n",
+			__func__, mask);
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info hsc_info =3D {
+	.read_raw =3D hsc_read_raw,
+};
+
+static void hsc_init_device(struct iio_dev *indio_dev)
+{
+	struct hsc_state *state =3D iio_priv(indio_dev);
+	const struct hsc_config *cfg =3D of_device_get_match_data(state->dev);
+
+	/* Pressure offset value */
+	state->offset.num =3D BIT(HSC_PRESS_BITS) *
+			    (cfg->pmin * cfg->rmax - cfg->pmax * cfg->rmin);
+	state->offset.den =3D 100 * (cfg->pmax - cfg->pmin);
+
+	/* Pressure scale value */
+	state->scale.num =3D 100 * cfg->knum * (cfg->pmax - cfg->pmin);
+	state->scale.den =3D BIT(HSC_PRESS_BITS) *
+			   cfg->kden * (cfg->rmax - cfg->rmin);
+}
+
+static int hsc_spi_probe(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct hsc_state *state;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (spi->max_speed_hz > HSC_MAX_SPI_FREQ_HZ) {
+		dev_warn(dev, "SPI CLK, %d Hz exceeds %d Hz - changed to max\n",
+			spi->max_speed_hz,
+			HSC_MAX_SPI_FREQ_HZ);
+		spi->max_speed_hz =3D HSC_MAX_SPI_FREQ_HZ;
+	}
+
+	spi->bits_per_word =3D 8;
+	spi->mode =3D SPI_MODE_0;
+
+	ret =3D spi_setup(spi);
+	if (ret < 0) {
+		dev_err(dev, "%s - Error in spi_setup()\n", __func__);
+		return ret;
+	}
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev) {
+		dev_err(dev, "%s - Error allocating iio_device\n", __func__);
+		return -ENOMEM;
+	}
+
+	state =3D iio_priv(indio_dev);
+	spi_set_drvdata(spi, state);
+	state->spi_dev =3D spi;
+	state->dev =3D dev;
+
+	indio_dev->dev.parent =3D dev;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &hsc_info;
+	indio_dev->channels =3D hsc_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(hsc_channels);
+
+	state->spi_xfer.rx_buf =3D &state->rx_buf[0];
+	state->spi_xfer.tx_buf =3D NULL;
+	state->spi_xfer.cs_change =3D 0;
+	spi_message_init(&state->spi_msg);
+	spi_message_add_tail(&state->spi_xfer, &state->spi_msg);
+
+	hsc_init_device(indio_dev);
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret < 0)
+		dev_err(dev, "iio_device_register failed: %d\n", ret);
+
+	dev_dbg(dev, "%s - scale =3D %d/%d, offset =3D %d/%d\n", __func__,
+		state->scale.num, state->scale.den,
+		state->offset.num, state->offset.den);
+
+	return ret;
+}
+
+static int hsc_spi_remove(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id hsc_of_match[] =3D {
+	{ .compatible =3D "honeywell,hsc001baa", .data =3D &hsc_cfg[HSC001BAA] },
+	{ .compatible =3D "honeywell,hsc001bab", .data =3D &hsc_cfg[HSC001BAB] },
+	{ .compatible =3D "honeywell,hsc001bac", .data =3D &hsc_cfg[HSC001BAC] },
+	{ .compatible =3D "honeywell,hsc001baf", .data =3D &hsc_cfg[HSC001BAF] },
+
+	{ .compatible =3D "honeywell,hsc1_6baa", .data =3D &hsc_cfg[HSC1_6BAA] },
+	{ .compatible =3D "honeywell,hsc1_6bab", .data =3D &hsc_cfg[HSC1_6BAB] },
+	{ .compatible =3D "honeywell,hsc1_6bac", .data =3D &hsc_cfg[HSC1_6BAC] },
+	{ .compatible =3D "honeywell,hsc1_6baf", .data =3D &hsc_cfg[HSC1_6BAF] },
+
+	{ .compatible =3D "honeywell,hsc2_5baa", .data =3D &hsc_cfg[HSC2_5BAA] },
+	{ .compatible =3D "honeywell,hsc2_5bab", .data =3D &hsc_cfg[HSC2_5BAB] },
+	{ .compatible =3D "honeywell,hsc2_5bac", .data =3D &hsc_cfg[HSC2_5BAC] },
+	{ .compatible =3D "honeywell,hsc2_5baf", .data =3D &hsc_cfg[HSC2_5BAF] },
+
+	{ .compatible =3D "honeywell,hsc004baa", .data =3D &hsc_cfg[HSC004BAA] },
+	{ .compatible =3D "honeywell,hsc004bab", .data =3D &hsc_cfg[HSC004BAB] },
+	{ .compatible =3D "honeywell,hsc004bac", .data =3D &hsc_cfg[HSC004BAC] },
+	{ .compatible =3D "honeywell,hsc004baf", .data =3D &hsc_cfg[HSC004BAF] },
+
+	{ .compatible =3D "honeywell,hsc006baa", .data =3D &hsc_cfg[HSC006BAA] },
+	{ .compatible =3D "honeywell,hsc006bab", .data =3D &hsc_cfg[HSC006BAB] },
+	{ .compatible =3D "honeywell,hsc006bac", .data =3D &hsc_cfg[HSC006BAC] },
+	{ .compatible =3D "honeywell,hsc006baf", .data =3D &hsc_cfg[HSC006BAF] },
+
+	{ .compatible =3D "honeywell,hsc010baa", .data =3D &hsc_cfg[HSC010BAA] },
+	{ .compatible =3D "honeywell,hsc010bab", .data =3D &hsc_cfg[HSC010BAB] },
+	{ .compatible =3D "honeywell,hsc010bac", .data =3D &hsc_cfg[HSC010BAC] },
+	{ .compatible =3D "honeywell,hsc010baf", .data =3D &hsc_cfg[HSC010BAF] },
+
+	{ .compatible =3D "honeywell,hsc100kaa", .data =3D &hsc_cfg[HSC100KAA] },
+	{ .compatible =3D "honeywell,hsc100kab", .data =3D &hsc_cfg[HSC100KAB] },
+	{ .compatible =3D "honeywell,hsc100kac", .data =3D &hsc_cfg[HSC100KAC] },
+	{ .compatible =3D "honeywell,hsc100kaf", .data =3D &hsc_cfg[HSC100KAF] },
+
+	{ .compatible =3D "honeywell,hsc160kaa", .data =3D &hsc_cfg[HSC160KAA] },
+	{ .compatible =3D "honeywell,hsc160kab", .data =3D &hsc_cfg[HSC160KAB] },
+	{ .compatible =3D "honeywell,hsc160kac", .data =3D &hsc_cfg[HSC160KAC] },
+	{ .compatible =3D "honeywell,hsc160kaf", .data =3D &hsc_cfg[HSC160KAF] },
+
+	{ .compatible =3D "honeywell,hsc250kaa", .data =3D &hsc_cfg[HSC250KAA] },
+	{ .compatible =3D "honeywell,hsc250kab", .data =3D &hsc_cfg[HSC250KAB] },
+	{ .compatible =3D "honeywell,hsc250kac", .data =3D &hsc_cfg[HSC250KAC] },
+	{ .compatible =3D "honeywell,hsc250kaf", .data =3D &hsc_cfg[HSC250KAF] },
+
+	{ .compatible =3D "honeywell,hsc400kaa", .data =3D &hsc_cfg[HSC400KAA] },
+	{ .compatible =3D "honeywell,hsc400kab", .data =3D &hsc_cfg[HSC400KAB] },
+	{ .compatible =3D "honeywell,hsc400kac", .data =3D &hsc_cfg[HSC400KAC] },
+	{ .compatible =3D "honeywell,hsc400kaf", .data =3D &hsc_cfg[HSC400KAF] },
+
+	{ .compatible =3D "honeywell,hsc600kaa", .data =3D &hsc_cfg[HSC600KAA] },
+	{ .compatible =3D "honeywell,hsc600kab", .data =3D &hsc_cfg[HSC600KAB] },
+	{ .compatible =3D "honeywell,hsc600kac", .data =3D &hsc_cfg[HSC600KAC] },
+	{ .compatible =3D "honeywell,hsc600kaf", .data =3D &hsc_cfg[HSC600KAF] },
+
+	{ .compatible =3D "honeywell,hsc001gaa", .data =3D &hsc_cfg[HSC001GAA] },
+	{ .compatible =3D "honeywell,hsc001gab", .data =3D &hsc_cfg[HSC001GAB] },
+	{ .compatible =3D "honeywell,hsc001gac", .data =3D &hsc_cfg[HSC001GAC] },
+	{ .compatible =3D "honeywell,hsc001gaf", .data =3D &hsc_cfg[HSC001GAF] },
+
+	{ .compatible =3D "honeywell,hsc015paa", .data =3D &hsc_cfg[HSC015PAA] },
+	{ .compatible =3D "honeywell,hsc015pab", .data =3D &hsc_cfg[HSC015PAB] },
+	{ .compatible =3D "honeywell,hsc015pac", .data =3D &hsc_cfg[HSC015PAC] },
+	{ .compatible =3D "honeywell,hsc015paf", .data =3D &hsc_cfg[HSC015PAF] },
+
+	{ .compatible =3D "honeywell,hsc030paa", .data =3D &hsc_cfg[HSC030PAA] },
+	{ .compatible =3D "honeywell,hsc030pab", .data =3D &hsc_cfg[HSC030PAB] },
+	{ .compatible =3D "honeywell,hsc030pac", .data =3D &hsc_cfg[HSC030PAC] },
+	{ .compatible =3D "honeywell,hsc030paf", .data =3D &hsc_cfg[HSC030PAF] },
+
+	{ .compatible =3D "honeywell,hsc060paa", .data =3D &hsc_cfg[HSC060PAA] },
+	{ .compatible =3D "honeywell,hsc060pab", .data =3D &hsc_cfg[HSC060PAB] },
+	{ .compatible =3D "honeywell,hsc060pac", .data =3D &hsc_cfg[HSC060PAC] },
+	{ .compatible =3D "honeywell,hsc060paf", .data =3D &hsc_cfg[HSC060PAF] },
+
+	{ .compatible =3D "honeywell,hsc100paa", .data =3D &hsc_cfg[HSC100PAA] },
+	{ .compatible =3D "honeywell,hsc100pab", .data =3D &hsc_cfg[HSC100PAB] },
+	{ .compatible =3D "honeywell,hsc100pac", .data =3D &hsc_cfg[HSC100PAC] },
+	{ .compatible =3D "honeywell,hsc100paf", .data =3D &hsc_cfg[HSC100PAF] },
+
+	{ .compatible =3D "honeywell,hsc150paa", .data =3D &hsc_cfg[HSC150PAA] },
+	{ .compatible =3D "honeywell,hsc150pab", .data =3D &hsc_cfg[HSC150PAB] },
+	{ .compatible =3D "honeywell,hsc150pac", .data =3D &hsc_cfg[HSC150PAC] },
+	{ .compatible =3D "honeywell,hsc150paf", .data =3D &hsc_cfg[HSC150PAF] },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, hsc_of_match);
+
+static struct spi_driver hsc_spi_driver =3D {
+	.probe =3D hsc_spi_probe,
+	.remove =3D hsc_spi_remove,
+	.driver =3D {
+		.name =3D "hsc_spi_pressure_sensor",
+		.of_match_table =3D hsc_of_match,
+	},
+};
+
+module_spi_driver(hsc_spi_driver);
+
+MODULE_AUTHOR("Carlos Iglesias <carlosiglesias@emutex.com>");
+MODULE_DESCRIPTION("Honeywell HSC SPI pressure sensor driver");
+MODULE_LICENSE("GPL v2");
--=20
2.19.1
