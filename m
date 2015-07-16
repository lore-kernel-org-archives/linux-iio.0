Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0136.outbound.protection.outlook.com ([157.56.111.136]:46780
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752346AbbGPGtR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 16 Jul 2015 02:49:17 -0400
From: Fugang Duan <b38611@freescale.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>
Subject: [PATCH 1/1] iio: adc: vf610: fix the adc register read fail issue
Date: Thu, 16 Jul 2015 14:49:09 +0800
Message-ID: <1437029349-5446-1-git-send-email-b38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Read the register only when the adc register address is 4 byte aligned.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 480f335..819632b 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -635,7 +635,7 @@ static int vf610_adc_reg_access(struct iio_dev *indio_dev,
 	struct vf610_adc *info = iio_priv(indio_dev);
 
 	if ((readval == NULL) ||
-		(!(reg % 4) || (reg > VF610_REG_ADC_PCTL)))
+		((reg % 4) || (reg > VF610_REG_ADC_PCTL)))
 		return -EINVAL;
 
 	*readval = readl(info->regs + reg);
-- 
1.9.1

