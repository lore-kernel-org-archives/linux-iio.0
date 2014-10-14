Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbaJNTN5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Oct 2014 15:13:57 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC Patch 1/3] iio: heart_monitors: Add support for heart rate monitors
Date: Tue, 14 Oct 2014 14:13:50 -0500
Message-ID: <1413314032-923-2-git-send-email-dmurphy@ti.com>
In-Reply-To: <1413314032-923-1-git-send-email-dmurphy@ti.com>
References: <1413314032-923-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a type for heart rate monitors
Add the modifier name in beats per minute.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/iio/industrialio-core.c                    |    2 ++
 .../staging/iio/Documentation/iio_event_monitor.c  |    2 ++
 include/linux/iio/types.h                          |    4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index af3e76d..d87ca35 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_HEARTRATE] = "heartrate",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -91,6 +92,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_NORTH_TRUE] = "from_north_true",
 	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
 	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
+	[IIO_MOD_HEART_BPM] = "heartrate_beats_per_minute",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 569d6f8..b06dab7 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -49,6 +49,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_HEARTRATE] = "heartrate"
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -108,6 +109,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_CCT:
 	case IIO_PRESSURE:
 	case IIO_HUMIDITYRELATIVE:
+	case IIO_MOD_HEART_BPM:
 		break;
 	default:
 		return false;
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4a2af8a..50b1456 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_chan_type {
 	IIO_CCT,
 	IIO_PRESSURE,
 	IIO_HUMIDITYRELATIVE,
+	IIO_HEARTRATE
 };
 
 enum iio_modifier {
@@ -59,7 +60,8 @@ enum iio_modifier {
 	IIO_MOD_NORTH_MAGN,
 	IIO_MOD_NORTH_TRUE,
 	IIO_MOD_NORTH_MAGN_TILT_COMP,
-	IIO_MOD_NORTH_TRUE_TILT_COMP
+	IIO_MOD_NORTH_TRUE_TILT_COMP,
+	IIO_MOD_HEART_BPM
 };
 
 enum iio_event_type {
-- 
1.7.9.5

