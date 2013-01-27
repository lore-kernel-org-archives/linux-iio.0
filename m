Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: fengguang.wu@intel.com
Cc: changlongx.xie@intel.com,
	yuheng.chen@intel.com,
	arnd@arndb.de,
	tony@atomide.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] ARM: OMAP: rx51: Fix include path for tsl2563.h
Date: Sun, 27 Jan 2013 17:32:44 +0000
Message-Id: <1359307964-23970-1-git-send-email-jic23@kernel.org>
In-Reply-To: <51056392.7070808@jic23.retrosnub.co.uk>
References: <51056392.7070808@jic23.retrosnub.co.uk>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

A file in staging was included here to get at some platform data
structures.  The tsl2563 is now moving out of staging and
so the path to the include must be updated.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index cf07e28..f3d075b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -42,7 +42,7 @@
 #include <media/si4713.h>
 #include <linux/leds-lp5523.h>
 
-#include <../drivers/staging/iio/light/tsl2563.h>
+#include <linux/platform_data/tsl2563.h>
 #include <linux/lis3lv02d.h>
 
 #if defined(CONFIG_IR_RX51) || defined(CONFIG_IR_RX51_MODULE)
-- 
1.8.1.1
