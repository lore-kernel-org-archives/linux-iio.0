Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:51189 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbaEBP5K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 May 2014 11:57:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] iio: Add ABI documentation for object and ambient modifiers
Date: Fri,  2 May 2014 17:57:05 +0200
Message-Id: <1399046226-6673-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net>
References: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6b74691..ca3d3b7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -114,14 +114,17 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_temp_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_ambient_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled no bias removal etc.) temperature measurement.
 		If an axis is specified it generally means that the temperature
 		sensor is associated with one part of a compound device (e.g.
-		a gyroscope axis). Units after application of scale and offset
+		a gyroscope axis). The ambient and object modifiers distinguish
+		between ambient (reference) and distant temperature for contact-
+		less measurements. Units after application of scale and offset
 		are milli degrees Celsius.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
-- 
1.9.1

