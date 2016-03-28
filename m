Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53991 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbcC1RPy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Mar 2016 13:15:54 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Markus Pargmann <mpa@pengutronix.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] iio: gyro: bmg160: fix buffer read values
Date: Mon, 28 Mar 2016 20:15:46 +0300
Message-Id: <1459185346-18600-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When reading gyroscope axes using iio buffers, the values
returned are always 0. In the interrupt handler, the return
value of the read operation is returned to the user instead
of the value read. Return the value read to the user.

This is also fixed in commit 82d8e5da1a33 ("iio:
accel: bmg160: optimize transfers in trigger handler").

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/gyro/bmg160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 295cf1d..e165ce9 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -781,7 +781,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
-		data->buffer[i++] = ret;
+		data->buffer[i++] = val;
 	}
 	mutex_unlock(&data->mutex);
 
-- 
1.9.1

