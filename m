Return-Path: <SRS0=aVu3=BY=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/accel/stk8312: Improve unlocking of a mutex in two
 functions
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <ae9d7e7f-541e-ce0c-1d41-6b9793c98f78@users.sourceforge.net>
Date: Wed, 25 Oct 2017 20:55:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Oct 2017 20:46:18 +0200

* Adjust jump targets so that a call of the function "mutex_unlock"
  is mostly stored at the end of these function implementations.

* Replace four calls by goto statements.

* Adjust condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/stk8312.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index cacc0da2f874..5275ab886e39 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -344,24 +344,24 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
 			return -EBUSY;
 		mutex_lock(&data->lock);
 		ret = stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			return ret;
-		}
+		if (ret)
+			goto unlock;
+
 		ret = stk8312_read_accel(data, chan->address);
 		if (ret < 0) {
 			stk8312_set_mode(data,
 					 data->mode & (~STK8312_MODE_ACTIVE));
-			mutex_unlock(&data->lock);
-			return ret;
+			goto unlock;
 		}
 		*val = sign_extend32(ret, 7);
 		ret = stk8312_set_mode(data,
 				       data->mode & (~STK8312_MODE_ACTIVE));
+unlock:
 		mutex_unlock(&data->lock);
-		if (ret < 0)
-			return ret;
-		return IIO_VAL_INT;
+		if (!ret)
+			ret = IIO_VAL_INT;
+
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		*val = stk8312_scale_table[data->range - 1][0];
 		*val2 = stk8312_scale_table[data->range - 1][1];
@@ -444,17 +444,15 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 						    data->buffer);
 		if (ret < STK8312_ALL_CHANNEL_SIZE) {
 			dev_err(&data->client->dev, "register read failed\n");
-			mutex_unlock(&data->lock);
-			goto err;
+			goto unlock_after_failure;
 		}
 	} else {
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 indio_dev->masklength) {
 			ret = stk8312_read_accel(data, bit);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
-				goto err;
-			}
+			if (ret < 0)
+				goto unlock_after_failure;
+
 			data->buffer[i++] = ret;
 		}
 	}
@@ -462,10 +460,13 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   pf->timestamp);
-err:
+notify_trigger:
 	iio_trigger_notify_done(indio_dev->trig);
-
 	return IRQ_HANDLED;
+
+unlock_after_failure:
+	mutex_unlock(&data->lock);
+	goto notify_trigger;
 }
 
 static irqreturn_t stk8312_data_rdy_trig_poll(int irq, void *private)
-- 
2.14.3
