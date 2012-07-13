Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio:adis16260: Fix drvdata inconsistency
Date: Fri, 13 Jul 2012 14:04:06 +0200
Message-Id: <1342181050-22579-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The SPI drvdata is set to adis16260_state struct in probe(), but assumed to be
the iio_dev struct in remove(). Fix this by setting it to the iio_dev in
probe().

The issue has been discovered using the following coccinelle patch:

// <smpl>
@r1@
type T;
T data;
expression dev;
@@
(
spi_set_drvdata(dev, (void *)data)
|
spi_set_drvdata(dev, data)
)

@r2@
type r1.T;
T data;
position p;
expression dev;
@@
data = spi_get_drvdata@p(dev)

@depends on r1@
position p != r2.p;
expression dev;
identifier data;
@@
*data = spi_get_drvdata@p(dev)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index f16b393..93aa431 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -617,7 +617,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (pd)
 		st->negate = pd->negate;
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-- 
1.7.10.4
