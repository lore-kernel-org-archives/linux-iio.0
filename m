Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5400 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbGaO2M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Jul 2015 10:28:12 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, teodora.baluta@intel.com,
	dan.carpenter@oracle.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: mmc35240: minor change to improve code readibility
Date: Fri, 31 Jul 2015 17:27:24 +0300
Message-Id: <1438352845-11540-2-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1438352845-11540-1-git-send-email-teodora.baluta@intel.com>
References: <1438352845-11540-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch changes two variables to arrays to improve code readibility.

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 66d8364..a4259bf 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -315,31 +315,31 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
 static int mmc35240_raw_to_mgauss(struct mmc35240_data *data, int index,
 				  __le16 buf[], int *val)
 {
-	int raw_x, raw_y, raw_z;
-	int sens_x, sens_y, sens_z;
+	int raw[3];
+	int sens[3];
 	int nfo;
 
-	raw_x = le16_to_cpu(buf[AXIS_X]);
-	raw_y = le16_to_cpu(buf[AXIS_Y]);
-	raw_z = le16_to_cpu(buf[AXIS_Z]);
+	raw[AXIS_X] = le16_to_cpu(buf[AXIS_X]);
+	raw[AXIS_Y] = le16_to_cpu(buf[AXIS_Y]);
+	raw[AXIS_Z] = le16_to_cpu(buf[AXIS_Z]);
 
-	sens_x = mmc35240_props_table[data->res].sens[AXIS_X];
-	sens_y = mmc35240_props_table[data->res].sens[AXIS_Y];
-	sens_z = mmc35240_props_table[data->res].sens[AXIS_Z];
+	sens[AXIS_X] = mmc35240_props_table[data->res].sens[AXIS_X];
+	sens[AXIS_Y] = mmc35240_props_table[data->res].sens[AXIS_Y];
+	sens[AXIS_Z] = mmc35240_props_table[data->res].sens[AXIS_Z];
 
 	nfo = mmc35240_props_table[data->res].nfo;
 
 	switch (index) {
 	case AXIS_X:
-		*val = (raw_x - nfo) * 1000 / sens_x;
+		*val = (raw[AXIS_X] - nfo) * 1000 / sens[AXIS_X];
 		break;
 	case AXIS_Y:
-		*val = (raw_y - nfo) * 1000 / sens_y -
-			(raw_z - nfo)  * 1000 / sens_z;
+		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y] -
+			(raw[AXIS_Z] - nfo)  * 1000 / sens[AXIS_Z];
 		break;
 	case AXIS_Z:
-		*val = (raw_y - nfo) * 1000 / sens_y +
-			(raw_z - nfo) * 1000 / sens_z;
+		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y] +
+			(raw[AXIS_Z] - nfo) * 1000 / sens[AXIS_Z];
 		break;
 	default:
 		return -EINVAL;
-- 
1.9.1

