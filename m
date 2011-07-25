Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/8] staging:iio:events: use IIO_<TYPE> and IIO_MOD_<> instead of IIO_EV_CLASS_<TYPE> etc
Date: Mon, 25 Jul 2011 14:10:56 +0100
Message-Id: <1311599458-15152-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599458-15152-1-git-send-email-jic23@cam.ac.uk>
References: <1311599458-15152-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The original definitions were duplicated to reduce tree churn during introduction of chan_spec
registration.  Now there is no point in maintaining the two sets of definitions.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   24 ++++++++++++------------
 drivers/staging/iio/accel/sca3000_core.c   |   16 ++++++++--------
 drivers/staging/iio/adc/ad7150.c           |    8 ++++----
 drivers/staging/iio/adc/ad7816.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |    4 ++--
 drivers/staging/iio/adc/adt75.c            |    2 +-
 drivers/staging/iio/adc/max1363_core.c     |   24 ++++++++----------------
 drivers/staging/iio/dac/ad5504.c           |    2 +-
 drivers/staging/iio/iio.h                  |    2 --
 drivers/staging/iio/light/tsl2563.c        |    2 +-
 drivers/staging/iio/sysfs.h                |   26 --------------------------
 11 files changed, 38 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 83ec286..7f946aa 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -452,54 +452,54 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_Z,
+						  IIO_MOD_Z,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_RISING),
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_Z,
+						  IIO_MOD_Z,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_FALLING),
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_Y,
+						  IIO_MOD_Y,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_RISING),
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_Y,
+						  IIO_MOD_Y,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_FALLING),
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_X,
+						  IIO_MOD_X,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_RISING),
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_X,
+						  IIO_MOD_X,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_FALLING),
 			       timestamp);
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 22c38c3..d5684fc 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -815,36 +815,36 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 
 	if (val & SCA3000_INT_STATUS_FREE_FALL)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_X_AND_Y_AND_Z,
+						  IIO_MOD_X_AND_Y_AND_Z,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_FALLING),
 			       last_timestamp);
 
 	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_Y,
+						  IIO_MOD_Y,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
 
 	if (val & SCA3000_INT_STATUS_X_TRIGGER)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_X,
