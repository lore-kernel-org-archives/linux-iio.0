Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35824 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbIJGb0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 02:31:26 -0400
Received: by pacfv12 with SMTP id fv12so34269886pac.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2015 23:31:26 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v4 2/4] iio: resistance: add IIO_RESISTANCE channel type
Date: Wed,  9 Sep 2015 23:30:52 -0700
Message-Id: <1441866654-10381-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1441866654-10381-1-git-send-email-mranostay@gmail.com>
References: <1441866654-10381-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 48080b7..0f683ed 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1466,3 +1466,10 @@ KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled no offset etc.) precentage reading of a substance.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
+KernelVersion:	4.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) resistance reading in ohms.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 58a60a1..d61a363 100644
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
index c5a0e3f..d58319c 100644
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

