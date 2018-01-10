Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:63232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965241AbeAJLOk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jan 2018 06:14:40 -0500
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w0ABEaII017038
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
        for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2018 03:14:36 -0800
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] staging: iio: adc: ad7192: disable burnout currents on misconfig
Date: Wed, 10 Jan 2018 13:14:11 +0200
Message-ID: <20180110111411.18505-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

According to the datasheet for all ad719x ADCs,
the burnout currents can be enabled only if buffer is enabled
and CHOP is disabled.

So, if neither of these conditions are met, then
we should disable the burnout currents in the driver as well,
and warn the user.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de9c777..7f204013d6d4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -266,6 +266,12 @@ static int ad7192_setup(struct ad7192_state *st,
 
 	st->conf = AD7192_CONF_GAIN(0);
 
+	if (pdata->burnout_curr_en && (!pdata->buf_en || pdata->chop_en)) {
+		pdata->burnout_curr_en = false;
+		dev_warn(dev,
+			 "Can't enable burnout currents: see CHOP or buffer\n");
+	}
+
 	if (pdata->rej60_en)
 		st->mode |= AD7192_MODE_REJ60;
 
-- 
2.14.1

