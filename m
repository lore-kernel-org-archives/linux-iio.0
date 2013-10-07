Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-017.synserver.de ([212.40.185.17]:1097 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3JGNYZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 09:24:25 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Stefan Roese <sr@denx.de>
Subject: [PATCH 1/2] staging:iio:spear_adc: Remove unused variable
Date: Mon,  7 Oct 2013 15:26:13 +0200
Message-Id: <1381152374-16567-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove the scale_mv variable from the read_raw() callback. Fixes the following
warning:
	drivers/staging/iio/adc/spear_adc.c: In function 'spear_read_raw':
	drivers/staging/iio/adc/spear_adc.c:149:6: warning: unused variable 'scale_mv'

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 657e01b..fc99598 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -146,7 +146,6 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 			  long mask)
 {
 	struct spear_adc_info *info = iio_priv(indio_dev);
-	u32 scale_mv;
 	u32 status;
 
 	switch (mask) {
-- 
1.8.0

