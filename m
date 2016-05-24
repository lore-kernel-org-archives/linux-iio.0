Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: proximity: as3935: remove redundant MODULE_ALIAS
Date: Mon, 23 May 2016 23:27:30 -0700
Message-Id: <1464071250-21097-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

MODULE_ALIAS isn't needed since the module name is the same as the alias
defined.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/as3935.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 8730451..5769017 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -468,4 +468,3 @@ module_spi_driver(as3935_driver);
 MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
 MODULE_DESCRIPTION("AS3935 lightning sensor");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:as3935");
-- 
2.7.4
