Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60358 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdETQhl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:37:41 -0400
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9d66f2f3-001b-c9e0-852b-189d140702e3@kernel.org>
Date: Sat, 20 May 2017 17:37:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 15:48, Nikita Yushchenko wrote:
> Reset GPIO is active low.
> 
> Currently driver uses gpiod_set_value(1) to clean reset, which depends
> on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.
> 
> This fixes driver to use _raw version of gpiod_set_value() to enforce
> active-low semantics despite of what's written in device tree. Allowing
> device tree to override that only opens possibility for errors and does
> not add any value.
> 
> Additionally, use _cansleep version to make things work with i2c-gpio
> and other sleeping gpio drivers.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Hopefully we don't have any 'interesting' wiring schemes out there
that actually have a not gate on that wire.

Your argument seems sound to me so applied to the togreg branch
of iio.git and pushed out as testing for the autobuilders to play with
it.

Again, input from Vladimir would be particularly welcome!

Jonathan
> ---
>   drivers/iio/adc/hi8435.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index d09cb6ff8044..ab59969b7c49 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -476,13 +476,15 @@ static int hi8435_probe(struct spi_device *spi)
>   	priv->spi = spi;
>   
>   	reset_gpio = devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
> -	if (IS_ERR(reset_gpio)) {
> -		/* chip s/w reset if h/w reset failed */
> +	if (!IS_ERR(reset_gpio)) {
> +		/* need >=100ns low pulse to reset chip */
> +		gpiod_set_raw_value_cansleep(reset_gpio, 0);
> +		udelay(1);
> +		gpiod_set_raw_value_cansleep(reset_gpio, 1);
> +	} else {
> +		/* s/w reset chip if h/w reset is not available */
>   		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
>   		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
> -	} else {
> -		udelay(5);
> -		gpiod_set_value(reset_gpio, 1);
>   	}
>   
>   	spi_set_drvdata(spi, idev);
> 

