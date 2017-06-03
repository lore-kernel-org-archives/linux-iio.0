Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdFCIaZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:30:25 -0400
Date: Sat, 3 Jun 2017 09:30:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, vz@mleia.com,
        slemieux.tyco@gmail.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:adc:lpc32xx Handle return value of
 clk_prepare_enable
Message-ID: <20170603093019.3cfa04b5@kernel.org>
In-Reply-To: <e54764708d74134ef1f5b3566b2d4d3ab4187b45.1496045161.git.arvind.yadav.cs@gmail.com>
References: <e54764708d74134ef1f5b3566b2d4d3ab4187b45.1496045161.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 30 May 2017 16:35:27 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/lpc32xx_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 0de709b..6a5b9a9 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -76,10 +76,14 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
> -
> +	int ret;
>  	if (mask == IIO_CHAN_INFO_RAW) {
>  		mutex_lock(&indio_dev->mlock);
> -		clk_prepare_enable(st->clk);
> +		ret = clk_prepare_enable(st->clk);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
>  		/* Measurement setup */
>  		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
>  			     LPC32XXAD_REFp | LPC32XXAD_REFm,

