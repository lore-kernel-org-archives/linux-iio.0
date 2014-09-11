Return-Path: <subbaraya.sundeep.bhatta@xilinx.com>
From: Subbaraya Sundeep Bhatta <subbaraya.sundeep.bhatta@xilinx.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <michals@xilinx.com>, <svemula@xilinx.com>, <anirudh@xilinx.com>,
	Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Subject: [PATCH] iio: adc: xilinx-xadc: assign auxiliary channels address correctly
Date: Thu, 11 Sep 2014 14:25:39 +0530
Message-ID: <344d9464-c489-42cd-b9c4-a63759f8f6da@BL2FFO11FD040.protection.gbl>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch fixes incorrect logic for assigning address
to auxiliary channels of xilinx xadc.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index fd2745c..626b397 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1126,7 +1126,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 				chan->address = XADC_REG_VPVN;
 			} else {
 				chan->scan_index = 15 + reg;
-				chan->scan_index = XADC_REG_VAUX(reg - 1);
+				chan->address = XADC_REG_VAUX(reg - 1);
 			}
 			num_channels++;
 			chan++;
-- 
1.7.4
