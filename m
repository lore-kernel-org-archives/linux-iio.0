Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: michael.hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:scan element types: introduce endian description to the data format.
Date: Fri, 29 Jul 2011 18:28:24 +0100
Message-Id: <1311960504-4268-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

If not set in chan_spec, cpu endianness used.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
Result of discussion in [PATCH 0/2] blue part 6: IIO abi rework.
Michael highlighted that we need to specify the endianness of buffer
contents.  This patch does that.  The IIO_CPU option exists so that
existing drivers which do conversion to cpu endian should work
without change.

Based on all sorts of fun I haven't pushed, so if you really want to
play with this see the iio-blue.git tree.

Jonathan

 drivers/staging/iio/iio.h               |    8 ++++++++
 drivers/staging/iio/industrialio-ring.c |   15 ++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index bde8b87..d09f84b 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -86,6 +86,12 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
 };
 
+enum iio_endian {
+	IIO_CPU,
+	IIO_BE,
+	IIO_LE,
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -101,6 +107,7 @@ enum iio_chan_info_enum {
  *			storage_bits:	Realbits + padding
  *			shift:		Shift right by this before masking out
  *					realbits.
+ *			endianness:	little or big endian	
  * @info_mask:		What information is to be exported about this channel.
  *			This includes calibbias, scale etc.
  * @event_mask:	What events can this channel produce.
@@ -129,6 +136,7 @@ struct iio_chan_spec {
 		u8	realbits;
 		u8	storagebits;
 		u8	shift;
+	       	enum iio_endian endianness;
 	} scan_type;
 	const long		info_mask;
 	const long		event_mask;
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 5edc6d8..aa1748b 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -24,6 +24,10 @@
 #include "iio_core.h"
 #include "ring_generic.h"
 
+const static char *iio_endian_prefix[] = {
+	[IIO_BE] = "be",
+	[IIO_LE] = "le",
+};
 
 /**
  * iio_ring_read_first_n_outer() - chrdev read for ring buffer access
@@ -95,7 +99,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	return sprintf(buf, "%c%d/%d>>%u\n",
+	u8 type = this_attr->c->scan_type.endianness;
+
+	if (type == IIO_CPU) {
+		if (__LITTLE_ENDIAN)
+			type = IIO_LE;
+		else
+			type = IIO_BE;
+	}
+	return sprintf(buf, "%s:%c%d/%d>>%u\n",
+		       iio_endian_prefix[type],
 		       this_attr->c->scan_type.sign,
 		       this_attr->c->scan_type.realbits,
 		       this_attr->c->scan_type.storagebits,
-- 
1.7.3.4
