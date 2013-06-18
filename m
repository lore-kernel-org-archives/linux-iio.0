Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:53593 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3FRNIB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2013 09:08:01 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so1767185bkc.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2013 06:08:00 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 18 Jun 2013 21:08:00 +0800
Message-ID: <CAPgLHd_7GTkOavGHctmaODV-gQBjRi5aiUF7+BR-FRnP8eCa7w@mail.gmail.com>
Subject: [PATCH -next] iio: dac: ad7303: fix error return code in ad7303_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, lars@metafoo.de
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/dac/ad7303.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 85aeef6..d546f50 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -235,8 +235,10 @@ static int ad7303_probe(struct spi_device *spi)
 
 	if (ext_ref) {
 		st->vref_reg = regulator_get(&spi->dev, "REF");
-		if (IS_ERR(st->vref_reg))
+		if (IS_ERR(st->vref_reg)) {
+			ret = PTR_ERR(st->vref_reg);
 			goto err_disable_vdd_reg;
+		}
 
 		ret = regulator_enable(st->vref_reg);
 		if (ret)

