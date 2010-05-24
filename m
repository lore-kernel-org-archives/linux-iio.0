Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/11] staging:iio:max1363 use device_id instead of searching on name again
Date: Mon, 24 May 2010 22:02:46 +0100
Message-Id: <1274734976-7941-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363.h      |    1 -
 drivers/staging/iio/adc/max1363_core.c |  151 +++++++++++++++-----------------
 2 files changed, 69 insertions(+), 83 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 72cf367..9f00783 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -179,7 +179,6 @@ enum max1363_modes {
  * @default_mode:	the scan mode in which the chip starts up
  */
 struct max1363_chip_info {
-	const char			*name;
 	u8				num_inputs;
 	u8				bits;
 	u16				int_vref_mv;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 20e2674..0b21c1c 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -305,7 +305,7 @@ static ssize_t max1363_show_name(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct max1363_state *st = iio_dev_get_devdata(dev_info);
-	return sprintf(buf, "%s\n", st->chip_info->name);
+	return sprintf(buf, "%s\n", st->client->name);
 }
 
 static IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);
@@ -552,8 +552,7 @@ enum { max1361,
 
 /* max1363 and max1368 tested - rest from data sheet */
 static const struct max1363_chip_info max1363_chip_info_tbl[] = {
-	{
-		.name = "max1361",
+	[max1361] = {
 		.num_inputs = 4,
 		.bits = 10,
 		.int_vref_mv = 2048,
@@ -563,8 +562,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1362",
+	},
+	[max1362] = {
 		.num_inputs = 4,
 		.bits = 10,
 		.int_vref_mv = 4096,
@@ -574,8 +573,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1363",
+	},
+	[max1363] = {
 		.num_inputs = 4,
 		.bits = 12,
 		.int_vref_mv = 2048,
@@ -585,8 +584,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1364",
+	},
+	[max1364] = {
 		.num_inputs = 4,
 		.bits = 12,
 		.int_vref_mv = 4096,
@@ -596,8 +595,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1036",
+	},
+	[max1036] = {
 		.num_inputs = 4,
 		.bits = 8,
 		.int_vref_mv = 4096,
@@ -606,8 +605,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1037",
+	},
+	[max1037] = {
 		.num_inputs = 4,
 		.bits = 8,
 		.int_vref_mv = 2048,
@@ -616,8 +615,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1038",
+	},
+	[max1038] = {
 		.num_inputs = 12,
 		.bits = 8,
 		.int_vref_mv = 4096,
@@ -626,8 +625,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max1039",
+	},
+	[max1039] = {
 		.num_inputs = 12,
 		.bits = 8,
 		.int_vref_mv = 2048,
@@ -636,8 +635,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max1136",
+	},
+	[max1136] = {
 		.num_inputs = 4,
 		.bits = 10,
 		.int_vref_mv = 4096,
@@ -646,8 +645,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1137",
+	},
+	[max1137] = {
 		.num_inputs = 4,
 		.bits = 10,
 		.int_vref_mv = 2048,
@@ -656,8 +655,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1138",
+	},
+	[max1138] = {
 		.num_inputs = 12,
 		.bits = 10,
 		.int_vref_mv = 4096,
@@ -666,8 +665,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max1139",
+	},
+	[max1139] = {
 		.num_inputs = 12,
 		.bits = 10,
 		.int_vref_mv = 2048,
@@ -676,8 +675,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max1236",
+	},
+	[max1236] = {
 		.num_inputs = 4,
 		.bits = 12,
 		.int_vref_mv = 4096,
@@ -686,8 +685,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1237",
+	},
+	[max1237] = {
 		.num_inputs = 4,
 		.bits = 12,
 		.int_vref_mv = 2048,
@@ -696,8 +695,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max1238",
+	},
+	[max1238] = {
 		.num_inputs = 12,
 		.bits = 12,
 		.int_vref_mv = 4096,
@@ -706,8 +705,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max1239",
+	},
+	[max1239] = {
 		.num_inputs = 12,
 		.bits = 12,
 		.int_vref_mv = 2048,
@@ -716,8 +715,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max11600",
+	},
+	[max11600] = {
 		.num_inputs = 4,
 		.bits = 8,
 		.int_vref_mv = 4096,
@@ -726,8 +725,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max11601",
+	},
+	[max11601] = {
 		.num_inputs = 4,
 		.bits = 8,
 		.int_vref_mv = 2048,
@@ -736,8 +735,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max11602",
+	},
+	[max11602] = {
 		.num_inputs = 8,
 		.bits = 8,
 		.int_vref_mv = 4096,
@@ -746,8 +745,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to7,
 		.dev_attrs = &max11608_dev_attr_group,
 		.scan_attrs = &max11608_scan_el_group,
-	}, {
-		.name = "max11603",
+	},
+	[max11603] = {
 		.num_inputs = 8,
 		.bits = 8,
 		.int_vref_mv = 2048,
@@ -756,8 +755,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to7,
 		.dev_attrs = &max11608_dev_attr_group,
 		.scan_attrs = &max11608_scan_el_group,
-	}, {
-		.name = "max11604",
+	},
+	[max11604] = {
 		.num_inputs = 12,
 		.bits = 8,
 		.int_vref_mv = 4098,
@@ -766,8 +765,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max11605",
+	},
+	[max11605] = {
 		.num_inputs = 12,
 		.bits = 8,
 		.int_vref_mv = 2048,
@@ -776,8 +775,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max11606",
+	},
+	[max11606] = {
 		.num_inputs = 4,
 		.bits = 10,
 		.int_vref_mv = 4096,
@@ -786,8 +785,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max11607",
+	},
+	[max11607] = {
 		.num_inputs = 4,
 		.bits = 10,
 		.int_vref_mv = 2048,
@@ -796,8 +795,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max11608",
+	},
+	[max11608] = {
 		.num_inputs = 8,
 		.bits = 10,
 		.int_vref_mv = 4096,
@@ -806,8 +805,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to7,
 		.dev_attrs = &max11608_dev_attr_group,
 		.scan_attrs = &max11608_scan_el_group,
-	}, {
-		.name = "max11609",
+	},
+	[max11609] = {
 		.num_inputs = 8,
 		.bits = 10,
 		.int_vref_mv = 2048,
@@ -816,8 +815,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to7,
 		.dev_attrs = &max11608_dev_attr_group,
 		.scan_attrs = &max11608_scan_el_group,
-	}, {
-		.name = "max11610",
+	},
+	[max11610] = {
 		.num_inputs = 12,
 		.bits = 10,
 		.int_vref_mv = 4098,
@@ -826,8 +825,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max11611",
+	},
+	[max11611] = {
 		.num_inputs = 12,
 		.bits = 10,
 		.int_vref_mv = 2048,
@@ -836,8 +835,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max11612",
+	},
+	[max11612] = {
 		.num_inputs = 4,
 		.bits = 12,
 		.int_vref_mv = 4096,
@@ -846,8 +845,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max11613",
+	},
+	[max11613] = {
 		.num_inputs = 4,
 		.bits = 12,
 		.int_vref_mv = 2048,
@@ -856,8 +855,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to3,
 		.dev_attrs = &max1363_dev_attr_group,
 		.scan_attrs = &max1363_scan_el_group,
-	}, {
-		.name = "max11614",
+	},
+	[max11614] = {
 		.num_inputs = 8,
 		.bits = 12,
 		.int_vref_mv = 4096,
@@ -866,8 +865,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to7,
 		.dev_attrs = &max11608_dev_attr_group,
 		.scan_attrs = &max11608_scan_el_group,
-	}, {
-		.name = "max11615",
+	},
+	[max11615] = {
 		.num_inputs = 8,
 		.bits = 12,
 		.int_vref_mv = 2048,
@@ -876,8 +875,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to7,
 		.dev_attrs = &max11608_dev_attr_group,
 		.scan_attrs = &max11608_scan_el_group,
-	}, {
-		.name = "max11616",
+	},
+	[max11616] = {
 		.num_inputs = 12,
 		.bits = 12,
 		.int_vref_mv = 4098,
@@ -886,8 +885,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.dev_attrs = &max1238_dev_attr_group,
 		.scan_attrs = &max1238_scan_el_group,
-	}, {
-		.name = "max11617",
+	},
+	[max11617] = {
 		.num_inputs = 12,
 		.bits = 12,
 		.int_vref_mv = 2048,
@@ -931,18 +930,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	atomic_set(&st->protect_ring, 0);
 
 	/* Find the chip model specific data */
-	for (i = 0; i < ARRAY_SIZE(max1363_chip_info_tbl); i++)
-		if (!strcmp(max1363_chip_info_tbl[i].name, id->name)) {
-			st->chip_info = &max1363_chip_info_tbl[i];
-			break;
-		};
-	/* Unsupported chip */
-	if (!st->chip_info) {
-		dev_err(&client->dev, "%s is not supported\n", id->name);
-		ret = -ENODEV;
-		goto error_free_st;
-	}
-
+	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
 	st->reg = regulator_get(&client->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
@@ -1010,7 +998,6 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-error_free_st:
 	i2c_set_clientdata(client, NULL);
 	kfree(st);
 
-- 
1.7.0.4
