Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: fabien.marteau@armadeus.com
Cc: guenter.roeck@ericsson.com,
	linux-iio@vger.kernel.org,
	lm-sensors@lm-sensors.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20staging=3Aiio=3Aadc=3A=20as1531=20driver=20initial=20conversion=20from=20hwmon=20submission=2E?=
Date: Wed, 18 May 2011 17:16:59 +0100
Message-Id: <1305735420-23293-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk>
References: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

From: Fabien Marteau <fabien.marteau@armadeus.com>

V2: Fix double mutex unlock and whitespace (Guenter Roeck).
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig  |   10 ++
 drivers/staging/iio/adc/Makefile |    2 +
 drivers/staging/iio/adc/as1531.c |  209 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 8c751c4..4af730a 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -168,6 +168,16 @@ config ADT7410
 	  Say yes here to build support for Analog Devices ADT7410
 	  temperature sensors.
 
+config AS1531
+tristate "Austria Microsystems AS1531 Analog to Digital Converter"
+	depends on SPI_MASTER
+	help
+	  If you say yes here you get support for Austria Microsystems AS1531.
+		AS1531 is a 12 bits Analog to digitals converter with 8 channels
+		provided by Austria-Microsystems company.
+	  This driver can also be built as a module.  If so, the module
+	  will be called as1531.
+
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 1d9b3f5..027b94e2 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -39,3 +39,5 @@ obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_ADT75) += adt75.o
 obj-$(CONFIG_ADT7310) += adt7310.o
 obj-$(CONFIG_ADT7410) += adt7410.o
+
+obj-$(CONFIG_AS1531) += as1531.o
\ No newline at end of file
diff --git a/drivers/staging/iio/adc/as1531.c b/drivers/staging/iio/adc/as1531.c
new file mode 100644
index 0000000..1724c39
--- /dev/null
+++ b/drivers/staging/iio/adc/as1531.c
@@ -0,0 +1,209 @@
+/*
+ * as1531.c
+ *
+ * Driver for Austria-Microsystem Analog to Digital Converter.
+ *
+ * Copyright (c) 2010, 2011 Fabien Marteau <fabien.marteau@armadeus.com>
+ * Driver based on Marc Pignat <marc.pignat@hevs.ch> adcxx.c driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "adc.h"
+
+#define AS1531_SPI_SPEED 64941
+#define AS1531_MAX_VALUE 2500
+
+#define AS1531_START_BIT	(0x80)
+#define AS1531_CHAN0		(0<<4)
+#define AS1531_CHAN1		(4<<4)
+#define AS1531_CHAN2		(1<<4)
+#define AS1531_CHAN3		(5<<4)
+#define AS1531_CHAN4		(2<<4)
+#define AS1531_CHAN5		(6<<4)
+#define AS1531_CHAN6		(3<<4)
+#define AS1531_CHAN7		(7<<4)
+
+#define AS1531_RANGE_0_TO_VREF			(1<<3)
+#define AS1531_RANGE_HALFVREF_TO_HALFVREF	(0<<3)
+
+#define AS1531_MODE_COM		(1<<2)
+#define AS1531_MODE_DIFF	(0<<2)
+
+#define AS1531_POWER_DOWN		0x0
+#define AS1531_POWER_REDUCED		0x1
+#define AS1531_POWER_REDUCED_BIS	0x2
+#define AS1531_POWER_NORMAL		0x3
+
+struct as1531_state {
+	struct spi_device *spi;
+	struct mutex lock;
+};
+
+static int as1531_message(struct spi_device *spi, int cmd, int *ret_value)
+{
+	struct spi_message	message;
+	struct spi_transfer	x[1];
+	int status, i;
+	u8	cmd_send;
+	unsigned char buf[64];
+	unsigned char buf_read[64];
+
+	cmd_send = cmd;
+
+	spi_message_init(&message);
+	memset(x, 0, sizeof x);
+	memset(buf, 0, sizeof(buf));
+	memset(buf_read, 0, sizeof(buf_read));
+
+	for (i = 0; i < 8; i++) {
+		buf[i] = ((cmd_send & 0x80)>>7);
+		cmd_send = cmd_send << 1;
+	}
+
+	x[0].tx_buf = buf;
+	x[0].len = 24;
+	x[0].rx_buf = buf_read;
+	x[0].speed_hz = AS1531_SPI_SPEED;
+	x[0].bits_per_word = 1;
+	spi_message_add_tail(&x[0], &message);
+
+	status = spi_sync(spi, &message);
+	if (status < 0)
+		return status;
+
+	*ret_value = buf_read[11] & 0x01;
+	for (i = 12; i < 23 ; i++) {
+		*ret_value = *ret_value << 1;
+		*ret_value = *ret_value | (buf_read[i]&0x01);
+	}
+
+	return 0;
+}
+
+static int as1531_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	int status = 0;
+	int ret_value = 0;
+	struct as1531_state *st = iio_priv(indio_dev);
+
+	if (mutex_lock_interruptible(&st->lock))
+		return -ERESTARTSYS;
+
+	status = as1531_message(st->spi,
+				AS1531_START_BIT | chan->address |
+				AS1531_RANGE_0_TO_VREF | AS1531_MODE_COM |
+				AS1531_POWER_NORMAL,
+				&ret_value);
+	mutex_unlock(&st->lock);
+	if (status < 0)
+		return status;
+
+	*val = ret_value*2500/4096;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_chan_spec as1531_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 0, 1, 0, AS1531_CHAN0, 0, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 1, 1, 0, AS1531_CHAN1, 1, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 2, 1, 0, AS1531_CHAN2, 2, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 3, 1, 0, AS1531_CHAN3, 3, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 4, 1, 0, AS1531_CHAN4, 4, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 5, 1, 0, AS1531_CHAN5, 5, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 6, 1, 0, AS1531_CHAN6, 6, {}, 0),
+	IIO_CHAN(IIO_IN, 0, 1, 1, NULL, 7, 1, 0, AS1531_CHAN7, 7, {}, 0),
+};
+
+static const struct iio_info as1531_info = {
+	.read_raw = &as1531_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int __devinit as1531_probe(struct spi_device *spi)
+{
+	int ret;
+	struct as1531_state *st;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+	st->spi = spi;
+
+	spi_set_drvdata(spi, indio_dev);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &as1531_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = as1531_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as1531_channels);
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		iio_free_device(indio_dev);
+	return ret;
+}
+
+static int as1531_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	iio_device_unregister(indio_dev);
+	return 0;
+}
+
+static const struct spi_device_id as1531_id[] = {
+	{"as1531", 0},
+	{}
+};
+
+static struct spi_driver as1531_driver = {
+	.driver = {
+		.name	= "as1531",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= as1531_probe,
+	.remove	= __devexit_p(as1531_remove),
+	.id_table = as1531_id,
+};
+
+static int __init init_as1531(void)
+{
+	return spi_register_driver(&as1531_driver);
+}
+module_init(init_as1531);
+
+static void __exit exit_as1531(void)
+{
+	spi_unregister_driver(&as1531_driver);
+}
+module_exit(exit_as1531);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabien Marteau <fabien.marteau@armadeus.com>");
+MODULE_DESCRIPTION("Driver for AS1531 ADC");
-- 
1.7.3.4
