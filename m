Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49866 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752866AbeDUAmM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Apr 2018 20:42:12 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 03/13] staging: iio: tsl2x7x: don't return error in IRQ handler
Date: Fri, 20 Apr 2018 20:41:43 -0400
Message-Id: <20180421004153.19073-4-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsl2x7x_event_handler() could return an error and this could cause the
interrupt to remain masked. We shouldn't return an error in the
interrupt handler so this patch always returns IRQ_HANDLED. An error
will be logged if one occurs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9cdcc8c9e812..95a00b965c5e 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1320,7 +1320,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 	ret = tsl2x7x_read_status(chip);
 	if (ret < 0)
-		return ret;
+		return IRQ_HANDLED;
 
 	/* What type of interrupt do we need to process */
 	if (ret & TSL2X7X_STA_PRX_INTR) {
@@ -1341,9 +1341,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 			       timestamp);
 	}
 
-	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
-	if (ret < 0)
-		return ret;
+	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
 
 	return IRQ_HANDLED;
 }
-- 
2.14.3

