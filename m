Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40069 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRJag (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 05:30:36 -0400
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2] Staging iio: adc: Match parenthesis alignment
Date: Wed, 17 Oct 2018 22:31:47 -0300
Message-Id: <20181018013147.15352-1-marcelo.schmitt1@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change close parenthesis alignment to match respective open parenthesis at
iio/drivers/staging/iio/adc/ad7606.c line 379.
This makes the file more compliant with the preferred coding style for the
linux kernel.

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
