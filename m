Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:53887 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933500AbdDGMHq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Apr 2017 08:07:46 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v2 2/7] iio: light: rpr0521 whitespace fixes
Date: Fri,  7 Apr 2017 15:07:14 +0300
Message-Id: <1491566839-3925-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just whitespace changes, no functional changes.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c15529b..30c2592 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -357,8 +357,8 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		*val = le16_to_cpu(raw_data);
-
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
 		mutex_lock(&data->lock);
 		ret = rpr0521_get_gain(data, chan->address, val, val2);
-- 
1.7.9.5

