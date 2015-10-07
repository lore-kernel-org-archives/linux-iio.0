Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42644 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752274AbbJGLRF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2015 07:17:05 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	=?UTF-8?q?Janusz=20U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>,
	Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2] iio: mxs-lradc: Fix temperature offset
Date: Wed,  7 Oct 2015 13:10:54 +0200
Message-Id: <1444216254-19668-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.
Also improve the comment explaining the calculation.

Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 3f7715c9968b..47fc00a3f63b 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -915,11 +915,12 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		if (chan->type == IIO_TEMP) {
 			/* The calculated value from the ADC is in Kelvin, we
-			 * want Celsius for hwmon so the offset is
-			 * -272.15 * scale
+			 * want Celsius for hwmon so the offset is -273.15
+			 * The offset is applied before scaling so it is
+			 * actually -213.15 * 4 / 1.012 = -1079.644268
 			 */
-			*val = -1075;
-			*val2 = 691699;
+			*val = -1079;
+			*val2 = 644268;
 
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
-- 
2.1.4

