Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:52688
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750832AbeAPLK7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jan 2018 06:10:59 -0500
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w0GBAtWE018242
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
        for <linux-iio@vger.kernel.org>; Tue, 16 Jan 2018 03:10:55 -0800
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][V2] staging: iio: adc: ad7192: disable burnout currents on misconfig
Date: Tue, 16 Jan 2018 13:10:47 +0200
Message-ID: <20180116111047.3262-1-alexandru.ardelean@analog.com>
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

This change doesn't fix anything.
The burnout currents simply won't work if CHOP is enabled
or buffer is disabled.
The intent is to provide the user with some feedback
instead of silently not working inside the chip.

This is especially useful when considering device-tree
support (and/or device-tree overlays) at a later point,
which will allow for a quicker/simpler reconfiguration
of the chip settings.

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

