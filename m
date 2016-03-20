Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57024 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbcCTLd0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 07:33:26 -0400
Subject: Re: [PATCH] iio: potentiometer: tpl0102: add hi-z enable/disable
 support
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>
References: <1457937284-16318-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE8A83.2060801@kernel.org>
Date: Sun, 20 Mar 2016 11:33:23 +0000
MIME-Version: 1.0
In-Reply-To: <1457937284-16318-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/16 06:34, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
I've been ignoring this a few days as it looked fiddly :) 
> ---
>  drivers/iio/potentiometer/tpl0102.c | 43 ++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
> index 313124b..1413419c 100644
> --- a/drivers/iio/potentiometer/tpl0102.c
> +++ b/drivers/iio/potentiometer/tpl0102.c
> @@ -12,8 +12,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
> - *
> - * TODO: enable/disable hi-z output control
>   */
>  
>  #include <linux/module.h>
> @@ -39,7 +37,7 @@ static const struct tpl0102_cfg tpl0102_cfg[] = {
>  	[CAT5140_503] = { .wipers = 1, .max_pos = 256, .kohms = 50, },
>  	[CAT5140_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
>  	/* ti parts */
> -	[TPL0102_104] = { .wipers = 2, .max_pos = 256, .kohms = 100 },
> +	[TPL0102_104] = { .wipers = 3, .max_pos = 256, .kohms = 100 },
>  	[TPL0401_103] = { .wipers = 1, .max_pos = 128, .kohms = 10, },
>  };
>  
> @@ -65,6 +63,15 @@ static const struct regmap_config tpl0102_regmap_config = {
>  static const struct iio_chan_spec tpl0102_channels[] = {
>  	TPL0102_CHANNEL(0),
>  	TPL0102_CHANNEL(1),
> +	/* hi-z enable/disable */
> +	{
> +		.type = IIO_RESISTANCE,
> +		.output = 1,
> +		.address = 0x10,
> +		.channel = BIT(6),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	}
I'm confused as to what this actually is...  What is the result on the output value of
doing this and does it apply to all other channels?  As far as I can tell this cuts
off the upper voltage by opening a switch.  Upshot is that you end up with just resistance
between the output and the low voltage rather than a potentiometer. So it becomes an
rheostat between the wiper output and the other end...

That's not remotely clear from the interface you have here unfortunately.

Mind you I'm open to ideas on how to support this!
>  };
>  
>  static int tpl0102_read_raw(struct iio_dev *indio_dev,
> @@ -72,13 +79,20 @@ static int tpl0102_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct tpl0102_data *data = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_RAW: {
> -		int ret = regmap_read(data->regmap, chan->channel, val);
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret = regmap_read(data->regmap, chan->address, val);
> +
> +		if (!ret)
> +			*val = !!(*val & chan->channel);
> +
> +		return ret ? ret : IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(data->regmap, chan->channel, val);
>  
>  		return ret ? ret : IIO_VAL_INT;
> -	}
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 1000 * tpl0102_cfg[data->devid].kohms;
>  		*val2 = tpl0102_cfg[data->devid].max_pos;
> @@ -94,13 +108,18 @@ static int tpl0102_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct tpl0102_data *data = iio_priv(indio_dev);
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> -
> -	if (val >= tpl0102_cfg[data->devid].max_pos || val < 0)
> -		return -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		return regmap_update_bits(data->regmap, chan->address,
> +					  chan->channel,
> +					  !!val ? chan->channel : 0);
> +	case IIO_CHAN_INFO_RAW:
> +		if (val >= tpl0102_cfg[data->devid].max_pos || val < 0)
> +			return -EINVAL;
> +		return regmap_write(data->regmap, chan->channel, val);
> +	}
>  
> -	return regmap_write(data->regmap, chan->channel, val);
> +	return -EINVAL;
>  }
>  
>  static const struct iio_info tpl0102_info = {
> 

