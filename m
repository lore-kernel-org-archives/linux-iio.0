Return-Path: <Paul.Cercueil@analog.com>
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>, Paul
 Cercueil <paul.cercueil@analog.com>
Subject: [PATCH 2/3] iio: ad5064: Allow choosing external supply from device tree
Date: Wed, 12 Feb 2014 13:01:57 +0100
Message-ID: <1392206518-1457-2-git-send-email-paul.cercueil@analog.com>
In-Reply-To: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
References: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Using the boolean property "adi,use-external-reference" it is
now possible to select the external supply from the device tree.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 drivers/iio/dac/ad5064.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index fbb836a..615790a 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -449,6 +449,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	unsigned int midscale;
 	unsigned int i;
 	int ret;
+	bool ext_vref;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -464,7 +465,13 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	for (i = 0; i < ad5064_num_vref(st); ++i)
 		st->vref_reg[i].supply = ad5064_vref_name(st, i);
 
-	if (pdata && pdata->use_external_ref) {
+	if (dev->of_node)
+		ext_vref = of_property_read_bool(dev->of_node,
+				"adi,use-external-reference");
+	else
+		ext_vref = pdata && pdata->use_external_ref;
+
+	if (ext_vref) {
 		ret = devm_regulator_bulk_get(dev, ad5064_num_vref(st),
 					st->vref_reg);
 		if (ret)
-- 
1.7.10.4
