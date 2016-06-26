Return-Path: <florian.vaussard@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v2 2/2] iio: adc: max1363: Add device tree binding
Date: Sun, 26 Jun 2016 22:04:04 +0200
Message-Id: <1466971444-5333-3-git-send-email-florian.vaussard@heig-vd.ch>
In-Reply-To: <1466971444-5333-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1466971444-5333-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the necessary device tree binding to allow DT probing of
currently supported parts.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/iio/adc/max1363.c | 169 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index b5d28c0..faa2514 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -1516,6 +1518,164 @@ done:
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id max1363_of_match[] = {
+	{
+		.compatible = "maxim,max1361",
+		.data = &max1363_chip_info_tbl[max1361]
+	},
+	{
+		.compatible = "maxim,max1362",
+		.data = &max1363_chip_info_tbl[max1362]
+	},
+	{
+		.compatible = "maxim,max1363",
+		.data = &max1363_chip_info_tbl[max1363]
+	},
+	{
+		.compatible = "maxim,max1364",
+		.data = &max1363_chip_info_tbl[max1364]
+	},
+	{
+		.compatible = "maxim,max1036",
+		.data = &max1363_chip_info_tbl[max1036]
+	},
+	{
+		.compatible = "maxim,max1037",
+		.data = &max1363_chip_info_tbl[max1037]
+	},
+	{
+		.compatible = "maxim,max1038",
+		.data = &max1363_chip_info_tbl[max1038]
+	},
+	{
+		.compatible = "maxim,max1039",
+		.data = &max1363_chip_info_tbl[max1039]
+	},
+	{
+		.compatible = "maxim,max1136",
+		.data = &max1363_chip_info_tbl[max1136]
+	},
+	{
+		.compatible = "maxim,max1137",
+		.data = &max1363_chip_info_tbl[max1137]
+	},
+	{
+		.compatible = "maxim,max1138",
+		.data = &max1363_chip_info_tbl[max1138]
+	},
+	{
+		.compatible = "maxim,max1139",
+		.data = &max1363_chip_info_tbl[max1139]
+	},
+	{
+		.compatible = "maxim,max1236",
+		.data = &max1363_chip_info_tbl[max1236]
+	},
+	{
+		.compatible = "maxim,max1237",
+		.data = &max1363_chip_info_tbl[max1237]
+	},
+	{
+		.compatible = "maxim,max1238",
+		.data = &max1363_chip_info_tbl[max1238]
+	},
+	{
+		.compatible = "maxim,max1239",
+		.data = &max1363_chip_info_tbl[max1239]
+	},
+	{
+		.compatible = "maxim,max11600",
+		.data = &max1363_chip_info_tbl[max11600]
+	},
+	{
+		.compatible = "maxim,max11601",
+		.data = &max1363_chip_info_tbl[max11601]
+	},
+	{
+		.compatible = "maxim,max11602",
+		.data = &max1363_chip_info_tbl[max11602]
+	},
+	{
+		.compatible = "maxim,max11603",
+		.data = &max1363_chip_info_tbl[max11603]
+	},
+	{
+		.compatible = "maxim,max11604",
+		.data = &max1363_chip_info_tbl[max11604]
+	},
+	{
+		.compatible = "maxim,max11605",
+		.data = &max1363_chip_info_tbl[max11605]
+	},
+	{
+		.compatible = "maxim,max11606",
+		.data = &max1363_chip_info_tbl[max11606]
+	},
+	{
+		.compatible = "maxim,max11607",
+		.data = &max1363_chip_info_tbl[max11607]
+	},
+	{
+		.compatible = "maxim,max11608",
+		.data = &max1363_chip_info_tbl[max11608]
+	},
+	{
+		.compatible = "maxim,max11609",
+		.data = &max1363_chip_info_tbl[max11609]
+	},
+	{
+		.compatible = "maxim,max11610",
+		.data = &max1363_chip_info_tbl[max11610]
+	},
+	{
+		.compatible = "maxim,max11611",
+		.data = &max1363_chip_info_tbl[max11611]
+	},
+	{
+		.compatible = "maxim,max11612",
+		.data = &max1363_chip_info_tbl[max11612]
+	},
+	{
+		.compatible = "maxim,max11613",
+		.data = &max1363_chip_info_tbl[max11613]
+	},
+	{
+		.compatible = "maxim,max11614",
+		.data = &max1363_chip_info_tbl[max11614]
+	},
+	{
+		.compatible = "maxim,max11615",
+		.data = &max1363_chip_info_tbl[max11615]
+	},
+	{
+		.compatible = "maxim,max11616",
+		.data = &max1363_chip_info_tbl[max11616]
+	},
+	{
+		.compatible = "maxim,max11617",
+		.data = &max1363_chip_info_tbl[max11617]
+	},
+	{
+		.compatible = "maxim,max11644",
+		.data = &max1363_chip_info_tbl[max11644]
+	},
+	{
+		.compatible = "maxim,max11645",
+		.data = &max1363_chip_info_tbl[max11645]
+	},
+	{
+		.compatible = "maxim,max11646",
+		.data = &max1363_chip_info_tbl[max11646]
+	},
+	{
+		.compatible = "maxim,max11647",
+		.data = &max1363_chip_info_tbl[max11647]
+	},
+	{ /* sentinel */ }
+};
+#endif
+
 static int max1363_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1523,6 +1683,7 @@ static int max1363_probe(struct i2c_client *client,
 	struct max1363_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *vref;
+	const struct of_device_id *match;
 
 	indio_dev = devm_iio_device_alloc(&client->dev,
 					  sizeof(struct max1363_state));
@@ -1549,7 +1710,12 @@ static int max1363_probe(struct i2c_client *client,
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
-	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
+	match = of_match_device(of_match_ptr(max1363_of_match),
+				&client->dev);
+	if (match)
+		st->chip_info = of_device_get_match_data(&client->dev);
+	else
+		st->chip_info = &max1363_chip_info_tbl[id->driver_data];
 	st->client = client;
 
 	st->vref_uv = st->chip_info->int_vref_mv * 1000;
@@ -1692,6 +1858,7 @@ MODULE_DEVICE_TABLE(i2c, max1363_id);
 static struct i2c_driver max1363_driver = {
 	.driver = {
 		.name = "max1363",
+		.of_match_table = of_match_ptr(max1363_of_match),
 	},
 	.probe = max1363_probe,
 	.remove = max1363_remove,
-- 
2.5.5
