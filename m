Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbeJIDWC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Oct 2018 23:22:02 -0400
Date: Mon, 8 Oct 2018 21:08:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Coffey <cmc@babblebit.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp4922: Add powerdown support
Message-ID: <20181008210829.41cc106f@archlinux>
In-Reply-To: <20181003090638.25111-1-cmc@babblebit.net>
References: <20181003090638.25111-1-cmc@babblebit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  3 Oct 2018 10:06:38 +0100
Chris Coffey <cmc@babblebit.net> wrote:

> This patch adds support for per-channel powerdown on the Microchip MCP
> 4902/4912/4922 family of DACs.
> 
> Signed-off-by: Chris Coffey <cmc@babblebit.net>
Hi Chris, 

Welcome to IIO.  There are a few interesting questions raised by
this inline.  I'm not totally sure on the 'right' answer for the question
of whether a value write on a DAC should bring the device out of power down.
I think that isn't what most drivers do, but I could be wrong on this.

I would like to get others opinion before we document the preferred option
one way or the other.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4922.c | 126 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 110 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index b5190d1dae..15cd17aa9d 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -28,6 +28,9 @@
>  
>  #define MCP4922_NUM_CHANNELS	2
>  
> +#define MCP4922_OUTA_POWER_DOWN	0x20
> +#define MCP4922_OUTB_POWER_DOWN	0xa0
> +
>  enum mcp4922_supported_device_ids {
>  	ID_MCP4902,
>  	ID_MCP4912,
> @@ -37,26 +40,13 @@ enum mcp4922_supported_device_ids {
>  struct mcp4922_state {
>  	struct spi_device *spi;
>  	unsigned int value[MCP4922_NUM_CHANNELS];
> +	bool powerdown[MCP4922_NUM_CHANNELS];
> +	unsigned int powerdown_mode;
>  	unsigned int vref_mv;
>  	struct regulator *vref_reg;
>  	u8 mosi[2] ____cacheline_aligned;
>  };
>  
> -#define MCP4922_CHAN(chan, bits) {			\
> -	.type = IIO_VOLTAGE,				\
> -	.output = 1,					\
> -	.indexed = 1,					\
> -	.channel = chan,				\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> -	.scan_type = {					\
> -		.sign = 'u',				\
> -		.realbits = (bits),			\
> -		.storagebits = 16,			\
> -		.shift = 12 - (bits),			\
> -	},						\
> -}
> -
>  static int mcp4922_spi_write(struct mcp4922_state *state, u8 addr, u32 val)
>  {
>  	state->mosi[1] = val & 0xff;
> @@ -106,8 +96,10 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  		val <<= chan->scan_type.shift;
>  
>  		ret = mcp4922_spi_write(state, chan->channel, val);
> -		if (!ret)
> +		if (!ret) {
>  			state->value[chan->channel] = val;
> +			state->powerdown[chan->channel] = false;
That's interesting.  I'm not sure we have any consistency of interface
around whether a write to the value when powered down results in the device
powering up or not.  It certainly feels like we should be consistent on this
and document it.

I checked the first random driver I found the ad5360 and it appears to
have the powerdown on the front end in some sense in that there is a
specific bit to clear in order to power up again and it is not done
by changing the current value.

To my mind that is the more logical option, but I'd like others opinions
on this.

If that is the consensus then in here you'll need to put a copy
of the value somewhere to be set only when we try to come out of powerdown.
You already do have such a cache for coming out of powerdown by
writing 0 the powerdown enable so not hard to extend to this.

> +		}
>  		return ret;
>  
>  	default:
> @@ -115,6 +107,108 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static const char * const mcp4922_powerdown_modes[] = {
> +	"500kohm_to_gnd"
> +};
> +
> +static int mcp4922_get_powerdown_mode(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct mcp4922_state *state = iio_priv(indio_dev);
> +
> +	return state->powerdown_mode;
> +}
> +
> +static int mcp4922_set_powerdown_mode(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					unsigned int mode)
> +{
> +	struct mcp4922_state *state = iio_priv(indio_dev);
> +
> +	state->powerdown_mode = mode;
It's a little unusual to have an enum specified with just
one value.. I can see the advantage in terms of this looking
like every other powerdown mode control.

I don't suppose it hurts though.   Seems a little pointless
to have this set function actually do anything though...

Also no really point in having the get actually read the value.

So I would just provide a stub for this that returns the
same value ever time and nothing at all for the set.

It's an odd enough corner case that it is probably not worth
making the enum code allow for no set function.

> +
> +	return 0;
> +}
> +
> +static ssize_t mcp4922_read_powerdown(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	struct mcp4922_state *state = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", state->powerdown[chan->channel]);
> +}
> +
> +static ssize_t mcp4922_write_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct mcp4922_state *state = iio_priv(indio_dev);
> +	bool powerdown;
> +	int ret;
> +
> +	ret = strtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	if (powerdown) {
> +		state->mosi[0] = (chan->channel == 0) ?
> +				MCP4922_OUTA_POWER_DOWN :
> +				MCP4922_OUTB_POWER_DOWN;
> +		state->mosi[1] = 0x00;
> +
> +		ret = spi_write(state->spi, state->mosi, 2);
> +	} else {
> +		/* Restore previous voltage level */
> +		ret = mcp4922_write_raw(indio_dev, chan,
> +					state->value[chan->channel], 0,
> +					IIO_CHAN_INFO_RAW);
> +	}
> +	if (!ret)
> +		state->powerdown[chan->channel] = powerdown;
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_enum mcp4922_powerdown_mode_enum = {
> +	.items = mcp4922_powerdown_modes,
> +	.num_items = ARRAY_SIZE(mcp4922_powerdown_modes),
> +	.get = mcp4922_get_powerdown_mode,
> +	.set = mcp4922_set_powerdown_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info mcp4922_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = mcp4922_read_powerdown,
> +		.write = mcp4922_write_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			&mcp4922_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode",
> +			&mcp4922_powerdown_mode_enum),
> +	{ },
> +};
> +
> +#define MCP4922_CHAN(chan, bits) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.output = 1,					\
> +	.indexed = 1,					\
> +	.channel = chan,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.scan_type = {					\
> +		.sign = 'u',				\
> +		.realbits = (bits),			\
> +		.storagebits = 16,			\
> +		.shift = 12 - (bits),			\
> +	},						\
> +	.ext_info = mcp4922_ext_info,			\
> +}
> +
>  static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
>  	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
>  	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
