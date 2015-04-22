Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40972 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965542AbbDVQcR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2015 12:32:17 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/3] iio: heart_monitors: Add support for heart rate monitors
Date: Wed, 22 Apr 2015 11:32:09 -0500
Message-ID: <1429720331-1900-2-git-send-email-dmurphy@ti.com>
In-Reply-To: <1429720331-1900-1-git-send-email-dmurphy@ti.com>
References: <1429720331-1900-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a type for heart rate monitors
Add the modifier name in beats per minute.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 tools/iio/iio_event_monitor.c   | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4df97f6..b7b3817 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ENERGY] = "energy",
 	[IIO_DISTANCE] = "distance",
 	[IIO_VELOCITY] = "velocity",
+	[IIO_HEARTRATE] = "heartrate",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 5c46019..b5e8c2f 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -35,6 +35,7 @@ enum iio_chan_type {
 	IIO_ENERGY,
 	IIO_DISTANCE,
 	IIO_VELOCITY,
+	IIO_HEARTRATE,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 427c271..b2cc544 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -51,6 +51,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
 	[IIO_ACTIVITY] = "activity",
 	[IIO_STEPS] = "steps",
+	[IIO_HEARTRATE] = "heartrate",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -130,6 +131,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_HUMIDITYRELATIVE:
 	case IIO_ACTIVITY:
 	case IIO_STEPS:
+	case IIO_HEARTRATE:
 		break;
 	default:
 		return false;
-- 
1.9.1

