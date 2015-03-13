Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:45928 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbCMCxY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2015 22:53:24 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-kernel@vger.kernel.org, quad@symbo1ics.com
Subject: [PATCH] iio: si7020: Fix endianness for I2C reads
Date: Thu, 12 Mar 2015 19:53:18 -0700
Message-Id: <1426215198-28630-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Si7020 outputs most significant byte of the measurement result first
and least significant byte last. As a result the data returned by
i2c_smbus_read_word_data appears as big endian. Fix this by making a
call to an approbriate byte conversion routine.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/iio/humidity/si7020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fa3b809..5c89e14 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -56,7 +56,7 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
 					       SI7020CMD_RH_HOLD);
 		if (ret < 0)
 			return ret;
-		*val = ret >> 2;
+		*val = be16_to_cpu(ret) >> 2;
 		if (chan->type == IIO_HUMIDITYRELATIVE)
 			*val &= GENMASK(11, 0);
 		return IIO_VAL_INT;
--
2.1.0
