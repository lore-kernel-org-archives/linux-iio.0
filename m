Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1107 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751797AbbHENih (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:37 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/9] iio: adis16400: Add ADIS16305 support
Date: Wed,  5 Aug 2015 15:38:17 +0200
Message-Id: <1438781901-28000-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16305 is fully register map compatible to the ADIS16300.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 7d612ab..e4cc2ec 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -927,6 +927,7 @@ static int adis16400_remove(struct spi_device *spi)
 
 static const struct spi_device_id adis16400_id[] = {
 	{"adis16300", ADIS16300},
+	{"adis16305", ADIS16300},
 	{"adis16334", ADIS16334},
 	{"adis16350", ADIS16350},
 	{"adis16354", ADIS16350},
-- 
2.1.4

