Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33073 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758069AbcIWUEy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 16:04:54 -0400
Received: by mail-pa0-f68.google.com with SMTP id oz2so5466032pac.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2016 13:04:53 -0700 (PDT)
Date: Sat, 24 Sep 2016 01:34:48 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH v2] drivers: iio: max1027: Fix sparse warning: "dubious: x |
 !y"
Message-ID: <20160923200447.GA13617@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixing below warning:
drivers/iio/adc/max1027.c:241:34: warning: dubious: x | !y .

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
Changes in v2:
* Using MAX1027_TEMP instead of number.

 drivers/iio/adc/max1027.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 712fbd2..d601818 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -238,7 +238,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
-		  MAX1027_NOSCAN | !!(chan->type == IIO_TEMP);
+		  MAX1027_NOSCAN;
+	if (chan->type == IIO_TEMP)
+		st->reg |= MAX1027_TEMP;
 	ret = spi_write(st->spi, &st->reg, 1);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev,
-- 
1.8.3.1

