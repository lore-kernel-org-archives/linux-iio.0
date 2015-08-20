Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58789 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865AbbHTHIj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:39 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 16/18] iio: frequency: adf4350: Add OF match table
Date: Thu, 20 Aug 2015 09:07:29 +0200
Message-Id: <1440054451-1223-17-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Documentation/devicetree/bindings/iio/frequency/adf4350.txt DT binding
doc lists "adi,adf4350" or "adi,adf4351" as compatible strings but the
corresponding driver does not have an OF match table. Add the table to the
driver so the SPI core can do an OF style match.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/frequency/adf4350.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 8bd873fc3787..73f27e0a08dd 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -616,6 +616,13 @@ static int adf4350_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adf4350_of_match[] = {
+	{ .compatible = "adi,adf4350", },
+	{ .compatible = "adi,adf4351", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, adf4350_of_match);
+
 static const struct spi_device_id adf4350_id[] = {
 	{"adf4350", 4350},
 	{"adf4351", 4351},
@@ -626,6 +633,7 @@ MODULE_DEVICE_TABLE(spi, adf4350_id);
 static struct spi_driver adf4350_driver = {
 	.driver = {
 		.name	= "adf4350",
+		.of_match_table = of_match_ptr(adf4350_of_match),
 		.owner	= THIS_MODULE,
 	},
 	.probe		= adf4350_probe,
-- 
2.4.3

