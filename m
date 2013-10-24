Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35568 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab3JXMnk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:43:40 -0400
Message-ID: <52692436.40207@kernel.org>
Date: Thu, 24 Oct 2013 14:44:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/9] iio: accel: kxsd9: Remove redundant variable
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> Return directly thereby eliminating an intermediate variable.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/accel/kxsd9.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 709c132..d72118d 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -222,7 +222,6 @@ static int kxsd9_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct kxsd9_state *st;
> -	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -244,11 +243,7 @@ static int kxsd9_probe(struct spi_device *spi)
>  	spi_setup(spi);
>  	kxsd9_power_up(st);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int kxsd9_remove(struct spi_device *spi)
> 
