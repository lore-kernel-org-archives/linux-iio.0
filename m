Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:38300 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbdDFGiX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Apr 2017 02:38:23 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 1/6] iio: light: rpr0521 disable sensor -bugfix
Date: Thu,  6 Apr 2017 09:37:02 +0300
Message-Id: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sensor was marked enabled on each call even if the call was for disabling
sensor.
Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7de0f39..c15529b 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -197,8 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
 	if (ret < 0)
 		return ret;
 
-	data->als_dev_en = true;
-
+	if (status & RPR0521_MODE_ALS_MASK)
+		data->als_dev_en = true;
+	else
+		data->als_dev_en = false;
 	return 0;
 }
 
@@ -212,7 +214,10 @@ static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
 	if (ret < 0)
 		return ret;
 
-	data->pxs_dev_en = true;
+	if (status & RPR0521_MODE_PXS_MASK)
+		data->pxs_dev_en = true;
+	else
+		data->pxs_dev_en = false;
 
 	return 0;
 }
-- 
1.9.1

