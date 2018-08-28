Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:6290 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeH1O0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Aug 2018 10:26:24 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH TRIVIAL] iio: fix position relative kernel version
Date: Tue, 28 Aug 2018 13:30:34 +0300
Message-ID: <1535452234-13184-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Position relative channel type was added in 4.19 kernel version

Fixes: "3055a6cfa04ba" ("iio: Add channel for Position Relative")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a5b4f22..8127a08 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -199,7 +199,7 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
-KernelVersion:	4.18
+KernelVersion:	4.19
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Relative position in direction x or y on a pad (may be
-- 
2.7.4
