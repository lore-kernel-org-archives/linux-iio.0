Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33701 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932948AbcLIKau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 05:30:50 -0500
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Sandhya Bankar <bankarsandhya512@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: adc: max1027: allocate DMA-safe buffer
Date: Fri,  9 Dec 2016 11:24:35 +0100
Message-Id: <20161209102435.30638-1-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The buffer needs to be DMA-safe when used with spi_read()

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/max1027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 712fbd2b1f16..ff1f1f15a873 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -435,7 +435,7 @@ static int max1027_probe(struct spi_device *spi)
 
 	st->buffer = devm_kmalloc(&indio_dev->dev,
 				  indio_dev->num_channels * 2,
-				  GFP_KERNEL);
+				  GFP_KERNEL | GFP_DMA);
 	if (st->buffer == NULL) {
 		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
 		return -ENOMEM;
-- 
2.11.0.rc2

