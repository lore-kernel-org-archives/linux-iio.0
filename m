Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48638 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab2FORZb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Jun 2012 13:25:31 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/6] iio: cleanup sysfs-bus-iio-light-lm3533-als
Date: Fri, 15 Jun 2012 19:25:24 +0200
Message-Id: <1339781128-2718-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
References: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 .../ABI/testing/sysfs-bus-iio-light-lm3533-als     |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als b/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
index 694a52c..22c5ea6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
+++ b/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
@@ -14,7 +14,6 @@ KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
 		Get the hysteresis for thresholds Y, that is,
-
 		threshY_hysteresis = threshY_raising - threshY_falling
 
 What:		/sys/.../events/illuminance_threshY_falling_value
@@ -31,7 +30,7 @@ Description:
 		threshY_raising.
 
 		These thresholds correspond to the eight zone-boundary
-		registers (boundaryY_{low,high}) and defines the five light
+		registers (boundaryY_{low,high}) and define the five light
 		zones.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_zone
-- 
1.7.9.5

