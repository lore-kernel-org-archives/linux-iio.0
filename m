Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:30587 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934346AbcJQODS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2016 10:03:18 -0400
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com
Subject: [PATCH v4 7/8] drivers:input:ads7846(+tsc2046): fix spi module table
Date: Mon, 17 Oct 2016 15:57:55 +0200
Message-Id: <70cc986f3cf98dd89f0460b5042083aad58a7366.1476712675.git.hns@goldelico.com>
In-Reply-To: <cover.1476712675.git.hns@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com>
In-Reply-To: <cover.1476712675.git.hns@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix module table so that the driver is loaded if compiled
as module and requested by DT.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/ads7846.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 400e421..9a5d84d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1532,6 +1532,17 @@ static int ads7846_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id ads7846_idtable[] = {
+	{ "tsc2046", 0 },
+	{ "ads7843", 0 },
+	{ "ads7845", 0 },
+	{ "ads7846", 0 },
+	{ "ads7873", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, ads7846_idtable);
+
 static struct spi_driver ads7846_driver = {
 	.driver = {
 		.name	= "ads7846",
-- 
2.7.3

