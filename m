Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:trigger:bfin-timer: Fix compile error
Date: Thu, 20 Oct 2011 14:38:43 +0200
Message-ID: <1319114323-13645-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 243f38f..1cbb25d 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -144,7 +144,7 @@ static int iio_bfin_tmr_get_number(int irq)
 }
 
 static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
-	owner = THIS_MODULE,
+	.owner = THIS_MODULE,
 };
 
 static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
-- 
1.7.6.3
