Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58657 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbbJYLTT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 07:19:19 -0400
Subject: Re: [PATCH v3 2/2] iio:ad5064: Add support for ltc2617 and similar
 devices
To: Marc Andre <marc.andre@netline.ch>
References: <1445488471-16568-1-git-send-email-marc.andre@netline.ch>
 <1445488471-16568-3-git-send-email-marc.andre@netline.ch>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CBAB6.7020806@kernel.org>
Date: Sun, 25 Oct 2015 11:19:18 +0000
MIME-Version: 1.0
In-Reply-To: <1445488471-16568-3-git-send-email-marc.andre@netline.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/10/15 05:34, Marc Andre wrote:
> The Linear Technology LTC2606, LTC2607, LTC2609, LTC2616, LTC2617,
> LTC2619, LTC2626, LTC2627 and LTC2629 devices are very similar
> to the AD5064 device.
> 
> This patch adds support for those devices.
> 
> Datasheet for LTC devices:
> LTC2606, LTC2616, LTC2626: http://www.linear.com/docs/6398
> LTC2607, LTC2617, LTC2627: http://www.linear.com/docs/8977
> LTC2709, LTC2619, LTC2629: http://www.linear.com/docs/8477
> 
> Signed-off-by: Marc Andre <marc.andre@netline.ch>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Queued up for when the prerequisits make it in.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   1 +
>  drivers/iio/dac/ad5064.c                | 112 +++++++++++++++++++++++++++++++-
>  2 files changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 42d360f..3e8b778 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -496,6 +496,7 @@ Description:
>  		1kohm_to_gnd: connected to ground via an 1kOhm resistor,
>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
> +		90kohm_to_gnd: connected to ground via a 90kOhm resistor,
>  		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
>  		500kohm_to_gnd: connected to ground via a 500kOhm resistor,
>  		three_state: left floating.
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 3bb0312..1b89625 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -1,6 +1,8 @@
>  /*
>   * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R,
> - * AD5648, AD5666, AD5668, AD5669R Digital to analog converters driver
> + * AD5648, AD5666, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
> + * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to analog converters
> + * driver
>   *
>   * Copyright 2011 Analog Devices Inc.
>   *
> @@ -126,6 +128,15 @@ enum ad5064_type {
>  	ID_AD5668_2,
>  	ID_AD5669_1,
>  	ID_AD5669_2,
> +	ID_LTC2606,
> +	ID_LTC2607,
> +	ID_LTC2609,
> +	ID_LTC2616,
> +	ID_LTC2617,
> +	ID_LTC2619,
> +	ID_LTC2626,
> +	ID_LTC2627,
> +	ID_LTC2629,
>  };
>  
>  static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
> @@ -164,6 +175,10 @@ static const char * const ad5064_powerdown_modes[] = {
>  	"three_state",
>  };
>  
> +static const char * const ltc2617_powerdown_modes[] = {
> +	"90kohm_to_gnd",
> +};
> +
>  static int ad5064_get_powerdown_mode(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan)
>  {
> @@ -194,6 +209,13 @@ static const struct iio_enum ad5064_powerdown_mode_enum = {
>  	.set = ad5064_set_powerdown_mode,
>  };
>  
> +static const struct iio_enum ltc2617_powerdown_mode_enum = {
> +	.items = ltc2617_powerdown_modes,
> +	.num_items = ARRAY_SIZE(ltc2617_powerdown_modes),
> +	.get = ad5064_get_powerdown_mode,
> +	.set = ad5064_set_powerdown_mode,
> +};
> +
>  static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
>  	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>  {
> @@ -304,6 +326,18 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
>  	{ },
>  };
>  
> +static const struct iio_chan_spec_ext_info ltc2617_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ad5064_read_dac_powerdown,
> +		.write = ad5064_write_dac_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ltc2617_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", &ltc2617_powerdown_mode_enum),
> +	{ },
> +};
> +
>  #define AD5064_CHANNEL(chan, addr, bits, _shift, _ext_info) {		\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
> @@ -350,6 +384,10 @@ static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4, ad5064_ext_info);
>  static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4, ad5064_ext_info);
>  static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0, ad5064_ext_info);
>  
> +static DECLARE_AD5064_CHANNELS(ltc2607_channels, 16, 0, ltc2617_ext_info);
> +static DECLARE_AD5064_CHANNELS(ltc2617_channels, 14, 2, ltc2617_ext_info);
> +static DECLARE_AD5064_CHANNELS(ltc2627_channels, 12, 4, ltc2617_ext_info);
> +
>  static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  	[ID_AD5024] = {
>  		.shared_vref = false,
> @@ -458,6 +496,69 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  		.channels = ad5669_channels,
>  		.num_channels = 8,
>  	},
> +	[ID_LTC2606] = {
> +		.shared_vref = true,
> +		.internal_vref = 0,
> +		.channels = ltc2607_channels,
> +		.num_channels = 1,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2607] = {
> +		.shared_vref = true,
> +		.internal_vref = 0,
> +		.channels = ltc2607_channels,
> +		.num_channels = 2,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2609] = {
> +		.shared_vref = false,
> +		.internal_vref = 0,
> +		.channels = ltc2607_channels,
> +		.num_channels = 4,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2616] = {
> +		.shared_vref = true,
> +		.internal_vref = 0,
> +		.channels = ltc2617_channels,
> +		.num_channels = 1,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2617] = {
> +		.shared_vref = true,
> +		.internal_vref = 0,
> +		.channels = ltc2617_channels,
> +		.num_channels = 2,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2619] = {
> +		.shared_vref = false,
> +		.internal_vref = 0,
> +		.channels = ltc2617_channels,
> +		.num_channels = 4,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2626] = {
> +		.shared_vref = true,
> +		.internal_vref = 0,
> +		.channels = ltc2627_channels,
> +		.num_channels = 1,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2627] = {
> +		.shared_vref = true,
> +		.internal_vref = 0,
> +		.channels = ltc2627_channels,
> +		.num_channels = 2,
> +		.powerdown_ltc = true,
> +	},
> +	[ID_LTC2629] = {
> +		.shared_vref = false,
> +		.internal_vref = 0,
> +		.channels = ltc2627_channels,
> +		.num_channels = 4,
> +		.powerdown_ltc = true,
> +	},
>  };
>  
>  static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
> @@ -669,6 +770,15 @@ static const struct i2c_device_id ad5064_i2c_ids[] = {
>  	{"ad5669-1", ID_AD5669_1},
>  	{"ad5669-2", ID_AD5669_2},
>  	{"ad5669-3", ID_AD5669_2}, /* similar enough to ad5669-2 */
> +	{"ltc2606", ID_LTC2606},
> +	{"ltc2607", ID_LTC2607},
> +	{"ltc2609", ID_LTC2609},
> +	{"ltc2616", ID_LTC2616},
> +	{"ltc2617", ID_LTC2617},
> +	{"ltc2619", ID_LTC2619},
> +	{"ltc2626", ID_LTC2626},
> +	{"ltc2627", ID_LTC2627},
> +	{"ltc2629", ID_LTC2629},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
> 

