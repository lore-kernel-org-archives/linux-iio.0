Return-Path: <error27@gmail.com>
Date: Wed, 29 Jun 2011 21:40:53 +0300
From: Dan Carpenter <error27@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	kernel-janitors@vger.kernel.org
Subject: [patch] Staging: iio: uninitialized variable in sca3000_probe()
Message-ID: <20110629184053.GI14591@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

We recently changed how "st" was allocated in 83f0422dc6a16
"staging:iio:accel:sca3000: allocate state in iio_dev and use
iio_priv to access."  Unfortunately this assignment was left out.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 4313f73..603f5bc 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1133,6 +1133,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 		goto error_ret;
 	}
 
+	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 	st->us = spi;
 	mutex_init(&st->lock);
