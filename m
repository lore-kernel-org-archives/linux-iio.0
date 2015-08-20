Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58776 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbbHTHId (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:33 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	George McCollister <george.mccollister@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 14/18] iio: as3935: Add OF match table
Date: Thu, 20 Aug 2015 09:07:27 +0200
Message-Id: <1440054451-1223-15-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Documentation/devicetree/bindings/iio/proximity/as3935.txt DT binding
doc lists "ams,as3935" as a compatible string but the corresponding driver
does not have an OF match table. Add the table to the driver so the SPI
core can do an OF style match.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/proximity/as3935.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index bc0d68efd455..e95035136889 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -434,6 +434,12 @@ static int as3935_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id as3935_of_match[] = {
+	{ .compatible = "ams,as3935", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, as3935_of_match);
+
 static const struct spi_device_id as3935_id[] = {
 	{"as3935", 0},
 	{},
@@ -443,6 +449,7 @@ MODULE_DEVICE_TABLE(spi, as3935_id);
 static struct spi_driver as3935_driver = {
 	.driver = {
 		.name	= "as3935",
+		.of_match_table = of_match_ptr(as3935_of_match),
 		.owner	= THIS_MODULE,
 		.pm	= AS3935_PM_OPS,
 	},
-- 
2.4.3

