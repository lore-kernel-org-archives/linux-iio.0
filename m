Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38536 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbaJVNu3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Oct 2014 09:50:29 -0400
Received: by mail-wi0-f171.google.com with SMTP id em10so1430786wid.16
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2014 06:50:28 -0700 (PDT)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH v3] staging: iio: iio_event_monitor: Add support for missing IIO modifiers
Date: Wed, 22 Oct 2014 16:50:17 +0300
Message-Id: <1413985817-10867-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the missing IIO modifiers in event_is_known function
and iio_modifier_names vector.

Additionally, it removes duplicate name entries of IIO_MOD_LIGHT_BOTH
and IIO_MOD_LIGHT_IR in iio_modifier_names.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
Changes since v1:
	- Add iio_event_monitor in subject
	- Modify commit message in order to be more clear
	- Add missing comma

Changes since v2:
	- Fix spotted typo
 
 .../staging/iio/Documentation/iio_event_monitor.c  | 32 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 569d6f8..0300900 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -69,16 +69,29 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_X] = "x",
 	[IIO_MOD_Y] = "y",
 	[IIO_MOD_Z] = "z",
+	[IIO_MOD_X_AND_Y] = "x&y",
+	[IIO_MOD_X_AND_Z] = "x&z",
+	[IIO_MOD_Y_AND_Z] = "y&z",
+	[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
+	[IIO_MOD_X_OR_Y] = "x|y",
+	[IIO_MOD_X_OR_Z] = "x|z",
+	[IIO_MOD_Y_OR_Z] = "y|z",
+	[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
 	[IIO_MOD_LIGHT_BOTH] = "both",
 	[IIO_MOD_LIGHT_IR] = "ir",
 	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
 	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
-	[IIO_MOD_LIGHT_BOTH] = "both",
-	[IIO_MOD_LIGHT_IR] = "ir",
 	[IIO_MOD_LIGHT_CLEAR] = "clear",
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_QUATERNION] = "quaternion",
+	[IIO_MOD_TEMP_AMBIENT] = "ambient",
+	[IIO_MOD_TEMP_OBJECT] = "object",
+	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
+	[IIO_MOD_NORTH_TRUE] = "from_north_true",
+	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
+	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -118,6 +131,14 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
 	case IIO_MOD_Z:
+	case IIO_MOD_X_AND_Y:
+	case IIO_MOD_X_AND_Z:
+	case IIO_MOD_Y_AND_Z:
+	case IIO_MOD_X_AND_Y_AND_Z:
+	case IIO_MOD_X_OR_Y:
+	case IIO_MOD_X_OR_Z:
+	case IIO_MOD_Y_OR_Z:
+	case IIO_MOD_X_OR_Y_OR_Z:
 	case IIO_MOD_LIGHT_BOTH:
 	case IIO_MOD_LIGHT_IR:
 	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
@@ -126,6 +147,13 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_LIGHT_RED:
 	case IIO_MOD_LIGHT_GREEN:
 	case IIO_MOD_LIGHT_BLUE:
+	case IIO_MOD_QUATERNION:
+	case IIO_MOD_TEMP_AMBIENT:
+	case IIO_MOD_TEMP_OBJECT:
+	case IIO_MOD_NORTH_MAGN:
+	case IIO_MOD_NORTH_TRUE:
+	case IIO_MOD_NORTH_MAGN_TILT_COMP:
+	case IIO_MOD_NORTH_TRUE_TILT_COMP:
 		break;
 	default:
 		return false;
-- 
1.9.1

