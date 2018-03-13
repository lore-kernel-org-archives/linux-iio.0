Return-Path: <SRS0=OtJ0=GD=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/adc/nau7802: Improve unlocking of a mutex in
 nau7802_read_raw()
Message-ID: <f2874cab-329b-297f-2b4a-bfc72755123d@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:56:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:52:26 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace two calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/nau7802.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 8997e74a8847..68d06a492760 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -303,10 +303,8 @@ static int nau7802_read_raw(struct iio_dev *indio_dev,
 		 *   - Channel 2 is value 1 in the CHS register
 		 */
 		ret = i2c_smbus_read_byte_data(st->client, NAU7802_REG_CTRL2);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
 
 		if (((ret & NAU7802_CTRL2_CHS_BIT) && !chan->channel) ||
 				(!(ret & NAU7802_CTRL2_CHS_BIT) &&
@@ -316,18 +314,15 @@ static int nau7802_read_raw(struct iio_dev *indio_dev,
 					NAU7802_REG_CTRL2,
 					NAU7802_CTRL2_CHS(chan->channel) |
 					NAU7802_CTRL2_CRS(st->sample_rate));
-
-			if (ret < 0) {
-				mutex_unlock(&st->lock);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
 		}
 
 		if (st->client->irq)
 			ret = nau7802_read_irq(indio_dev, chan, val);
 		else
 			ret = nau7802_read_poll(indio_dev, chan, val);
-
+unlock:
 		mutex_unlock(&st->lock);
 		return ret;
 
-- 
2.16.2
