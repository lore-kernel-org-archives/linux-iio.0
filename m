Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58744 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbbHTHIW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:22 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 10/18] iio: dac: ad7303: Add OF match table
Date: Thu, 20 Aug 2015 09:07:23 +0200
Message-Id: <1440054451-1223-11-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Documentation/devicetree/bindings/iio/dac/ad7303.txt DT binding doc
lists "adi,ad7303" as a compatible string but the corresponding driver
does not have an OF match table. Add the table to the driver so the SPI
core can do an OF style match.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/dac/ad7303.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index fa2810032968..18a4ad5ff8c5 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -281,6 +281,12 @@ static int ad7303_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ad7303_spi_of_match[] = {
+	{ .compatible = "adi,ad7303", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ad7303_spi_of_match);
+
 static const struct spi_device_id ad7303_spi_ids[] = {
 	{ "ad7303", 0 },
 	{}
@@ -290,6 +296,7 @@ MODULE_DEVICE_TABLE(spi, ad7303_spi_ids);
 static struct spi_driver ad7303_driver = {
 	.driver = {
 		.name = "ad7303",
+		.of_match_table = of_match_ptr(ad7303_spi_of_match),
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7303_probe,
-- 
2.4.3

