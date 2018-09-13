Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:57155
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbeIMQLs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Sep 2018 12:11:48 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] staging:iio:ad7606: Remove incorrect kernel doc annotations
Date: Thu, 13 Sep 2018 14:02:11 +0300
Message-ID: <20180913110212.29068-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7606_chip_info struct does not have the lock & name fields. Remove
the kernel documentation annotations for it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7606.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 24c2a85f5c5a..57f11b46bc69 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -11,10 +11,8 @@
 
 /**
  * struct ad7606_chip_info - chip specific information
- * @name:		identification string for chip
  * @channels:		channel specification
  * @num_channels:	number of channels
- * @lock		protect sensor state
  */
 
 struct ad7606_chip_info {
-- 
2.17.1
