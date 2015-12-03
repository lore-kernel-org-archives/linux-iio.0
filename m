Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35158 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbLCXy7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2015 18:54:59 -0500
From: Robert Kmiec <robert.r.kmiec@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, denis.ciocca@st.com, linus.walleij@linaro.org,
	giuseppe.barba@st.com, alban.bedel@avionic-design.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robert Kmiec <robert.r.kmiec@gmail.com>
Subject: [PATCH] iio: st_accel_core: Remove unneeded define
Date: Fri,  4 Dec 2015 00:54:48 +0100
Message-Id: <1449186888-22070-1-git-send-email-robert.r.kmiec@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Definition of ST_SENSORS_WAI_ADDRESS was introduced within a very
first commit of this driver, but it was never used.
This address is already defined as ST_SENSORS_DEFAULT_WAI_ADDRESS
in include/linux/iio/common/st_sensors.h

To avoid duplication of the same constant in two different places
called almost exactly the same, the one which was never used
should be removed.

Signed-off-by: Robert Kmiec <robert.r.kmiec@gmail.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 25258e2..8447c31 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -18,9 +18,6 @@
 #include <asm/unaligned.h>
 #include <linux/iio/common/st_sensors.h>
 
-
-#define ST_SENSORS_WAI_ADDRESS		0x0f
-
 static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
 {
 	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
-- 
2.6.3

