Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/3] staging:iio:events - new 64 bit code structure and push out drivers.
Date: Mon, 25 Jul 2011 14:35:11 +0100
Message-Id: <1311600911-20353-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311600911-20353-1-git-send-email-jic23@cam.ac.uk>
References: <1311600911-20353-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This costs us nothing in event storage (as we are carrying a 64 bit
timestamp in the structure) and gives us lots more room to play with.

Also allows for more channels which some parts need.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |    8 +++---
 drivers/staging/iio/accel/sca3000_core.c   |   10 +++---
 drivers/staging/iio/adc/max1363_core.c     |   10 +++---
 drivers/staging/iio/chrdev.h               |    2 +-
 drivers/staging/iio/iio.h                  |   39 +++++++++++++++-------------
 drivers/staging/iio/industrialio-core.c    |   16 +++--------
 drivers/staging/iio/light/tsl2563.c        |   12 ++++----
 drivers/staging/iio/sysfs.h                |   36 ++++++++++++++-----------
 8 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 83c12b0..8c25309 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -199,14 +199,14 @@ static u8 lis3l02dq_axis_map[3][3] = {
 };
 
 static int lis3l02dq_read_thresh(struct iio_dev *indio_dev,
-				 int e,
+				 u64 e,
 				 int *val)
 {
 	return lis3l02dq_read_reg_s16(indio_dev, LIS3L02DQ_REG_THS_L_ADDR, val);
 }
 
 static int lis3l02dq_write_thresh(struct iio_dev *indio_dev,
-				  int event_code,
+				  u64 event_code,
 				  int val)
 {
 	u16 value = val;
@@ -533,7 +533,7 @@ static struct iio_chan_spec lis3l02dq_channels[] = {
 
 
 static ssize_t lis3l02dq_read_event_config(struct iio_dev *indio_dev,
-					   int event_code)
+					   u64 event_code)
 {
 
 	u8 val;
@@ -585,7 +585,7 @@ error_ret:
 }
 
 static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
-					int event_code,
+					u64 event_code,
 					int state)
 {
 	int ret = 0;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 02ff6ba..851a143 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -694,7 +694,7 @@ static IIO_CONST_ATTR_TEMP_OFFSET("-214.6");
  * sca3000_read_thresh() - query of a threshold
  **/
 static int sca3000_read_thresh(struct iio_dev *indio_dev,
-			       int e,
+			       u64 e,
 			       int *val)
 {
 	int ret, i;
@@ -722,8 +722,8 @@ static int sca3000_read_thresh(struct iio_dev *indio_dev,
  * sca3000_write_thresh() control of threshold
  **/
 static int sca3000_write_thresh(struct iio_dev *indio_dev,
-				    int e,
-				    int val)
+				u64 e,
+				int val)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
@@ -857,7 +857,7 @@ done:
  * sca3000_read_event_config() what events are enabled
  **/
 static int sca3000_read_event_config(struct iio_dev *indio_dev,
-				     int e)
+				     u64 e)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
@@ -960,7 +960,7 @@ error_ret:
  * this mode is disabled.  Currently normal mode is assumed.
  **/
 static int sca3000_write_event_config(struct iio_dev *indio_dev,
-				      int e,
+				      u64 e,
 				      int state)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index d37d1ca..66e4735 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -552,7 +552,7 @@ static IIO_CONST_ATTR(sampling_frequency_available,
 		"133000 665000 33300 16600 8300 4200 2000 1000");
 
 static int max1363_read_thresh(struct iio_dev *indio_dev,
-			       int event_code,
+			       u64 event_code,
 			       int *val)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
@@ -564,7 +564,7 @@ static int max1363_read_thresh(struct iio_dev *indio_dev,
 }
 
 static int max1363_write_thresh(struct iio_dev *indio_dev,
-				int event_code,
+				u64 event_code,
 				int val)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
@@ -592,7 +592,7 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static const int max1363_event_codes[] = {
+static const u64 max1363_event_codes[] = {
 	IIO_UNMOD_EVENT_CODE(IIO_IN, 0, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
 	IIO_UNMOD_EVENT_CODE(IIO_IN, 1, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
 	IIO_UNMOD_EVENT_CODE(IIO_IN, 2, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
@@ -623,7 +623,7 @@ static irqreturn_t max1363_event_handler(int irq, void *private)
 }
 
 static int max1363_read_event_config(struct iio_dev *indio_dev,
-				     int event_code)
+				     u64 event_code)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 
@@ -775,7 +775,7 @@ error_ret:
 }
 
 static int max1363_write_event_config(struct iio_dev *indio_dev,
-				      int event_code,
+				      u64 event_code,
 				      int state)
 {
 	int ret = 0;
diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index 28cce12..d8e736f 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -17,7 +17,7 @@
  *		the interrupt handler)
  */
 struct iio_event_data {
-	int	id;
+	u64	id;
 	s64	timestamp;
 };
 
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 5854f4a..dec098f 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -46,19 +46,22 @@ enum iio_chan_type {
 #define	IIO_OUT IIO_VOLTAGE
 #define	IIO_IN_DIFF IIO_VOLTAGE_DIFF
 
-#define IIO_MOD_X			0
-#define IIO_MOD_LIGHT_BOTH		0
-#define IIO_MOD_Y			1
-#define IIO_MOD_LIGHT_IR		1
-#define IIO_MOD_Z			2
-#define IIO_MOD_X_AND_Y			3
-#define IIO_MOD_X_ANX_Z			4
-#define IIO_MOD_Y_AND_Z			5
-#define IIO_MOD_X_AND_Y_AND_Z		6
-#define IIO_MOD_X_OR_Y			7
-#define IIO_MOD_X_OR_Z			8
-#define IIO_MOD_Y_OR_Z			9
-#define IIO_MOD_X_OR_Y_OR_Z		10
+enum iio_modifier {
+	IIO_NO_MOD,
+	IIO_MOD_X,
+	IIO_MOD_Y,
+	IIO_MOD_Z,
+	IIO_MOD_X_AND_Y,
+	IIO_MOD_X_ANX_Z,
+	IIO_MOD_Y_AND_Z,
+	IIO_MOD_X_AND_Y_AND_Z,
+	IIO_MOD_X_OR_Y,
+	IIO_MOD_X_OR_Z,
+	IIO_MOD_Y_OR_Z,
+	IIO_MOD_X_OR_Y_OR_Z,
+	IIO_MOD_LIGHT_BOTH,
+	IIO_MOD_LIGHT_IR,
+};
 
 /* Could add the raw attributes as well - allowing buffer only devices */
 enum iio_chan_info_enum {
@@ -249,17 +252,17 @@ struct iio_info {
 			 long mask);
 
 	int (*read_event_config)(struct iio_dev *indio_dev,
-				 int event_code);
+				 u64 event_code);
 
 	int (*write_event_config)(struct iio_dev *indio_dev,
-				  int event_code,
+				  u64 event_code,
 				  int state);
 
 	int (*read_event_value)(struct iio_dev *indio_dev,
-				int event_code,
+				u64 event_code,
 				int *val);
 	int (*write_event_value)(struct iio_dev *indio_dev,
-				 int event_code,
+				 u64 event_code,
 				 int val);
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
@@ -331,7 +334,7 @@ void iio_device_unregister(struct iio_dev *dev_info);
  * @ev_code:		What event
  * @timestamp:		When the event occurred
  **/
-int iio_push_event(struct iio_dev *dev_info, int ev_code,  s64 timestamp);
+int iio_push_event(struct iio_dev *dev_info, u64 ev_code,  s64 timestamp);
 
 extern struct bus_type iio_bus_type;
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 77b5b2d..e92e28d 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -69,15 +69,12 @@ static const char * const iio_chan_type_name_spec_complex[] = {
 	[IIO_VOLTAGE_DIFF] = "voltage%d-voltage%d",
 };
 
-static const char * const iio_modifier_names_light[] = {
-	[IIO_MOD_LIGHT_BOTH] = "both",
-	[IIO_MOD_LIGHT_IR] = "ir",
-};
-
-static const char * const iio_modifier_names_axial[] = {
+static const char * const iio_modifier_names[] = {
 	[IIO_MOD_X] = "x",
 	[IIO_MOD_Y] = "y",
 	[IIO_MOD_Z] = "z",
+	[IIO_MOD_LIGHT_BOTH] = "both",
+	[IIO_MOD_LIGHT_IR] = "ir",
 };
 
 /* relies on pairs of these shared then separate */
@@ -150,7 +147,7 @@ struct iio_event_interface {
 	unsigned long flags;
 };
 
-int iio_push_event(struct iio_dev *dev_info, int ev_code, s64 timestamp)
+int iio_push_event(struct iio_dev *dev_info, u64 ev_code, s64 timestamp)
 {
 	struct iio_event_interface *ev_int = dev_info->event_interface;
 	struct iio_detected_event_list *ev;
@@ -464,9 +461,6 @@ static int __iio_build_postfix(struct iio_chan_spec const *chan,
 		const char *intermediate;
 		switch (chan->type) {
 		case IIO_INTENSITY:
-			intermediate
-				= iio_modifier_names_light[chan->channel2];
-			break;
 		case IIO_ACCEL:
 		case IIO_GYRO:
 		case IIO_MAGN:
@@ -474,7 +468,7 @@ static int __iio_build_postfix(struct iio_chan_spec const *chan,
 		case IIO_ROT:
 		case IIO_ANGL:
 			intermediate
-				= iio_modifier_names_axial[chan->channel2];
+				= iio_modifier_names[chan->channel2];
 			break;
 		default:
 			return -EINVAL;
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 10a658d..cafcbfb 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -540,8 +540,8 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 };
 
 static int tsl2563_read_thresh(struct iio_dev *indio_dev,
-				int event_code,
-				int *val)
+			       u64 event_code,
+			       int *val)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 
@@ -560,7 +560,7 @@ static int tsl2563_read_thresh(struct iio_dev *indio_dev,
 }
 
 static ssize_t tsl2563_write_thresh(struct iio_dev *indio_dev,
-				  int event_code,
+				  u64 event_code,
 				  int val)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
@@ -608,8 +608,8 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 }
 
 static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
-					int event_code,
-					int state)
+					  u64 event_code,
+					  int state)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
@@ -650,7 +650,7 @@ out:
 }
 
 static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
-					   int event_code)
+					 u64 event_code)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 8277950..6bd5928 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -120,36 +120,40 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
 	IIO_CONST_ATTR(temp_scale, _string)
 
-#define IIO_EV_TYPE_THRESH		0
-#define IIO_EV_TYPE_MAG			1
-#define IIO_EV_TYPE_ROC			2
+enum iio_event_type {
+	IIO_EV_TYPE_THRESH,
+	IIO_EV_TYPE_MAG,
+	IIO_EV_TYPE_ROC,
+};
+
+enum iio_event_direction {
+	IIO_EV_DIR_EITHER,
+	IIO_EV_DIR_RISING,
+	IIO_EV_DIR_FALLING,
+};
 
-#define IIO_EV_DIR_EITHER		0
-#define IIO_EV_DIR_RISING		1
-#define IIO_EV_DIR_FALLING		2
+#define IIO_EVENT_CODE(chan_type, modifier, direction,			\
+		       type, chan, chan1, chan2)			\
+	(((u64)type << 56) | ((u64)direction << 48) | ((u64)modifier << 40) | \
+	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
 
 #define IIO_EV_TYPE_MAX 8
 #define IIO_EV_BIT(type, direction)			\
 	(1 << (type*IIO_EV_TYPE_MAX + direction))
 
-#define IIO_EVENT_CODE(channelclass, orient_bit, number,		\
-		       modifier, type, direction)			\
-	(channelclass | (orient_bit << 8) | ((number) << 9) |		\
-	 ((modifier) << 13) | ((type) << 16) | ((direction) << 24))
-
 #define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
 			   type, direction)				\
-	IIO_EVENT_CODE(channelclass, 1, number, modifier, type, direction)
+	IIO_EVENT_CODE(channelclass, modifier, direction, type, number, 0, 0)
 
 #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
-	IIO_EVENT_CODE(channelclass, 0, number, 0, type, direction)
+	IIO_EVENT_CODE(channelclass, 0, direction, type, number, 0, 0)
 
-#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 24) & 0xf)
+#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
 
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((mask >> 9) & 0x0f)
+#define IIO_EVENT_CODE_EXTRACT_NUM(mask) (mask & 0xFFFF)
 
-#define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 13) & 0x7)
+#define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
 
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
-- 
1.7.3.4
