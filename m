Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33677 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbJSQHd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 12:07:33 -0400
From: Insu Yun <wuninsu@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu,
	changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] adc: correctly check return value
Date: Mon, 19 Oct 2015 16:08:51 +0000
Message-Id: <1445270931-24109-1-git-send-email-wuninsu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since devm_regulator_get returns address or error, not NULL,
it needs to be checked with IS_ERR, not IS_ERR_OR_NULL.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 70f78c3..26cd54b 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -397,7 +397,7 @@ static int ad7266_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 
 	st->reg = devm_regulator_get(&spi->dev, "vref");
-	if (!IS_ERR_OR_NULL(st->reg)) {
+	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
-- 
1.9.1

