Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:64064
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751289AbbKBXSJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Nov 2015 18:18:09 -0500
Date: Mon, 2 Nov 2015 15:45:03 -0600
From: Chris Lesiak <chris.lesiak@licor.com>
To: <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: si7020: Swap data byte order
Message-ID: <5637d95f.kjNhlcFiM4VW/Nz7%chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>From e983f08f5cdeb811fd59abfc5ed9b47cef647bf6 Mon Sep 17 00:00:00 2001
From: Chris Lesiak <chris.lesiak@licor.com>
Date: Mon, 2 Nov 2015 15:13:45 -0600
Subject: [PATCH] iio: si7020: Swap data byte order

The Silicon Labs Si7013, Si7020, and Si7021 family of I2C humidity and
temperature sensors deliver 16 bit data high byte first.

See the datasheet available at:
https://www.silabs.com/Support%20Documents%2fTechnicalDocs%2fSi7020-A20.pdf

But as documented in Documentation/i2c/smbus-protocol,
i2c_smbus_read_word_data() expects the low byte first.

Change the driver to use i2c_smbus_read_word_swapped to get correct byte
order.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/iio/humidity/si7020.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index 00aec56..d169e90 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -50,10 +50,10 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_smbus_read_word_data(*client,
-					       chan->type == IIO_TEMP ?
-					       SI7020CMD_TEMP_HOLD :
-					       SI7020CMD_RH_HOLD);
+		ret = i2c_smbus_read_word_swapped(*client,
+						  chan->type == IIO_TEMP ?
+						  SI7020CMD_TEMP_HOLD :
+						  SI7020CMD_RH_HOLD);
 		if (ret < 0)
 			return ret;
 		*val = ret >> 2;
-- 
2.4.3

