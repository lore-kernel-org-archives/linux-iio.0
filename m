Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45766 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbGSJky (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:40:54 -0400
Message-ID: <55AB70A5.90709@kernel.org>
Date: Sun, 19 Jul 2015 10:40:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	=?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 6/6] iio: mxs-lradc: add datasheet name for every usable
 channel
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <1437222646-8742-7-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-7-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/15 13:30, Stefan Wahren wrote:
> In order to provide a channel name to in kernel consumers add the
> datasheet names for every usable AD channel. Since the channel names
> differ between i.MX23 and i.MX28, we need to separate the channel
> specs.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Good series - nice to have some cleanups and then some more meat at 
the end :)  Thanks,

Applied to the togreg branch of iio.git.
Pushed out as testing for the autobuilders to play with it.

Jonathan
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |   80 +++++++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 3a549ef..3f7715c 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1365,7 +1365,7 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
>   * Driver initialization
>   */
>  
> -#define MXS_ADC_CHAN(idx, chan_type) {				\
> +#define MXS_ADC_CHAN(idx, chan_type, name) {			\
>  	.type = (chan_type),					\
>  	.indexed = 1,						\
>  	.scan_index = (idx),					\
> @@ -1378,17 +1378,18 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
>  		.realbits = LRADC_RESOLUTION,			\
>  		.storagebits = 32,				\
>  	},							\
> +	.datasheet_name = (name),				\
>  }
>  
> -static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
> -	MXS_ADC_CHAN(0, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(1, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(2, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(3, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(4, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(5, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(6, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(7, IIO_VOLTAGE),
> +static const struct iio_chan_spec mx23_lradc_chan_spec[] = {
> +	MXS_ADC_CHAN(0, IIO_VOLTAGE, "LRADC0"),
> +	MXS_ADC_CHAN(1, IIO_VOLTAGE, "LRADC1"),
> +	MXS_ADC_CHAN(2, IIO_VOLTAGE, "LRADC2"),
> +	MXS_ADC_CHAN(3, IIO_VOLTAGE, "LRADC3"),
> +	MXS_ADC_CHAN(4, IIO_VOLTAGE, "LRADC4"),
> +	MXS_ADC_CHAN(5, IIO_VOLTAGE, "LRADC5"),
> +	MXS_ADC_CHAN(6, IIO_VOLTAGE, "VDDIO"),
> +	MXS_ADC_CHAN(7, IIO_VOLTAGE, "VBATT"),
>  	/* Combined Temperature sensors */
>  	{
>  		.type = IIO_TEMP,
> @@ -1399,6 +1400,7 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
>  				      BIT(IIO_CHAN_INFO_SCALE),
>  		.channel = 8,
>  		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
> +		.datasheet_name = "TEMP_DIE",
>  	},
>  	/* Hidden channel to keep indexes */
>  	{
> @@ -1407,12 +1409,48 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
>  		.scan_index = -1,
>  		.channel = 9,
>  	},
> -	MXS_ADC_CHAN(10, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(11, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(12, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(13, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(14, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(15, IIO_VOLTAGE),
> +	MXS_ADC_CHAN(10, IIO_VOLTAGE, NULL),
> +	MXS_ADC_CHAN(11, IIO_VOLTAGE, NULL),
> +	MXS_ADC_CHAN(12, IIO_VOLTAGE, "USB_DP"),
> +	MXS_ADC_CHAN(13, IIO_VOLTAGE, "USB_DN"),
> +	MXS_ADC_CHAN(14, IIO_VOLTAGE, "VBG"),
> +	MXS_ADC_CHAN(15, IIO_VOLTAGE, "VDD5V"),
> +};
> +
> +static const struct iio_chan_spec mx28_lradc_chan_spec[] = {
> +	MXS_ADC_CHAN(0, IIO_VOLTAGE, "LRADC0"),
> +	MXS_ADC_CHAN(1, IIO_VOLTAGE, "LRADC1"),
> +	MXS_ADC_CHAN(2, IIO_VOLTAGE, "LRADC2"),
> +	MXS_ADC_CHAN(3, IIO_VOLTAGE, "LRADC3"),
> +	MXS_ADC_CHAN(4, IIO_VOLTAGE, "LRADC4"),
> +	MXS_ADC_CHAN(5, IIO_VOLTAGE, "LRADC5"),
> +	MXS_ADC_CHAN(6, IIO_VOLTAGE, "LRADC6"),
> +	MXS_ADC_CHAN(7, IIO_VOLTAGE, "VBATT"),
> +	/* Combined Temperature sensors */
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.scan_index = 8,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.channel = 8,
> +		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
> +		.datasheet_name = "TEMP_DIE",
> +	},
> +	/* Hidden channel to keep indexes */
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.scan_index = -1,
> +		.channel = 9,
> +	},
> +	MXS_ADC_CHAN(10, IIO_VOLTAGE, "VDDIO"),
> +	MXS_ADC_CHAN(11, IIO_VOLTAGE, "VTH"),
> +	MXS_ADC_CHAN(12, IIO_VOLTAGE, "VDDA"),
> +	MXS_ADC_CHAN(13, IIO_VOLTAGE, "VDDD"),
> +	MXS_ADC_CHAN(14, IIO_VOLTAGE, "VBG"),
> +	MXS_ADC_CHAN(15, IIO_VOLTAGE, "VDD5V"),
>  };
>  
>  static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
> @@ -1608,10 +1646,16 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	iio->dev.parent = &pdev->dev;
>  	iio->info = &mxs_lradc_iio_info;
>  	iio->modes = INDIO_DIRECT_MODE;
> -	iio->channels = mxs_lradc_chan_spec;
> -	iio->num_channels = ARRAY_SIZE(mxs_lradc_chan_spec);
>  	iio->masklength = LRADC_MAX_TOTAL_CHANS;
>  
> +	if (lradc->soc == IMX23_LRADC) {
> +		iio->channels = mx23_lradc_chan_spec;
> +		iio->num_channels = ARRAY_SIZE(mx23_lradc_chan_spec);
> +	} else {
> +		iio->channels = mx28_lradc_chan_spec;
> +		iio->num_channels = ARRAY_SIZE(mx28_lradc_chan_spec);
> +	}
> +
>  	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
>  				&mxs_lradc_trigger_handler,
>  				&mxs_lradc_buffer_ops);
> 

