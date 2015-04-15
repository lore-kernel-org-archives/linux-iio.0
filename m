Return-Path: <thomas.betker@freenet.de>
From: Thomas Betker <thomas.betker@freenet.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [PATCH 5/5] iio: adc: xilinx: Set .datasheet_name instead of .extend_name
Date: Wed, 15 Apr 2015 21:11:51 +0200
Message-Id: <1429125111-2926-6-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
List-ID: <linux-iio@vger.kernel.org>

From: Thomas Betker <thomas.betker@rohde-schwarz.com>

"vccint", "vccaux", "vccbram" etc. are the datasheet names of the
XADC channels, not extensions; make them so.

Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
---
 drivers/iio/adc/xilinx-xadc-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ce93bd8..69db509 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -985,7 +985,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
 	}, \
 }
 
-#define XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, _ext, _alarm) { \
+#define XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, _name, _alarm) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.channel = (_chan), \
@@ -1003,7 +1003,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
 		.shift = 4, \
 		.endianness = IIO_CPU, \
 	}, \
-	.extend_name = _ext, \
+	.datasheet_name = _name, \
 }
 
 static const struct iio_chan_spec xadc_channels[] = {
-- 
1.7.9.5
