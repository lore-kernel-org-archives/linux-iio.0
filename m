Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60669 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab3IYQcN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 12:32:13 -0400
In-Reply-To: <1380106208-6948-29-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org> <1380106208-6948-29-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 28/32] staging: iio: tsl2x7x_core: Use devm_iio_device_register
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 25 Sep 2013 17:32:05 +0100
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Message-ID: <19fcb32b-620f-45a8-b627-37c2efd7f763@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Sachin Kamat <sachin.kamat@linaro.org> wrote:
>devm_iio_device_register simplifies the code.
>
>Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>---
> drivers/staging/iio/light/tsl2x7x_core.c |    4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/staging/iio/light/tsl2x7x_core.c
>b/drivers/staging/iio/light/tsl2x7x_core.c
>index 9c43dcf..ba2079e 100644
>--- a/drivers/staging/iio/light/tsl2x7x_core.c
>+++ b/drivers/staging/iio/light/tsl2x7x_core.c
>@@ -1909,7 +1909,7 @@ static int tsl2x7x_probe(struct i2c_client
>*clientp,
> 	/* Make sure the chip is on */
> 	tsl2x7x_chip_on(indio_dev);
> 
>-	ret = iio_device_register(indio_dev);
>+	ret = devm_iio_device_register(&clientp->dev, indio_dev);
> 	if (ret) {
> 		dev_err(&clientp->dev,
> 			"%s: iio registration failed\n", __func__);
>@@ -1963,8 +1963,6 @@ static int tsl2x7x_remove(struct i2c_client
>*client)
> 
> 	tsl2x7x_chip_off(indio_dev);

This order is wrong in the driver. Should remove interfaces before powering down the chip!
> 
>-	iio_device_unregister(indio_dev);
>-
> 	return 0;
> }
> 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
