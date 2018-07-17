Return-Path: <SRS0=3Bdj=KB=novotny.cz=tomas@kernel.org>
From: Tomas Novotny <tomas@novotny.cz>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 3/4] iio: vcnl4000: warn on incorrectly specified device id
Date: Tue, 17 Jul 2018 18:46:54 +0200
Message-Id: <20180717164655.27142-4-tomas@novotny.cz>
In-Reply-To: <20180717164655.27142-1-tomas@novotny.cz>
References: <20180717164655.27142-1-tomas@novotny.cz>
List-ID: <linux-iio@vger.kernel.org>

We can detect incorrectly specified device id for some chips, so warn
user in that case.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/vcnl4000.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0688214fc152..642a366c1479 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -83,8 +83,20 @@ static int vcnl4000_init(struct vcnl4000_data *data)
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
+					"wrong device id, use vcnl4010");
+		break;
+	default:
 		return -ENODEV;
+	}
 
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
-- 
2.12.3
