Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38552 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbaEaXKw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 May 2014 19:10:52 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so3463013wgh.28
        for <linux-iio@vger.kernel.org>; Sat, 31 May 2014 16:10:51 -0700 (PDT)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad_sigma_delta.c:  Cleaning up uninitialized variables
Date: Sun,  1 Jun 2014 01:11:44 +0200
Message-Id: <1401577904-4764-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is a risk that the variable will be used without being initialized.

This was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/iio/adc/ad_sigma_delta.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 9a4e0e3..d58fad9 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -248,7 +248,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	unsigned int sample, raw_sample;
+	unsigned int sample, raw_sample = 0;
 	int ret = 0;
 
 	if (iio_buffer_enabled(indio_dev))
-- 
1.7.10.4

