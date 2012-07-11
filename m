Return-Path: <dev@snitselaar.org>
From: Gerard Snitselaar <dev@snitselaar.org>
To: linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	linux-iio@vger.kernel.org,
	jic23@cam.ac.uk,
	gregkh@linuxfoundation.org,
	lars@metafoo.de
Subject: [PATCH] iio: dac: ad5064: fix section mismatch in ad5064_init() in linux-next
Date: Tue, 10 Jul 2012 21:05:02 -0700
Message-Id: <1341979502-27440-1-git-send-email-dev@snitselaar.org>
List-ID: <linux-iio@vger.kernel.org>

ad5064_init() calls ad5064_spi_unregister_driver() which is annotated
__exit.

Signed-off-by: Gerard Snitselaar <dev@snitselaar.org>
---
 drivers/iio/dac/ad5064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index aa739c4..6ec1319 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -582,7 +582,7 @@ static int __init ad5064_spi_register_driver(void)
 	return spi_register_driver(&ad5064_spi_driver);
 }
 
-static void __exit ad5064_spi_unregister_driver(void)
+static void ad5064_spi_unregister_driver(void)
 {
 	spi_unregister_driver(&ad5064_spi_driver);
 }
-- 
1.7.11.1.165.g299666c
