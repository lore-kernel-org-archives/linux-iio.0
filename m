Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3CBQXY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:23:24 -0500
Message-ID: <5132277A.5040304@kernel.org>
Date: Sat, 02 Mar 2013 16:23:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio:ad5064: Fix address of the second channel for
 ad5065/ad5045/ad5025
References: <1362143239-891-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1362143239-891-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 01:07 PM, Lars-Peter Clausen wrote:
> The ad5065, ad5045, ad5025 use address '3' for the second channel, so they need
> their own channel spec.
Obviously! (another candidate for weird hardware designer of the day :)
> 
> Note that ad5064_sync_powerdown_mode() also needs to be slightly updated since
> it was relying on the fact that chan->address always equaled chan->channel.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied to fixes-togreg branch of iio.git

> ---
>  drivers/iio/dac/ad5064.c | 49 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index eb281a2..e19b73f 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -27,7 +27,6 @@
>  #define AD5064_ADDR(x)				((x) << 20)
>  #define AD5064_CMD(x)				((x) << 24)
>  
> -#define AD5064_ADDR_DAC(chan)			(chan)
>  #define AD5064_ADDR_ALL_DAC			0xF
>  
>  #define AD5064_CMD_WRITE_INPUT_N		0x0
> @@ -131,15 +130,15 @@ static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
>  }
>  
>  static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
> -	unsigned int channel)
> +	const struct iio_chan_spec *chan)
>  {
>  	unsigned int val;
>  	int ret;
>  
> -	val = (0x1 << channel);
> +	val = (0x1 << chan->address);
>  
> -	if (st->pwr_down[channel])
> -		val |= st->pwr_down_mode[channel] << 8;
> +	if (st->pwr_down[chan->channel])
> +		val |= st->pwr_down_mode[chan->channel] << 8;
>  
>  	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, 0, val, 0);
>  
> @@ -169,7 +168,7 @@ static int ad5064_set_powerdown_mode(struct iio_dev *indio_dev,
>  	mutex_lock(&indio_dev->mlock);
>  	st->pwr_down_mode[chan->channel] = mode + 1;
>  
> -	ret = ad5064_sync_powerdown_mode(st, chan->channel);
> +	ret = ad5064_sync_powerdown_mode(st, chan);
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	return ret;
> @@ -205,7 +204,7 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
>  	mutex_lock(&indio_dev->mlock);
>  	st->pwr_down[chan->channel] = pwr_down;
>  
> -	ret = ad5064_sync_powerdown_mode(st, chan->channel);
> +	ret = ad5064_sync_powerdown_mode(st, chan);
>  	mutex_unlock(&indio_dev->mlock);
>  	return ret ? ret : len;
>  }
> @@ -292,34 +291,44 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
>  	{ },
>  };
>  
> -#define AD5064_CHANNEL(chan, bits) {				\
> +#define AD5064_CHANNEL(chan, addr, bits) {			\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.output = 1,						\
>  	.channel = (chan),					\
>  	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
>  	IIO_CHAN_INFO_SCALE_SEPARATE_BIT,			\
> -	.address = AD5064_ADDR_DAC(chan),			\
> +	.address = addr,					\
>  	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits)),	\
>  	.ext_info = ad5064_ext_info,				\
>  }
>  
>  #define DECLARE_AD5064_CHANNELS(name, bits) \
>  const struct iio_chan_spec name[] = { \
> -	AD5064_CHANNEL(0, bits), \
> -	AD5064_CHANNEL(1, bits), \
> -	AD5064_CHANNEL(2, bits), \
> -	AD5064_CHANNEL(3, bits), \
> -	AD5064_CHANNEL(4, bits), \
> -	AD5064_CHANNEL(5, bits), \
> -	AD5064_CHANNEL(6, bits), \
> -	AD5064_CHANNEL(7, bits), \
> +	AD5064_CHANNEL(0, 0, bits), \
> +	AD5064_CHANNEL(1, 1, bits), \
> +	AD5064_CHANNEL(2, 2, bits), \
> +	AD5064_CHANNEL(3, 3, bits), \
> +	AD5064_CHANNEL(4, 4, bits), \
> +	AD5064_CHANNEL(5, 5, bits), \
> +	AD5064_CHANNEL(6, 6, bits), \
> +	AD5064_CHANNEL(7, 7, bits), \
> +}
> +
> +#define DECLARE_AD5065_CHANNELS(name, bits) \
> +const struct iio_chan_spec name[] = { \
> +	AD5064_CHANNEL(0, 0, bits), \
> +	AD5064_CHANNEL(1, 3, bits), \
>  }
>  
>  static DECLARE_AD5064_CHANNELS(ad5024_channels, 12);
>  static DECLARE_AD5064_CHANNELS(ad5044_channels, 14);
>  static DECLARE_AD5064_CHANNELS(ad5064_channels, 16);
>  
> +static DECLARE_AD5065_CHANNELS(ad5025_channels, 12);
> +static DECLARE_AD5065_CHANNELS(ad5045_channels, 14);
> +static DECLARE_AD5065_CHANNELS(ad5065_channels, 16);
> +
>  static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  	[ID_AD5024] = {
>  		.shared_vref = false,
> @@ -328,7 +337,7 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  	},
>  	[ID_AD5025] = {
>  		.shared_vref = false,
> -		.channels = ad5024_channels,
> +		.channels = ad5025_channels,
>  		.num_channels = 2,
>  	},
>  	[ID_AD5044] = {
> @@ -338,7 +347,7 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  	},
>  	[ID_AD5045] = {
>  		.shared_vref = false,
> -		.channels = ad5044_channels,
> +		.channels = ad5045_channels,
>  		.num_channels = 2,
>  	},
>  	[ID_AD5064] = {
> @@ -353,7 +362,7 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  	},
>  	[ID_AD5065] = {
>  		.shared_vref = false,
> -		.channels = ad5064_channels,
> +		.channels = ad5065_channels,
>  		.num_channels = 2,
>  	},
>  	[ID_AD5628_1] = {
> 
