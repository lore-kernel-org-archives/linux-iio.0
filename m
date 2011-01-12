Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:56281 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab1ALKkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Jan 2011 05:40:24 -0500
Received: from [IPv6:2001:a60:f08d:1:3594:36e1:581a:3d62] (unknown [IPv6:2001:a60:f08d:1:3594:36e1:581a:3d62])
	by chuck.antcom.de (Postfix) with ESMTPSA id 53E6A7201BA
	for <linux-iio@vger.kernel.org>; Wed, 12 Jan 2011 10:40:22 +0000 (UTC)
Message-ID: <4D2D8516.1040602@antcom.de>
Date: Wed, 12 Jan 2011 11:40:22 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH] iio: Documentation update for outputs / dac
Content-Type: multipart/mixed;
 boundary="------------050506080401060307030708"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------050506080401060307030708
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Attached is the documentation update for iio outputs / dac.

--------------050506080401060307030708
Content-Type: text/x-patch;
 name="iio-out-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="iio-out-doc.patch"

iio: Documentation update for outputs / dac

Signed-off-by: Roland Stigge <stigge@antcom.de>

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

--------------050506080401060307030708--
