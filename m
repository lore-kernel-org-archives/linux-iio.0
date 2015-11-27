Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53657 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbK0Nwu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2015 08:52:50 -0500
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] iio: adc: mcp3422: Add mcp3421 support
Date: Fri, 27 Nov 2015 14:52:51 +0100
Message-Id: <1448632372-5315-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
References: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The mcp3421 is the single channel variant of the mcp342x family. Support
is straight forward, only the channels array has to be added for this
chip.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/iio/adc/mcp3422.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 3555122..6eca7ae 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -305,6 +305,10 @@ static const struct attribute_group mcp3422_attribute_group = {
 	.attrs = mcp3422_attributes,
 };
 
+static const struct iio_chan_spec mcp3421_channels[] = {
+	MCP3422_CHAN(0),
+};
+
 static const struct iio_chan_spec mcp3422_channels[] = {
 	MCP3422_CHAN(0),
 	MCP3422_CHAN(1),
@@ -352,6 +356,10 @@ static int mcp3422_probe(struct i2c_client *client,
 	indio_dev->info = &mcp3422_info;
 
 	switch (adc->id) {
+	case 1:
+		indio_dev->channels = mcp3421_channels;
+		indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
+		break;
 	case 2:
 	case 3:
 	case 6:
@@ -383,6 +391,7 @@ static int mcp3422_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id mcp3422_id[] = {
+	{ "mcp3421", 1 },
 	{ "mcp3422", 2 },
 	{ "mcp3423", 3 },
 	{ "mcp3424", 4 },
-- 
2.6.2

