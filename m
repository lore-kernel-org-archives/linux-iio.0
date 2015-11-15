Return-Path: <nizamhaider786@gmail.com>
From: Nizam Haider <nizamhaider786@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com,
	thomas.betker@rohde-schwarz.com,
	xander.huff@ni.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [PATCH] IIO: adc: xilinx-xadc-core.c: constify iio_buffer_setup_ops structure
Date: Mon, 16 Nov 2015 04:41:51 +0530
Message-Id: <1447629111-6400-1-git-send-email-nizamhaider786@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

structure iio_buffer_setup_ops is never modified, so declare it as const.

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0370624..c2b5f10 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -803,7 +803,7 @@ err:
 	return ret;
 }
 
-static struct iio_buffer_setup_ops xadc_buffer_ops = {
+static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.preenable = &xadc_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
-- 
1.8.1.4
