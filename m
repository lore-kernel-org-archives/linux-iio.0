Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38563 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab3EFMtS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 08:49:18 -0400
From: Jan Luebbe <jlu@pengutronix.de>
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: rachna@ti.com, linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>,
	Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH 1/2] iio: adc: ti_am335x_adc: revert info_mask removal
Date: Mon,  6 May 2013 14:48:58 +0200
Message-Id: <1367844539-6812-2-git-send-email-jlu@pengutronix.de>
In-Reply-To: <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com>
 <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit "ti_tscadc: Update with IIO map interface & deal with partial activation"
by Pantelis Antoniou <panto@antoniou-consulting.com> removed this line.
Without it, the in_voltage?_raw entries are missing from sysfs.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index ee20c0c..620cc0c 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -107,6 +107,7 @@ static int tiadc_channel_init(struct iio_dev *indio_dev,
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
 		chan->channel = i;
+		chan->info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT;
 		chan->datasheet_name = s;
 		chan->scan_type.sign = 'u';
 		chan->scan_type.realbits = 12;
-- 
1.8.2.rc2

