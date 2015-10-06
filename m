Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52034 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752596AbbJFOWd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2015 10:22:33 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Marek Vasut <marex@denx.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] iio: mxs-lradc: Fix temperature offset
Date: Tue,  6 Oct 2015 16:22:27 +0200
Message-Id: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.

Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 3f7715c9968b..67bfa54c4fb1 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -916,10 +916,10 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 		if (chan->type == IIO_TEMP) {
 			/* The calculated value from the ADC is in Kelvin, we
 			 * want Celsius for hwmon so the offset is
-			 * -272.15 * scale
+			 * -273.15 * scale
 			 */
-			*val = -1075;
-			*val2 = 691699;
+			*val = -1079;
+			*val2 = 644268;
 
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
-- 
2.1.4

