Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54120 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab2EOHyy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 03:54:54 -0400
Message-ID: <4FB20BCD.9000401@cam.ac.uk>
Date: Tue, 15 May 2012 08:54:53 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio:dac:ad5791: Use strtobool for boolean
 values
References: <1337068365-23971-1-git-send-email-lars@metafoo.de> <1337068365-23971-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1337068365-23971-3-git-send-email-lars@metafoo.de>
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
>   drivers/staging/iio/dac/ad5791.c |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
> index 4e955ed..82b51a7 100644
> --- a/drivers/staging/iio/dac/ad5791.c
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -114,25 +114,23 @@ static ssize_t ad5791_write_dac_powerdown(struct iio_dev *indio_dev,
>   	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
>   	 size_t len)
>   {
> -	long readin;
> +	bool pwr_down;
>   	int ret;
>   	struct ad5791_state *st = iio_priv(indio_dev);
>
> -	ret = strict_strtol(buf, 10,&readin);
> +	ret = strtobool(buf,&pwr_down);
>   	if (ret)
>   		return ret;
>
> -	if (readin == 0) {
> -		st->pwr_down = false;
> +	if (!pwr_down) {
>   		st->ctrl&= ~(AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
> -	} else if (readin == 1) {
> -		st->pwr_down = true;
> +	} else {
>   		if (st->pwr_down_mode == AD5791_DAC_PWRDN_6K)
>   			st->ctrl |= AD5791_CTRL_OPGND;
>   		else if (st->pwr_down_mode == AD5791_DAC_PWRDN_3STATE)
>   			st->ctrl |= AD5791_CTRL_DACTRI;
> -	} else
> -		ret = -EINVAL;
> +	}
> +	st->pwr_down = pwr_down;
>
>   	ret = ad5791_spi_write(st->spi, AD5791_ADDR_CTRL, st->ctrl);
>

