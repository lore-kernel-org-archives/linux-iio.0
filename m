Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56092 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2CCLiI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Mar 2012 06:38:08 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio:accel:lis3l02dq add symmetry to check for presence of trigger.
Date: Sat,  3 Mar 2012 11:39:12 +0000
Message-Id: <1330774755-18031-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1330774755-18031-1-git-send-email-jic23@kernel.org>
References: <1330774755-18031-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Checking indio_dev->modes is uggly and not symmetric with the conditions
on whether triggers are allowed in the first place.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 376da51..bcf4712 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -724,7 +724,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)))
 		lis3l02dq_remove_trigger(indio_dev);
 error_free_interrupt:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-- 
1.7.9.2

