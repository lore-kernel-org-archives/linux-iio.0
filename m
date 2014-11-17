Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbaKQSFJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Nov 2014 13:05:09 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC 1/8] iio: add support for hardware fifo
Date: Mon, 17 Nov 2014 19:55:59 +0200
Message-Id: <1416246966-3083-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some devices have hardware buffers that can store a number of samples
for later consumption. Hardware usually provides interrupts to notify
the processor when the fifo is full or when it has reached a certain
threshold.

Some devices also offer flexibility in what they do when the hardware
fifo is full: either discard future samples, or overwrite older
samples with newer ones.

The hardware fifo is useful for reducing the number of interrupts to
the host processor and thus it helps decreasing the power consumption.

This patch adds four new IIO attributes to expose the hardware fifo
and it's configuration to userspace:

 * _fifo_length - the number of samples that the hardware can store;
   it is usefull to expose it to userspace, so that applications can
   increase the device buffer size appropriately

 * _fifo_mode - the mode the hardware fifo operates

 * _fifo_mode_available - the available hardware fifo modes

 * _fifo_flush - this attribute can be used by userspace to trigger a
   fifo flush operation, where all data stored in the fifo will be
   made available to the device buffer

Since the last two attributes work with strings, they are using the
iio_chan_spec_ext_info infrastructure. To simplify the setup for a
hardware fifo the IIO_FIFO_EXT_INFO marcro can be used to initialize
them.

This patch also add two new events: IIO_EV_TYPE_FIFO_FULL and
IIO_EV_TYPE_FIFO_WATERMAK. If enabled they must be issued by the
device when the fifo level reaches full or, respectively, the
watermark level. The watermark level can be set by configuring the
event value.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 51 +++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |  2 ++
 drivers/iio/industrialio-event.c        |  2 ++
 include/linux/iio/iio.h                 | 17 +++++++++++
 include/linux/iio/types.h               |  2 ++
 5 files changed, 74 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ea7e7ab..f326de1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1050,3 +1050,54 @@ Description:
 		after application of scale and offset. If no offset or scale is
 		present, output should be considered as processed with the
 		unit in milliamps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_fifo_length
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_fifo_length
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_fifo_length
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_length
+KernelVersion:	3.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The maximum number of samples that the hardware fifo can
+		store.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_fifo_mode
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_fifo_mode
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_fifo_mode
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_mode
+KernelVersion:	3.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The mode in which the hardware fifo currently operates. The
+		supported values are "disabled", "fifo" and "stream".
+		In disabled mode the hardware fifo is not operational.
+		In fifo mode the samples are stored until the fifo is full at
+		which point all subsequent samples are discarded.
+		In stream mode, when the fifo is full new samples start to
+		overrride old samples.
+		If the hardware supports it, IIO_EVENT_TYPE_FIFO_FULL and
+		IIO_EVENT_TYPE_FIFO_WATERMARK events will be generated when they
+		are enabled by the application and the fifo is full and,
+		respectively, when the fifo level reaches the watermark
+		level.
+		The watermark level can be set by the application by configuring
+		the IIO_EVENT_TYPE_FIFO_WATERMARK value (IIO_EV_INFO_VALUE).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_fifo_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_fifo_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_fifo_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_mode_available
+KernelVersion:	3.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The modes that the hardware fifo supports.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_fifo_flush
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_fifo_flush
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_fifo_flush
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_flush
+KernelVersion:	3.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writting to this entry will cause the device to flush the data
+		from the hardware fifo into the device buffer.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index af3e76d..17e84c3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -113,6 +113,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
 	[IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
 	[IIO_CHAN_INFO_INT_TIME] = "integration_time",
+	[IIO_CHAN_INFO_FIFO_LENGTH] = "fifo_length",
+	[IIO_CHAN_INFO_FIFO_FLUSH] = "fifo_flush",
 };
 
 /**
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 0c1e37e..3d73fd0 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -197,6 +197,8 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_ROC] = "roc",
 	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
+	[IIO_EV_TYPE_FIFO_FULL] = "fifo_full",
+	[IIO_EV_TYPE_FIFO_WATERMARK] = "fifo_watermak",
 };
 
 static const char * const iio_ev_dir_text[] = {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3642ce7..ad100a1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -38,6 +38,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_HARDWAREGAIN,
 	IIO_CHAN_INFO_HYSTERESIS,
 	IIO_CHAN_INFO_INT_TIME,
+	IIO_CHAN_INFO_FIFO_LENGTH,
+	IIO_CHAN_INFO_FIFO_FLUSH,
 };
 
 enum iio_shared_by {
@@ -629,4 +631,19 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
  */
 #define IIO_G_TO_M_S_2(g) ((g) * 980665ULL / 100000ULL)
 
+/**
+ * IIO_FIFO_EXT_INFO() - define a hardware fifo associated with a channel/device
+ *
+ * @_fifo_mode_enum - a pointer to a struct iio_enum that defines the available
+ * modes for this hardware fifo (see Documentation/ABI/testing/sysfs-bus-iio for
+ * supported modes)
+ * @_shared - type of sharing; can be IIO_SEPARATE if we have fifo(s) per
+ * modifier (e.g. x, y, z), IIO_SHARED_BY_TYPE if we have fifo(s) per channel or
+ * IIO_SHARED_BY_ALL if we have a single fifo for all channels
+ *
+ */
+#define IIO_FIFO_EXT_INFO(_fifo_mode_enum, _shared)			\
+	IIO_ENUM("fifo_mode", _shared, _fifo_mode_enum),		\
+	IIO_ENUM_AVAILABLE("fifo_mode", _fifo_mode_enum)
+
 #endif /* _INDUSTRIAL_IO_H_ */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4a2af8a..8ee5a21 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -68,6 +68,8 @@ enum iio_event_type {
 	IIO_EV_TYPE_ROC,
 	IIO_EV_TYPE_THRESH_ADAPTIVE,
 	IIO_EV_TYPE_MAG_ADAPTIVE,
+	IIO_EV_TYPE_FIFO_FULL,
+	IIO_EV_TYPE_FIFO_WATERMARK,
 };
 
 enum iio_event_info {
-- 
1.9.1

