Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V5 3/7] iio: core: add high pass filter attributes
To: Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org
Date: Mon, 01 Jun 2015 15:39:50 +0200
Message-ID: <20150601133949.24925.89399.stgit@localhost>
In-Reply-To: <20150601133943.24925.83080.stgit@localhost>
References: <20150601133943.24925.83080.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Add a high pass filter attribute for measurements
(like the existing low pass)

Also add both high and low pass attibutes for events.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   30 ++++++++++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |    2 ++
 drivers/iio/industrialio-event.c        |    2 ++
 include/linux/iio/iio.h                 |    1 +
 include/linux/iio/types.h               |    2 ++
 5 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3befcb1..ef1f11e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -420,6 +420,16 @@ Description:
 		to the underlying data channel, then this parameter
 		gives the 3dB frequency of the filter in Hz.
 
+What:		/sys/.../in_accel_filter_high_pass_3db_frequency
+What:		/sys/.../in_anglvel_filter_high_pass_3db_frequency
+What:		/sys/.../in_magn_filter_high_pass_3db_frequency
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If a known or controllable high pass filter is applied
+		to the underlying data channel, then this parameter
+		gives the 3dB frequency of the filter in Hz.
+
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_raw
 KernelVersion:	2.6.37
@@ -880,6 +890,26 @@ Description:
 		met before an event is generated. If direction is not
 		specified then this period applies to both directions.
 
+What:		/sys/.../events/in_accel_thresh_rising_low_pass_filter_3db
+What:		/sys/.../events/in_anglvel_thresh_rising_low_pass_filter_3db
+What:		/sys/.../events/in_magn_thresh_rising_low_pass_filter_3db
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If a low pass filter can be applied to the event generation
+		this property gives its 3db frequency in Hz.
+		A value of zero disables the filter.
+
+What:		/sys/.../events/in_accel_thresh_rising_high_pass_filter_3db
+What:		/sys/.../events/in_anglvel_thresh_rising_high_pass_filter_3db
+What:		/sys/.../events/in_magn_thresh_rising_high_pass_filter_3db
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If a high pass filter can be applied to the event generation
+		this property gives its 3db frequency in Hz.
+		A value of zero disables the filter.
+
 What:		/sys/.../events/in_activity_still_thresh_rising_en
 What:		/sys/.../events/in_activity_still_thresh_falling_en
 What:		/sys/.../events/in_activity_walking_thresh_rising_en
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4df97f6..6c8730e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -117,6 +117,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
 	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
 	= "filter_low_pass_3db_frequency",
+	[IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY]
+	= "filter_high_pass_3db_frequency",
 	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
 	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
 	[IIO_CHAN_INFO_PHASE] = "phase",
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a99692b..894d813 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -211,6 +211,8 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_VALUE] = "value",
 	[IIO_EV_INFO_HYSTERESIS] = "hysteresis",
 	[IIO_EV_INFO_PERIOD] = "period",
+	[IIO_EV_INFO_HIGH_PASS_FILTER_3DB] = "high_pass_filter_3db",
+	[IIO_EV_INFO_LOW_PASS_FILTER_3DB] = "low_pass_filter_3db",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d86b753..1d6c15e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -32,6 +32,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
 	IIO_CHAN_INFO_AVERAGE_RAW,
 	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
+	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
 	IIO_CHAN_INFO_SAMP_FREQ,
 	IIO_CHAN_INFO_FREQUENCY,
 	IIO_CHAN_INFO_PHASE,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 942b6de..32b5795 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -17,6 +17,8 @@ enum iio_event_info {
 	IIO_EV_INFO_VALUE,
 	IIO_EV_INFO_HYSTERESIS,
 	IIO_EV_INFO_PERIOD,
+	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
+	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
 };
 
 #define IIO_VAL_INT 1
