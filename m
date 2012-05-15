Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53312 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583Ab2EOHxU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 03:53:20 -0400
Message-ID: <4FB20B6E.1070503@cam.ac.uk>
Date: Tue, 15 May 2012 08:53:18 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:dac:ad5504: Check if IRQ was requested before
 freeing it
References: <1337068288-23809-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1337068288-23809-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/15/2012 8:51 AM, Lars-Peter Clausen wrote:
> IRQ support is optional, so we have to check whether it was actually requested
> before we attempt to free it.
good spot.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/ad5504.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
> index 6ccf178..cd754d2 100644
> --- a/drivers/staging/iio/dac/ad5504.c
> +++ b/drivers/staging/iio/dac/ad5504.c
> @@ -294,7 +294,8 @@ static int __devinit ad5504_probe(struct spi_device *spi)
>   	return 0;
>
>   error_free_irq:
> -	free_irq(spi->irq, indio_dev);
> +	if (spi->irq)
> +		free_irq(spi->irq, indio_dev);
>   error_disable_reg:
>   	if (!IS_ERR(reg))
>   		regulator_disable(reg);

