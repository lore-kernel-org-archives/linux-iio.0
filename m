Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58630 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbJYLOt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 07:14:49 -0400
Subject: Re: [PATCH v3 1/2] iio:ad5064: Structural changes to support LTC2617
To: Marc Andre <marc.andre@netline.ch>
References: <1445488471-16568-1-git-send-email-marc.andre@netline.ch>
 <1445488471-16568-2-git-send-email-marc.andre@netline.ch>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CB9A4.1030805@kernel.org>
Date: Sun, 25 Oct 2015 11:14:44 +0000
MIME-Version: 1.0
In-Reply-To: <1445488471-16568-2-git-send-email-marc.andre@netline.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/10/15 05:34, Marc Andre wrote:
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
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Really trivial point inline.  If you find a formatting issue
(81 char line here) please fix it in a precursor patch rather than
as you happen to go by it.  That makes for a trivial patch, but
then ensures there is no 'noise' cluttering up the real work.

Applied to the togreg branch of iio.git - initially pushed out as testing.
Note that due to my day job silly week, this missed the merge window for
this cycle.  Sorry about that. Next pull request to Greg and hence hitting
linux next will be after rc1.

Jonathan
> ---
>  drivers/iio/dac/ad5064.c | 67 +++++++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 978f130..3bb0312 100644
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
I'm guessing this just tripped the 80 character limit. Ideally this would have
been a precursor patch as it has nothing to with the changes here.  
>   * @channel:		channel specification
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

