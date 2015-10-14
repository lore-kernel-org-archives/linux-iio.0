Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53028 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbbJNMzA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 14 Oct 2015 08:55:00 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Andrea Galbusera <gizero@gmail.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 2/2] iio: adc: mcp320x: Add compatible with vendor prefix to OF table
Date: Wed, 14 Oct 2015 14:54:39 +0200
Message-Id: <1444827279-23163-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1444827279-23163-1-git-send-email-javier@osg.samsung.com>
References: <1444827279-23163-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver Device Tree binding now documents compatible strings that have
a vendor prefix, so add these to the OF device ID table to match and mark
the old ones as deprecated explaining that should not be used anymore.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/iio/adc/mcp320x.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 41a21e986c1a..9fcb8b61e300 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -354,6 +354,7 @@ static int mcp320x_remove(struct spi_device *spi)
 
 #if defined(CONFIG_OF)
 static const struct of_device_id mcp320x_dt_ids[] = {
+	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
 	{
 		.compatible = "mcp3001",
 		.data = &mcp320x_chip_infos[mcp3001],
@@ -382,6 +383,33 @@ static const struct of_device_id mcp320x_dt_ids[] = {
 		.compatible = "mcp3301",
 		.data = &mcp320x_chip_infos[mcp3301],
 	}, {
+		.compatible = "microchip,mcp3001",
+		.data = &mcp320x_chip_infos[mcp3001],
+	}, {
+		.compatible = "microchip,mcp3002",
+		.data = &mcp320x_chip_infos[mcp3002],
+	}, {
+		.compatible = "microchip,mcp3004",
+		.data = &mcp320x_chip_infos[mcp3004],
+	}, {
+		.compatible = "microchip,mcp3008",
+		.data = &mcp320x_chip_infos[mcp3008],
+	}, {
+		.compatible = "microchip,mcp3201",
+		.data = &mcp320x_chip_infos[mcp3201],
+	}, {
+		.compatible = "microchip,mcp3202",
+		.data = &mcp320x_chip_infos[mcp3202],
+	}, {
+		.compatible = "microchip,mcp3204",
+		.data = &mcp320x_chip_infos[mcp3204],
+	}, {
+		.compatible = "microchip,mcp3208",
+		.data = &mcp320x_chip_infos[mcp3208],
+	}, {
+		.compatible = "microchip,mcp3301",
+		.data = &mcp320x_chip_infos[mcp3301],
+	}, {
 	}
 };
 MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
-- 
2.4.3

