Return-Path: <SRS0=0JFy=YN=intel.com=hongyan.song@kernel.org>
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@intel.com,
	Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH 1/4] iio: Add support for max_sampling_frequency
Date: Fri, 30 Dec 2016 17:23:09 +0800
Message-Id: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for max_sampling_frequency, this will help user to
set sampling frequency to an acceptable range.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/linux/iio/iio.h                 | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 60b7406..cbcd2b8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -54,6 +54,13 @@ Description:
 		relevant directories.  If it effects all of the above
 		then it is to be found in the base device directory.
 
+What:		/sys/bus/iio/devices/iio:deviceX/max_sampling_frequency
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This parameter shows the max sampling frequency, which can
+		help user to set sampling frequency to an acceptable range.
+
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
 What:		/sys/.../iio:deviceX/buffer/sampling_frequency_available
 What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 72fc96a..5203e75 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -140,6 +140,7 @@ struct bus_type iio_bus_type = {
 	[IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY]
 	= "filter_high_pass_3db_frequency",
 	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
+	[IIO_CHAN_INFO_MAX_SAMP_FREQ] = "max_sampling_frequency",
 	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
 	[IIO_CHAN_INFO_PHASE] = "phase",
 	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b4a0679..f9eba2e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -34,6 +34,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
 	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
 	IIO_CHAN_INFO_SAMP_FREQ,
+	IIO_CHAN_INFO_MAX_SAMP_FREQ,
 	IIO_CHAN_INFO_FREQUENCY,
 	IIO_CHAN_INFO_PHASE,
 	IIO_CHAN_INFO_HARDWAREGAIN,
-- 
1.9.1
