Return-Path: <SRS0=jGaO=A2=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: benjamin.gaignard@linaro.org,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 1/5] iio: Implement counter channel specification and IIO_SIGNAL constant
Date: Mon, 25 Sep 2017 14:08:14 -0400
Message-Id: <f998338a324ad1c0454afb7fd78055564f1b590d.1506353914.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1506353914.git.vilhelm.gray@gmail.com>
References: <cover.1506353914.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Counters are IIO devices that are exposed via a generic counter
interface consisting of one or more counter signals (IIO_SIGNAL) linked
to one or more counter values (IIO_COUNT).

This patch introduces the IIO_SIGNAL constant which represents a counter
device signal line. Additionally, a new "counter" member is added to
struct iio_chan_spec, with relevant support, to indicate that a channel
is part of a counter.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/industrialio-core.c | 14 +++++++++++++-
 include/linux/iio/iio.h         |  2 ++
 include/uapi/linux/iio/types.h  |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 7a5aa127c52e..ee508f2070a7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_SIGNAL] = "signal",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -989,7 +990,18 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 			break;
 
 		case IIO_SEPARATE:
-			if (chan->indexed)
+			if (chan->counter) {
+				if (!chan->indexed) {
+					WARN(1, "Counter channels must be indexed\n");
+					ret = -EINVAL;
+					goto error_free_full_postfix;
+				}
+				name = kasprintf(GFP_KERNEL, "%s%d-%d_%s",
+						    iio_chan_type_name_spec[chan->type],
+						    chan->channel,
+						    chan->channel2,
+						    full_postfix);
+			} else if (chan->indexed)
 				name = kasprintf(GFP_KERNEL, "%s_%s%d_%s",
 						    iio_direction[chan->output],
 						    iio_chan_type_name_spec[chan->type],
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 486ffbb1a926..de4dc2a0e4e3 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -263,6 +263,7 @@ struct iio_event_spec {
  *			attributes but not for event codes.
  * @output:		Channel is output.
  * @differential:	Channel is differential.
+ * @counter:		Channel is part of a counter.
  */
 struct iio_chan_spec {
 	enum iio_chan_type	type;
@@ -295,6 +296,7 @@ struct iio_chan_spec {
 	unsigned		indexed:1;
 	unsigned		output:1;
 	unsigned		differential:1;
+	unsigned		counter:1;
 };
 
 
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index ffafd6c25a48..313899652ca7 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -43,6 +43,7 @@ enum iio_chan_type {
 	IIO_COUNT,
 	IIO_INDEX,
 	IIO_GRAVITY,
+	IIO_SIGNAL,
 };
 
 enum iio_modifier {
-- 
2.14.1
