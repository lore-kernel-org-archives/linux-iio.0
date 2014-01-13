Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47953 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbaAMVRD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jan 2014 16:17:03 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/6] staging:iio:accel:sca3000: Fix kerneldoc
Date: Mon, 13 Jan 2014 22:16:57 +0100
Message-Id: <1389647817-31320-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389647817-31320-1-git-send-email-pmeerw@pmeerw.net>
References: <1389647817-31320-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

match function names with kerneldoc

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/sca3000_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 7f6ccdf..908d5cd 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -250,9 +250,8 @@ error_ret:
 }
 #endif /* SCA3000_DEBUG */
 
-
 /**
- * sca3000_show_reg() - sysfs interface to read the chip revision number
+ * sca3000_show_rev() - sysfs interface to read the chip revision number
  **/
 static ssize_t sca3000_show_rev(struct device *dev,
 				struct device_attribute *attr,
@@ -312,7 +311,7 @@ sca3000_show_available_measurement_modes(struct device *dev,
 }
 
 /**
- * sca3000_show_measurmenet_mode() sysfs read of current mode
+ * sca3000_show_measurement_mode() sysfs read of current mode
  **/
 static ssize_t
 sca3000_show_measurement_mode(struct device *dev,
@@ -547,7 +546,7 @@ error_ret:
 	return ret;
 }
 /**
- * __sca3000_get_base_frequency() obtain mode specific base frequency
+ * __sca3000_get_base_freq() obtain mode specific base frequency
  *
  * lock must be held
  **/
@@ -972,7 +971,7 @@ error_ret:
 }
 
 /**
- * sca3000_set_mo_det() simple on off control for motion detector
+ * sca3000_write_event_config() simple on off control for motion detector
  *
  * This is a per axis control, but enabling any will result in the
  * motion detector unit being enabled.
-- 
1.8.3.2

