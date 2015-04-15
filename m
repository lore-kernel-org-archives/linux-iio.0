Return-Path: <thomas.betker@freenet.de>
From: Thomas Betker <thomas.betker@freenet.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [PATCH 4/5] iio: adc: xilinx: Fix VREFN sign
Date: Wed, 15 Apr 2015 21:11:50 +0200
Message-Id: <1429125111-2926-5-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
List-ID: <linux-iio@vger.kernel.org>

From: Thomas Betker <thomas.betker@rohde-schwarz.com>

The VREFN channel is bipolar, not unipolar. Small negative values do
occur (e.g., -1mV), and unsigned conversion maps them incorrectly to
large positive values (about +1V), so fix this.

Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
---
 drivers/iio/adc/xilinx-xadc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 6fa629b..ce93bd8 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -997,7 +997,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
 	.num_event_specs = (_alarm) ? ARRAY_SIZE(xadc_voltage_events) : 0, \
 	.scan_index = (_scan_index), \
 	.scan_type = { \
-		.sign = 'u', \
+		.sign = ((_addr) == XADC_REG_VREFN) ? 's' : 'u', \
 		.realbits = 12, \
 		.storagebits = 16, \
 		.shift = 4, \
-- 
1.7.9.5
