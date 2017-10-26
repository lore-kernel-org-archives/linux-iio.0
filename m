Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbdJZQ3b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:29:31 -0400
Date: Thu, 26 Oct 2017 17:29:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/light/max44000: Use common error handling code in
 max44000_probe()
Message-ID: <20171026172926.62d5ff87@archlinux>
In-Reply-To: <28854212-d360-8636-4de5-017fbee0db36@users.sourceforge.net>
References: <28854212-d360-8636-4de5-017fbee0db36@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 10:40:12 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Oct 2017 10:30:57 +0200
> 
> * Add a jump target so that a specific error message is stored only once
>   at the end of this function implementation.
> 
> * Replace two calls of the function "dev_err" by goto statements.
> 
> * Adjust condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Again, throttle your patch sending please Markus as it will save
everyone time.  I try to give full reasoning in each patch because
others may encounter them without having visibility of similar
patches posted at the same time.  As such I end up writing
the same thing multiple times wasting my time on top of the time
you have already wasted by sending out multiple patches of a type
I am going to reject..

> ---
>  drivers/iio/light/max44000.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index bcdb0eb9e537..8f4bc6a918d5 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -569,18 +569,14 @@ static int max44000_probe(struct i2c_client *client,
>  	 * Set a middle value so that we get some sort of valid data by default.
>  	 */
>  	ret = max44000_write_led_current_raw(data, MAX44000_LED_CURRENT_DEFAULT);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "failed to write init config: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		goto report_failure;
>  
>  	/* Reset CFG bits to ALS_PRX mode which allows easy reading of both values. */
>  	reg = MAX44000_CFG_TRIM | MAX44000_CFG_MODE_ALS_PRX;
>  	ret = regmap_write(data->regmap, MAX44000_REG_CFG_MAIN, reg);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "failed to write init config: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		goto report_failure;
>  
>  	/* Read status at least once to clear any stale interrupt bits. */
>  	ret = regmap_read(data->regmap, MAX44000_REG_STATUS, &reg);
> @@ -596,6 +592,10 @@ static int max44000_probe(struct i2c_client *client,
>  	}
>  
>  	return iio_device_register(indio_dev);
> +
> +report_failure:
> +	dev_err(&client->dev, "failed to write init config: %d\n", ret);
This reduces readability of the code for a very minor gain.  
Printing an error message is not a source of bugs or similar unlike
unwinding some state, so a unified path makes little sense. 


> +	return ret;
>  }
>  
>  static int max44000_remove(struct i2c_client *client)

