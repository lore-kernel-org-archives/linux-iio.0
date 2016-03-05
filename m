Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56751 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbcCERkO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 12:40:14 -0500
Subject: Re: [PATCH 4/4] iio: mma8452: add low_power mode
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
 <1456993444-21320-5-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB19FA.8090403@kernel.org>
Date: Sat, 5 Mar 2016 17:40:10 +0000
MIME-Version: 1.0
In-Reply-To: <1456993444-21320-5-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 08:24, Martin Kepplinger wrote:
> This adds a mode of operation that consumes less power by lesser
> oversampling. It's exposed in IIO sysfs as in_accelX_power_mode, as
> documented.
> 
> It consumes roughly half the power the default low_noise mode does.
> See the datasheet for details.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
This is in the datasheet as oversampling.  So why are we not using the oversampling
interface rather than adding a new one?

It's obvious that with the interactions with sampling rate that this won't be trivial
to support, but it doesn't look that hard.  For a given sampling_frequency only
certain oversampling rations are possible, but that's not exactly unusual.

That way everything is explicit, whereas with this approach people will need to
read the datasheet to know if setting the power mode is having any effect at all.

That will also allow appropriate trade offs to use the low noise / low power version
if the oversampling ratio is appropriate.  All this stuff is clearly given in 
table 59 of the datasheet google gave me.
(actually as control mechanisms go for this sort of setting I think this one is
reasonably elegant as such hardware goes!)

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 5ca0d16..5b5abec 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -75,6 +75,9 @@
>  #define  MMA8452_CTRL_DR_DEFAULT		0x4 /* 50 Hz sample frequency */
>  #define MMA8452_CTRL_REG2			0x2b
>  #define  MMA8452_CTRL_REG2_RST			BIT(6)
> +#define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
> +#define  MMA8452_CTRL_REG2_MODS_NORMAL		0x00
> +#define  MMA8452_CTRL_REG2_MODS_LOW_POWER	0x1b
>  #define MMA8452_CTRL_REG4			0x2d
>  #define MMA8452_CTRL_REG5			0x2e
>  #define MMA8452_OFF_X				0x2f
> @@ -950,6 +953,56 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.attrs = mma8452_event_attributes,
>  };
>  
> +static const char * const mma8452_power_modes[] = {"low_noise", "low_power"};
> +
> +static int mma8452_get_power_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(data->client,
> +				       MMA8452_CTRL_REG2);
> +	if (reg < 0)
> +		return reg;
> +
> +	return !(reg & MMA8452_CTRL_REG2_MODS_MASK);
> +}
> +
> +static int mma8452_set_power_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int mode)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(data->client,
> +				       MMA8452_CTRL_REG2);
> +	if (reg < 0)
> +		return reg;
> +
> +	reg &= ~MMA8452_CTRL_REG2_MODS_MASK;
> +	if (mode)
> +		reg |= MMA8452_CTRL_REG2_MODS_LOW_POWER;
> +	else
> +		reg |= MMA8452_CTRL_REG2_MODS_NORMAL;
> +
> +	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
> +}
> +
> +static const struct iio_enum mma8452_power_mode_enum = {
> +	.items = mma8452_power_modes,
> +	.num_items = ARRAY_SIZE(mma8452_power_modes),
> +	.get = mma8452_get_power_mode,
> +	.set = mma8452_set_power_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info mma8452_ext_info[] = {
> +	IIO_ENUM("power_mode", true, &mma8452_power_mode_enum),
> +	IIO_ENUM_AVAILABLE("power_mode", &mma8452_power_mode_enum),
> +	{ },
> +};
> +
>  #define MMA8452_FREEFALL_CHANNEL(modifier) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -987,6 +1040,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	}, \
>  	.event_spec = mma8452_transient_event, \
>  	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
> +	.ext_info = mma8452_ext_info, \
>  }
>  
>  #define MMA8652_CHANNEL(axis, idx, bits) { \
> @@ -1007,6 +1061,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	}, \
>  	.event_spec = mma8452_motion_event, \
>  	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
> +	.ext_info = mma8452_ext_info, \
>  }
>  
>  static const struct iio_chan_spec mma8451_channels[] = {
> 

