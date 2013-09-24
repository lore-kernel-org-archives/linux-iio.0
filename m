Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42299 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab3IXNIQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 09:08:16 -0400
In-Reply-To: <1380024338-30204-9-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org> <1380024338-30204-9-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 8/8] iio: amplifiers: ad8366: Use devm_iio_device_register
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 24 Sep 2013 14:08:00 +0100
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Message-ID: <96573e4d-194d-4fd9-b03c-7cbd37fe0c9e@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Sachin Kamat <sachin.kamat@linaro.org> wrote:
>devm_iio_device_register simplifies the code.
>
>Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Is there not a race here?
>---
> drivers/iio/amplifiers/ad8366.c |    4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/iio/amplifiers/ad8366.c
>b/drivers/iio/amplifiers/ad8366.c
>index ba6f6a9..6af459c 100644
>--- a/drivers/iio/amplifiers/ad8366.c
>+++ b/drivers/iio/amplifiers/ad8366.c
>@@ -162,7 +162,7 @@ static int ad8366_probe(struct spi_device *spi)
> 	indio_dev->channels = ad8366_channels;
> 	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
> 
>-	ret = iio_device_register(indio_dev);
>+	ret = devm_iio_device_register(&spi->dev, indio_dev);
> 	if (ret)
> 		goto error_disable_reg;
> 
>@@ -183,8 +183,6 @@ static int ad8366_remove(struct spi_device *spi)
> 	struct ad8366_state *st = iio_priv(indio_dev);
> 	struct regulator *reg = st->reg;
> 
>-	iio_device_unregister(indio_dev);
>-
> 	if (!IS_ERR(reg))
> 		regulator_disable(reg);

So now the reg will be disabled before the user space interfaces have gone away?

I wondered about a similar patch when the alloc patches turned up and concluded that there were too many cases like this to make it a good idea...

> 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
