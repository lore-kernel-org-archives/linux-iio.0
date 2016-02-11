Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30863 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbcBKKFS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Feb 2016 05:05:18 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 2/3] iio:core: timestamping clock resolution support
Date: Thu, 11 Feb 2016 11:04:51 +0100
Message-ID: <892dd561a12d3dcb33d753f566127776daf557dc.1455184829.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455184829.git.gregor.boirie@parrot.com>
References: <cover.1455184829.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adds a new function iio_get_time_res() to retrieve the current timestamping
clock resolution.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/industrialio-core.c | 23 +++++++++++++++++++++++
 include/linux/iio/iio.h         |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 97bdb95..eb56cdf 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -212,6 +212,29 @@ s64 iio_get_time_ns(const struct iio_dev* indio_dev)
 }
 EXPORT_SYMBOL(iio_get_time_ns);
 
+/**
+ * iio_get_time_res() - utility function to get time stamp clock resolution in
+ *                      nano seconds.
+ * @indio_dev: device
+ */
+unsigned int iio_get_time_res(const struct iio_dev* indio_dev)
+{
+	switch (indio_dev->clock_id) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_BOOTTIME:
+	case CLOCK_TAI:
+		return hrtimer_resolution;
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
+		return LOW_RES_NSEC;
+	default:
+		BUG();
+	}
+}
+EXPORT_SYMBOL(iio_get_time_res);
+
 static int __init iio_init(void)
 {
 	int ret;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 904a5b0..931b0ab 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -282,6 +282,7 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 }
 
 extern s64 iio_get_time_ns(const struct iio_dev*);
+extern unsigned int iio_get_time_res(const struct iio_dev*);
 
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
-- 
2.1.4

