Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-028.synserver.de ([212.40.185.28]:1068 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752121Ab2BTSlC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2012 13:41:02 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Convert remaining drivers to module_spi_driver
Date: Mon, 20 Feb 2012 19:42:38 +0100
Message-Id: <1329763358-29891-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert the IIO drivers which have not been converted yet to module_spi_driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5421.c |   13 +------------
 drivers/staging/iio/dac/ad5764.c |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5421.c b/drivers/staging/iio/dac/ad5421.c
index 71ee868..0b040b2 100644
--- a/drivers/staging/iio/dac/ad5421.c
+++ b/drivers/staging/iio/dac/ad5421.c
@@ -536,18 +536,7 @@ static struct spi_driver ad5421_driver = {
 	.probe = ad5421_probe,
 	.remove = __devexit_p(ad5421_remove),
 };
-
-static __init int ad5421_init(void)
-{
-	return spi_register_driver(&ad5421_driver);
-}
-module_init(ad5421_init);
-
-static __exit void ad5421_exit(void)
-{
-	spi_unregister_driver(&ad5421_driver);
-}
-module_exit(ad5421_exit);
+module_spi_driver(ad5421_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Analog Devices AD5421 DAC");
diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/staging/iio/dac/ad5764.c
index ff91480..f73a730 100644
--- a/drivers/staging/iio/dac/ad5764.c
+++ b/drivers/staging/iio/dac/ad5764.c
@@ -375,18 +375,7 @@ static struct spi_driver ad5764_driver = {
 	.remove = __devexit_p(ad5764_remove),
 	.id_table = ad5764_ids,
 };
-
-static int __init ad5764_spi_init(void)
-{
-	return spi_register_driver(&ad5764_driver);
-}
-module_init(ad5764_spi_init);
-
-static void __exit ad5764_spi_exit(void)
-{
-	spi_unregister_driver(&ad5764_driver);
-}
-module_exit(ad5764_spi_exit);
+module_spi_driver(ad5764_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Analog Devices AD5744/AD5744R/AD5764/AD5764R DAC");
-- 
1.7.9

