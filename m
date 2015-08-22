Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:51400 "EHLO
	14.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbbHVUcT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 16:32:19 -0400
Received: from mail170.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id B69B910081AE
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2015 20:02:57 +0200 (CEST)
From: Nicola Corna <nicola@corna.info>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Nicola Corna <nicola@corna.info>
Subject: [PATCH v2 1/2] iio:humidity:si7020: replaced bitmask on humidity values with range check
Date: Sat, 22 Aug 2015 20:01:28 +0200
Message-Id: <1440266488-21507-1-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The maximum possible value for the relative humidity is 55575 (100%RH).
This value, if shifted right by 2 bits, uses 14 bits and masking it with
a 12 bit mask removes 2 meaningful bits.
The masking has been replaced with a range check that sets the minimum
value at 786 (0%RH) and the maximum at 13894 (100%RH).

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 drivers/iio/humidity/si7020.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fa3b809..d27e2f2 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -57,8 +57,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		*val = ret >> 2;
+		/*
+		 * Humidity values can sligthly exceed the 0-100%RH
+		 * range and should be corrected by software
+		 */
 		if (chan->type == IIO_HUMIDITYRELATIVE)
-			*val &= GENMASK(11, 0);
+			clamp_val(*val, 786, 13894);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP)
-- 
2.5.0

