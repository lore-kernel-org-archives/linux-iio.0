Return-Path: <SRS0=f3yP=NF=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
To: Renato Lui Geh <renatogeh@gmail.com>, Michael.Hennerich@analog.com,
 jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
 stefan.popa@analog.com, giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
Date: Thu, 25 Oct 2018 15:38:35 +0200
MIME-Version: 1.0
In-Reply-To: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 10/25/2018 03:32 PM, Renato Lui Geh wrote:
> The ad7780 driver previously did not read the correct device output.
> This patch fixes two issues.
> 
> - The driver read an outdated value set at initialization. It now
> updates its voltage on read.
> - Variable val subtracted an uninitialized value on
> IIO_CHAN_INFO_OFFSET. This was fixed by assiging the correct value
> instead.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>

Hi,

Thanks for the patch, this looks good.

But please create one patch per issue and do not put unrelated changes into
the same patch.

Also your mail client seems to have replaced tabs in the patch with spaces,
this means the patch will not apply cleanly. Check the
Documentation/email-clients.txt file for some hints how to configure your
mail client so it will not break patches.

- Lars

> ---
> drivers/staging/iio/adc/ad7780.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c
> b/drivers/staging/iio/adc/ad7780.c
> index b67412db0318..06700fe554a2 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -87,16 +87,20 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>                long m)
> {
>     struct ad7780_state *st = iio_priv(indio_dev);
> +    int voltage_uv = 0;
> 
>     switch (m) {
>     case IIO_CHAN_INFO_RAW:
>         return ad_sigma_delta_single_conversion(indio_dev, chan, val);
>     case IIO_CHAN_INFO_SCALE:
> +        voltage_uv = regulator_get_voltage(st->reg);
> +        if (voltage_uv)
> +            st->int_vref_mv = voltage_uv/1000;
>         *val = st->int_vref_mv * st->gain;
>         *val2 = chan->scan_type.realbits - 1;
>         return IIO_VAL_FRACTIONAL_LOG2;
>     case IIO_CHAN_INFO_OFFSET:
> -        *val -= (1 << (chan->scan_type.realbits - 1));
> +        *val = -(1 << (chan->scan_type.realbits - 1));
>         return IIO_VAL_INT;
>     }
> 
