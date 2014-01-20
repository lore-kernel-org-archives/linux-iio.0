Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30580 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbaATFCa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 Jan 2014 00:02:30 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] IIO: core: Introduce Quaternion types
Date: Sun, 19 Jan 2014 21:02:21 -0800
Message-Id: <1390194142-25058-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1390194142-25058-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1390194142-25058-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduced IIO_VAL_QUATERNION and its formatting. Format used here:
x:y:z:w
In addition IIO_QUAT_ROT is added to the channel type and name.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f8b730a..267b0a0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -69,6 +69,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ALTVOLTAGE] = "altvoltage",
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
+	[IIO_QUAT_ROT] = "rotquaternion",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -403,6 +404,9 @@ ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
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
index 4ac928e..878db0e 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -29,6 +29,7 @@ enum iio_chan_type {
 	IIO_ALTVOLTAGE,
 	IIO_CCT,
 	IIO_PRESSURE,
+	IIO_QUAT_ROT,
 };
 
 enum iio_modifier {
@@ -52,6 +53,7 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_RED,
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
+	IIO_MOD_QUATERNION,
 };
 
 enum iio_event_type {
@@ -78,6 +80,7 @@ enum iio_event_direction {
 #define IIO_VAL_INT_PLUS_MICRO 2
 #define IIO_VAL_INT_PLUS_NANO 3
 #define IIO_VAL_INT_PLUS_MICRO_DB 4
+#define IIO_VAL_QUATERNION 5
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 
-- 
1.8.3.2

