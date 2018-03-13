Return-Path: <SRS0=OtJ0=GD=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/adc/ad7291: Improve unlocking of a mutex in
 ad7291_read_raw()
Message-ID: <a53248a9-4422-4436-aa43-bfbd2b60a85f@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:16:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:08:40 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace three calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/ad7291.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index a862b5d8fb4b..b2c3d4c79909 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -335,27 +335,27 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 			mutex_lock(&chip->state_lock);
 			/* If in autocycle mode drop through */
 			if (chip->command & AD7291_AUTOCYCLE) {
-				mutex_unlock(&chip->state_lock);
-				return -EBUSY;
+				ret = -EBUSY;
+				goto unlock;
 			}
 			/* Enable this channel alone */
 			regval = chip->command & (~AD7291_VOLTAGE_MASK);
 			regval |= BIT(15 - chan->channel);
 			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
-			if (ret < 0) {
-				mutex_unlock(&chip->state_lock);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
+
 			/* Read voltage */
 			ret = i2c_smbus_read_word_swapped(chip->client,
 							  AD7291_VOLTAGE);
-			if (ret < 0) {
-				mutex_unlock(&chip->state_lock);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
+
 			*val = ret & AD7291_VALUE_MASK;
+			ret = IIO_VAL_INT;
+unlock:
 			mutex_unlock(&chip->state_lock);
-			return IIO_VAL_INT;
+			return ret;
 		case IIO_TEMP:
 			/* Assumes tsense bit of command register always set */
 			ret = i2c_smbus_read_word_swapped(chip->client,
-- 
2.16.2
