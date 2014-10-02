Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: daniel.baluta@intel.com,
	irina.tirdea@intel.com
Subject: [RFC PATCH 8/8] iio: event_monitor: Add support for activity channel
Date: Thu,  2 Oct 2014 16:43:59 +0300
Message-Id: <1412257439-15683-9-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1412257439-15683-1-git-send-email-daniel.baluta@intel.com>
References: <1412257439-15683-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

We have the following testing scenario:

$ insmod iio_dummy_evgen.ko
$ insmod iio_dummy.ko

$ ./iio_event_monitor /dev/iio:device0
Event: time: 1412254756207353948, type: voltage, channel: 0, evtype: thresh, direction: rising
Event: time: 1412254762455172908, type: activity(running), channel: 0, evtype: motion, direction: rising
Event: time: 1412254770823830774, type: activity, channel: 0, evtype: step_detect, direction: rising

$ echo 0 > /sys/bus/iio/devices/iio_evgen/poke_ev0
$ echo 1 > /sys/bus/iio/devices/iio_evgen/poke_ev0
$ echo 2 > /sys/bus/iio/devices/iio_evgen/poke_ev0

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/staging/iio/Documentation/iio_event_monitor.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 569d6f8..5df7662 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -49,6 +49,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_ACTIVITY] = "activity",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -57,6 +58,8 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_ROC] = "roc",
 	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
+	[IIO_EV_TYPE_MOTION] = "motion",
+	[IIO_EV_TYPE_STEP_DETECT] = "step_detect",
 };
 
 static const char * const iio_ev_dir_text[] = {
@@ -79,6 +82,11 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_RUNNING] = "running",
+	[IIO_MOD_JOGGING] = "jogging",
+	[IIO_MOD_WALKING] = "walking",
+	[IIO_MOD_STILL] = "still",
+	[IIO_MOD_PED_STEPS] = "steps",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -108,6 +116,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_CCT:
 	case IIO_PRESSURE:
 	case IIO_HUMIDITYRELATIVE:
+	case IIO_ACTIVITY:
 		break;
 	default:
 		return false;
@@ -126,6 +135,11 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_LIGHT_RED:
 	case IIO_MOD_LIGHT_GREEN:
 	case IIO_MOD_LIGHT_BLUE:
+	case IIO_MOD_RUNNING:
+	case IIO_MOD_JOGGING:
+	case IIO_MOD_WALKING:
+	case IIO_MOD_STILL:
+	case IIO_MOD_PED_STEPS:
 		break;
 	default:
 		return false;
@@ -137,6 +151,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_EV_TYPE_ROC:
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
+	case IIO_EV_TYPE_MOTION:
+	case IIO_EV_TYPE_STEP_DETECT:
 		break;
 	default:
 		return false;
-- 
1.9.1
