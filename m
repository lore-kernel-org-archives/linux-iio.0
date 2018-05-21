Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:46160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750829AbeEUGkX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 May 2018 02:40:23 -0400
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w4L6eKqG024356
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
        for <linux-iio@vger.kernel.org>; Sun, 20 May 2018 23:40:20 -0700
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <Michael.Hennerich@analog.com>, <Lars-Peter.Clausen@analog.com>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: amplifiers: ad8366: move channel init before iio_device_register()
Date: Mon, 21 May 2018 09:40:05 +0300
Message-ID: <20180521064005.17637-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Otherwise a race condition can occur, where userspace can start operations
before the channels have been properly initialized.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 43667866321e..0138337aedd1 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -161,12 +161,14 @@ static int ad8366_probe(struct spi_device *spi)
 	indio_dev->channels = ad8366_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
 
+	ret = ad8366_write(indio_dev, 0 , 0);
+	if (ret < 0)
+		goto error_disable_reg;
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg;
 
-	ad8366_write(indio_dev, 0, 0);
-
 	return 0;
 
 error_disable_reg:
-- 
2.17.0

