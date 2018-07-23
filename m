Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:35072
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388410AbeGWQEJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:09 -0400
From: Manish Narani <manish.narani@xilinx.com>
To: <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <manish.narani@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <jic23@kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency value
Date: Mon, 23 Jul 2018 20:32:01 +0530
Message-ID: <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch limits the xadc pcap clock frequency value to be less than
200MHz. This fixes the issue when zynq is booted at higher frequency
values, pcap crosses the maximum limit of 200MHz(Fmax) as it is derived
from IOPLL.
If this limit is crossed it is required to alter the WEDGE and REDGE
bits of XADC_CFG register to make timings better in the interface. So to
avoid alteration of these bits every time, the pcap value should not
cross the Fmax limit.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 23395fc..0dd306d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -322,6 +322,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 
 #define XADC_ZYNQ_TCK_RATE_MAX 50000000
 #define XADC_ZYNQ_IGAP_DEFAULT 20
+#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
 
 static int xadc_zynq_setup(struct platform_device *pdev,
 	struct iio_dev *indio_dev, int irq)
@@ -332,6 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	unsigned int div;
 	unsigned int igap;
 	unsigned int tck_rate;
+	int ret;
 
 	/* TODO: Figure out how to make igap and tck_rate configurable */
 	igap = XADC_ZYNQ_IGAP_DEFAULT;
@@ -343,6 +345,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	if (!pcap_rate)
 		return -EINVAL;
 
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk,
+				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		if (ret)
+			return ret;
+	}
+
 	if (tck_rate > pcap_rate / 2) {
 		div = 2;
 	} else {
@@ -368,6 +377,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
 			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk, pcap_rate);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.1.1

