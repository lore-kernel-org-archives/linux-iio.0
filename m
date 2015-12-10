Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36122 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbbLJIKo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2015 03:10:44 -0500
Received: by pfbu66 with SMTP id u66so490418pfb.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2015 00:10:43 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v1 2/3] iio: ph: add IIO_PH channel type
Date: Thu, 10 Dec 2015 00:10:47 -0800
Message-Id: <1449735048-16668-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1449735048-16668-1-git-send-email-mranostay@gmail.com>
References: <1449735048-16668-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0439c2a..b15314e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1491,3 +1491,9 @@ Description:
 		This ABI is especially applicable for humidity sensors
 		to heatup the device and get rid of any condensation
 		in some humidity environment
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_ph_raw
+KernelVersion:	4.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) pH reading of a substance.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d42a8ff9..e1b9a9e 100644
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
1.9.1

