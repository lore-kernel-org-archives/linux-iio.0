Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56710 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbbG2Vj7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 29 Jul 2015 17:39:59 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH v2 7/7] iio:accel:stk8312: drop local buffer
Date: Wed, 29 Jul 2015 23:39:40 +0200
Message-Id: <f3fe313ea881ad695de6b088b60cd7efbe0cc38d.1438204273.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438204273.git.knaack.h@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438204273.git.knaack.h@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop the local buffer in stk8312_trigger_handler() and use data->buffer
instead for bulk reads.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/stk8312.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 39eb9f4ea5c0..c88baabe08e7 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -435,7 +435,6 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct stk8312_data *data = iio_priv(indio_dev);
 	int bit, ret, i = 0;
-	u8 buffer[STK8312_ALL_CHANNEL_SIZE];
 
 	mutex_lock(&data->lock);
 	/*
@@ -446,15 +445,12 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
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

