Return-Path: <shawn.guo@linaro.org>
From: Shawn Guo <shawn.guo@linaro.org>
To: <linux-arm-kernel@lists.infradead.org>
CC: Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH 02/13] iio: mxs-lradc: remove unneeded mach header inclusion
Date: Fri, 29 Mar 2013 16:55:38 +0800
Message-ID: <1364547350-30498-3-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Headers <mach/mxs.h> and <mach/common.h> are not used in the driver
at all.  Removed the inclusions.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 drivers/staging/iio/adc/mxs-lradc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 55a459b..0eb5b4d 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -36,9 +36,6 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 
-#include <mach/mxs.h>
-#include <mach/common.h>
-
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
-- 
1.7.9.5
