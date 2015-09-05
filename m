Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34865 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbbIEFxU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 01:53:20 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v1 2/4] iio: resistance: add IIO_RESISTANCE channel type
Date: Fri,  4 Sep 2015 22:53:24 -0700
Message-Id: <1441432406-4761-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a3803a1..1084659 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1469,3 +1469,9 @@ Description:
 		Raw (unscaled no offset etc.) concentration reading of data like
 		CO2 or VOC (Volatile Organic Compounds) substances with or without
 		ppm (Part Per Million) or ppb (Parts Per Billion) channel modifiers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
+KernelVersion:	4.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) resistance reading in ohms.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ea9e31a..862c066 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -76,6 +76,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_DISTANCE] = "distance",
 	[IIO_VELOCITY] = "velocity",
 	[IIO_CONCENTRATION] = "concentration",
+	[IIO_RESISTANCE] = "resistance",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index dfb8b8c..22edd4d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -36,6 +36,7 @@ enum iio_chan_type {
 	IIO_DISTANCE,
 	IIO_VELOCITY,
 	IIO_CONCENTRATION,
+	IIO_RESISTANCE,
 };
 
 enum iio_modifier {
-- 
1.9.1

