Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:10092 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750996AbdGZVcY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jul 2017 17:32:24 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH] iio: adc: ina219: Avoid underflow for sleeping time
Date: Wed, 26 Jul 2017 23:32:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <ad692a867c25499ea8e0859f72f46549@rwthex-w2-b.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Proper support for the INA219 lowered the minimum sampling period from
2*140us to 2*84us. Subtracting 200us later leads to an underflow and
an almost infinite udelay later.

Using a signed int for the sampling period provides sufficient range
(at most 2*8640*1024us), but catches the underflow when comparing with
buffer_us.

Fixes: 18edac2e22f4 ("iio: adc: Fix integration time/averaging for INA219/220")
Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index b0d9e3b80e6d..85b419ea9ba9 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -657,7 +657,7 @@ static int ina2xx_capture_thread(void *data)
 {
 	struct iio_dev *indio_dev = data;
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
-	unsigned int sampling_us = SAMPLING_PERIOD(chip);
+	int sampling_us = SAMPLING_PERIOD(chip);
 	int buffer_us;
 
 	/*
-- 
2.13.3

