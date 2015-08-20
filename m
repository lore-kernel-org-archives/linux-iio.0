Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58783 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbbHTHIh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:37 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	=?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 15/18] iio: adc128s052: Add OF match table
Date: Thu, 20 Aug 2015 09:07:28 +0200
Message-Id: <1440054451-1223-16-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt DT binding
doc lists "ti,adc128s052" or "ti,adc122s021" as compatible strings but the
corresponding driver does not have an OF match table. Add the table to the
driver so the SPI core can do an OF style match.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/adc/ti-adc128s052.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 915be6b60097..98c0d2b444bf 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -174,6 +174,13 @@ static int adc128_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adc128_of_match[] = {
+	{ .compatible = "ti,adc128s052", },
+	{ .compatible = "ti,adc122s021", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, adc128_of_match);
+
 static const struct spi_device_id adc128_id[] = {
 	{ "adc128s052", 0},	/* index into adc128_config */
 	{ "adc122s021",	1},
@@ -184,6 +191,7 @@ MODULE_DEVICE_TABLE(spi, adc128_id);
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
+		.of_match_table = of_match_ptr(adc128_of_match),
 		.owner = THIS_MODULE,
 	},
 	.probe = adc128_probe,
-- 
2.4.3

