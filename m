Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:39528 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755349AbdJJNsv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Oct 2017 09:48:51 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] Documentation: iio: Clarify meaning of IIO_DISTANCE channel type
Date: Tue, 10 Oct 2017 15:48:46 +0200
Message-Id: <20171010134847.2175-1-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_DISTANCE is used for two purposes: for pedometers to record the
distance covered by a walker, and to measure the distance to an object

IIO_DISTANCE is in meters while IIO_PROXIMITY is a unitless measure
indirectly proportional to distance (higher value relates to a closer
object)

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7eead5f97e02..3fc79185cc56 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1242,9 +1242,9 @@ What:		/sys/.../iio:deviceX/in_distance_raw
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
-		This attribute is used to read the distance covered by the user
-		since the last reboot while activated. Units after application
-		of scale are meters.
+		This attribute is used to read the measured distance to an object
+		or the distance covered by the user since the last reboot while
+		activated. Units after application of scale are meters.
 
 What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
 KernelVersion:	3.4.0
-- 
2.11.0

