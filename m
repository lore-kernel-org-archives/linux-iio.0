Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:53412
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755354Ab2EIKgQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 06:36:16 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] iio: core: introduce IIO_CHAN_INFO_HARDWAREGAIN
Date: Wed, 9 May 2012 12:36:13 +0200
Message-ID: <1336559774-21136-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com>
References: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |    7 +++++++
 drivers/iio/industrialio-core.c         |    1 +
 include/linux/iio/iio.h                 |    5 +++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ccd8c84..cfedf63 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -282,6 +282,13 @@ Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
+What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
+KernelVersion:	2.6.35
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Hardware applied gain factor. If shared across all channels,
+		<type>_hardwaregain is used.
+
 What:		/sys/.../in_accel_filter_low_pass_3db_frequency
 What:		/sys/.../in_magn_filter_low_pass_3db_frequency
 What:		/sys/.../in_anglvel_filter_low_pass_3db_frequency
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e799d35..874fb70 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -91,6 +91,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
 	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
 	[IIO_CHAN_INFO_PHASE] = "phase",
+	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
 };
 
 const struct iio_chan_spec
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 6fdbdb8..897c6b0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -34,6 +34,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SAMP_FREQ,
 	IIO_CHAN_INFO_FREQUENCY,
 	IIO_CHAN_INFO_PHASE,
+	IIO_CHAN_INFO_HARDWAREGAIN,
 };
 
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
@@ -95,6 +96,10 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PHASE)
 #define IIO_CHAN_INFO_PHASE_SHARED_BIT			\
 	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PHASE)
+#define IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
+#define IIO_CHAN_INFO_HARDWAREGAIN_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
 
 enum iio_endian {
 	IIO_CPU,
-- 
1.7.0.4


