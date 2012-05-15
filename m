Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53871 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324Ab2EOHy1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 03:54:27 -0400
Message-ID: <4FB20BB1.3000404@cam.ac.uk>
Date: Tue, 15 May 2012 08:54:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio:dac:ad5504: Use strtobool for boolean
 values
References: <1337068365-23971-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1337068365-23971-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/15/2012 8:52 AM, Lars-Peter Clausen wrote:
> Use strtobool for parsing the powerdown value instead of strict_strtol, since
> the powerdown attribute is a boolean value.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/ad5504.c |   10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
> index 25a04d3..6ccf178 100644
> --- a/drivers/staging/iio/dac/ad5504.c
> +++ b/drivers/staging/iio/dac/ad5504.c
> @@ -147,20 +147,18 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
>   	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
>   	size_t len)
>   {
> -	long readin;
> +	bool pwr_down;
>   	int ret;
>   	struct ad5504_state *st = iio_priv(indio_dev);
>
> -	ret = strict_strtol(buf, 10,&readin);
> +	ret = strtobool(buf,&pwr_down);
>   	if (ret)
>   		return ret;
>
> -	if (readin == 0)
> +	if (pwr_down)
>   		st->pwr_down_mask |= (1<<  chan->channel);
> -	else if (readin == 1)
> -		st->pwr_down_mask&= ~(1<<  chan->channel);
>   	else
> -		ret = -EINVAL;
> +		st->pwr_down_mask&= ~(1<<  chan->channel);
>
>   	ret = ad5504_spi_write(st->spi, AD5504_ADDR_CTRL,
>   				AD5504_DAC_PWRDWN_MODE(st->pwr_down_mode) |

