Return-Path: <SRS0=axIo=C4=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	samuel@sortiz.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/3] iio: trigger: Fix platform_get_irq's error checking
Date: Thu, 30 Nov 2017 21:13:34 +0530
Message-Id: <1512056616-21065-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index d80dcf8..f389f5c 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -187,9 +187,9 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st->irq = platform_get_irq(pdev, 0);
-	if (!st->irq) {
+	if (st->irq < 0) {
 		dev_err(&pdev->dev, "No IRQs specified");
-		return -ENODEV;
+		return st->irq;
 	}
 
 	ret = iio_bfin_tmr_get_number(st->irq);
-- 
2.7.4
