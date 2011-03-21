Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, stable@kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 6/6] IIO: IMU: ADIS16400: Avoid using printk facility directly
Date: Mon, 21 Mar 2011 16:44:40 +0100
Message-ID: <1300722280-10720-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
References: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 0d8df62..540bde6 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -6,6 +6,7 @@
  *
  * Copyright (c) 2009 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
  * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2011 Analog Devices Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -472,7 +473,8 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 	if ((prod_id & 0xF000) != ADIS16400_PRODUCT_ID_DEFAULT)
 		dev_warn(dev, "unknown product id");

-	printk(KERN_INFO DRIVER_NAME ": prod_id 0x%04x at CS%d (irq %d)\n",
+
+	dev_info(dev, ": prod_id 0x%04x at CS%d (irq %d)\n",
 			prod_id, st->us->chip_select, st->us->irq);

 	/* use high spi speed if possible */
@@ -645,7 +647,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)

 	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
+		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
 	}

--
1.6.0.2
