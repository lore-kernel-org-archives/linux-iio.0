Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752147AbdHLMDe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:03:34 -0400
Date: Sat, 12 Aug 2017 12:59:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: srf08: add support for srf02 in i2c mode
Message-ID: <20170812125923.13028539@archlinux>
In-Reply-To: <20170802232536.GA15377@arbeit>
References: <20170802232536.GA15377@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 01:25:36 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> srf02 added with support for i2c interface
> 
> Attributes for setting max range or sensitivity are omitted for the case of
> srf02 type sensor, because they are not supported by the hardware.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
A few little things inline.
> ---
>  drivers/iio/proximity/srf08.c | 56 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index a2913a5bf68e..a63c272c3b22 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -1,14 +1,17 @@
>  /*
> - * srf08.c - Support for Devantech SRF08 ultrasonic ranger
> + * srf08.c - Support for Devantech SRF02/SRF08/SRF10 ultrasonic ranger
> + *           with I2C-Interface
>   *
> - * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> + * Copyright (c) 2016, 2017 Andreas Klinger <ak@it-klinger.de>
>   *
>   * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> + * the GNU General Public License. See the file COPYING in the main
>   * directory of this archive for more details.
>   *
>   * For details about the device see:
>   * http://www.robot-electronics.co.uk/htm/srf08tech.html
> + * http://www.robot-electronics.co.uk/htm/srf10tech.htm
Push this into an earlier patch please.  Nothing to do with the srf02.
> + * http://www.robot-electronics.co.uk/htm/srf02tech.htm
>   */
>  
>  #include <linux/err.h>
> @@ -38,6 +41,7 @@
>  #define SRF08_MAX_SENSITIVITY	32	/* number of Gain Register values */
>  
>  enum srf08_sensor_type {
> +	SRF02,
>  	SRF08,
>  	SRF10,
>  	SRF_MAX_TYPE
> @@ -61,6 +65,13 @@ struct srf08_data {
>   * is called "Sensitivity" here.
>   */
>  static const int srf08_sensitivity[SRF_MAX_TYPE][SRF08_MAX_SENSITIVITY] = {
> +	/* SRF02: unused */
> +	{
Same as below, use indexed value setting and you won't need to
pad this out.
> +	  0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0
> +	},
>  	/* SRF08 */
>  	{
>  	 94,  97, 100, 103, 107, 110, 114, 118,
> @@ -78,6 +89,8 @@ static const int srf08_sensitivity[SRF_MAX_TYPE][SRF08_MAX_SENSITIVITY] = {
>  };
>  
>  static const int srf08_default_sensitivity[SRF_MAX_TYPE] = {
> +	/* SRF02: unused*/
> +	0,
Use indexed assignment and this becomes clear.
[1] = 1025,
[2] = ...

Even better if you can index it with an appropriate enum and
hence drop the documentation as it'll be obvious from the code.
>  	/* SRF08 */
>  	1025,
>  	/* SRF10 */
> @@ -394,7 +407,7 @@ static const struct iio_chan_spec srf08_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
> -static const struct iio_info srf08_info = {
> +static struct iio_info srf08_info = {
>  	.read_raw = srf08_read_raw,
>  	.attrs = &srf08_attribute_group,
>  	.driver_module = THIS_MODULE,
> @@ -425,6 +438,11 @@ static int srf08_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* srf02 is not using sensitivity nor max_range */
> +	if (id->driver_data == SRF02)
This I really don't like.  Just have two possible info structures
and pick between them rather than doing this.  If you have
two different sensors on one board, this just broke the driver.

> +		srf08_info.attrs = NULL;
> +
>  	indio_dev->info = &srf08_info;
>  	indio_dev->channels = srf08_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
> @@ -438,24 +456,27 @@ static int srf08_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	/*
> -	 * set default values of device here
> -	 * these register values cannot be read from the hardware
> -	 * therefore set driver specific default values
> -	 */
> -	ret = srf08_write_range_mm(data, SRF08_DEFAULT_RANGE);
> -	if (ret < 0)
> -		return ret;
> +	if (id->driver_data != SRF02) {
I'd have a slight preference for doing this as a switch
with all the options listed.  That way it is cleaner to extend
in future when another device comes along.
> +		/*
> +		 * set default values of device here
> +		 * these register values cannot be read from the hardware
> +		 * therefore set driver specific default values
> +		 */
> +		ret = srf08_write_range_mm(data, SRF08_DEFAULT_RANGE);
> +		if (ret < 0)
> +			return ret;
>  
> -	ret = srf08_write_sensitivity(data,
> -			srf08_default_sensitivity[id->driver_data]);
> -	if (ret < 0)
> -		return ret;
> +		ret = srf08_write_sensitivity(data,
> +				srf08_default_sensitivity[id->driver_data]);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct of_device_id of_srf08_match[] = {
> +	{ .compatible = "devantech,srf02", (void *)SRF02},
>  	{ .compatible = "devantech,srf08", (void *)SRF08},
>  	{ .compatible = "devantech,srf10", (void *)SRF10},
>  	{},
> @@ -464,6 +485,7 @@ static const struct of_device_id of_srf08_match[] = {
>  MODULE_DEVICE_TABLE(of, of_srf08_match);
>  
>  static const struct i2c_device_id srf08_id[] = {
> +	{ "srf02", SRF02 },
>  	{ "srf08", SRF08 },
>  	{ "srf10", SRF10 },
>  	{ }
> @@ -481,5 +503,5 @@ static struct i2c_driver srf08_driver = {
>  module_i2c_driver(srf08_driver);
>  
>  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> -MODULE_DESCRIPTION("Devantech SRF08/SRF10 ultrasonic ranger driver");
> +MODULE_DESCRIPTION("Devantech SRF02/SRF08/SRF10 i2c ultrasonic ranger driver");
>  MODULE_LICENSE("GPL");

