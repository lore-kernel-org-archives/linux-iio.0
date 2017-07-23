Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55634 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbdGWQ0q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:46 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 35/45] iio:adc: drop assignment of iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:17 +0100
Message-Id: <20170723162627.22534-36-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 4e0b4eedb53d..d80dcf82eba9 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -172,7 +172,6 @@ static int iio_bfin_tmr_get_number(int irq)
 }
 
 static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = iio_bfin_tmr_set_state,
 };
 
-- 
2.13.3

