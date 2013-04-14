Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/3] iio:Add an IIO_VAL_INTO_PLUS_PICO return type for read_raw callbacks.
Date: Sun, 14 Apr 2013 12:23:43 +0100
Message-Id: <1365938625-21778-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1365938625-21778-1-git-send-email-jic23@kernel.org>
References: <1365938625-21778-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

For now not added to the write_raw handling as no usecase yet exists
and it would involve a more substantial reworking of the string
processing code to handle it cleanly.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 5 +++++
 include/linux/iio/types.h       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e145931..40ef037 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -393,6 +393,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 			return sprintf(buf, "-%d.%09u\n", val, -val2);
 		else
 			return sprintf(buf, "%d.%09u\n", val, val2);
+	case IIO_VAL_INT_PLUS_PICO:
+		if (val2 < 0)
+			return sprintf(buf, "-%d.%012u\n", val, -val2);
+		else
+			return sprintf(buf, "-%d.%012u\n", val, val2);
 	case IIO_VAL_FRACTIONAL:
 		tmp = div_s64((s64)val * 1000000000LL, val2);
 		val2 = do_div(tmp, 1000000000LL);
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 88bf0f0..27e78a6 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -58,6 +58,7 @@ enum iio_modifier {
 #define IIO_VAL_INT_PLUS_MICRO 2
 #define IIO_VAL_INT_PLUS_NANO 3
 #define IIO_VAL_INT_PLUS_MICRO_DB 4
+#define IIO_VAL_INT_PLUS_PICO 5
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 
-- 
1.8.2.1
