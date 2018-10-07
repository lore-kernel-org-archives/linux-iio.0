Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJHCiy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 22:38:54 -0400
Date: Sun, 7 Oct 2018 20:30:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <Dragos.Bogdan@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/4] staging: iio: ad5933: Add regulator binding for
 vref
Message-ID: <20181007203031.6545485a@archlinux>
In-Reply-To: <20181002115800.12399-2-alexandru.ardelean@analog.com>
References: <20181002115800.12399-1-alexandru.ardelean@analog.com>
        <20181002115800.12399-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2 Oct 2018 14:57:58 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> In order to add full device tree support, add the option of specifying
> the vref using the regulator framework.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 8a920f675b83..ec54ab4471b9 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -97,6 +97,7 @@ struct ad5933_platform_data {
>  struct ad5933_state {
>  	struct i2c_client		*client;
>  	struct regulator		*reg;
> +	struct regulator		*vref;
>  	struct delayed_work		work;
>  	struct mutex			lock; /* Protect sensor state */
>  	unsigned long			mclk_hz;
> @@ -721,6 +722,14 @@ static int ad5933_probe(struct i2c_client *client,
>  	}
>  	voltage_uv = regulator_get_voltage(st->reg);
>  
> +	st->reg = devm_regulator_get(&client->dev, "vref");

You want devm_regulator_get_optional here I think.

Otherwise you'll get a stub regulator if one isn't specified in
the device tree.


Also, I'm confused, you have an existing regulator which you
override with a second one?  Please provide some more details of
this..

> +	if (!IS_ERR(st->vref)) {
> +		ret = regulator_enable(st->vref);
> +		if (ret)
> +			goto error_disable_reg;
> +		pdata->vref_mv = regulator_get_voltage(st->vref) / 1000;
> +	}
> +
>  	if (voltage_uv)
>  		st->vref_mv = voltage_uv / 1000;
>  	else
> @@ -747,7 +756,7 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  	ret = ad5933_register_ring_funcs_and_init(indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_vref;
>  
>  	ret = ad5933_setup(st);
>  	if (ret)
> @@ -761,6 +770,8 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  error_unreg_ring:
>  	iio_kfifo_free(indio_dev->buffer);
> +error_disable_vref:
> +	regulator_disable(st->vref);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -775,6 +786,7 @@ static int ad5933_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	iio_kfifo_free(indio_dev->buffer);
>  	regulator_disable(st->reg);
> +	regulator_disable(st->vref);
>  
>  	return 0;
>  }
