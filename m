Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJWCLx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Oct 2018 22:11:53 -0400
Message-ID: <55b8a6364a0a4d8c123a1041a07f7ed34bf45ded.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: Switch to the gpio descriptor
 interface
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Nishad Kamdar <nishadkamdar@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc: Slawomir Stepien <sst@poczta.fm>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date: Mon, 22 Oct 2018 23:22:15 +0530
In-Reply-To: <20181022171418.GA2612@nishad>
References: <20181022171418.GA2612@nishad>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2018-10-22 at 22:44 +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface for ldac_pin.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---

Hi Nishad,

I have been working on implementing device tree bindings for this
driver and removing platform data from it.

I've sent a series of patches for it to Jonathan. I didn't send it 
on the mailing list as I wanted to confirm from Jonathan if we wants
something more to be done in the series. That series also includes
the change which you are proposing here.
I am really sorry that you didn't know about this.
If you are planning to send any other patches for this driver then
let me know before you start implementing it so that we can
co-ordinate before doing any work.

Thanks


>  drivers/staging/iio/addac/adt7316.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c
> b/drivers/staging/iio/addac/adt7316.c
> index 3f22d1088713..94f945ba0097 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -177,7 +177,7 @@
>  
>  struct adt7316_chip_info {
>  	struct adt7316_bus	bus;
> -	u16			ldac_pin;
> +	struct gpio_desc	*ldac_pin;
>  	u16			int_mask;	/* 0x2f */
>  	u8			config1;
>  	u8			config2;
> @@ -950,8 +950,8 @@ static ssize_t adt7316_store_update_DAC(struct
> device *dev,
>  		if (ret)
>  			return -EIO;
>  	} else {
> -		gpio_set_value(chip->ldac_pin, 0);
> -		gpio_set_value(chip->ldac_pin, 1);
> +		gpiod_set_value(chip->ldac_pin, 0);
> +		gpiod_set_value(chip->ldac_pin, 1);
>  	}
>  
>  	return len;
> @@ -2120,7 +2120,14 @@ int adt7316_probe(struct device *dev, struct
> adt7316_bus *bus,
>  	else
>  		return -ENODEV;
>  
> -	chip->ldac_pin = adt7316_platform_data[1];
> +	chip->ldac_pin = devm_gpiod_get(dev, "ldac",
> GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->ldac_pin)) {
> +		ret = PTR_ERR(chip->ldac_pin);
> +		dev_err(dev, "Failed to request ldac GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	if (chip->ldac_pin) {
>  		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
>  		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
