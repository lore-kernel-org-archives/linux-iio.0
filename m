Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:13415 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755192Ab2BMJYS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2012 04:24:18 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/4] staging:iio: Rename IIO_EVENT_CODE_EXTRACT_NUM to IIO_EVENT_CODE_EXTRACT_CHAN
Date: Mon, 13 Feb 2012 10:25:32 +0100
Message-ID: <1329125134-24150-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1329125134-24150-1-git-send-email-lars@metafoo.de>
References: <1329125134-24150-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We name this field "chan" throughout IIO with the exception of this one macro.
Rename it to be more consistent.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
Changes since v1:
	* Actually convert users of the macro as well...
---
 drivers/staging/iio/adc/ad7291.c       |   14 +++++++-------
 drivers/staging/iio/adc/ad799x_core.c  |    4 ++--
 drivers/staging/iio/adc/max1363_core.c |   12 ++++++------
 drivers/staging/iio/cdc/ad7150.c       |   10 +++++-----
 drivers/staging/iio/events.h           |    2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 0a13616..81d6b61 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -321,7 +321,7 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 
 	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
-		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
+		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)]
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_RISING)];
 
@@ -359,7 +359,7 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 	case IIO_VOLTAGE:
 		if (val > AD7291_VALUE_MASK || val < 0)
 			return -EINVAL;
-		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
+		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)]
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_RISING)];
 		return ad7291_i2c_write(chip, reg, val);
@@ -386,7 +386,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
 	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		if (chip->c_mask &
-		    (1 << (15 - IIO_EVENT_CODE_EXTRACT_NUM(event_code))))
+		    (1 << (15 - IIO_EVENT_CODE_EXTRACT_CHAN(event_code))))
 			return 1;
 		else
 			return 0;
@@ -418,12 +418,12 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
 	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		if ((!state) && (chip->c_mask & (1 << (15 -
-				IIO_EVENT_CODE_EXTRACT_NUM(event_code)))))
-			chip->c_mask &= ~(1 << (15 - IIO_EVENT_CODE_EXTRACT_NUM
+				IIO_EVENT_CODE_EXTRACT_CHAN(event_code)))))
+			chip->c_mask &= ~(1 << (15 - IIO_EVENT_CODE_EXTRACT_CHAN
 							(event_code)));
 		else if (state && (!(chip->c_mask & (1 << (15 -
-				IIO_EVENT_CODE_EXTRACT_NUM(event_code))))))
-			chip->c_mask |= (1 << (15 - IIO_EVENT_CODE_EXTRACT_NUM
+				IIO_EVENT_CODE_EXTRACT_CHAN(event_code))))))
+			chip->c_mask |= (1 << (15 - IIO_EVENT_CODE_EXTRACT_CHAN
 							(event_code)));
 		else
 			break;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index d5b581d..a845866 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -256,7 +256,7 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_FALLING);
-	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 
 	mutex_lock(&indio_dev->mlock);
 	ret = ad799x_i2c_write16(st,
@@ -275,7 +275,7 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_FALLING);
-	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 	u16 valin;
 
 	mutex_lock(&indio_dev->mlock);
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index b92cb4a..3a5bd20 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -543,9 +543,9 @@ static int max1363_read_thresh(struct iio_dev *indio_dev,
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
-		*val = st->thresh_low[IIO_EVENT_CODE_EXTRACT_NUM(event_code)];
+		*val = st->thresh_low[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)];
 	else
-		*val = st->thresh_high[IIO_EVENT_CODE_EXTRACT_NUM(event_code)];
+		*val = st->thresh_high[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)];
 	return 0;
 }
 
@@ -568,10 +568,10 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 
 	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
 	case IIO_EV_DIR_FALLING:
-		st->thresh_low[IIO_EVENT_CODE_EXTRACT_NUM(event_code)] = val;
+		st->thresh_low[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)] = val;
 		break;
 	case IIO_EV_DIR_RISING:
-		st->thresh_high[IIO_EVENT_CODE_EXTRACT_NUM(event_code)] = val;
+		st->thresh_high[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)] = val;
 		break;
 	}
 
@@ -622,7 +622,7 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 
 	int val;
-	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 	mutex_lock(&indio_dev->mlock);
 	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
@@ -775,7 +775,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	int ret = 0;
 	struct max1363_state *st = iio_priv(indio_dev);
 	u16 unifiedmask;
-	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 
 	mutex_lock(&indio_dev->mlock);
 	unifiedmask = st->mask_low | st->mask_high;
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index b73007d..e4a08dc 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -167,7 +167,7 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
 	u16 value;
 	u8 sens, timeout;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			IIO_EV_DIR_RISING);
 
@@ -279,7 +279,7 @@ static int ad7150_read_event_value(struct iio_dev *indio_dev,
 				   u64 event_code,
 				   int *val)
 {
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			IIO_EV_DIR_RISING);
@@ -309,7 +309,7 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			IIO_EV_DIR_RISING);
 
@@ -347,7 +347,7 @@ static ssize_t ad7150_show_timeout(struct device *dev,
 	u8 value;
 
 	/* use the event code for consistency reasons */
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
+	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
 	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
 			== IIO_EV_DIR_RISING);
 
@@ -373,7 +373,7 @@ static ssize_t ad7150_store_timeout(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
+	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
 	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address) ==
 			IIO_EV_DIR_RISING);
 	u8 data;
diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index bfb6340..416800e 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -96,7 +96,7 @@ enum iio_event_direction {
 
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
+#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
 
-- 
1.7.9


