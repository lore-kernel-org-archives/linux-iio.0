Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-006.synserver.de ([212.40.185.6]:1085 "EHLO
	smtp-out-245.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752176Ab2FYNjT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jun 2012 09:39:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:adc:at91: Relase mutex on error path in at91_adc_read_raw
Date: Mon, 25 Jun 2012 15:43:00 +0200
Message-Id: <1340631780-14685-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This issue was reported by the mini_lock.cocci coccinelle semantic patch.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/at91_adc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 6a08469..f61780a 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -349,9 +349,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 						       st->done,
 						       msecs_to_jiffies(1000));
 		if (ret == 0)
-			return -ETIMEDOUT;
-		else if (ret < 0)
+			ret = -ETIMEDOUT;
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
 			return ret;
+		}
 
 		*val = st->last_value;
 
-- 
1.7.10

