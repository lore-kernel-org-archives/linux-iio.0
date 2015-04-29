Return-Path: <octavian.purdila@intel.com>
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adriana.reus@intel.com,
	linux-api@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 2/3] iio: allow better control for flushing the hardware fifo
Date: Wed, 29 Apr 2015 14:18:59 +0300
Message-Id: <1430306340-5026-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1430306340-5026-1-git-send-email-octavian.purdila@intel.com>
References: <1430306340-5026-1-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Some applications need to be able to flush [1] the hardware fifo of
the device and to receive events of when that happened [2] so that it
can ignore stale data.

This patch adds a new event (IIO_EV_TYPE_HWFIFO_FLUSHED) that should
be sent to userspace when a flush has been completed. The application
will be able to identify which are the samples to ignore based on the
timestamp of the event.

To allow applications to accurately generate a hardware fifo flush on
demand, this patch also adds a new sysfs entry that triggers a
hardware fifo flush when written to.

[1] https://source.android.com/devices/sensors/hal-interface.html#flush_sensor
[2] https://source.android.com/devices/sensors/hal-interface.html#metadata_flush_complete_events

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 include/linux/iio/sysfs.h               |  3 +++
 include/uapi/linux/iio/types.h          |  1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 866b4ec..bb4d8de 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1375,3 +1375,14 @@ Description:
 		The emissivity ratio of the surface in the field of view of the
 		contactless temperature sensor.  Emissivity varies from 0 to 1,
 		with 1 being the emissivity of a black body.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_flush
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Write only entry that accepts a single strictly positive integer
+		specifying the number of samples to flush from the hardware fifo
+		to the device buffer. When the flush is completed an
+		IIO_EV_TYPE_HWFIFO_FLUSHED event is generated. The event has the
+		timestamp equal with the timestamp of last sample that was
+		flushed from the hardware fifo.
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 8822bab..8fcc25b 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -136,4 +136,7 @@ struct iio_const_attr {
 #define IIO_DEV_ATTR_HWFIFO_WATERMARK(_hwfifo_get_wm)	\
 	IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO, _hwfifo_get_wm, NULL, 0)
 
+#define IIO_DEV_ATTR_HWFIFO_FLUSH(_hwfifo_flush)	\
+	IIO_DEVICE_ATTR(hwfifo_flush, S_IWUSR, NULL, _hwfifo_flush, 0)
+
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 5c46019..4600157 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -79,6 +79,7 @@ enum iio_event_type {
 	IIO_EV_TYPE_THRESH_ADAPTIVE,
 	IIO_EV_TYPE_MAG_ADAPTIVE,
 	IIO_EV_TYPE_CHANGE,
+	IIO_EV_TYPE_HWFIFO_FLUSHED,
 };
 
 enum iio_event_direction {
-- 
1.9.1
