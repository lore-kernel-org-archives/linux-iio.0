Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:42519
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753895Ab2DZMeP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Apr 2012 08:34:15 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/4] iio: core: Introduce IIO_ALTVOLTAGE and appropriate channel info elements
Date: Thu, 26 Apr 2012 14:34:01 +0200
Message-ID: <1335443643-20439-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1335443643-20439-1-git-send-email-michael.hennerich@analog.com>
References: <1335443643-20439-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/industrialio-core.c |    3 +++
 include/linux/iio/iio.h         |   10 ++++++++++
 include/linux/iio/types.h       |    1 +
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dd1a6a2..1c55d2b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ANGL] = "angl",
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_CAPACITANCE] = "capacitance",
+	[IIO_ALTVOLTAGE] = "altvoltage",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -88,6 +89,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
 	= "filter_low_pass_3db_frequency",
 	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
+	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
+	[IIO_CHAN_INFO_PHASE] = "phase",
 };
 
 const struct iio_chan_spec
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9c0908a..0e826af 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -32,6 +32,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_AVERAGE_RAW,
 	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
 	IIO_CHAN_INFO_SAMP_FREQ,
+	IIO_CHAN_INFO_FREQUENCY,
+	IIO_CHAN_INFO_PHASE,
 };
 
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
@@ -85,6 +87,14 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SAMP_FREQ)
 #define IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT			\
 	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_SAMP_FREQ)
+#define IIO_CHAN_INFO_FREQUENCY_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_FREQUENCY)
+#define IIO_CHAN_INFO_FREQUENCY_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_FREQUENCY)
+#define IIO_CHAN_INFO_PHASE_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PHASE)
+#define IIO_CHAN_INFO_PHASE_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PHASE)
 
 enum iio_endian {
 	IIO_CPU,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 0c32136..a471fd5 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -27,6 +27,7 @@ enum iio_chan_type {
 	IIO_ANGL,
 	IIO_TIMESTAMP,
 	IIO_CAPACITANCE,
+	IIO_ALTVOLTAGE,
 };
 
 enum iio_modifier {
-- 
1.7.0.4


