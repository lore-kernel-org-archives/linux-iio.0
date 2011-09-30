Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46053 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/11] staging:iio:resolver:ad2s90 ensure name is passed to iio_core.
Date: Fri, 30 Sep 2011 11:14:45 +0100
Message-Id: <1317377694-9001-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Scraps the pointless name define and adds an id table.
It's not technically required in drivers with only one supported
part but it does make the probe code more consistent.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s90.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 161442e..4b936d6 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -19,8 +19,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 
-#define DRV_NAME "ad2s90"
-
 struct ad2s90_state {
 	struct mutex lock;
 	struct spi_device *sdev;
@@ -85,6 +83,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s90_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi_get_device_id(spi)->name;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -110,13 +109,19 @@ static int __devexit ad2s90_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id ad2s90_id[] = {
+	{ "ad2s90" },
+	{}
+};
+
 static struct spi_driver ad2s90_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "ad2s90",
 		.owner = THIS_MODULE,
 	},
 	.probe = ad2s90_probe,
 	.remove = __devexit_p(ad2s90_remove),
+	.id_table = ad2s90_id,
 };
 
 static __init int ad2s90_spi_init(void)
-- 
1.7.3.4

