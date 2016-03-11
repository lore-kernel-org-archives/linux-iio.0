Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34844 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbcCKOwe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2016 09:52:34 -0500
Received: by mail-wm0-f44.google.com with SMTP id l68so22070851wml.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2016 06:52:33 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: afd@ti.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH-vs-togreg 2/2] iio: ina2xx-adc: fix scale for VShunt
Date: Fri, 11 Mar 2016 15:52:30 +0100
Message-Id: <1457707950-17593-2-git-send-email-marc.titinger@baylibre.com>
In-Reply-To: <1457707950-17593-1-git-send-email-marc.titinger@baylibre.com>
References: <1457707950-17593-1-git-send-email-marc.titinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The scale would result in uV instead of expected mV.
Mostly cosmetic, since the value of 'Power' was computed OK.

Signed-off-by: Marc Titinger <marc.titinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index e5ac120..6ada336 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -185,9 +185,9 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->address) {
 		case INA2XX_SHUNT_VOLTAGE:
-			/* processed (mV) = raw*1000/shunt_div */
+			/* processed (mV) = raw/shunt_div */
 			*val2 = chip->config->shunt_div;
-			*val = 1000;
+			*val = 1;
 			return IIO_VAL_FRACTIONAL;
 
 		case INA2XX_BUS_VOLTAGE:
-- 
2.5.0

