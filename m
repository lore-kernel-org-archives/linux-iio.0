Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0092.outbound.protection.outlook.com ([157.56.110.92]:23418
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751599AbbJLMFn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 12 Oct 2015 08:05:43 -0400
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>,
	Paul Cercueil <paul.cercueil@analog.com>
Subject: [PATCHv2 3/3] iio: ad5064: Always use external vref if there is no internal vref
Date: Mon, 12 Oct 2015 13:50:34 +0200
Message-ID: <1444650634-12025-3-git-send-email-paul.cercueil@analog.com>
In-Reply-To: <1444650634-12025-1-git-send-email-paul.cercueil@analog.com>
References: <1444650634-12025-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the device does not have an internal reference, there is no
other choice but to use the external reference. In that case,
it does not make much sense to have to specify it.

This patch ensures that the external reference is used if the
device does not feature an internal reference.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 drivers/iio/dac/ad5064.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

 v2: No change in this patch

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index e77631d..18674e5 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -464,14 +464,16 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	for (i = 0; i < ad5064_num_vref(st); ++i)
 		st->vref_reg[i].supply = ad5064_vref_name(st, i);
 
-	if (dev->of_node) {
-		for (i = 0; ext_vref && i < ad5064_num_vref(st); ++i)
-			ext_vref = of_property_read_bool(dev->of_node,
-					ad5064_vref_name(st, i));
-	} else {
-		struct ad5064_platform_data *pdata = dev->platform_data;
-
-		ext_vref = pdata && pdata->use_external_ref;
+	if (st->chip_info->internal_vref) {
+		if (dev->of_node) {
+			for (i = 0; ext_vref && i < ad5064_num_vref(st); ++i)
+				ext_vref = of_property_read_bool(dev->of_node,
+						ad5064_vref_name(st, i));
+		} else {
+			struct ad5064_platform_data *pdata = dev->platform_data;
+
+			ext_vref = pdata && pdata->use_external_ref;
+		}
 	}
 
 	if (ext_vref) {
@@ -483,11 +485,6 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 		if (ret)
 			return ret;
 	} else {
-		if (!st->chip_info->internal_vref) {
-			dev_err(dev, "No vref available\n");
-			return -ENXIO;
-		}
-
 		st->use_internal_vref = true;
 		ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
 			AD5064_CONFIG_INT_VREF_ENABLE, 0);
-- 
2.5.3

