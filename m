Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35158 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdFTQqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jun 2017 12:46:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so24399934pfs.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Jun 2017 09:46:50 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: light: tsl2563: use correct event code
Date: Wed, 21 Jun 2017 01:46:37 +0900
Message-Id: <1497977197-19157-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The TSL2563 driver provides three iio channels, two of which are raw ADC
channels (channel 0 and channel 1) in the device and the remaining one
is calculated by the two.  The ADC channel 0 only supports programmable
interrupt with threshold settings and this driver supports the event but
the generated event code does not contain the corresponding iio channel
type.

Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/light/tsl2563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index e7d4ea7..7599693 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -626,7 +626,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 	struct tsl2563_chip *chip = iio_priv(dev_info);
 
 	iio_push_event(dev_info,
-		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+		       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
 					    0,
 					    IIO_EV_TYPE_THRESH,
 					    IIO_EV_DIR_EITHER),
-- 
2.7.4

