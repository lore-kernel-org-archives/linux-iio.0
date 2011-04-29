Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:9417 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab1D2M0V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 08:26:21 -0400
Received: from mail132-tx2 (localhost.localdomain [127.0.0.1])	by
 mail132-tx2-R.bigfish.com (Postfix) with ESMTP id 52B957F03A9	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 12:26:20 +0000 (UTC)
Received: from TX2EHSMHS046.bigfish.com (unknown [10.9.14.246])	by
 mail132-tx2.bigfish.com (Postfix) with ESMTP id 2EED31C48054	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 12:26:20 +0000 (UTC)
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<jic23@cam.ac.uk>, <device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 6/6] IIO: GYRO: ADXRS450: Don't exit probe, in case the power on default is not met.
Date: Fri, 29 Apr 2011 14:17:04 +0200
Message-ID: <1304079424-18506-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
References: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

If the part get's probed twice without hard reset in between, the power on default
register read-back can't be met. This shouldn't cause the second probe to fail.
So warn but don't exit.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index e71b91c..7a9d7c2 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -278,11 +278,9 @@ static int adxrs450_initial_setup(struct adxrs450_state *st)
 	ret = adxrs450_spi_initial(st, &t, 1);
 	if (ret)
 		return ret;
-	if (t != 0x01) {
-		dev_err(&st->us->dev, "The initial response is not correct!\n");
-		return -ENODEV;
-
-	}
+	if (t != 0x01)
+		dev_warn(&st->us->dev, "The initial power on response "
+			 "is not correct! Restart without reset?\n");

 	msleep(ADXRS450_STARTUP_DELAY);
 	ret = adxrs450_spi_initial(st, &t, 0);
--
1.6.0.2


