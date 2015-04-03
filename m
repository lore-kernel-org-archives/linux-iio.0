Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 3/6] iio: sx9500: rename GPIO interrupt pin
Date: Fri,  3 Apr 2015 15:47:31 +0300
Message-Id: <1428065254-6444-4-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 94c56f3..13b174c 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -31,7 +31,8 @@
 
 #define SX9500_DRIVER_NAME		"sx9500"
 #define SX9500_IRQ_NAME			"sx9500_event"
-#define SX9500_GPIO_NAME		"sx9500_gpio"
+
+#define SX9500_GPIO_INT			"interrupt"
 
 /* Register definitions. */
 #define SX9500_REG_IRQ_SRC		0x00
-- 
1.9.1
