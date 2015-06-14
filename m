Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:40777 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbbFNVJo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 14 Jun 2015 17:09:44 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: light: tcs3414: Fix bug preventing to set integration time
Date: Sun, 14 Jun 2015 23:09:35 +0200
Message-Id: <1434316175-24657-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

the millisecond values in tcs3414_times should be checked against
val2, not val, which is always zero.

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Reported-by: Stephan Kleisinger <stephan.kleisinger@gmail.com>
---
 drivers/iio/light/tcs3414.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 71c2bde..f8b1df0 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -185,7 +185,7 @@ static int tcs3414_write_raw(struct iio_dev *indio_dev,
 		if (val != 0)
 			return -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(tcs3414_times); i++) {
-			if (val == tcs3414_times[i] * 1000) {
+			if (val2 == tcs3414_times[i] * 1000) {
 				data->timing &= ~TCS3414_INTEG_MASK;
 				data->timing |= i;
 				return i2c_smbus_write_byte_data(
-- 
1.9.1

