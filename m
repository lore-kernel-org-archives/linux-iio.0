Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:3360
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751919AbbJBM5E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 Oct 2015 08:57:04 -0400
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
Subject: [PATCH 3/3] iio: ad5064: Always use external vref if there is no internal vref
Date: Fri, 2 Oct 2015 14:41:42 +0200
Message-ID: <1443789702-24945-3-git-send-email-paul.cercueil@analog.com>
In-Reply-To: <1443789702-24945-1-git-send-email-paul.cercueil@analog.com>
References: <1443789702-24945-1-git-send-email-paul.cercueil@analog.com>
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
 drivers/iio/dac/ad5064.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 7146f42..daee39e 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -464,7 +464,9 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	for (i = 0; i < ad5064_num_vref(st); ++i)
 		st->vref_reg[i].supply = ad5064_vref_name(st, i);
 
-	if (dev->of_node) {
+	if (!st->chip_info->internal_vref) {
+		ext_vref = true;
+	} else if (dev->of_node) {
 		for (i = 0; ext_vref && i < ad5064_num_vref(st); ++i)
 			ext_vref = of_property_read_bool(dev->of_node,
 					ad5064_vref_name(st, i));
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

