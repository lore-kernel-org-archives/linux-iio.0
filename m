Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jon Brenner <jbrenner@taosinc.com>
Subject: [PATCH 4/4] staging:iio:tsl2x7x: Ensure request_irq and free_irq dev_id parameter match
Date: Fri, 13 Jul 2012 14:04:09 +0200
Message-Id: <1342181050-22579-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1342181050-22579-1-git-send-email-lars@metafoo.de>
References: <1342181050-22579-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The data parameters for request_irq and free_irq have to match, otherwise the
IRQ wont be freed.

The issue has been discovered using the following coccinelle patch:

// <smpl>
@r1@
type T;
T data;
@@
(
request_irq(..., (void *)data)
|
request_irq(..., data)
|
request_threaded_irq(..., (void *)data)
|
request_threaded_irq(..., data)
)

@r2@
type r1.T;
T data;
position p;
@@
(
free_irq@p(..., (void *)data)
|
free_irq@p(..., data)
)

@depends on r1@
position p != r2.p;
@@
*free_irq@p(...)

// </smpl>

Cc: Jon Brenner <jbrenner@taosinc.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 7944686..497a977 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -2029,13 +2029,12 @@ static int tsl2x7x_resume(struct device *dev)
 static int __devexit tsl2x7x_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
 	tsl2x7x_chip_off(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	if (client->irq)
-		free_irq(client->irq, chip->client->name);
+		free_irq(client->irq, indio_dev);
 
 	iio_device_free(indio_dev);
 
-- 
1.7.10.4
