Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45212 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeKIGPe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Nov 2018 01:15:34 -0500
From: Matt Walker <mattofak@gmail.com>
Cc: Matt Walker <mattofak@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: extend dac/MCP4922 to MCP49x1 devices
Date: Thu,  8 Nov 2018 15:36:53 -0500
Message-Id: <20181108203655.17448-1-mattofak@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Extend the existing dual channel MCP4922 DAC driver to single channel
MCP49x1 devices. These devices are simple and write only. The most
significant bit of the transfer dictates what channel to write to.

Although there is no danger in writing to the non existant channel in
the single channel devices, it's better to not register it at all.
Therefore extend the driver to know how many channels a device has at
probe time based on the ID table.

Signed-off-by: Matt Walker <mattofak@gmail.com>
---
 drivers/iio/dac/mcp4922.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index b5190d1dae8e..094f7dd560ca 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -29,8 +29,11 @@
 #define MCP4922_NUM_CHANNELS	2
 
 enum mcp4922_supported_device_ids {
+	ID_MCP4901,
 	ID_MCP4902,
+	ID_MCP4911,
 	ID_MCP4912,
+	ID_MCP4921,
 	ID_MCP4922,
 };
 
@@ -115,10 +118,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
-	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
-	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
-	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
+static const unsigned int mcp4922_channel_counts[6] = {
+	[ID_MCP4901] = 1,
+	[ID_MCP4902] = 2,
+	[ID_MCP4911] = 1,
+	[ID_MCP4912] = 2,
+	[ID_MCP4921] = 1,
+	[ID_MCP4922] = 2,
+};
+
+static const struct iio_chan_spec mcp4922_channels[6][MCP4922_NUM_CHANNELS] = {
+	[ID_MCP4901] = { MCP4922_CHAN(0, 8),  {} },
+	[ID_MCP4902] = { MCP4922_CHAN(0, 8),  MCP4922_CHAN(1, 8) },
+	[ID_MCP4911] = { MCP4922_CHAN(0, 10), {} },
+	[ID_MCP4912] = { MCP4922_CHAN(0, 10), MCP4922_CHAN(1, 10) },
+	[ID_MCP4921] = { MCP4922_CHAN(0, 12), {} },
+	[ID_MCP4922] = { MCP4922_CHAN(0, 12), MCP4922_CHAN(1, 12) },
 };
 
 static const struct iio_info mcp4922_info = {
@@ -166,7 +181,7 @@ static int mcp4922_probe(struct spi_device *spi)
 	indio_dev->info = &mcp4922_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp4922_channels[id->driver_data];
-	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
+	indio_dev->num_channels = mcp4922_channel_counts[id->driver_data];
 	indio_dev->name = id->name;
 
 	ret = iio_device_register(indio_dev);
@@ -197,8 +212,11 @@ static int mcp4922_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id mcp4922_id[] = {
+	{"mcp4901", ID_MCP4901},
 	{"mcp4902", ID_MCP4902},
+	{"mcp4911", ID_MCP4911},
 	{"mcp4912", ID_MCP4912},
+	{"mcp4921", ID_MCP4921},
 	{"mcp4922", ID_MCP4922},
 	{}
 };
@@ -215,5 +233,5 @@ static struct spi_driver mcp4922_driver = {
 module_spi_driver(mcp4922_driver);
 
 MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
-MODULE_DESCRIPTION("Microchip MCP4902, MCP4912, MCP4922 DAC");
+MODULE_DESCRIPTION("Microchip MCP49xx DAC");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1
