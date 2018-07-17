Return-Path: <SRS0=MvsK=KB=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org
Cc: jonathan@marek.ca,
	jmaneyrol@invensense.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mkelly@xevo.com,
	fischerdouglasc@gmail.com,
	bshah@kde.org,
	ctatlor97@gmail.com,
	drew.paterson@ams.com
Subject: [PATCH v2 6/7] iio: tsl2772: add device tree binding for avago,apds9930
Date: Tue, 17 Jul 2018 04:41:57 -0400
Message-Id: <20180717084158.23532-7-masneyb@onstation.org>
In-Reply-To: <20180717084158.23532-1-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The Avago APDS9930 has the same register set as the TAOS/AMS TSL2772 so
this patch adds the correct device tree bindings and the appropriate
LUX table values based on the values in the datasheet. Driver was tested
on a LG Nexus 5 (hammerhead) phone.

avago,apds9930 datasheet:
https://www.mouser.com/datasheet/2/678/avago_AV02-3190EN_DS_APDS-9930_2014-03-25[1]-1217273.pdf

tsl2772 datasheet:
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../devicetree/bindings/iio/light/tsl2772.txt  |  1 +
 drivers/iio/light/tsl2772.c                    | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
index bfde8b2c8790..e842db749ab2 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
@@ -13,6 +13,7 @@ Required properties:
 		"amstaos,tmd2672"
 		"amstaos,tsl2772"
 		"amstaos,tmd2772"
+		"avago,apds9930"
   - reg: the I2C address of the device
 
 Optional properties:
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index f6a27f8b3ca7..e5b449aec20c 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -119,7 +119,8 @@ enum {
 	tsl2672,
 	tmd2672,
 	tsl2772,
-	tmd2772
+	tmd2772,
+	apds9930,
 };
 
 enum {
@@ -201,6 +202,12 @@ static const struct tsl2772_lux tmd2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
 	{     0,      0 },
 };
 
+static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
+	{ 52000,  96824 },
+	{ 38792,  67132 },
+	{     0,      0 },
+};
+
 static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
 	[tsl2571] = tsl2x71_lux_table,
 	[tsl2671] = tsl2x71_lux_table,
@@ -212,6 +219,7 @@ static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
 	[tmd2672] = tmd2x72_lux_table,
 	[tsl2772] = tsl2x72_lux_table,
 	[tmd2772] = tmd2x72_lux_table,
+	[apds9930] = apds9930_lux_table,
 };
 
 static const struct tsl2772_settings tsl2772_default_settings = {
@@ -262,6 +270,7 @@ static const int tsl2772_int_time_avail[][6] = {
 	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
 	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
 	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
+	[apds9930] = { 0, 2730, 0, 2730, 0, 699000 },
 };
 
 static int tsl2772_int_calibscale_avail[] = { 1, 8, 16, 120 };
@@ -287,7 +296,8 @@ static const u8 device_channel_config[] = {
 	[tsl2672] = PRX2,
 	[tmd2672] = PRX2,
 	[tsl2772] = ALSPRX2,
-	[tmd2772] = ALSPRX2
+	[tmd2772] = ALSPRX2,
+	[apds9930] = ALSPRX2,
 };
 
 static int tsl2772_read_status(struct tsl2772_chip *chip)
@@ -501,6 +511,7 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
+	case apds9930:
 		if (!(ret & TSL2772_STA_PRX_VALID)) {
 			ret = -EINVAL;
 			goto prox_poll_err;
@@ -1325,6 +1336,7 @@ static int tsl2772_device_id_verif(int id, int target)
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
+	case apds9930:
 		return (id & 0xf0) == SWORDFISH_ID;
 	}
 
@@ -1852,6 +1864,7 @@ static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tmd2672", tmd2672 },
 	{ "tsl2772", tsl2772 },
 	{ "tmd2772", tmd2772 },
+	{ "apds9930", apds9930},
 	{}
 };
 
@@ -1868,6 +1881,7 @@ static const struct of_device_id tsl2772_of_match[] = {
 	{ .compatible = "amstaos,tmd2672" },
 	{ .compatible = "amstaos,tsl2772" },
 	{ .compatible = "amstaos,tmd2772" },
+	{ .compatible = "avago,apds9930" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tsl2772_of_match);
-- 
2.17.1
