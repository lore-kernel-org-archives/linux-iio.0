Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1029 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3AaO1G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] staging:iio:adxrs450: Don't split string across multiple lines
Date: Thu, 31 Jan 2013 15:27:54 +0100
Message-Id: <1359642478-9622-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is one of the exceptions to the 80 chars per line rule since breaking the
string in half it badly affects the grep-ability.

Fixes the following checkpatch warning:
	WARNING: quoted string split across lines
	#203: FILE: staging/iio/gyro/adxrs450_core.c:203:
		+		dev_warn(&st->us->dev, "The initial power on response "
		+			 "is not correct! Restart without reset?\n");

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index dd0b744..ea10f84 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -199,8 +199,7 @@ static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 	if (t != 0x01)
-		dev_warn(&st->us->dev, "The initial power on response "
-			 "is not correct! Restart without reset?\n");
+		dev_warn(&st->us->dev, "The initial power on response is not correct! Restart without reset?\n");
 
 	msleep(ADXRS450_STARTUP_DELAY);
 	ret = adxrs450_spi_initial(st, &t, 0);
-- 
1.8.0

