Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55574 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbaG1LTX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Jul 2014 07:19:23 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: linux-iio@vger.kernel.org
Cc: Teodora Baluta <teodora.baluta@intel.com>
Subject: [PATCH 1/5] staging: iio: ad7816: fix sparse warning cast to restricted __be16
Date: Mon, 28 Jul 2014 14:18:29 +0300
Message-Id: <1406546313-23031-2-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix following sparse endianness problems:

  CHECK   drivers/staging/iio/adc/ad7816.c
drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
__be16
drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
__be16
drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
__be16
drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
__be16

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 158d770..6686eac 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -90,7 +90,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		return ret;
 	}
 
-	*data = be16_to_cpu(*data);
+	be16_to_cpus(data);
 
 	return ret;
 }
-- 
1.9.1

