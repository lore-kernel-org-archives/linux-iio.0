Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0063.outbound.protection.outlook.com ([104.47.33.63]:3461
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750805AbdIEMQ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Sep 2017 08:16:27 -0400
From: Dragos Bogdan <dragos.bogdan@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 2/2] iio: ad7793: Fix the serial interface reset
Date: Tue, 5 Sep 2017 15:16:13 +0300
Message-ID: <20170905121613.26969-1-dragos.bogdan@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The serial interface can be reset by writing 32 consecutive 1s to the device.
'ret' was initialized correctly but its value was overwritten when
ad7793_check_platform_data() was called. Since a dedicated reset function
is present now, it should be used instead.

Fixes: 2edb769d246e ("iio:ad7793: Add support for the ad7798 and ad7799")
Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
---
 drivers/iio/adc/ad7793.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index e6706a09e100..47c3d7f32900 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -257,7 +257,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	unsigned int vref_mv)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
-	int i, ret = -1;
+	int i, ret;
 	unsigned long long scale_uv;
 	u32 id;
 
@@ -266,7 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	/* reset the serial interface */
-	ret = spi_write(st->sd.spi, (u8 *)&ret, sizeof(ret));
+	ret = ad_sd_reset(&st->sd, 32);
 	if (ret < 0)
 		goto out;
 	usleep_range(500, 2000); /* Wait for at least 500us */
-- 
2.11.0

