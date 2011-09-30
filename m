Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46067 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/11] staging:iio:resolver:ad2s1210 ensure iio_dev->name is set
Date: Fri, 30 Sep 2011 11:14:51 +0100
Message-Id: <1317377694-9001-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is needed to ensure the required name attribute is
created. Using an id table is the route most consistent
with other drivers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s1210.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 5c9c409..9a88563 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -760,6 +760,7 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi_get_device_id(spi)->name;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -791,6 +792,11 @@ static int __devexit ad2s1210_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id ad2s1210_id[] = {
+	{ "ad2s1210" },
+	{}
+};
+
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
@@ -798,6 +804,7 @@ static struct spi_driver ad2s1210_driver = {
 	},
 	.probe = ad2s1210_probe,
 	.remove = __devexit_p(ad2s1210_remove),
+	.id_table = ad2s1210_id,
 };
 
 static __init int ad2s1210_spi_init(void)
-- 
1.7.3.4

