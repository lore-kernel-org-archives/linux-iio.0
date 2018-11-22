Return-Path: <SRS0=WzaZ=OB=gmail.com=marcelo.schmitt1@kernel.org>
Date: Thu, 22 Nov 2018 10:53:47 -0200
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad5933: replaced kfifo by triggered_buffer
Message-ID: <20181122125347.sn2oqrw7fyb4corf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Previously, there was an implicit creation of a kfifo which was replaced
by a call to triggered_buffer_setup, which is already implemented in iio
infrastructure.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../staging/iio/impedance-analyzer/Kconfig    |  2 +-
 .../staging/iio/impedance-analyzer/ad5933.c   | 25 ++++---------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index dd97b6bb3fd0..d0af5aa55dc0 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -7,7 +7,7 @@ config AD5933
 	tristate "Analog Devices AD5933, AD5934 driver"
 	depends on I2C
 	select IIO_BUFFER
-	select IIO_KFIFO_BUF
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
 	  Network Analyzer, AD5933/4, provides direct access via sysfs.
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f9bcb8310e21..edb8b540bbf1 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -20,7 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* AD5933/AD5934 Registers */
 #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
@@ -615,22 +615,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 	.postdisable = ad5933_ring_postdisable,
 };
 
-static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = iio_kfifo_allocate();
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad5933_ring_setup_ops;
-
-	return 0;
-}
-
 static void ad5933_work(struct work_struct *work)
 {
 	struct ad5933_state *st = container_of(work,
@@ -744,7 +728,8 @@ static int ad5933_probe(struct i2c_client *client,
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
-	ret = ad5933_register_ring_funcs_and_init(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, NULL,
+					 &ad5933_ring_setup_ops);
 	if (ret)
 		goto error_disable_reg;
 
@@ -759,7 +744,7 @@ static int ad5933_probe(struct i2c_client *client,
 	return 0;
 
 error_unreg_ring:
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	regulator_disable(st->reg);
 
@@ -772,7 +757,7 @@ static int ad5933_remove(struct i2c_client *client)
 	struct ad5933_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(st->reg);
 
 	return 0;
-- 
2.17.1
