Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:58149 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629AbbG0Wto (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:49:44 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 6/7] iio:accel:stk8312: code style cleanup
Date: Tue, 28 Jul 2015 00:49:26 +0200
Message-Id: <e385d57dcb753a56fdee5be5ddb4fb963f502b9c.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adjust some indentation issues to make checkpatch.pl happy in strict mode.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/stk8312.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index e3624e2b3ec4..b059a6cabfbb 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -157,8 +157,7 @@ static int stk8312_otp_init(struct stk8312_data *data)
 	if (ret < 0)
 		goto exit_err;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-			STK8312_REG_AFECTRL, ret);
+	ret = i2c_smbus_write_byte_data(data->client, STK8312_REG_AFECTRL, ret);
 	if (ret < 0)
 		goto exit_err;
 	msleep(150);
@@ -453,7 +452,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 		data->buffer[2] = buffer[2];
 	} else {
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
-			   indio_dev->masklength) {
+				 indio_dev->masklength) {
 			ret = stk8312_read_accel(data, bit);
 			if (ret < 0) {
 				mutex_unlock(&data->lock);
-- 
2.4.6

