Return-Path: <SRS0=aVu3=BY=users.sourceforge.net=elfring@kernel.org>
Subject: [PATCH 2/2] iio/accel/stk8ba50: Improve unlocking of a mutex in
 stk8ba50_read_raw()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Tiberiu Breana <tiberiu.a.breana@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
Message-ID: <8e9436af-440e-b4a8-5024-1f2a51c41b6b@users.sourceforge.net>
Date: Wed, 25 Oct 2017 22:17:29 +0200
MIME-Version: 1.0
In-Reply-To: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Oct 2017 22:00:42 +0200

Adjust jump targets so that a call of the function "mutex_unlock" is stored
only once in a case branch of this function implementation.
Replace two calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/stk8ba50.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index afe90567ad37..ffc26b5d1fad 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -221,20 +221,24 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
 			return -EBUSY;
 		mutex_lock(&data->lock);
 		ret = stk8ba50_set_power(data, STK8BA50_MODE_NORMAL);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			return -EINVAL;
-		}
+		if (ret < 0)
+			goto e_inval;
+
 		ret = stk8ba50_read_accel(data, chan->address);
 		if (ret < 0) {
 			stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
-			mutex_unlock(&data->lock);
-			return -EINVAL;
+e_inval:
+			ret = -EINVAL;
+			goto unlock;
 		}
 		*val = sign_extend32(ret >> STK8BA50_DATA_SHIFT, 9);
-		stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
+		ret = stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
+unlock:
 		mutex_unlock(&data->lock);
-		return IIO_VAL_INT;
+		if (ret >= 0)
+			ret = IIO_VAL_INT;
+
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = stk8ba50_scale_table[data->range].scale_val;
-- 
2.14.3
