Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 8 Feb 2016 19:16:49 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio:ad5064: Structural changes to support LTC2617
In-Reply-To: <1454950910-26049-1-git-send-email-lars@metafoo.de>
Message-ID: <alpine.DEB.2.02.1602081915280.22739@pmeerw.net>
References: <1454950910-26049-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Mon, 8 Feb 2016, Lars-Peter Clausen wrote:

> From: Marc Andre <marc.andre@netline.ch>
> 
> This patch makes minor structural changes to support specifics
> for LTC2617 DAC. This DAC requires different handling of the
> power down modes. The configuration to actually support the
> DAC will be submitted in a secondary patch.
> 
> Adjust the DECLARE_AD5064_CHANNELS() macro to accept a new
> ext_info parameter. This allows to use different power down
> modes per DAC. (e.g. DAC only support 90kohm to ground)
> 
> Add the chip_info parameter "powerdown_ltc". This parameter is
> used in the ad5064_sync_powerdown_mode() function to handle the
> power down command for LTC diffently. For those devices the
> power down command must be addressed to the channel.
> 
> Signed-off-by: Marc Andre <marc.andre@netline.ch>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Took the liberty to rebase this onto the latest iio/testing branch
> ---
>  drivers/iio/dac/ad5064.c | 67 +++++++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 81ca008..c55282d 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -50,10 +50,12 @@
>  /**
>   * struct ad5064_chip_info - chip specific information
>   * @shared_vref:	whether the vref supply is shared between channels
> - * @internal_vref:	internal reference voltage. 0 if the chip has no internal
> - *			vref.
> + * @internal_vref:	internal reference voltage. 0 if the chip has no
> +			internal vref.
>   * @channel:		channel specification

unrelated, but should be channels

>   * @num_channels:	number of channels
> + * @powerdown_ltc:	Use alternative power down addressing as required by
> + *			ltc2617 and others.
>   */
>  
>  struct ad5064_chip_info {
> @@ -61,6 +63,7 @@ struct ad5064_chip_info {
>  	unsigned long internal_vref;
>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
> +	bool powerdown_ltc;
>  };
>  
>  struct ad5064_state;
> @@ -136,15 +139,21 @@ static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
>  static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
>  	const struct iio_chan_spec *chan)
>  {
> -	unsigned int val;
> +	unsigned int val, address;
>  	int ret;
>  
> -	val = (0x1 << chan->address);
> +	if (st->chip_info->powerdown_ltc) {
> +		val = 0;
> +		address = chan->address;
> +	} else {
> +		address = 0;
> +		val = (0x1 << chan->address);
>  
> -	if (st->pwr_down[chan->channel])
> -		val |= st->pwr_down_mode[chan->channel] << 8;
> +		if (st->pwr_down[chan->channel])
> +			val |= st->pwr_down_mode[chan->channel] << 8;
> +	}
>  
> -	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, 0, val, 0);
> +	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, address, val, 0);
>  
>  	return ret;
>  }
> @@ -295,7 +304,7 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
>  	{ },
>  };
>  
> -#define AD5064_CHANNEL(chan, addr, bits, _shift) {		\
> +#define AD5064_CHANNEL(chan, addr, bits, _shift, _ext_info) {		\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.output = 1,						\
> @@ -309,37 +318,37 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
>  		.storagebits = 16,				\
>  		.shift = (_shift),				\
>  	},							\
> -	.ext_info = ad5064_ext_info,				\
> +	.ext_info = (_ext_info),				\
>  }
>  
> -#define DECLARE_AD5064_CHANNELS(name, bits, shift) \
> +#define DECLARE_AD5064_CHANNELS(name, bits, shift, ext_info) \
>  const struct iio_chan_spec name[] = { \
> -	AD5064_CHANNEL(0, 0, bits, shift), \
> -	AD5064_CHANNEL(1, 1, bits, shift), \
> -	AD5064_CHANNEL(2, 2, bits, shift), \
> -	AD5064_CHANNEL(3, 3, bits, shift), \
> -	AD5064_CHANNEL(4, 4, bits, shift), \
> -	AD5064_CHANNEL(5, 5, bits, shift), \
> -	AD5064_CHANNEL(6, 6, bits, shift), \
> -	AD5064_CHANNEL(7, 7, bits, shift), \
> +	AD5064_CHANNEL(0, 0, bits, shift, ext_info), \
> +	AD5064_CHANNEL(1, 1, bits, shift, ext_info), \
> +	AD5064_CHANNEL(2, 2, bits, shift, ext_info), \
> +	AD5064_CHANNEL(3, 3, bits, shift, ext_info), \
> +	AD5064_CHANNEL(4, 4, bits, shift, ext_info), \
> +	AD5064_CHANNEL(5, 5, bits, shift, ext_info), \
> +	AD5064_CHANNEL(6, 6, bits, shift, ext_info), \
> +	AD5064_CHANNEL(7, 7, bits, shift, ext_info), \
>  }
>  
> -#define DECLARE_AD5065_CHANNELS(name, bits, shift) \
> +#define DECLARE_AD5065_CHANNELS(name, bits, shift, ext_info) \
>  const struct iio_chan_spec name[] = { \
> -	AD5064_CHANNEL(0, 0, bits, shift), \
> -	AD5064_CHANNEL(1, 3, bits, shift), \
> +	AD5064_CHANNEL(0, 0, bits, shift, ext_info), \
> +	AD5064_CHANNEL(1, 3, bits, shift, ext_info), \
>  }
>  
> -static DECLARE_AD5064_CHANNELS(ad5024_channels, 12, 8);
> -static DECLARE_AD5064_CHANNELS(ad5044_channels, 14, 6);
> -static DECLARE_AD5064_CHANNELS(ad5064_channels, 16, 4);
> +static DECLARE_AD5064_CHANNELS(ad5024_channels, 12, 8, ad5064_ext_info);
> +static DECLARE_AD5064_CHANNELS(ad5044_channels, 14, 6, ad5064_ext_info);
> +static DECLARE_AD5064_CHANNELS(ad5064_channels, 16, 4, ad5064_ext_info);
>  
> -static DECLARE_AD5065_CHANNELS(ad5025_channels, 12, 8);
> -static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6);
> -static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4);
> +static DECLARE_AD5065_CHANNELS(ad5025_channels, 12, 8, ad5064_ext_info);
> +static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6, ad5064_ext_info);
> +static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4, ad5064_ext_info);
>  
> -static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4);
> -static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0);
> +static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4, ad5064_ext_info);
> +static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0, ad5064_ext_info);
>  
>  static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  	[ID_AD5024] = {
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
