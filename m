Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:37371 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751498Ab1AMNJ7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 08:09:59 -0500
From: Roland Stigge <rst@work-microwave.de>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <rst@work-microwave.de>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 1/3] iio: Documentation update for outputs / dac
Date: Thu, 13 Jan 2011 14:09:50 +0100
Message-Id: <1294924192-28923-1-git-send-email-rst@work-microwave.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Documented outX_raw etc. interfaces

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/staging/iio/Documentation/sysfs-bus-iio |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 2dde97d..38b9813 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -168,6 +168,7 @@ Description:
 What:		/sys/bus/iio/devices/deviceX/inY_scale
 What:		/sys/bus/iio/devices/deviceX/inY_supply_scale
 What:		/sys/bus/iio/devices/deviceX/in_scale
+What:		/sys/bus/iio/devices/deviceX/outY_scale
 What:		/sys/bus/iio/devices/deviceX/accel_scale
 What:		/sys/bus/iio/devices/deviceX/accel_peak_scale
 What:		/sys/bus/iio/devices/deviceX/gyro_scale
@@ -222,6 +223,25 @@ Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
+What:		/sys/bus/iio/devices/deviceX/outY_raw
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled, no bias etc.) output voltage for
+		channel Y. In special cases where the channel does not
+		correspond to externally available output one of the named
+		versions may be used. The number must always be specified and
+		unique if the output corresponds to a single channel.
+
+What:		/sys/bus/iio/devices/deviceX/outY&Z&..._raw
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled, no bias etc.) output voltage for an aggregate of
+		channel Y, channel Z, etc.  This interface is available in cases
+		where a single output sets the value for multiple channels
+		simultaneously.
+
 What:		/sys/bus/iio/devices/deviceX/deviceX:eventY
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
-- 
1.7.2.3

