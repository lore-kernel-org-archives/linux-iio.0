Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33275 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab2GIUdH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Jul 2012 16:33:07 -0400
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] IIO: core: Add hysteresis in channel spec
Date: Mon,  9 Jul 2012 13:22:31 -0700
Message-Id: <1341865351-6673-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added hysteresis to the list of channel info enumeration, shared
/separate bit defines and to postfix channel info strings.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/industrialio-core.c |    1 +
 include/linux/iio/iio.h         |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1ddd886..ceb5d90 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -92,6 +92,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
 	[IIO_CHAN_INFO_PHASE] = "phase",
 	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
+	[IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
 };
 
 const struct iio_chan_spec
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3a4f6a3..9ed1063 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -35,6 +35,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_FREQUENCY,
 	IIO_CHAN_INFO_PHASE,
 	IIO_CHAN_INFO_HARDWAREGAIN,
+	IIO_CHAN_INFO_HYSTERESIS,
 };
 
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
@@ -100,6 +101,10 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
 #define IIO_CHAN_INFO_HARDWAREGAIN_SHARED_BIT			\
 	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
+#define IIO_CHAN_INFO_HYSTERESIS_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HYSTERESIS)
+#define IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HYSTERESIS)
 
 enum iio_endian {
 	IIO_CPU,
-- 
1.7.7.6

