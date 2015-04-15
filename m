Return-Path: <thomas.betker@freenet.de>
From: Thomas Betker <thomas.betker@freenet.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [PATCH 2/5] iio: adc: xilinx: Fix "vccaux" channel .address
Date: Wed, 15 Apr 2015 21:11:48 +0200
Message-Id: <1429125111-2926-3-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
List-ID: <linux-iio@vger.kernel.org>

From: Thomas Betker <thomas.betker@rohde-schwarz.com>

For the "vccaux" channel, read the VCCAUX register, not VCCINT.

Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
---
 drivers/iio/adc/xilinx-xadc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index a221f73..0ad7b50 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1008,7 +1008,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
 static const struct iio_chan_spec xadc_channels[] = {
 	XADC_CHAN_TEMP(0, 8, XADC_REG_TEMP),
 	XADC_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
-	XADC_CHAN_VOLTAGE(1, 10, XADC_REG_VCCINT, "vccaux", true),
+	XADC_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
 	XADC_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
 	XADC_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpint", true),
 	XADC_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpaux", true),
-- 
1.7.9.5
