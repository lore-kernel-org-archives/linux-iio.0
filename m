Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jon Brenner <jbrenner@taosinc.com>
Subject: [PATCH 2/4] staging:iio:tsl2x7x: Fix client data inconsistency
Date: Fri, 13 Jul 2012 14:04:07 +0200
Message-Id: <1342181050-22579-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1342181050-22579-1-git-send-email-lars@metafoo.de>
References: <1342181050-22579-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

In probe the I2C client data is set to the iio_dev struct in probe(), but
assumed to be the tsl2X7X_chip struct in remove(). Fix this by reading the
client data back as iio_dev as well.

The issue has been discovered using the following coccinelle patch:

// <smpl>
@r1@
type T;
T data;
expression dev;
@@
(
i2c_set_clientdata(dev, (void *)data)
|
i2c_set_clientdata(dev, data)
)

@r2@
type r1.T;
T data;
position p;
expression dev;
@@
data = i2c_get_clientdata@p(dev)

@depends on r1@
position p != r2.p;
expression dev;
identifier data;
@@
*data = i2c_get_clientdata@p(dev)
// </smpl>

Cc: Jon Brenner <jbrenner@taosinc.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index fdf75e4..7944686 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -2028,8 +2028,8 @@ static int tsl2x7x_resume(struct device *dev)
 
 static int __devexit tsl2x7x_remove(struct i2c_client *client)
 {
-	struct tsl2X7X_chip *chip = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
 	tsl2x7x_chip_off(indio_dev);
 
-- 
1.7.10.4
