Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-177.synserver.de ([212.40.185.177]:1045 "EHLO
	smtp-out-166.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759568Ab2BJSQR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 13:16:17 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] staging:iio: Convert remaining drivers to module_spi_driver
Date: Fri, 10 Feb 2012 19:17:39 +0100
Message-Id: <1328897859-24628-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328897859-24628-1-git-send-email-lars@metafoo.de>
References: <1328897859-24628-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert the IIO drivers which have not been converted yet to module_spi_driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
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

