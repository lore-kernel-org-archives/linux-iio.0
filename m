Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	tglx@linutronix.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 16/21] stargate2 - add an IIO interrupt pool
Date: Thu, 31 Mar 2011 15:54:10 +0100
Message-Id: <1301583255-28468-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
References: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Included here as a somewhat obvious example and because it's my test platform.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 arch/arm/mach-pxa/stargate2.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index cb5611d..3005b9c 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -56,8 +56,9 @@
 
 #include "devices.h"
 #include "generic.h"
-
-#define STARGATE_NR_IRQS	(IRQ_BOARD_START + 8)
+#include "../../../drivers/staging/iio/iio-board-info.h"
+#define STARGATE_IIO_IRQ_POOL 16
+#define STARGATE_NR_IRQS	(IRQ_BOARD_START + STARGATE_IIO_IRQ_POOL)
 
 /* Bluetooth */
 #define SG2_BT_RESET		81
@@ -408,6 +409,7 @@ static struct i2c_pxa_platform_data i2c_pdata = {
 
 static void __init imote2_stargate2_init(void)
 {
+	iio_set_irq_pool(IRQ_BOARD_START, STARGATE_IIO_IRQ_POOL);
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(sg2_im2_unified_pin_config));
 
-- 
1.7.3.4
