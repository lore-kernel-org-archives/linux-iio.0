Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:52778 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753792Ab3FKSCs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 14:02:48 -0400
Received: from mail96.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 81DA3FF9003
	for <linux-iio@vger.kernel.org>; Tue, 11 Jun 2013 16:58:09 +0200 (CEST)
From: Alexandre Relange <alexandre@relange.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Alexandre Relange <alexandre@relange.org>
Subject: [PATCH 3/5] iio: new type of channel: STATE
Date: Tue, 11 Jun 2013 16:52:14 +0200
Message-Id: <1370962336-20739-3-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-1-git-send-email-alexandre@relange.org>
References: <1370962336-20739-1-git-send-email-alexandre@relange.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This type is used for sensing that is not a physical quantity
(e.g. a switch). This type has no unit.
Included ABI documentation update.

Signed-off-by: Alexandre Relange <alexandre@relange.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/types.h               |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index dda81ff..1c2be35 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -197,6 +197,13 @@ Description:
 		Raw pressure measurement from channel Y. Units after
 		application of scale and offset are kilopascal.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_state_raw
+KernelVersion:	3.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		State sensing of a device (e.g. switch state). Since this is not a
+		physical quantity, the value has no unit.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
@@ -714,6 +721,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
 What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
+What:		/sys/.../iio:deviceX/scan_elements/in_state_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -729,6 +737,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
 What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
+What:		/sys/.../iio:deviceX/scan_elements/in_state_type
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -775,6 +784,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_index
 What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_index
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_index
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
+What:		/sys/.../iio:deviceX/scan_elements/in_state_index
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e145931..0799d39 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -66,6 +66,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ALTVOLTAGE] = "altvoltage",
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
+	[IIO_STATE] = "state",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 88bf0f0..0aded40 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -29,6 +29,7 @@ enum iio_chan_type {
 	IIO_ALTVOLTAGE,
 	IIO_CCT,
 	IIO_PRESSURE,
+	IIO_STATE,
 };
 
 enum iio_modifier {
-- 
1.8.3

