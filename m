Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62838 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbbG0Wti (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:49:38 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 7/7] iio:accel:stk8312: drop local buffer
Date: Tue, 28 Jul 2015 00:49:27 +0200
Message-Id: <1c9023e014e0e17fd1705aedafe6dc3932a50a44.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop the local buffer in stk8312_trigger_handler() and use data-buffer
instead for bulk reads.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/stk8312.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index b059a6cabfbb..a6b2bda7a63c 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -430,7 +430,6 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct stk8312_data *data = iio_priv(indio_dev);
 	int bit, ret, i = 0;
-	u8 buffer[STK8312_ALL_CHANNEL_SIZE];
 
 	mutex_lock(&data->lock);
 	/*
@@ -441,15 +440,12 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 						    STK8312_REG_XOUT,
 						    STK8312_ALL_CHANNEL_SIZE,
-						    buffer);
+						    data->buffer);
 		if (ret < STK8312_ALL_CHANNEL_SIZE) {
 			dev_err(&data->client->dev, "register read failed\n");
 			mutex_unlock(&data->lock);
 			goto err;
 		}
-		data->buffer[0] = buffer[0];
-		data->buffer[1] = buffer[1];
-		data->buffer[2] = buffer[2];
 	} else {
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 indio_dev->masklength) {
-- 
2.4.6

