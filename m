Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:28131
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752287AbbKXHv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2015 02:51:29 -0500
From: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
	<soren.brinkmann@xilinx.com>
CC: <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <sbhatta@xilinx.com>,
	<punnaia@xilinx.com>, Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Subject: [LINUX PATCH] iio: xadc: fix for extended name remains same issue
Date: Tue, 24 Nov 2015 11:47:27 +0530
Message-ID: <1448345847-15051-1-git-send-email-ranjit.waghmode@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If we read channel details based on the device tree entry; channel’s scan_index
and channel’s address were overwritten by scan_index and address of channel
based on device tree. But extended name were remaining same because of which
sysfs entry names were continuous.

So this patch takes care of the above issue by updating 'channels' structure
inside xadc_parse_dt() function with the help of 'xadc_channels' structure
so that every channel's parameters will be updated properly. Also for the
sake of simplicity this patch updates default values for extend_name.

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 52 +++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index a221f73..b3f158f 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1015,23 +1015,23 @@ static const struct iio_chan_spec xadc_channels[] = {
 	XADC_CHAN_VOLTAGE(5, 7, XADC_REG_VCCO_DDR, "vccoddr", true),
 	XADC_CHAN_VOLTAGE(6, 12, XADC_REG_VREFP, "vrefp", false),
 	XADC_CHAN_VOLTAGE(7, 13, XADC_REG_VREFN, "vrefn", false),
-	XADC_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, NULL, false),
-	XADC_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), NULL, false),
-	XADC_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), NULL, false),
-	XADC_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), NULL, false),
-	XADC_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), NULL, false),
-	XADC_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), NULL, false),
-	XADC_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), NULL, false),
-	XADC_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), NULL, false),
-	XADC_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), NULL, false),
-	XADC_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), NULL, false),
-	XADC_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), NULL, false),
-	XADC_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), NULL, false),
-	XADC_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), NULL, false),
-	XADC_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), NULL, false),
-	XADC_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), NULL, false),
-	XADC_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), NULL, false),
-	XADC_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
+	XADC_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, "vpvn", false),
+	XADC_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), "vaux0", false),
+	XADC_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), "vaux1", false),
+	XADC_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), "vaux2", false),
+	XADC_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), "vaux3", false),
+	XADC_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), "vaux4", false),
+	XADC_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), "vaux5", false),
+	XADC_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), "vaux6", false),
+	XADC_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), "vaux7", false),
+	XADC_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), "vaux8", false),
+	XADC_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), "vaux9", false),
+	XADC_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), "vaux10", false),
+	XADC_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), "vaux11", false),
+	XADC_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), "vaux12", false),
+	XADC_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), "vaux13", false),
+	XADC_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), "vaux14", false),
+	XADC_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), "vaux15", false),
 };

 static const struct iio_info xadc_info = {
@@ -1056,7 +1056,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	struct iio_chan_spec *channels, *chan;
+	struct iio_chan_spec *channels;
 	struct device_node *chan_node, *child;
 	unsigned int num_channels;
 	const char *external_mux;
@@ -1104,7 +1104,6 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		return -ENOMEM;

 	num_channels = 9;
-	chan = &channels[9];

 	chan_node = of_get_child_by_name(np, "xlnx,channels");
 	if (chan_node) {
@@ -1114,22 +1113,17 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 				break;
 			}

+			channels[num_channels] = xadc_channels[reg + 9];
+			channels[num_channels].channel = num_channels - 1;
+
 			ret = of_property_read_u32(child, "reg", &reg);
 			if (ret || reg > 16)
 				continue;

 			if (of_property_read_bool(child, "xlnx,bipolar"))
-				chan->scan_type.sign = 's';
-
-			if (reg == 0) {
-				chan->scan_index = 11;
-				chan->address = XADC_REG_VPVN;
-			} else {
-				chan->scan_index = 15 + reg;
-				chan->address = XADC_REG_VAUX(reg - 1);
-			}
+				channels[num_channels].scan_type.sign = 's';
+
 			num_channels++;
-			chan++;
 		}
 	}
 	of_node_put(chan_node);
--
2.1.2

