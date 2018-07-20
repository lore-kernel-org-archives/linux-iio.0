Return-Path: <m.othacehe@gmail.com>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: jic23@jic23.retrosnub.co.uk,
	linux-iio@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	pmeerw@pmeerw.net,
	pierre-moana.levesque@parrot.com,
	Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 1/3] iio: Add channel for Phase
Date: Fri, 20 Jul 2018 19:34:25 +0200
Message-Id: <20180720173427.30445-2-m.othacehe@gmail.com>
In-Reply-To: <20180720173427.30445-1-m.othacehe@gmail.com>
References: <20180720173427.30445-1-m.othacehe@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add new channel type support for phase.

This channel may be used by Time-of-flight sensors to express the
phase difference between emitted and received signals. Those sensor
will then use the phase shift of return signals to approximate the
distance to objects.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c7353030670a..c9cfa833cf47 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1675,3 +1675,10 @@ KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw counter device counters direction for channel Y.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
+KernelVersion:	4.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) phase difference reading from channel Y
+		that can be processed to radians.
\ No newline at end of file
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ed1b3ebade94..a16ad5a4ab0c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -86,6 +86,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
+	[IIO_PHASE] = "phase",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 033c7d28924e..e4df3cc268db 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -45,6 +45,7 @@ enum iio_chan_type {
 	IIO_INDEX,
 	IIO_GRAVITY,
 	IIO_POSITIONRELATIVE,
+	IIO_PHASE,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 148f69dfae75..f478f5558720 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
 	[IIO_POSITIONRELATIVE] = "positionrelative",
+	[IIO_PHASE] = "phase",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -153,6 +154,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_UVINDEX:
 	case IIO_GRAVITY:
 	case IIO_POSITIONRELATIVE:
+	case IIO_PHASE:
 		break;
 	default:
 		return false;
-- 
2.17.1
