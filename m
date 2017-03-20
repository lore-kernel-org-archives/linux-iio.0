Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:40005 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755012AbdCTTeD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 15:34:03 -0400
Subject: Re: [PATCH v3] staging: ad7606: Replace mlock with driver private
 lock
To: Arushi Singhal <arushisinghal19971997@gmail.com>
References: <20170320185616.GA17444@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fe1d918f-76e0-8574-c234-fc2fc9268c59@metafoo.de>
Date: Mon, 20 Mar 2017 20:33:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170320185616.GA17444@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/20/2017 07:56 PM, Arushi Singhal wrote:
[...]
> @@ -413,6 +413,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st = iio_priv(indio_dev);
>  
>  	st->dev = dev;
> +	mutex_init(&st->lock);

This is nitpicking, but putting this in the middle of the assignments has a
bit of a weired flow it. Either put it above or below the assignments.

>  	st->bops = bops;
>  	st->base_address = base_address;
>  	/* tied to logic low, analog input range is +/- 5V */
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 746f9553d2ba..5d59bdd78727 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -14,6 +14,7 @@
>   * @name:		identification string for chip
>   * @channels:		channel specification
>   * @num_channels:	number of channels
> + * @lock		protect sensor state

This documentation is for struct ad7607_chip_info, but you are adding the
field to struct ad7606_state.

>   */
>  
>  struct ad7606_chip_info {
> @@ -37,6 +38,7 @@ struct ad7606_state {
>  	bool				done;
>  	void __iomem			*base_address;
>  
> +	struct mutex			lock; /* protect sensor state */
>  	struct gpio_desc		*gpio_convst;
>  	struct gpio_desc		*gpio_reset;
>  	struct gpio_desc		*gpio_range;
> 

