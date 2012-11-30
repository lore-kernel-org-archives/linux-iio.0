Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57870 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406Ab2K3OW6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 09:22:58 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio:impedance-analyzer switch from sw_ring to kfifo.
Date: Fri, 30 Nov 2012 14:22:49 +0000
Message-Id: <1354285372-11779-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1354285372-11779-1-git-send-email-jic23@kernel.org>
References: <1354285372-11779-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

sw_ring buffer implementation is going away so switch to the
kfifo based alternative.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/impedance-analyzer/Kconfig  | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index ad0ff76..dd97b6b 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -7,7 +7,7 @@ config AD5933
 	tristate "Analog Devices AD5933, AD5934 driver"
 	depends on I2C
 	select IIO_BUFFER
-	select IIO_SW_RING
+	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
 	  Network Analyzer, AD5933/4, provides direct access via sysfs.
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 779243d..440e226 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -22,7 +22,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include "../ring_sw.h"
+#include <linux/iio/kfifo_buf.h>
 
 #include "ad5933.h"
 
@@ -630,7 +630,7 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 
 static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
 	if (!indio_dev->buffer)
 		return -ENOMEM;
 
@@ -774,7 +774,7 @@ static int ad5933_probe(struct i2c_client *client,
 error_uninitialize_ring:
 	iio_buffer_unregister(indio_dev);
 error_unreg_ring:
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
@@ -794,7 +794,7 @@ static int ad5933_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
-- 
1.8.0.1

