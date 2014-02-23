Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47623 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbaBWTug (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Feb 2014 14:50:36 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 3/5] IIO: core: Introduce Quaternion types
Date: Sun, 23 Feb 2014 11:50:46 -0800
Message-Id: <1393185048-4004-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduced IIO_VAL_QUATERNION and its formatting. Format used here:
x:y:z:w
In addition IIO_QUAT_ROT is added to the channel type and name.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b1225a4..69aaa7a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_QUAT_ROT] = "rotquaternion",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -409,6 +410,9 @@ ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
 		vals[1] = do_div(tmp, 1000000000LL);
 		vals[0] = tmp;
 		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
+	case IIO_VAL_QUATERNION:
+		return sprintf(buf, "%d:%d:%d:%d\n", vals[0], vals[1], vals[2],
+							vals[3]);
 	default:
 		return 0;
 	}
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 084d882..256ad2d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_chan_type {
 	IIO_CCT,
 	IIO_PRESSURE,
 	IIO_HUMIDITYRELATIVE,
+	IIO_QUAT_ROT,
 };
 
 enum iio_modifier {
@@ -79,6 +80,7 @@ enum iio_event_direction {
 #define IIO_VAL_INT_PLUS_MICRO 2
 #define IIO_VAL_INT_PLUS_NANO 3
 #define IIO_VAL_INT_PLUS_MICRO_DB 4
+#define IIO_VAL_QUATERNION 5
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 
-- 
1.8.3.2

