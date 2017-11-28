Return-Path: <SRS0=ICZm=C2=it-klinger.de=ak@kernel.org>
Date: Tue, 28 Nov 2017 13:57:59 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	singhalsimran0@gmail.com, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: hx711: fix bug in reset functionality
Message-ID: <20171128125759.GA31842@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

return value in hx711_reset() should indicate status of dout
otherwise the calling function is reporting an error als false positive

wait up to 1 second until the device is in normal state;
by changing the channel on every trigger event it turned out that the
former 100 ms are not enough for waiting until the device is in normal mode

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index d773fd69a76d..eabd2e66aca3 100644
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
