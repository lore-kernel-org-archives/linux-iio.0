Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49577 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561Ab2GAKUP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 Jul 2012 06:20:15 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio staging: add recently added modifiers to iio_event_monitor
Date: Sun,  1 Jul 2012 12:20:13 +0200
Message-Id: <1341138013-28267-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

maybe iio_modifier_names and iio_chan_type_name_spec should be
exported from industrialio-core instead?

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 .../staging/iio/Documentation/iio_event_monitor.c  |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 4326e9e..3a9b000 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -68,6 +68,12 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Z] = "z",
 	[IIO_MOD_LIGHT_BOTH] = "both",
 	[IIO_MOD_LIGHT_IR] = "ir",
+	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
+	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
+	[IIO_MOD_LIGHT_CLEAR] = "clear",
+	[IIO_MOD_LIGHT_RED] = "red",
+	[IIO_MOD_LIGHT_GREEN] = "green",
+	[IIO_MOD_LIGHT_BLUE] = "blue",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -106,6 +112,12 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_Z:
 	case IIO_MOD_LIGHT_BOTH:
 	case IIO_MOD_LIGHT_IR:
+	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
+	case IIO_MOD_SUM_SQUARED_X_Y_Z:
+	case IIO_MOD_LIGHT_CLEAR:
+	case IIO_MOD_LIGHT_RED:
+	case IIO_MOD_LIGHT_GREEN:
+	case IIO_MOD_LIGHT_BLUE:
 		break;
 	default:
 		return false;
-- 
1.7.9.5

