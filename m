Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33007 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcATFfx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2016 00:35:53 -0500
Received: by mail-pa0-f48.google.com with SMTP id cy9so464243872pac.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2016 21:35:53 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 2/3] iio: ph: add IIO_PH channel type
Date: Tue, 19 Jan 2016 21:35:45 -0800
Message-Id: <1453268146-28388-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1453268146-28388-1-git-send-email-mranostay@gmail.com>
References: <1453268146-28388-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0439c2a..86ba8d6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1491,3 +1491,10 @@ Description:
 		This ABI is especially applicable for humidity sensors
 		to heatup the device and get rid of any condensation
 		in some humidity environment
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_ph_raw
+KernelVersion:	4.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) pH reading of a substance as a negative
+		base-10 logarithm of hydrodium ions in a litre of water.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index af7cc1e..70cb7eb 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -77,6 +77,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_VELOCITY] = "velocity",
 	[IIO_CONCENTRATION] = "concentration",
 	[IIO_RESISTANCE] = "resistance",
+	[IIO_PH] = "ph",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 7c63bd6..c077617 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -37,6 +37,7 @@ enum iio_chan_type {
 	IIO_VELOCITY,
 	IIO_CONCENTRATION,
 	IIO_RESISTANCE,
+	IIO_PH,
 };
 
 enum iio_modifier {
-- 
2.7.0.rc3

