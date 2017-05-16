Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:33966 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdEPNOO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 May 2017 09:14:14 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v4 4/9] iio: light: rpr0521 magic number to sizeof() on value read
Date: Tue, 16 May 2017 15:33:31 +0300
Message-Id: <1494938016-8940-4-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1494938016-8940-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1494938016-8940-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changed magic number to sizeof() on value read.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 02ce635..d4d2d8c 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -356,7 +356,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 
 		ret = regmap_bulk_read(data->regmap,
 				       rpr0521_data_reg[chan->address].address,
-				       &raw_data, 2);
+				       &raw_data, sizeof(raw_data));
 		if (ret < 0) {
 			rpr0521_set_power_state(data, false, device_mask);
 			mutex_unlock(&data->lock);
-- 
1.7.9.5

