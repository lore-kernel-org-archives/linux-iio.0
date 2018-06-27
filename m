Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55816 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932203AbeF0IFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jun 2018 04:05:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so4676245wmv.5
        for <linux-iio@vger.kernel.org>; Wed, 27 Jun 2018 01:05:42 -0700 (PDT)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com
Cc: pierre-moana.levesque@parrot.com,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 1/2] iio: Add channel for Phase
Date: Wed, 27 Jun 2018 10:05:35 +0200
Message-Id: <1530086736-8005-1-git-send-email-m.othacehe@gmail.com>
In-Reply-To: <20180622182555.000032b6@huawei.com>
References: <20180622182555.000032b6@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
index 731146c..e0ff2b7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1663,3 +1663,10 @@ KernelVersion:	4.12
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
index 19bdf3d..34333de 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_PHASE] = "phase",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 4213cdf..6252a0b 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -44,6 +44,7 @@ enum iio_chan_type {
 	IIO_COUNT,
 	IIO_INDEX,
 	IIO_GRAVITY,
+	IIO_PHASE,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e..34190f4 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
+	[IIO_PHASE] = "phase",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PH:
 	case IIO_UVINDEX:
 	case IIO_GRAVITY:
+	case IIO_PHASE:
 		break;
 	default:
 		return false;
-- 
2.7.4

