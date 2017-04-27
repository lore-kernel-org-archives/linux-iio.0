Return-Path: <SRS0=18F/=4D=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: as3935: fix AS3935_INT mask
Date: Thu, 27 Apr 2017 00:52:32 -0700
Message-Id: <20170427075232.3689-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

AS3935 interrupt mask has been incorrect so valid lightning events
would never trigger an buffer event. Also noise interrupt should be
BIT(0).

Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
CC: stable@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index aa0d0be1a608..8f081ef4802d 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -40,9 +40,9 @@
 #define AS3935_AFE_PWR_BIT	BIT(0)
 
 #define AS3935_INT		0x03
-#define AS3935_INT_MASK		0x07
+#define AS3935_INT_MASK		0x0f
 #define AS3935_EVENT_INT	BIT(3)
-#define AS3935_NOISE_INT	BIT(1)
+#define AS3935_NOISE_INT	BIT(0)
 
 #define AS3935_DATA		0x07
 #define AS3935_DATA_MASK	0x3F
-- 
2.11.0
