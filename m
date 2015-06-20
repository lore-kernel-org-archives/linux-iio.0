Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] tools: iio: Add missing names to iio_event_monitor
Date: Sat, 20 Jun 2015 23:52:31 +0200
Message-Id: <1434837152-30830-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
References: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 tools/iio/iio_event_monitor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 427c271..2a89616 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -51,6 +51,9 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
 	[IIO_ACTIVITY] = "activity",
 	[IIO_STEPS] = "steps",
+	[IIO_ENERGY] = "energy",
+	[IIO_DISTANCE] = "distance",
+	[IIO_VELOCITY] = "velocity",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -99,6 +102,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_JOGGING] = "jogging",
 	[IIO_MOD_WALKING] = "walking",
 	[IIO_MOD_STILL] = "still",
+	[IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -130,6 +134,9 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_HUMIDITYRELATIVE:
 	case IIO_ACTIVITY:
 	case IIO_STEPS:
+	case IIO_ENERGY:
+	case IIO_DISTANCE:
+	case IIO_VELOCITY:
 		break;
 	default:
 		return false;
@@ -167,6 +174,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_JOGGING:
 	case IIO_MOD_WALKING:
 	case IIO_MOD_STILL:
+	case IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z:
 		break;
 	default:
 		return false;
-- 
1.9.1
