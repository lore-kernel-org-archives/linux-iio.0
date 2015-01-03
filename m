Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64581 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbACUen (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jan 2015 15:34:43 -0500
From: Stefan Wahren <stefan.wahren@i2se.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	fabio.estevam@freescale.com, alexandre.belloni@free-electrons.com,
	robert.hodaszi@digi.com, linux-iio@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2] iio: mxs-lradc: fix iio channel map regression
Date: Sat,  3 Jan 2015 20:34:12 +0000
Message-Id: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
from channel 8 and 9") with the removal of adc channel 9 there is
no 1-1 mapping in the channel spec.

All hwmon channel values above 9 are accessible via there index minus
one. So add a hidden iio channel 9 to fix this issue.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
Changes in V2:
- define hidden channel instead of a bogus one

 drivers/staging/iio/adc/mxs-lradc.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d9d6fad..594684d 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1413,6 +1413,13 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 		.channel = 8,
 		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
 	},
+	/* Hidden channel to keep indexes */
+	{
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.scan_index = -1,
+		.channel = 9,
+	},
 	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
 	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
 	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
--
1.7.9.5

