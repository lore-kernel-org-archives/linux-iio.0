Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:33606 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeGYQhl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jul 2018 12:37:41 -0400
From: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v3 3/4] iio: vcnl4000: warn on incorrectly specified device id
Date: Wed, 25 Jul 2018 17:18:20 +0200
Message-Id: <20180725151821.17566-4-tomas.novotny@tbs-biometrics.com>
In-Reply-To: <20180725151821.17566-1-tomas.novotny@tbs-biometrics.com>
References: <20180725151821.17566-1-tomas.novotny@tbs-biometrics.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Tomas Novotny <tomas@novotny.cz>

We can detect incorrectly specified device id for some chips, so warn
user in that case.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
Changes v2..v3:
- update warn message, vcnl4020 is now valid device id

 drivers/iio/light/vcnl4000.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 980eb3b77d5f..a0cd1dcbf935 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -84,8 +84,20 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 		return ret;
 
 	prod_id = ret >> 4;
-	if (prod_id != VCNL4010_PROD_ID && prod_id != VCNL4000_PROD_ID)
+	switch (prod_id) {
+	case VCNL4000_PROD_ID:
+		if (data->id != VCNL4000)
+			dev_warn(&data->client->dev,
+					"wrong device id, use vcnl4000");
+		break;
+	case VCNL4010_PROD_ID:
+		if (data->id != VCNL4010)
+			dev_warn(&data->client->dev,
+					"wrong device id, use vcnl4010/4020");
+		break;
+	default:
 		return -ENODEV;
+	}
 
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
-- 
2.12.3