+						  IIO_MOD_X,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
 
 	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
 		iio_push_event(indio_dev, 0,
-			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-						  IIO_EV_MOD_Z,
+						  IIO_MOD_Z,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
 			       last_timestamp);
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 04017ef..67989e0 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -652,14 +652,14 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 
 	if ((int_status & AD7150_STATUS_OUT1) && !(chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev, 0,
-			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_IN,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
 				timestamp);
 	else if ((!(int_status & AD7150_STATUS_OUT1)) && (chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev, 0,
-			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_IN,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
@@ -667,14 +667,14 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 
 	if ((int_status & AD7150_STATUS_OUT2) && !(chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev, 0,
-			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_IN,
 						    1,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
 			       timestamp);
 	else if ((!(int_status & AD7150_STATUS_OUT2)) && (chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev, 0,
-			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_IN,
 						    1,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0c84217..3fa4bb3 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -246,7 +246,7 @@ static const struct attribute_group ad7816_attribute_group = {
  * temperature bound events
  */
 
-#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP, \
+#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
 						       0,		\
 						       IIO_EV_TYPE_THRESH, \
 						       IIO_EV_DIR_FALLING)
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index d42d61d..2438ed5 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -335,11 +335,11 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 		if (status & (1 << i))
 			iio_push_event(indio_dev, 0,
 				       i & 0x1 ?
-				       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN,
 							    (i >> 1),
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING) :
-				       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN,
 							    (i >> 1),
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 38f141d..fc31cac 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -257,7 +257,7 @@ static const struct attribute_group adt75_attribute_group = {
  * temperature bound events
  */
 
-#define IIO_EVENT_CODE_ADT75_OTI IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP, \
+#define IIO_EVENT_CODE_ADT75_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,		\
 						      0,		\
 						      IIO_EV_TYPE_THRESH, \
 						      IIO_EV_DIR_FALLING)
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 9525aec..6896b4c 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -591,22 +591,14 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 }
 
 static const int max1363_event_codes[] = {
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 0,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 1,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 2,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 3,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 0,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 1,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 2,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 3,
-			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 0, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 1, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 2, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 3, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 0, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 1, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 2, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_IN, 3, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
 };
 
 static irqreturn_t max1363_event_handler(int irq, void *private)
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 1915f45..716a3d2 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -251,7 +251,7 @@ static struct attribute_group ad5504_ev_attribute_group = {
 static irqreturn_t ad5504_event_handler(int irq, void *private)
 {
 	iio_push_event(private, 0,
-		       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP,
+		       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 					    0,
 					    IIO_EV_TYPE_THRESH,
 					    IIO_EV_DIR_RISING),
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 61cfb26..16abb37 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -23,8 +23,6 @@
  * Currently assumes nano seconds.
  */
 
-/* naughty temporary hack to match these against the event version
-   - need to flattern these together */
 enum iio_chan_type {
 	/* real channel types */
 	IIO_IN,
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index f25243b..7c4cc9e 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -596,7 +596,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 	struct tsl2563_chip *chip = iio_priv(dev_info);
 
 	iio_push_event(dev_info, 0,
-		       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_LIGHT,
+		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
 					    0,
 					    IIO_EV_TYPE_THRESH,
 					    IIO_EV_DIR_EITHER),
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index fed7b11..8277950 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -120,28 +120,6 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
 	IIO_CONST_ATTR(temp_scale, _string)
 
-/* must match our channel defs */
-#define IIO_EV_CLASS_IN			IIO_IN
-#define IIO_EV_CLASS_IN_DIFF		IIO_IN_DIFF
-#define IIO_EV_CLASS_ACCEL		IIO_ACCEL
-#define IIO_EV_CLASS_GYRO		IIO_GYRO
-#define IIO_EV_CLASS_MAGN		IIO_MAGN
-#define IIO_EV_CLASS_LIGHT		IIO_LIGHT
-#define IIO_EV_CLASS_PROXIMITY		IIO_PROXIMITY
-#define IIO_EV_CLASS_TEMP		IIO_TEMP
-
-#define IIO_EV_MOD_X			IIO_MOD_X
-#define IIO_EV_MOD_Y			IIO_MOD_Y
-#define IIO_EV_MOD_Z			IIO_MOD_Z
-#define IIO_EV_MOD_X_AND_Y		IIO_MOD_X_AND_Y
-#define IIO_EV_MOD_X_ANX_Z		IIO_MOD_X_AND_Z
-#define IIO_EV_MOD_Y_AND_Z		IIO_MOD_Y_AND_Z
-#define IIO_EV_MOD_X_AND_Y_AND_Z	IIO_MOD_X_AND_Y_AND_Z
-#define IIO_EV_MOD_X_OR_Y		IIO_MOD_X_OR_Y
-#define IIO_EV_MOD_X_OR_Z		IIO_MOD_X_OR_Z
-#define IIO_EV_MOD_Y_OR_Z		IIO_MOD_Y_OR_Z
-#define IIO_EV_MOD_X_OR_Y_OR_Z		IIO_MOD_X_OR_Y_OR_Z
-
 #define IIO_EV_TYPE_THRESH		0
 #define IIO_EV_TYPE_MAG			1
 #define IIO_EV_TYPE_ROC			2
@@ -166,10 +144,6 @@ struct iio_const_attr {
 #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
 	IIO_EVENT_CODE(channelclass, 0, number, 0, type, direction)
 
-
-#define IIO_BUFFER_EVENT_CODE(code)		\
-	(IIO_EV_CLASS_BUFFER | (code << 8))
-
 #define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 24) & 0xf)
 
 /* Event code number extraction depends on which type of event we have.
-- 
1.7.3.4
