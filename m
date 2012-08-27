Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jkosina@suse.cz,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 1/9] IIO: core: Add hysteresis in channel spec
Date: Mon, 27 Aug 2012 08:49:49 -0700
Message-Id: <1346082597-768-2-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added hysteresis to the list of channel info enumeration, shared
/separate bit defines and to postfix channel info strings.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/industrialio-core.c |    1 +
 include/linux/iio/iio.h         |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2ec266e..5ff85d5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -99,6 +99,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
 	[IIO_CHAN_INFO_PHASE] = "phase",
 	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
+	[IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
 };
 
 const struct iio_chan_spec
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index be82936..7f7afb7 100644
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
