Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx0a-00158d01.pphosted.com ([208.84.65.189]:63387 "EHLO
	mx0a-00158d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998AbaKFP6R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Nov 2014 10:58:17 -0500
From: Fabien Proriol <Fabien.Proriol@jdsu.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
Date: Thu, 6 Nov 2014 15:33:45 +0000
Message-ID: <545B9479.5030700@jdsu.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 From 3f57e39e3c69476513c00cd5ec45703f58334972 Mon Sep 17 00:00:00 2001
From: Fabien Proriol <fabien.proriol@jdsu.com>
Date: Tue, 4 Nov 2014 17:05:59 +0100
Subject: [PATCH] xilinx-xadc-core: Fix voltage offset

When xilinx-xadc is used with hwmon driver to read voltage, offset used 
for temperature is always apply.
This patch change the return for IIO_CHAN_INFO_OFFSET to -EINVAL except 
for temperature to avoid offset.

Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
---
  drivers/iio/adc/xilinx-xadc-core.c | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c 
b/drivers/iio/adc/xilinx-xadc-core.c
index 41d3a5e..6064d26 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -877,9 +877,14 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
                         return -EINVAL;
                 }
         case IIO_CHAN_INFO_OFFSET:
-               /* Only the temperature channel has an offset */
-               *val = -((273150 << 12) / 503975);
-               return IIO_VAL_INT;
+               switch (chan->type) {
+               case IIO_TEMP:
+                       /* Only the temperature channel has an offset */
+                       *val = -((273150 << 12) / 503975);
+                       return IIO_VAL_INT;
+               default:
+                       return -EINVAL;
+               }
         case IIO_CHAN_INFO_SAMP_FREQ:
                 ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
                 if (ret)
-- 
2.0.4
