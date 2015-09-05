Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33679 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbbIEFxT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 01:53:19 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v1 1/4] iio: chemical: Add IIO_CONCENTRATION channel type
Date: Fri,  4 Sep 2015 22:53:23 -0700
Message-Id: <1441432406-4761-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are air quality sensors that report data back in parts per million
of VOC (Volatile Organic Compounds) which are usually indexed from CO2
or another common pollutant.

This patchset adds an IIO_CONCENTRATION type and IIO_MOD_PPM/PPB modifiers
because no other channels types fit this use case.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-core.c         |  3 +++
 include/uapi/linux/iio/types.h          |  3 +++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 42d360f..a3803a1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1459,3 +1459,13 @@ Description:
 		measurements and return the average value as output data. Each
 		value resulted from <type>[_name]_oversampling_ratio measurements
 		is considered as one sample for <type>[_name]_sampling_frequency.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ppm_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ppb_raw
+KernelVersion:	4.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) concentration reading of data like
+		CO2 or VOC (Volatile Organic Compounds) substances with or without
+		ppm (Part Per Million) or ppb (Parts Per Billion) channel modifiers.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b3fcc2c..ea9e31a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ENERGY] = "energy",
 	[IIO_DISTANCE] = "distance",
 	[IIO_VELOCITY] = "velocity",
+	[IIO_CONCENTRATION] = "concentration",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -111,6 +112,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
 	[IIO_MOD_I] = "i",
 	[IIO_MOD_Q] = "q",
+	[IIO_MOD_PPM] = "ppm",
+	[IIO_MOD_PPB] = "ppb",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 2f8b117..dfb8b8c 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -35,6 +35,7 @@ enum iio_chan_type {
 	IIO_ENERGY,
 	IIO_DISTANCE,
 	IIO_VELOCITY,
+	IIO_CONCENTRATION,
 };
 
 enum iio_modifier {
@@ -72,6 +73,8 @@ enum iio_modifier {
 	IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z,
 	IIO_MOD_I,
 	IIO_MOD_Q,
+	IIO_MOD_PPM,
+	IIO_MOD_PPB,
 };
 
 enum iio_event_type {
-- 
1.9.1

