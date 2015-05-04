Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46880 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbEDQVE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:21:04 -0400
Message-ID: <55479C6B.1090205@kernel.org>
Date: Mon, 04 May 2015 17:20:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 02/10] iio: st_sensors: make interrupt optional
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org> <1430399755-26475-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/15 14:15, Linus Walleij wrote:
> Some sensors such as magnetometers and pressure sensors doesn't
> have interrupts at all, and thus no DRDY setting applies. Make
> the assignment of an interrupt optional, and do not call
> st_sensors_set_drdy_int_pin() if there is no drdy (data ready)
> pin specified.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git.

thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index edd13d2b4121..5a01093b29a2 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -245,6 +245,16 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> +	/* Sensor does not support interrupts */
> +	if (sdata->sensor_settings->drdy_irq.addr == 0) {
> +		if (pdata->drdy_int_pin)
> +			dev_info(&indio_dev->dev,
> +				 "DRDY on pin INT%d specified, but sensor "
> +				 "does not support interrupts\n",
> +				 pdata->drdy_int_pin);
> +		return 0;
> +	}
> +
>  	switch (pdata->drdy_int_pin) {
>  	case 1:
>  		if (sdata->sensor_settings->drdy_irq.mask_int1 == 0) {
> @@ -285,7 +295,7 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
>  	if (!of_property_read_u32(np, "st,drdy-int-pin", &val) && (val <= 2))
>  		pdata->drdy_int_pin = (u8) val;
>  	else
> -		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 1;
> +		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 0;
>  
>  	return pdata;
>  }
> 

