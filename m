Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeJ2AlQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 20:41:16 -0400
Date: Sun, 28 Oct 2018 15:56:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Renato Lui Geh <renatogeh@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181028155611.67abeafb@archlinux>
In-Reply-To: <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
References: <cover.1540506298.git.renatogeh@gmail.com>
        <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 19:30:04 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> The ad7780 driver previously did not read the correct device output, as
> it read an outdated value set at initialization. It now updates its
> voltage on read.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7780.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index b67412db0318..27972563bb6a 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -87,11 +87,15 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7780_state *st = iio_priv(indio_dev);
> +	int voltage_uv = 0;
No initialization needed as it is always set in the paths where it is used
(before it is used).
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
>  	case IIO_CHAN_INFO_SCALE:
> +		voltage_uv = regulator_get_voltage(st->reg);
> +		if (voltage_uv)
> +			st->int_vref_mv = voltage_uv/1000;
>  		*val = st->int_vref_mv * st->gain;
Is there actually a reason (now) to have the stashed value
of int_vref_mv in the state structure?

Also, I think we are always replacing the value that is retrieved
in probe so we can drop reading it there as well.

Thanks,

Jonathan

>  		*val2 = chan->scan_type.realbits - 1;
>  		return IIO_VAL_FRACTIONAL_LOG2;
