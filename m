Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58754 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbbHTHIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:25 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masanari Iida <standby24x7@gmail.com>,
	linux-iio@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 11/18] iio: adc: max1027: Set struct spi_driver .of_match_table
Date: Thu, 20 Aug 2015 09:07:24 +0200
Message-Id: <1440054451-1223-12-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver has an OF id table but the .of_match_table is not set so
the SPI core can't do an OF style match and the table was unused.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/adc/max1027.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 44bf815adb6c..54a8302aaace 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -508,6 +508,7 @@ static int max1027_remove(struct spi_device *spi)
 static struct spi_driver max1027_driver = {
 	.driver = {
 		.name	= "max1027",
+		.of_match_table = of_match_ptr(max1027_adc_dt_ids),
 		.owner	= THIS_MODULE,
 	},
 	.probe		= max1027_probe,
-- 
2.4.3

