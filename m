Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34226 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbcF3HfV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 03:35:21 -0400
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v3 3/4] iio: potentiometer: mcp4531: Add device tree binding
Date: Thu, 30 Jun 2016 09:34:50 +0200
Message-Id: <1467272091-28087-4-git-send-email-florian.vaussard@heig-vd.ch>
In-Reply-To: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the necessary device tree binding to allow DT probing of
currently supported parts.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/iio/potentiometer/mcp4531.c | 87 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 2251173..13b6ae2 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -31,6 +31,8 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/iio.h>
 
@@ -188,12 +190,89 @@ static const struct iio_info mcp4531_info = {
 	.driver_module = THIS_MODULE,
 };
 
+#ifdef CONFIG_OF
+
+#define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
+			.compatible = of_compatible,	\
+			.data = &mcp4531_cfg[cfg],	\
+}
+
+static const struct of_device_id mcp4531_of_match[] = {
+	MCP4531_COMPATIBLE("microchip,mcp4531-502", MCP453x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4531-103", MCP453x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4531-503", MCP453x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4531-104", MCP453x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4532-502", MCP453x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4532-103", MCP453x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4532-503", MCP453x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4532-104", MCP453x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4541-502", MCP454x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4541-103", MCP454x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4541-503", MCP454x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4541-104", MCP454x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4542-502", MCP454x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4542-103", MCP454x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4542-503", MCP454x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4542-104", MCP454x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4551-502", MCP455x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4551-103", MCP455x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4551-503", MCP455x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4551-104", MCP455x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4552-502", MCP455x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4552-103", MCP455x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4552-503", MCP455x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4552-104", MCP455x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4561-502", MCP456x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4561-103", MCP456x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4561-503", MCP456x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4561-104", MCP456x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4562-502", MCP456x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4562-103", MCP456x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4562-503", MCP456x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4562-104", MCP456x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4631-502", MCP463x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4631-103", MCP463x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4631-503", MCP463x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4631-104", MCP463x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4632-502", MCP463x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4632-103", MCP463x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4632-503", MCP463x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4632-104", MCP463x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4641-502", MCP464x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4641-103", MCP464x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4641-503", MCP464x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4641-104", MCP464x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4642-502", MCP464x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4642-103", MCP464x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4642-503", MCP464x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4642-104", MCP464x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4651-502", MCP465x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4651-103", MCP465x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4651-503", MCP465x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4651-104", MCP465x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4652-502", MCP465x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4652-103", MCP465x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4652-503", MCP465x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4652-104", MCP465x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4661-502", MCP466x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4661-103", MCP466x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4661-503", MCP466x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4661-104", MCP466x_104),
+	MCP4531_COMPATIBLE("microchip,mcp4662-502", MCP466x_502),
+	MCP4531_COMPATIBLE("microchip,mcp4662-103", MCP466x_103),
+	MCP4531_COMPATIBLE("microchip,mcp4662-503", MCP466x_503),
+	MCP4531_COMPATIBLE("microchip,mcp4662-104", MCP466x_104),
+	{ /* sentinel */ }
+};
+#endif
+
 static int mcp4531_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct mcp4531_data *data;
 	struct iio_dev *indio_dev;
+	const struct of_device_id *match;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
@@ -207,7 +286,12 @@ static int mcp4531_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	data->cfg = &mcp4531_cfg[id->driver_data];
+
+	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
+	if (match)
+		data->cfg = of_device_get_match_data(dev);
+	else
+		data->cfg = &mcp4531_cfg[id->driver_data];
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &mcp4531_info;
@@ -290,6 +374,7 @@ MODULE_DEVICE_TABLE(i2c, mcp4531_id);
 static struct i2c_driver mcp4531_driver = {
 	.driver = {
 		.name	= "mcp4531",
+		.of_match_table = of_match_ptr(mcp4531_of_match),
 	},
 	.probe		= mcp4531_probe,
 	.id_table	= mcp4531_id,
-- 
2.5.5

