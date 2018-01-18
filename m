Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0054.outbound.protection.outlook.com ([104.47.36.54]:6197
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753527AbeARO5q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Jan 2018 09:57:46 -0500
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w0IEvi26022371
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 18 Jan 2018 06:57:44 -0800
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4] staging: iio: adc: ad7192: disable burnout currents on misconfig
Date: Thu, 18 Jan 2018 16:57:40 +0200
Message-ID: <20180118145740.5113-1-alexandru.ardelean@analog.com>
In-Reply-To: <20180110111411.18505-1-alexandru.ardelean@analog.com>
References: <20180110111411.18505-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

The burnout currents can be enabled only if buffer is enabled
and CHOP is disabled.

So, if neither of these conditions are met, then
we should disable the burnout currents in the driver as well,
and warn the user.

This change doesn't fix anything.
The burnout currents simply won't work if CHOP is enabled
or buffer is disabled.
The intent is to provide the user with some feedback
instead of silently not working inside the chip.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changes v3 -> v4:
 * need to check if `pdata->burnout_curr_en` is positive on the
   else path, otherwise a false warning may be thrown

 drivers/staging/iio/adc/ad7192.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de9c777..9287b50b7870 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -291,8 +291,12 @@ static int ad7192_setup(struct ad7192_state *st,
 	if (pdata->unipolar_en)
 		st->conf |= AD7192_CONF_UNIPOLAR;
 
-	if (pdata->burnout_curr_en)
+	if (pdata->burnout_curr_en && pdata->buf_en && !pdata->chop_en) {
 		st->conf |= AD7192_CONF_BURN;
+	} else if (pdata->burnout_curr_en) {
+		dev_warn(&st->sd.spi->dev,
+			 "Can't enable burnout currents: see CHOP or buffer\n");
+	}
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 	if (ret)
-- 
2.14.1

