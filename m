Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48107 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFZRgt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 13:36:49 -0400
Subject: Re: [PATCH v1 5/7] iio:st_pressure: temperature triggered buffering
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1466687364.git.gregor.boirie@parrot.com>
 <5e9c440148dd4f1e124837f3c3edb13c79f18e21.1466687364.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2239f836-dcc9-5c06-feec-ef3768fa1b6c@kernel.org>
Date: Sun, 26 Jun 2016 18:36:47 +0100
MIME-Version: 1.0
In-Reply-To: <5e9c440148dd4f1e124837f3c3edb13c79f18e21.1466687364.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/16 14:49, Gregor Boirie wrote:
> Enable support for triggered buffering of temperature samples.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> ---
>  drivers/iio/pressure/st_pressure_core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 737d20a..122d190 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -105,8 +105,6 @@
>  #define ST_PRESS_LSB_PER_CELSIUS		480UL
>  #define ST_PRESS_MILLI_CELSIUS_OFFSET		42500UL
>  
> -#define ST_PRESS_NUMBER_DATA_CHANNELS		1
> -
>  /* FULLSCALE */
>  #define ST_PRESS_FS_AVL_1100MB			1100
>  #define ST_PRESS_FS_AVL_1260MB			1260
> @@ -222,7 +220,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>  		.type = IIO_PRESSURE,
>  		.channel2 = IIO_NO_MOD,
>  		.address = ST_PRESS_1_OUT_XL_ADDR,
> -		.scan_index = ST_SENSORS_SCAN_X,
> +		.scan_index = 0,
That does indeed make little sense ;)  oops, I missed this in the original
reviews.
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 24,
> @@ -237,7 +235,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>  		.type = IIO_TEMP,
>  		.channel2 = IIO_NO_MOD,
>  		.address = ST_TEMP_1_OUT_L_ADDR,
> -		.scan_index = -1,
> +		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 16,
> @@ -250,7 +248,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>  			BIT(IIO_CHAN_INFO_OFFSET),
>  		.modified = 0,
>  	},
> -	IIO_CHAN_SOFT_TIMESTAMP(1)
> +	IIO_CHAN_SOFT_TIMESTAMP(2)
>  };
>  
>  static const struct iio_chan_spec st_press_lps001wp_channels[] = {
> @@ -258,7 +256,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>  		.type = IIO_PRESSURE,
>  		.channel2 = IIO_NO_MOD,
>  		.address = ST_PRESS_LPS001WP_OUT_L_ADDR,
> -		.scan_index = ST_SENSORS_SCAN_X,
> +		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 16,
> @@ -274,7 +272,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>  		.type = IIO_TEMP,
>  		.channel2 = IIO_NO_MOD,
>  		.address = ST_TEMP_LPS001WP_OUT_L_ADDR,
> -		.scan_index = -1,
> +		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 16,
> @@ -286,7 +284,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.modified = 0,
>  	},
> -	IIO_CHAN_SOFT_TIMESTAMP(1)
> +	IIO_CHAN_SOFT_TIMESTAMP(2)
>  };
>  
>  static const struct iio_chan_spec st_press_lps22hb_channels[] = {
> @@ -641,7 +639,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_press_power_off;
>  
> -	press_data->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
> +	press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
Maybe a quick comment that the last one is the timestamp?  Made me wonder for
a few seconds.
>  	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
>  	indio_dev->channels = press_data->sensor_settings->ch;
>  	indio_dev->num_channels = press_data->sensor_settings->num_ch;
> 

