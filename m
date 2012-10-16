Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1077 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab2JPQ2b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Oct 2012 12:28:31 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: Add a logarithmic fractional value type
Date: Tue, 16 Oct 2012 18:29:38 +0200
Message-Id: <1350404979-29253-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For ADCs or DACs the denominator for fractional types often is a power of two.
In this case we can use a shift operation instead of the rather expensive 64 bit
division. This patch adds a new fractional type which expects the denominator to
be specified as the log2 of the actual denominator. E.g. for ADCs and DACs this
will usually be the number of significant bits.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |    5 +++++
 drivers/iio/inkern.c            |    3 +++
 include/linux/iio/types.h       |    1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6eb24db..37650a7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -397,6 +397,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 		val2 = do_div(tmp, 1000000000LL);
 		val = tmp;
 		return sprintf(buf, "%d.%09u\n", val, val2);
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)val * 1000000000LL >> val2;
+		val2 = do_div(tmp, 1000000000LL);
+		val = tmp;
+		return sprintf(buf, "%d.%09u\n", val, val2);
 	default:
 		return 0;
 	}
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f2b78d4..2ee4450 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -314,6 +314,9 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		*processed = div_s64(raw64 * (s64)scale_val * scale,
 				     scale_val2);
 		break;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		*processed = (raw64 * (s64)scale_val * scale) >> scale_val2;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 5c647ec..87b196a 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -58,5 +58,6 @@ enum iio_modifier {
 #define IIO_VAL_INT_PLUS_NANO 3
 #define IIO_VAL_INT_PLUS_MICRO_DB 4
 #define IIO_VAL_FRACTIONAL 10
+#define IIO_VAL_FRACTIONAL_LOG2 11
 
 #endif /* _IIO_TYPES_H_ */
-- 
1.7.10.4

