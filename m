Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-022.synserver.de ([212.40.185.22]:1238 "EHLO
	smtp-out-022.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2IJIeM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2012 04:34:12 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 02/10] staging:iio:ad7476: Remove duplicated chip info entries
Date: Mon, 10 Sep 2012 10:34:33 +0200
Message-Id: <1347266081-6045-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1347266081-6045-1-git-send-email-lars@metafoo.de>
References: <1347266081-6045-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some of the parts supported by this driver are software compatible. The
difference between them is only in the operating voltage range. So we do not
need extra chip info entries for them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7476.h      |    4 ----
 drivers/staging/iio/adc/ad7476_core.c |   30 +++++++-----------------------
 2 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index b1dd931..6085fad 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -41,10 +41,6 @@ enum ad7476_supported_device_ids {
 	ID_AD7466,
 	ID_AD7467,
 	ID_AD7468,
-	ID_AD7475,
-	ID_AD7476,
-	ID_AD7477,
-	ID_AD7478,
 	ID_AD7495
 };
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 33435ed..c97300b 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -93,22 +93,6 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.channel[0] = AD7476_CHAN(8),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
-	[ID_AD7475] = {
-		.channel[0] = AD7476_CHAN(12),
-		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7476] = {
-		.channel[0] = AD7476_CHAN(12),
-		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7477] = {
-		.channel[0] = AD7476_CHAN(10),
-		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7478] = {
-		.channel[0] = AD7476_CHAN(8),
-		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
 	[ID_AD7495] = {
 		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
@@ -216,13 +200,13 @@ static const struct spi_device_id ad7476_id[] = {
 	{"ad7466", ID_AD7466},
 	{"ad7467", ID_AD7467},
 	{"ad7468", ID_AD7468},
-	{"ad7475", ID_AD7475},
-	{"ad7476", ID_AD7476},
-	{"ad7476a", ID_AD7476},
-	{"ad7477", ID_AD7477},
-	{"ad7477a", ID_AD7477},
-	{"ad7478", ID_AD7478},
-	{"ad7478a", ID_AD7478},
+	{"ad7475", ID_AD7466},
+	{"ad7476", ID_AD7466},
+	{"ad7476a", ID_AD7466},
+	{"ad7477", ID_AD7467},
+	{"ad7477a", ID_AD7467},
+	{"ad7478", ID_AD7468},
+	{"ad7478a", ID_AD7468},
 	{"ad7495", ID_AD7495},
 	{}
 };
-- 
1.7.10.4

