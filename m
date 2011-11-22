Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 22 Nov 2011 10:39:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: [patch] Staging: iio: fix endian conversion in ad7298_scan_direct()
Message-ID: <20111122073915.GB25051@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

"tmp" is used to store the output from cpu_to_be16() so it should be
a __be16 bit type.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker patch.  Untested.

diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index a799bd1..3e804e2 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -69,27 +69,28 @@ static int ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
 static int ad7298_scan_temp(struct ad7298_state *st, int *val)
 {
 	int tmp, ret;
+	__be16 buf;
 
-	tmp = cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
+	buf = cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
 			  AD7298_TAVG | st->ext_ref);
 
-	ret = spi_write(st->spi, (u8 *)&tmp, 2);
+	ret = spi_write(st->spi, (u8 *)&buf, 2);
 	if (ret)
 		return ret;
 
-	tmp = 0;
+	buf = cpu_to_be16(0);
 
-	ret = spi_write(st->spi, (u8 *)&tmp, 2);
+	ret = spi_write(st->spi, (u8 *)&buf, 2);
 	if (ret)
 		return ret;
 
 	usleep_range(101, 1000); /* sleep > 100us */
 
-	ret = spi_read(st->spi, (u8 *)&tmp, 2);
+	ret = spi_read(st->spi, (u8 *)&buf, 2);
 	if (ret)
 		return ret;
 
-	tmp = be16_to_cpu(tmp) & RES_MASK(AD7298_BITS);
+	tmp = be16_to_cpu(buf) & RES_MASK(AD7298_BITS);
 
 	/*
 	 * One LSB of the ADC corresponds to 0.25 deg C.
