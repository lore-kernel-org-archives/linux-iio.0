Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42760 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab3FWVa3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:30:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: add DAC 500kohm_to_gnd to possible powerdown_modes
Date: Sun, 23 Jun 2013 23:30:19 +0200
Message-Id: <1372023020-18742-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2e33dc6..0af1af0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -351,6 +351,7 @@ Description:
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
+		500kohm_to_gnd: connected to ground via an 100kOhm resistor,
 		three_state: left floating.
 		For a list of available output power down options read
 		outX_powerdown_mode_available. If Y is not present the
-- 
1.8.3.1

