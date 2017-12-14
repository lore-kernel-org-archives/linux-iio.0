Return-Path: <SRS0=13zJ=DK=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH v9 04/13] IIO: inkern: API for manipulating channel attributes
Date: Thu, 14 Dec 2017 09:57:56 +0100
Message-ID: <1513241885-32079-5-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1513241885-32079-1-git-send-email-arnaud.pouliquen@st.com>
References: <1513241885-32079-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Extend the inkern API with functions for reading and writing
attribute of iio channels.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/inkern.c         | 17 ++++++++++++-----
 include/linux/iio/consumer.h | 26 ++++++++++++++++++++++++++
 include/linux/iio/iio.h      | 28 ----------------------------
 include/linux/iio/types.h    | 28 ++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 069defc..ec98790 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -664,9 +664,8 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
-static int iio_read_channel_attribute(struct iio_channel *chan,
-				      int *val, int *val2,
-				      enum iio_chan_info_enum attribute)
+int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
+			       enum iio_chan_info_enum attribute)
 {
 	int ret;
 
@@ -682,6 +681,7 @@ static int iio_read_channel_attribute(struct iio_channel *chan,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
 
 int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 {
@@ -850,7 +850,8 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 						chan->channel, val, val2, info);
 }
 
-int iio_write_channel_raw(struct iio_channel *chan, int val)
+int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
+				enum iio_chan_info_enum attribute)
 {
 	int ret;
 
@@ -860,12 +861,18 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 		goto err_unlock;
 	}
 
-	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
+	ret = iio_channel_write(chan, val, val2, attribute);
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
+
+int iio_write_channel_raw(struct iio_channel *chan, int val)
+{
+	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
+}
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
 
 unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5e347a9..2017f35 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -216,6 +216,32 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
 int iio_read_channel_processed(struct iio_channel *chan, int *val);
 
 /**
+ * iio_write_channel_attribute() - Write values to the device attribute.
+ * @chan:	The channel being queried.
+ * @val:	Value being written.
+ * @val2:	Value being written.val2 use depends on attribute type.
+ * @attribute:	info attribute to be read.
+ *
+ * Returns an error code or 0.
+ */
+int iio_write_channel_attribute(struct iio_channel *chan, int val,
+				int val2, enum iio_chan_info_enum attribute);
+
+/**
+ * iio_read_channel_attribute() - Read values from the device attribute.
+ * @chan:	The channel being queried.
+ * @val:	Value being written.
+ * @val2:	Value being written.Val2 use depends on attribute type.
+ * @attribute:	info attribute to be written.
+ *
+ * Returns an error code if failed. Else returns a description of what is in val
+ * and val2, such as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
+ * + val2/1e6
+ */
+int iio_read_channel_attribute(struct iio_channel *chan, int *val,
+			       int *val2, enum iio_chan_info_enum attribute);
+
+/**
  * iio_write_channel_raw() - write to a given channel
  * @chan:		The channel being queried.
  * @val:		Value being written.
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index c380daa..007caf7 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -20,34 +20,6 @@
  * Currently assumes nano seconds.
  */
 
-enum iio_chan_info_enum {
-	IIO_CHAN_INFO_RAW = 0,
-	IIO_CHAN_INFO_PROCESSED,
-	IIO_CHAN_INFO_SCALE,
-	IIO_CHAN_INFO_OFFSET,
-	IIO_CHAN_INFO_CALIBSCALE,
-	IIO_CHAN_INFO_CALIBBIAS,
-	IIO_CHAN_INFO_PEAK,
-	IIO_CHAN_INFO_PEAK_SCALE,
-	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
-	IIO_CHAN_INFO_AVERAGE_RAW,
-	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
-	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
-	IIO_CHAN_INFO_SAMP_FREQ,
-	IIO_CHAN_INFO_FREQUENCY,
-	IIO_CHAN_INFO_PHASE,
-	IIO_CHAN_INFO_HARDWAREGAIN,
-	IIO_CHAN_INFO_HYSTERESIS,
-	IIO_CHAN_INFO_INT_TIME,
-	IIO_CHAN_INFO_ENABLE,
-	IIO_CHAN_INFO_CALIBHEIGHT,
-	IIO_CHAN_INFO_CALIBWEIGHT,
-	IIO_CHAN_INFO_DEBOUNCE_COUNT,
-	IIO_CHAN_INFO_DEBOUNCE_TIME,
-	IIO_CHAN_INFO_CALIBEMISSIVITY,
-	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
-};
-
 enum iio_shared_by {
 	IIO_SEPARATE,
 	IIO_SHARED_BY_TYPE,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 2aa7b63..6eb3d683 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -34,4 +34,32 @@ enum iio_available_type {
 	IIO_AVAIL_RANGE,
 };
 
+enum iio_chan_info_enum {
+	IIO_CHAN_INFO_RAW = 0,
+	IIO_CHAN_INFO_PROCESSED,
+	IIO_CHAN_INFO_SCALE,
+	IIO_CHAN_INFO_OFFSET,
+	IIO_CHAN_INFO_CALIBSCALE,
+	IIO_CHAN_INFO_CALIBBIAS,
+	IIO_CHAN_INFO_PEAK,
+	IIO_CHAN_INFO_PEAK_SCALE,
+	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
+	IIO_CHAN_INFO_AVERAGE_RAW,
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
+	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
+	IIO_CHAN_INFO_SAMP_FREQ,
+	IIO_CHAN_INFO_FREQUENCY,
+	IIO_CHAN_INFO_PHASE,
+	IIO_CHAN_INFO_HARDWAREGAIN,
+	IIO_CHAN_INFO_HYSTERESIS,
+	IIO_CHAN_INFO_INT_TIME,
+	IIO_CHAN_INFO_ENABLE,
+	IIO_CHAN_INFO_CALIBHEIGHT,
+	IIO_CHAN_INFO_CALIBWEIGHT,
+	IIO_CHAN_INFO_DEBOUNCE_COUNT,
+	IIO_CHAN_INFO_DEBOUNCE_TIME,
+	IIO_CHAN_INFO_CALIBEMISSIVITY,
+	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+};
+
 #endif /* _IIO_TYPES_H_ */
-- 
2.7.4
