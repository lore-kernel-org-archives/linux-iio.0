Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58767 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbbHTHIb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 03:08:31 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Andrea Galbusera <gizero@gmail.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Welling <mwelling@ieee.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@rosetechnology.dk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 13/18] iio: adc: mcp320x: Set struct spi_driver .of_match_table
Date: Thu, 20 Aug 2015 09:07:26 +0200
Message-Id: <1440054451-1223-14-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver has an OF id table but the .of_match_table is not set so
the SPI core can't do an OF style match and the table was unused.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/adc/mcp320x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index b19e4f9d16e0..41a21e986c1a 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -404,6 +404,7 @@ MODULE_DEVICE_TABLE(spi, mcp320x_id);
 static struct spi_driver mcp320x_driver = {
 	.driver = {
 		.name = "mcp320x",
+		.of_match_table = of_match_ptr(mcp320x_dt_ids),
 		.owner = THIS_MODULE,
 	},
 	.probe = mcp320x_probe,
-- 
2.4.3

