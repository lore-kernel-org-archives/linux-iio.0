Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51916 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbdLFIwW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Dec 2017 03:52:22 -0500
Date: Wed, 6 Dec 2017 09:52:20 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: hx711: fix bug in reset functionality
Message-ID: <20171206085220.GA15428@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Return value in hx711_reset() should indicate status of dout otherwise the
calling function is reporting an error as false positive

If there are two reads too close to each other, then the second one will
never succeed. This happens especially when using buffered mode with both
channels enabled.

When changing the channel on every trigger event the former 100 ms are not
enough for waiting until the device indicates normal mode.

Wait up to 1 second until the device turns into normal mode.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 37982b93a227..0a2d0b6cd38a 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -153,15 +153,16 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 	int i, val;
 
 	/*
-	 * a maximum reset cycle time of 56 ms was measured.
-	 * we round it up to 100 ms
+	 * in some rare cases the reset takes quite a long time
+	 * especially when the channel is changed.
+	 * Allow up to one second for it
 	 */
 	for (i = 0; i < 100; i++) {
 		val = gpiod_get_value(hx711_data->gpiod_dout);
 		if (!val)
 			break;
-		/* sleep at least 1 ms */
-		msleep(1);
+		/* sleep at least 10 ms */
+		msleep(10);
 	}
 	if (val)
 		return -EIO;
@@ -203,9 +204,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
 		 * after a dummy read we need to wait vor readiness
 		 * for not mixing gain pulses with the clock
 		 */
-		ret = hx711_wait_for_ready(hx711_data);
-		if (ret)
-			return ret;
+		val = hx711_wait_for_ready(hx711_data);
 	}
 
 	return val;
-- 
2.1.4


-- 
