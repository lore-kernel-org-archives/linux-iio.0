Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJHCk6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 22:40:58 -0400
Date: Sun, 7 Oct 2018 20:32:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <Dragos.Bogdan@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/4] staging: iio: ad5933: Use the clock framework for
 the external clock
Message-ID: <20181007203235.6a60cf8f@archlinux>
In-Reply-To: <20181002115800.12399-3-alexandru.ardelean@analog.com>
References: <20181002115800.12399-1-alexandru.ardelean@analog.com>
        <20181002115800.12399-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2 Oct 2018 14:57:59 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> In order to add full device tree support, add the option of specifying
> the external clock (MCLK) using the clock framework.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

This looks fine, but I would like to know if the intent is to get
rid of the platform data support entirely once we have DT able to
do everything. Do we still have usecases for platform data with this
chip that can't be converted over?

Thanks,

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index ec54ab4471b9..04208a1df48e 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/clk.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -98,6 +99,7 @@ struct ad5933_state {
>  	struct i2c_client		*client;
>  	struct regulator		*reg;
>  	struct regulator		*vref;
> +	struct clk			*mclk;
>  	struct delayed_work		work;
>  	struct mutex			lock; /* Protect sensor state */
>  	unsigned long			mclk_hz;
> @@ -735,6 +737,19 @@ static int ad5933_probe(struct i2c_client *client,
>  	else
>  		st->vref_mv = pdata->vref_mv;
>  
> +	st->mclk = devm_clk_get(&client->dev, "mclk");
> +	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
> +		ret = PTR_ERR(st->mclk);
> +		goto error_disable_vref;
> +	}
> +
> +	if (!IS_ERR(st->mclk)) {
> +		ret = clk_prepare_enable(st->mclk);
> +		if (ret < 0)
> +			goto error_disable_vref;
> +		pdata->ext_clk_hz = clk_get_rate(st->mclk);
> +	}
> +
>  	if (pdata->ext_clk_hz) {
>  		st->mclk_hz = pdata->ext_clk_hz;
>  		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
> @@ -756,7 +771,7 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  	ret = ad5933_register_ring_funcs_and_init(indio_dev);
>  	if (ret)
> -		goto error_disable_vref;
> +		goto error_disable_mclk;
>  
>  	ret = ad5933_setup(st);
>  	if (ret)
> @@ -770,6 +785,8 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  error_unreg_ring:
>  	iio_kfifo_free(indio_dev->buffer);
> +error_disable_mclk:
> +	clk_disable_unprepare(st->mclk);
>  error_disable_vref:
>  	regulator_disable(st->vref);
>  error_disable_reg:
> @@ -787,6 +804,7 @@ static int ad5933_remove(struct i2c_client *client)
>  	iio_kfifo_free(indio_dev->buffer);
>  	regulator_disable(st->reg);
>  	regulator_disable(st->vref);
> +	clk_disable_unprepare(st->mclk);
>  
>  	return 0;
>  }
