Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.cosmopool.net ([178.63.74.76]:48222 "EHLO
	mail.cosmopool.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab3HVS1D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 14:27:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.cosmopool.net (Postfix) with ESMTP id 09E606D8010
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2013 20:17:54 +0200 (CEST)
Received: from mail.cosmopool.net ([127.0.0.1])
	by localhost (mail.cosmopool.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7PEzLwU2O67 for <linux-iio@vger.kernel.org>;
	Thu, 22 Aug 2013 20:17:52 +0200 (CEST)
Received: from stardust.g4.wien.funkfeuer.at (046-220-076-243.dyn.orange.at [46.220.76.243])
	by mail.cosmopool.net (Postfix) with ESMTPSA id 656E36D8006
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2013 20:17:50 +0200 (CEST)
Received: from lambda (helo=a.g4.wien.funkfeuer.at)
	by stardust.g4.wien.funkfeuer.at with local-esmtp (Exim 4.72)
	(envelope-from <harald@ccbib.org>)
	id 1VCZSM-0000d4-6T
	for linux-iio@vger.kernel.org; Thu, 22 Aug 2013 20:18:02 +0200
Message-Id: <E1VCZSM-0000d4-6T@stardust.g4.wien.funkfeuer.at>
To: linux-iio@vger.kernel.org
Subject: [PATCH] iio: Add support for humidity sensors
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Thu, 22 Aug 2013 20:18:02 +0200
From: Harald Geyer <harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are already humidity sensors in the hwmon subsystem,
so we use their unit (milli percent) here as well.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
I decided to test the actual driver on more diverse hardware
and am still waiting for samples to arrive. But I figure I
can already post the required changes to the iio core for
review.

This works for me (tested on a openwrt system). Please tell
me if more is needed.

Harald

 Documentation/ABI/testing/sysfs-bus-iio |   13 +++++++++++++
 drivers/iio/industrialio-core.c         |    1 +
 include/linux/iio/types.h               |    1 +
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 45ae709..23e427f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -197,6 +197,19 @@ Description:
 		Raw pressure measurement from channel Y. Units after
 		application of scale and offset are kilopascal.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
+KernelVersion:	3.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw humidity measurement of air. Units after application of
+		scale and offset are milli percent.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
+KernelVersion:	3.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scaled humidity measurement in milli percent.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 97f0297..08f62d1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -66,6 +66,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ALTVOLTAGE] = "altvoltage",
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
+	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 88bf0f0..f822b3d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -29,6 +29,7 @@ enum iio_chan_type {
 	IIO_ALTVOLTAGE,
 	IIO_CCT,
 	IIO_PRESSURE,
+	IIO_HUMIDITYRELATIVE,
 };
 
 enum iio_modifier {
-- 
1.7.2.5

