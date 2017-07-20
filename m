Return-Path: <SRS0=4kh6=6X=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 10/11] iio: adc: ti-ads1015: use iio_device_claim_direct_mode()
Date: Fri, 21 Jul 2017 00:24:26 +0900
Message-Id: <1500564267-8613-11-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

While the iio buffer for the ti-ads1015 driver is enabled, reading the
raw ADC channel data is restricted.  We usually use the
iio_device_claim_direct_mode()/iio_device_release_direct_mode() pair for
that.

This change consequently reverses the locking order for the driver's
private lock and indio_dev->mlock which acquired by
iio_device_claim_direct_mode() internally. But it's safe because there is
no other dependency between these locks.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index da25780..5568be4 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -347,34 +347,34 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 	int ret, idx;
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
 	mutex_lock(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
 		int shift = chan->scan_type.shift;
 
-		if (iio_buffer_enabled(indio_dev)) {
-			ret = -EBUSY;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
 			break;
-		}
 
 		ret = ads1015_set_power_state(data, true);
 		if (ret < 0)
-			break;
+			goto release_direct;
 
 		ret = ads1015_get_adc_result(data, chan->address, val);
 		if (ret < 0) {
 			ads1015_set_power_state(data, false);
-			break;
+			goto release_direct;
 		}
 
 		*val = sign_extend32(*val >> shift, 15 - shift);
 
 		ret = ads1015_set_power_state(data, false);
 		if (ret < 0)
-			break;
+			goto release_direct;
 
 		ret = IIO_VAL_INT;
+release_direct:
+		iio_device_release_direct_mode(indio_dev);
 		break;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -393,7 +393,6 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 		break;
 	}
 	mutex_unlock(&data->lock);
-	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
 }
-- 
2.7.4
