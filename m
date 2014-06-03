Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58620 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933860AbaFCWmY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:24 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 01/15] staging:iio: Update iio_event_monitor program
Date: Wed,  4 Jun 2014 00:42:01 +0200
Message-Id: <1401835335-29969-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

add types recently added

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_event_monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 3a9b000..cb35a97 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -46,6 +46,9 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_CAPACITANCE] = "capacitance",
 	[IIO_ALTVOLTAGE] = "altvoltage",
+	[IIO_CCT] = "cct",
+	[IIO_PRESSURE] = "pressure",
+	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -70,6 +73,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_IR] = "ir",
 	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
 	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
+	[IIO_MOD_LIGHT_BOTH] = "both",
+	[IIO_MOD_LIGHT_IR] = "ir",
 	[IIO_MOD_LIGHT_CLEAR] = "clear",
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
@@ -100,6 +105,9 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_TIMESTAMP:
 	case IIO_CAPACITANCE:
 	case IIO_ALTVOLTAGE:
+	case IIO_CCT:
+	case IIO_PRESSURE:
+	case IIO_HUMIDITYRELATIVE:
 		break;
 	default:
 		return false;
@@ -114,6 +122,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_LIGHT_IR:
 	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
 	case IIO_MOD_SUM_SQUARED_X_Y_Z:
+	case IIO_MOD_LIGHT_BOTH:
+	case IIO_MOD_LIGHT_IR:
 	case IIO_MOD_LIGHT_CLEAR:
 	case IIO_MOD_LIGHT_RED:
 	case IIO_MOD_LIGHT_GREEN:
-- 
1.9.1

