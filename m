Return-Path: <denis.ciocca@gmail.com>
From: Denis Ciocca <denis.ciocca@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio: Proposal for full scale attribute (not working)
Date: Sat,  9 Feb 2013 18:34:57 +0100
Message-Id: <1360431297-18251-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1360431297-18251-1-git-send-email-denis.ciocca@st.com>
References: <1360431297-18251-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Proposal to add full scale attribute for channel and sysfs macro for full scale available. This method will substitute the change full scale by write gain attribute that is inefficient.
---
 include/linux/iio/iio.h   |    5 +++++
 include/linux/iio/sysfs.h |   16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index da8c776..e250d25 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -36,6 +36,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_PHASE,
 	IIO_CHAN_INFO_HARDWAREGAIN,
 	IIO_CHAN_INFO_HYSTERESIS,
+	IIO_CHAN_INFO_FULL_SCALE,
 };
 
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
@@ -107,6 +108,10 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HYSTERESIS)
 #define IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT			\
 	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HYSTERESIS)
+#define IIO_CHAN_INFO_FULL_SCALE_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_FULL_SCALE)
+#define IIO_CHAN_INFO_FULL_SCALE_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_FULL_SCALE)
 
 enum iio_endian {
 	IIO_CPU,
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index b7a934b..7e322a9 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -104,6 +104,22 @@ struct iio_const_attr {
  **/
 #define IIO_CONST_ATTR_SAMP_FREQ_AVAIL(_string)			\
 	IIO_CONST_ATTR(sampling_frequency_available, _string)
+/**
+ * IIO_DEV_ATTR_FULL_SCALE_AVAIL - list available full scales
+ * @_show: output method for the attribute
+ *
+ * May be mode dependent on some devices
+ **/
+#define IIO_DEV_ATTR_FULL_SCALE_AVAIL(_show)				\
+	IIO_DEVICE_ATTR(full_scale_available, S_IRUGO, _show, NULL, 0)
+/**
+ * IIO_CONST_ATTR_FULL_SCALE_AVAIL - list available full scales
+ * @_string: full scale string for the attribute
+ *
+ * Constant version
+ **/
+#define IIO_CONST_ATTR_FULL_SCALE_AVAIL(_string)			\
+	IIO_CONST_ATTR(full_scale_available, _string)
 
 #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
 	IIO_DEVICE_ATTR(in_temp_raw, S_IRUGO, _show, NULL, 0)
-- 
1.7.9.5
