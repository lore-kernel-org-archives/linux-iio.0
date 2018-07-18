Return-Path: <SRS0=qv6e=KC=xilinx.com=MNARANI@kernel.org>
From: Manish Narani <manish.narani@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 2/4] iio: adc: xilinx: Remove dead code from xadc_zynq_setup
Date: Wed, 18 Jul 2018 16:42:09 +0530
Message-ID: <1531912331-26431-3-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch removes dead code from xadc_zynq_setup. The condition
"if (tck_rate > XADC_ZYNQ_TCK_RATE_MAX)" cannot be true at any point of
time. There is also an incompatible parameter used in the code.
This patch fixes the same reported by coverity.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 27b45df..248cffa 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -341,8 +341,6 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 
 	pcap_rate = clk_get_rate(xadc->clk);
 
-	if (tck_rate > XADC_ZYNQ_TCK_RATE_MAX)
-		tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
 	if (tck_rate > pcap_rate / 2) {
 		div = 2;
 	} else {
@@ -1045,7 +1043,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int num_channels;
 	const char *external_mux;
 	u32 ext_mux_chan;
-	int reg;
+	u32 reg;
 	int ret;
 
 	*conf = 0;
-- 
2.1.1
