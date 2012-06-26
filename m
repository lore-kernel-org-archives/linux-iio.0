Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-096.synserver.de ([212.40.185.96]:1066 "EHLO
	smtp-out-092.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758245Ab2FZIjp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jun 2012 04:39:45 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:adc:at91: Relase mutex on error path in at91_adc_read_raw
Date: Tue, 26 Jun 2012 10:43:05 +0200
Message-Id: <1340700185-16692-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This issue was reported by the mini_lock.cocci coccinelle semantic patch.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
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

