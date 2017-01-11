Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdAKPvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 10:51:53 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de
Subject: [PATCHv2 1/2] iio: Documentation: Add proximity unit
Date: Wed, 11 Jan 2017 16:51:38 +0100
Message-Id: <20170111155139.6559-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To follow iio guidelines Where possible we stick to the raw SI unit, so
specify meters for proximity.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b8f220f..1bd8ed1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1245,7 +1245,8 @@ Description:
 		reflectivity of infrared or ultrasound emitted.
 		Often these sensors are unit less and as such conversion
 		to SI units is not possible. Higher proximity measurements
-		indicate closer objects, and vice versa.
+		indicate closer objects, and vice versa. Units after
+		application of scale and offset are meters.
 
 What:		/sys/.../iio:deviceX/in_illuminance_input
 What:		/sys/.../iio:deviceX/in_illuminance_raw
-- 
2.9.3

