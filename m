Return-Path: <thomas.betker@freenet.de>
From: Thomas Betker <thomas.betker@freenet.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [PATCH 3/5] iio: adc: xilinx: Fix VREFP scale
Date: Wed, 15 Apr 2015 21:11:49 +0200
Message-Id: <1429125111-2926-4-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
List-ID: <linux-iio@vger.kernel.org>

From: Thomas Betker <thomas.betker@rohde-schwarz.com>

The scaling factor for VREFP is 3.0/4096, not 1.0/4096; fix this to get
correct readings.

Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
---
 drivers/iio/adc/xilinx-xadc-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0ad7b50..6fa629b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -856,6 +856,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			switch (chan->address) {
 			case XADC_REG_VCCINT:
 			case XADC_REG_VCCAUX:
+			case XADC_REG_VREFP:
 			case XADC_REG_VCCBRAM:
 			case XADC_REG_VCCPINT:
 			case XADC_REG_VCCPAUX:
-- 
1.7.9.5
