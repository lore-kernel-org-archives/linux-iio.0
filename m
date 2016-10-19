Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60000 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757155AbcJSRHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/13] staging:iio:ad7606: Use oversampling ratio of 1 for no oversampling
Date: Wed, 19 Oct 2016 19:07:00 +0200
Message-Id: <1476896828-10544-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the ad7606 driver uses a value of 0 for the oversampling ratio to
express that no oversampling is done. Strictly speaking this means though
that no data capture is done at all. Instead change the driver to use a
value of 1, this is in accordance with what other drivers do and what the
IIO spec suggests.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index d3a3551..7c093e2 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -149,7 +149,7 @@ static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
 
 static int ad7606_oversampling_get_index(unsigned int val)
 {
-	unsigned char supported[] = {0, 2, 4, 8, 16, 32, 64};
+	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(supported); i++)
@@ -188,7 +188,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
+static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes_os_and_range[] = {
 	&iio_dev_attr_in_voltage_range.dev_attr.attr,
@@ -449,7 +449,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	st->bops = bops;
 	st->base_address = base_address;
 	st->range = 5000;
-	st->oversampling = 0;
+	st->oversampling = 1;
 
 	st->reg = devm_regulator_get(dev, "vcc");
 	if (!IS_ERR(st->reg)) {
-- 
2.1.4

