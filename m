Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710089.outbound.protection.outlook.com ([40.107.71.89]:49184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729185AbeGRMUZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Jul 2018 08:20:25 -0400
From: Manish Narani <manish.narani@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to 'iio_xadc_channels'
Date: Wed, 18 Jul 2018 16:42:08 +0530
Message-ID: <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fix the following checkpatch warning in xadc driver.
- Reusing the krealloc arg is almost always a bug.

Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
warning.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d4f21d1..27b45df 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1040,7 +1040,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	struct iio_chan_spec *channels, *chan;
+	struct iio_chan_spec *iio_xadc_channels, *chan;
 	struct device_node *chan_node, *child;
 	unsigned int num_channels;
 	const char *external_mux;
@@ -1083,12 +1083,13 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
-	if (!channels)
+	iio_xadc_channels = kmemdup(xadc_channels, sizeof(xadc_channels),
+				    GFP_KERNEL);
+	if (!iio_xadc_channels)
 		return -ENOMEM;
 
 	num_channels = 9;
-	chan = &channels[9];
+	chan = &iio_xadc_channels[9];
 
 	chan_node = of_get_child_by_name(np, "xlnx,channels");
 	if (chan_node) {
@@ -1119,11 +1120,12 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	of_node_put(chan_node);
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = krealloc(channels, sizeof(*channels) *
-					num_channels, GFP_KERNEL);
+	indio_dev->channels = krealloc(iio_xadc_channels,
+				       sizeof(*iio_xadc_channels) *
+				       num_channels, GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
-		indio_dev->channels = channels;
+		indio_dev->channels = iio_xadc_channels;
 
 	return 0;
 }
-- 
2.1.1

