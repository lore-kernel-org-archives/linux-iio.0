Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50337 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbAATLb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 14:11:31 -0500
From: Stefan Wahren <stefan.wahren@i2se.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	fabio.estevam@freescale.com, alexandre.belloni@free-electrons.com,
	linux-iio@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] iio: mxs-lradc: fix iio channel map regression
Date: Thu,  1 Jan 2015 19:11:17 +0000
Message-Id: <1420139477-2361-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
from channel 8 and 9") with the removal of adc channel 9 there is
no 1-1 mapping in the channel spec.

All hwmon channel values above 9 are accessible via there index minus
one. So add a "bogus" iio channel 9 to fix this issue.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d9d6fad..126a07b 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1413,6 +1413,7 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 		.channel = 8,
 		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
 	},
+	MXS_ADC_CHAN(9, IIO_VOLTAGE),
 	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
 	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
 	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
--
1.7.9.5

