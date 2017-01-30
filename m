Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58820 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdA3UGf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 15:06:35 -0500
Subject: Re: [PATCH] iio: stx104: Remove unneeded struct stx104_dev code
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <20170130135850.28274-1-vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ddade4bc-8951-9f82-2b2e-31baa59d36fb@kernel.org>
Date: Mon, 30 Jan 2017 20:05:44 +0000
MIME-Version: 1.0
In-Reply-To: <20170130135850.28274-1-vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/17 13:58, William Breathitt Gray wrote:
> The stx104_dev structure was used to hold private data for use in the
> stx104_remove function. Now that the stx104_remove function is gone, the
> stx104_dev structure and relevant code is no longer needed. This patch
> removes the unnecessary code.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stx104.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index c56ff286695d..fcfad51cc4fb 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -76,16 +76,6 @@ struct stx104_gpio {
>  	unsigned int out_state;
>  };
>  
> -/**
> - * struct stx104_dev - STX104 device private data structure
> - * @indio_dev:	IIO device
> - * @chip:	instance of the gpio_chip
> - */
> -struct stx104_dev {
> -	struct iio_dev *indio_dev;
> -	struct gpio_chip *chip;
> -};
> -
>  static int stx104_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
> @@ -271,7 +261,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	struct iio_dev *indio_dev;
>  	struct stx104_iio *priv;
>  	struct stx104_gpio *stx104gpio;
> -	struct stx104_dev *stx104dev;
>  	int err;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> @@ -282,10 +271,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	if (!stx104gpio)
>  		return -ENOMEM;
>  
> -	stx104dev = devm_kzalloc(dev, sizeof(*stx104dev), GFP_KERNEL);
> -	if (!stx104dev)
> -		return -ENOMEM;
> -
>  	if (!devm_request_region(dev, base[id], STX104_EXTENT,
>  		dev_name(dev))) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> @@ -335,10 +320,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  
>  	spin_lock_init(&stx104gpio->lock);
>  
> -	stx104dev->indio_dev = indio_dev;
> -	stx104dev->chip = &stx104gpio->chip;
> -	dev_set_drvdata(dev, stx104dev);
> -
>  	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
>  	if (err) {
>  		dev_err(dev, "GPIO registering failed (%d)\n", err);
> 

