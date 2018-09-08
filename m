Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:34853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeIHPzS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Sep 2018 11:55:18 -0400
From: zhong jiang <zhongjiang@huawei.com>
To: <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: remove unnecessary condition judgment in am2315_trigger_handler
Date: Sat, 8 Sep 2018 18:57:36 +0800
Message-ID: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The iterator in for_each_set_bit is never null, therefore, remove
the redundant conditional judgment.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/iio/humidity/am2315.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 7d8669d..dc12e37 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
 		i = 0;
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 indio_dev->masklength) {
-			data->buffer[i] = (bit ? sensor_data.temp_data :
-						 sensor_data.hum_data);
+			data->buffer[i] = sensor_data.temp_data;
 			i++;
 		}
 	}
-- 
1.7.12.4
