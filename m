Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36454 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXxh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Oct 2018 19:53:37 -0400
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH] Staging iio/adc: fixes parenthesis alignment
Date: Tue, 16 Oct 2018 13:01:04 -0300
Message-Id: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes close parenthesis alignment to match open parenthesis at
iio/drivers/staging/iio/adc/ad7606.c line 379.

Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7606.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 0b728b6ea135..230faae38c12 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return 0;
 
 	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
-			GPIOD_OUT_LOW);
+						    GPIOD_OUT_LOW);
 	return PTR_ERR_OR_ZERO(st->gpio_os);
 }
 
-- 
2.17.1
