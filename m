Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33721 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756830AbdCUPwy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:52:54 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        irina.tirdea@intel.com, gregor.boirie@parrot.com,
        amsfield22@gmail.com, s.trumtrar@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH] iio: bmg160: reset chip when probing
Date: Tue, 21 Mar 2017 16:52:14 +0100
Message-Id: <20170321155214.18060-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The gyroscope chip might need to be reset to be used.

Without the chip being reset, the driver stopped at the first
regmap_read (to get the CHIP_ID) and failed to probe.

The datasheet of the gyroscope says that a minimum wait of 30ms after
the reset has to be done.

This patch has been checked on a BMX055 and the datasheet of the BMG160
and the BMI055 give the same reset register and bits.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/gyro/bmg160_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index f7fcfa8..821919d 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -27,6 +27,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
+#include <linux/delay.h>
 #include "bmg160.h"
 
 #define BMG160_IRQ_NAME		"bmg160_event"
@@ -52,6 +53,9 @@
 #define BMG160_DEF_BW			100
 #define BMG160_REG_PMU_BW_RES		BIT(7)
 
+#define BMG160_GYRO_REG_RESET		0x14
+#define BMG160_GYRO_RESET_VAL		0xb6
+
 #define BMG160_REG_INT_MAP_0		0x17
 #define BMG160_INT_MAP_0_BIT_ANY	BIT(1)
 
@@ -236,6 +240,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	int ret;
 	unsigned int val;
 
+	/*
+	 * Reset chip to get it in a known good state. A delay of 30ms after
+	 * reset is required according to the datasheet.
+	 */
+	regmap_write(data->regmap, BMG160_GYRO_REG_RESET,
+		     BMG160_GYRO_RESET_VAL);
+	usleep_range(30000, 30700);
+
 	ret = regmap_read(data->regmap, BMG160_REG_CHIP_ID, &val);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_chip_id\n");
-- 
2.9.3

