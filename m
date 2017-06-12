Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33777 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdFLPFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jun 2017 11:05:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id a70so14524830pge.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Jun 2017 08:05:33 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] iio: light: tcs3472: fix ATIME register write
Date: Tue, 13 Jun 2017 00:05:08 +0900
Message-Id: <1497279909-11197-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com>
References: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The integration time is controlled by the ATIME register only.  However,
this register is written by i2c_smbus_write_word_data() in write_raw().

We actually don't need to write a subsequent register.  So just use
i2c_smbus_write_byte_data() instead.

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/light/tcs3472.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 3aa71e3..a9e153b 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -169,7 +169,7 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 		for (i = 0; i < 256; i++) {
 			if (val2 == (256 - i) * 2400) {
 				data->atime = i;
-				return i2c_smbus_write_word_data(
+				return i2c_smbus_write_byte_data(
 					data->client, TCS3472_ATIME,
 					data->atime);
 			}
-- 
2.7.4

