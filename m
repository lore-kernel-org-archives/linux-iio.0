Return-Path: <error27@gmail.com>
Date: Wed, 29 Jun 2011 22:50:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	kernel-janitors@vger.kernel.org
Subject: [patch v2] Staging: iio: some uninitialized variable bugs
Message-ID: <20110629195048.GJ14591@shale.localdomain>
References: <20110629184053.GI14591@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110629184053.GI14591@shale.localdomain>
List-ID: <linux-iio@vger.kernel.org>

There were some uninitialized variable warnings in iio.  Two of
these came from the recent changes to how the private data was
allocated in 83f0422dc6a16 "staging:iio:accel:sca3000: allocate
state in iio_dev and use iio_priv to access."

drivers/staging/iio/accel/sca3000_core.c: In function 'sca3000_probe':
drivers/staging/iio/accel/sca3000_core.c:1137:9: warning: 'st' may be used uninitialized in this function
drivers/staging/iio/adc/ad7291.c: In function 'ad7291_probe':
drivers/staging/iio/adc/ad7291.c:805:15: warning: 'chip' may be used uninitialized in this function
drivers/staging/iio/dac/ad5624r_spi.c: In function 'ad5624r_probe':
drivers/staging/iio/dac/ad5624r_spi.c:228:24: warning: 'st' may be used uninitialized in this function

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2:  I added a couple more bug related bug fixes.

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
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index f024026..96cbb17 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -799,6 +799,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 		ret = -ENOMEM;
 		goto error_ret;
 	}
+	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 0175cc0..a5b3776 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -276,7 +276,7 @@ error_free_dev:
 	iio_free_device(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
-		regulator_disable(st->reg);
+		regulator_disable(reg);
 error_put_reg:
 	if (!IS_ERR(reg))
 		regulator_put(reg);
