Return-Path: <SRS0=kmJF=4W=kapsi.fi=mikkoz@kernel.org>
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	lars@metafoo.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-iio@vger.kernel.org,
	Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v4 1/9] iio: light: rpr0521 disable sensor -bugfix
Date: Tue, 16 May 2017 15:33:28 +0300
Message-Id: <1494938016-8940-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
List-ID: <linux-iio@vger.kernel.org>

Sensor was marked enabled on each call even if the call was for disabling
sensor.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
Patch v2->v3 changes:
whitespace change.

 drivers/iio/light/rpr0521.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7de0f39..03504f6 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -197,7 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
 	if (ret < 0)
 		return ret;
 
-	data->als_dev_en = true;
+	if (status & RPR0521_MODE_ALS_MASK)
+		data->als_dev_en = true;
+	else
+		data->als_dev_en = false;
 
 	return 0;
 }
@@ -212,7 +215,10 @@ static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
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
1.7.9.5
