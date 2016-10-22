Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53650 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJVRKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:10:02 -0400
Subject: Re: [PATCH 12/13] staging:iio:ad7606: Use GPIO descriptor API
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-13-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9c742ee2-90da-bbdb-9bcc-e59a622e4018@kernel.org>
Date: Sat, 22 Oct 2016 18:09:59 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-13-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:07, Lars-Peter Clausen wrote:
> Convert the ad7606 driver away from the deprecated legacy GPIO API and use
> the new GPIO descriptor API.
> 
> This also means that the platform data struct is now empty and can be
> removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Nice illustration of how much nicer the newer gpio stuff is.

Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606.h      |  35 ++----
>  drivers/staging/iio/adc/ad7606_core.c | 200 ++++++++++------------------------
>  drivers/staging/iio/adc/ad7606_ring.c |   4 +-
>  3 files changed, 64 insertions(+), 175 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 6dde987..f5f85fa 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -9,33 +9,6 @@
>  #ifndef IIO_ADC_AD7606_H_
>  #define IIO_ADC_AD7606_H_
>  
> -/*
> - * TODO: struct ad7606_platform_data needs to go into include/linux/iio
> - */
> -
> -/**
> - * struct ad7606_platform_data - platform/board specific information
> - * @gpio_convst:	number of gpio connected to the CONVST pin
> - * @gpio_reset:		gpio connected to the RESET pin, if not used set to -1
> - * @gpio_range:		gpio connected to the RANGE pin, if not used set to -1
> - * @gpio_os0:		gpio connected to the OS0 pin, if not used set to -1
> - * @gpio_os1:		gpio connected to the OS1 pin, if not used set to -1
> - * @gpio_os2:		gpio connected to the OS2 pin, if not used set to -1
> - * @gpio_frstdata:	gpio connected to the FRSTDAT pin, if not used set to -1
> - * @gpio_stby:		gpio connected to the STBY pin, if not used set to -1
> - */
> -
> -struct ad7606_platform_data {
> -	unsigned int			gpio_convst;
> -	unsigned int			gpio_reset;
> -	unsigned int			gpio_range;
> -	unsigned int			gpio_os0;
> -	unsigned int			gpio_os1;
> -	unsigned int			gpio_os2;
> -	unsigned int			gpio_frstdata;
> -	unsigned int			gpio_stby;
> -};
> -
>  /**
>   * struct ad7606_chip_info - chip specific information
>   * @name:		identification string for chip
> @@ -55,7 +28,6 @@ struct ad7606_chip_info {
>  struct ad7606_state {
>  	struct device			*dev;
>  	const struct ad7606_chip_info	*chip_info;
> -	struct ad7606_platform_data	*pdata;
>  	struct regulator		*reg;
>  	struct work_struct		poll_work;
>  	wait_queue_head_t		wq_data_avail;
> @@ -65,6 +37,13 @@ struct ad7606_state {
>  	bool				done;
>  	void __iomem			*base_address;
>  
> +	struct gpio_desc		*gpio_convst;
> +	struct gpio_desc		*gpio_reset;
> +	struct gpio_desc		*gpio_range;
> +	struct gpio_desc		*gpio_standby;
> +	struct gpio_desc		*gpio_frstdata;
> +	struct gpio_descs		*gpio_os;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index 670caa2..4ef6cb4 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -13,7 +13,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/sched.h>
>  #include <linux/module.h>
> @@ -26,10 +26,10 @@
>  
>  int ad7606_reset(struct ad7606_state *st)
>  {
> -	if (gpio_is_valid(st->pdata->gpio_reset)) {
> -		gpio_set_value(st->pdata->gpio_reset, 1);
> +	if (st->gpio_reset) {
> +		gpiod_set_value(st->gpio_reset, 1);
>  		ndelay(100); /* t_reset >= 100ns */
> -		gpio_set_value(st->pdata->gpio_reset, 0);
> +		gpiod_set_value(st->gpio_reset, 0);
>  		return 0;
>  	}
>  
> @@ -52,12 +52,12 @@ int ad7606_read_samples(struct ad7606_state *st)
>  	 * situations.
>  	 */
>  
> -	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
> +	if (st->gpio_frstdata) {
>  		ret = st->bops->read_block(st->dev, 1, data);
>  		if (ret)
>  			return ret;
>  
> -		if (!gpio_get_value(st->pdata->gpio_frstdata)) {
> +		if (!gpiod_get_value(st->gpio_frstdata)) {
>  			ad7606_reset(st);
>  			return -EIO;
>  		}
> @@ -75,7 +75,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	int ret;
>  
>  	st->done = false;
> -	gpio_set_value(st->pdata->gpio_convst, 1);
> +	gpiod_set_value(st->gpio_convst, 1);
>  
>  	ret = wait_event_interruptible(st->wq_data_avail, st->done);
>  	if (ret)
> @@ -86,7 +86,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  		ret = st->data[ch];
>  
>  error_ret:
> -	gpio_set_value(st->pdata->gpio_convst, 0);
> +	gpiod_set_value(st->gpio_convst, 0);
>  
>  	return ret;
>  }
> @@ -150,7 +150,7 @@ static ssize_t ad7606_store_range(struct device *dev,
>  		return -EINVAL;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	gpio_set_value(st->pdata->gpio_range, lval == 10000);
> +	gpiod_set_value(st->gpio_range, lval == 10000);
>  	st->range = lval;
>  	mutex_unlock(&indio_dev->mlock);
>  
> @@ -180,6 +180,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> +	int values[3];
>  	int ret;
>  
>  	switch (mask) {
> @@ -190,12 +191,16 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> +		values[0] = (ret >> 0) & 1;
> +		values[1] = (ret >> 1) & 1;
> +		values[2] = (ret >> 2) & 1;
> +
>  		mutex_lock(&indio_dev->mlock);
> -		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
> -		gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> -		gpio_set_value(st->pdata->gpio_os2, (ret >> 2) & 1);
> +		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
> +				      values);
>  		st->oversampling = val;
>  		mutex_unlock(&indio_dev->mlock);
> +
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -285,119 +290,37 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  
>  static int ad7606_request_gpios(struct ad7606_state *st)
>  {
> -	struct gpio gpio_array[3] = {
> -		[0] = {
> -			.gpio =  st->pdata->gpio_os0,
> -			.flags = GPIOF_DIR_OUT | ((st->oversampling & 1) ?
> -				 GPIOF_INIT_HIGH : GPIOF_INIT_LOW),
> -			.label = "AD7606_OS0",
> -		},
> -		[1] = {
> -			.gpio =  st->pdata->gpio_os1,
> -			.flags = GPIOF_DIR_OUT | ((st->oversampling & 2) ?
> -				 GPIOF_INIT_HIGH : GPIOF_INIT_LOW),
> -			.label = "AD7606_OS1",
> -		},
> -		[2] = {
> -			.gpio =  st->pdata->gpio_os2,
> -			.flags = GPIOF_DIR_OUT | ((st->oversampling & 4) ?
> -				 GPIOF_INIT_HIGH : GPIOF_INIT_LOW),
> -			.label = "AD7606_OS2",
> -		},
> -	};
> -	int ret;
> +	struct device *dev = st->dev;
>  
> -	if (gpio_is_valid(st->pdata->gpio_convst)) {
> -		ret = gpio_request_one(st->pdata->gpio_convst,
> -				       GPIOF_OUT_INIT_LOW,
> -				       "AD7606_CONVST");
> -		if (ret) {
> -			dev_err(st->dev, "failed to request GPIO CONVST\n");
> -			goto error_ret;
> -		}
> -	} else {
> -		ret = -EIO;
> -		goto error_ret;
> -	}
> +	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_convst))
> +		return PTR_ERR(st->gpio_convst);
>  
> -	if (gpio_is_valid(st->pdata->gpio_os0) &&
> -	    gpio_is_valid(st->pdata->gpio_os1) &&
> -	    gpio_is_valid(st->pdata->gpio_os2)) {
> -		ret = gpio_request_array(gpio_array, ARRAY_SIZE(gpio_array));
> -		if (ret < 0)
> -			goto error_free_convst;
> -	}
> +	st->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_reset))
> +		return PTR_ERR(st->gpio_reset);
>  
> -	if (gpio_is_valid(st->pdata->gpio_reset)) {
> -		ret = gpio_request_one(st->pdata->gpio_reset,
> -				       GPIOF_OUT_INIT_LOW,
> -				       "AD7606_RESET");
> -		if (ret < 0)
> -			goto error_free_os;
> -	}
> +	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_range))
> +		return PTR_ERR(st->gpio_range);
>  
> -	if (gpio_is_valid(st->pdata->gpio_range)) {
> -		ret = gpio_request_one(st->pdata->gpio_range, GPIOF_DIR_OUT |
> -				       ((st->range == 10000) ? GPIOF_INIT_HIGH :
> -					GPIOF_INIT_LOW), "AD7606_RANGE");
> -		if (ret < 0)
> -			goto error_free_reset;
> -	}
> -	if (gpio_is_valid(st->pdata->gpio_stby)) {
> -		ret = gpio_request_one(st->pdata->gpio_stby,
> -				       GPIOF_OUT_INIT_HIGH,
> -				       "AD7606_STBY");
> -		if (ret < 0)
> -			goto error_free_range;
> -	}
> +	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_standby))
> +		return PTR_ERR(st->gpio_standby);
>  
> -	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
> -		ret = gpio_request_one(st->pdata->gpio_frstdata, GPIOF_IN,
> -				       "AD7606_FRSTDATA");
> -		if (ret < 0)
> -			goto error_free_stby;
> -	}
> +	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
> +						    GPIOD_IN);
> +	if (IS_ERR(st->gpio_frstdata))
> +		return PTR_ERR(st->gpio_frstdata);
>  
> -	return 0;
> +	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
> +			GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_os))
> +		return PTR_ERR(st->gpio_os);
>  
> -error_free_stby:
> -	if (gpio_is_valid(st->pdata->gpio_stby))
> -		gpio_free(st->pdata->gpio_stby);
> -error_free_range:
> -	if (gpio_is_valid(st->pdata->gpio_range))
> -		gpio_free(st->pdata->gpio_range);
> -error_free_reset:
> -	if (gpio_is_valid(st->pdata->gpio_reset))
> -		gpio_free(st->pdata->gpio_reset);
> -error_free_os:
> -	if (gpio_is_valid(st->pdata->gpio_os0) &&
> -	    gpio_is_valid(st->pdata->gpio_os1) &&
> -	    gpio_is_valid(st->pdata->gpio_os2))
> -		gpio_free_array(gpio_array, ARRAY_SIZE(gpio_array));
> -error_free_convst:
> -	gpio_free(st->pdata->gpio_convst);
> -error_ret:
> -	return ret;
> -}
> -
> -static void ad7606_free_gpios(struct ad7606_state *st)
> -{
> -	if (gpio_is_valid(st->pdata->gpio_frstdata))
> -		gpio_free(st->pdata->gpio_frstdata);
> -	if (gpio_is_valid(st->pdata->gpio_stby))
> -		gpio_free(st->pdata->gpio_stby);
> -	if (gpio_is_valid(st->pdata->gpio_range))
> -		gpio_free(st->pdata->gpio_range);
> -	if (gpio_is_valid(st->pdata->gpio_reset))
> -		gpio_free(st->pdata->gpio_reset);
> -	if (gpio_is_valid(st->pdata->gpio_os0) &&
> -	    gpio_is_valid(st->pdata->gpio_os1) &&
> -	    gpio_is_valid(st->pdata->gpio_os2)) {
> -		gpio_free(st->pdata->gpio_os2);
> -		gpio_free(st->pdata->gpio_os1);
> -		gpio_free(st->pdata->gpio_os0);
> -	}
> -	gpio_free(st->pdata->gpio_convst);
> +	return 0;
>  }
>  
>  /**
> @@ -447,7 +370,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops)
>  {
> -	struct ad7606_platform_data *pdata = dev->platform_data;
>  	struct ad7606_state *st;
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -471,19 +393,20 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  			return ret;
>  	}
>  
> -	st->pdata = pdata;
> +	ret = ad7606_request_gpios(st);
> +	if (ret)
> +		goto error_disable_reg;
> +
>  	st->chip_info = &ad7606_chip_info_tbl[id];
>  
>  	indio_dev->dev.parent = dev;
> -	if (gpio_is_valid(st->pdata->gpio_os0) &&
> -	    gpio_is_valid(st->pdata->gpio_os1) &&
> -	    gpio_is_valid(st->pdata->gpio_os2)) {
> -		if (gpio_is_valid(st->pdata->gpio_range))
> +	if (st->gpio_os) {
> +		if (st->gpio_range)
>  			indio_dev->info = &ad7606_info_os_and_range;
>  		else
>  			indio_dev->info = &ad7606_info_os;
>  	} else {
> -		if (gpio_is_valid(st->pdata->gpio_range))
> +		if (st->gpio_range)
>  			indio_dev->info = &ad7606_info_range;
>  		else
>  			indio_dev->info = &ad7606_info_no_os_or_range;
> @@ -495,10 +418,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  
>  	init_waitqueue_head(&st->wq_data_avail);
>  
> -	ret = ad7606_request_gpios(st);
> -	if (ret)
> -		goto error_disable_reg;
> -
>  	ret = ad7606_reset(st);
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
> @@ -506,7 +425,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
>  			  indio_dev);
>  	if (ret)
> -		goto error_free_gpios;
> +		goto error_disable_reg;
>  
>  	ret = ad7606_register_ring_funcs_and_init(indio_dev);
>  	if (ret)
> @@ -525,9 +444,6 @@ error_unregister_ring:
>  error_free_irq:
>  	free_irq(irq, indio_dev);
>  
> -error_free_gpios:
> -	ad7606_free_gpios(st);
> -
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> @@ -547,8 +463,6 @@ int ad7606_remove(struct device *dev, int irq)
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
>  
> -	ad7606_free_gpios(st);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ad7606_remove);
> @@ -560,10 +474,9 @@ static int ad7606_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
> -	if (gpio_is_valid(st->pdata->gpio_stby)) {
> -		if (gpio_is_valid(st->pdata->gpio_range))
> -			gpio_set_value(st->pdata->gpio_range, 1);
> -		gpio_set_value(st->pdata->gpio_stby, 0);
> +	if (st->gpio_standby) {
> +		gpiod_set_value(st->gpio_range, 1);
> +		gpiod_set_value(st->gpio_standby, 0);
>  	}
>  
>  	return 0;
> @@ -574,12 +487,9 @@ static int ad7606_resume(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
> -	if (gpio_is_valid(st->pdata->gpio_stby)) {
> -		if (gpio_is_valid(st->pdata->gpio_range))
> -			gpio_set_value(st->pdata->gpio_range,
> -				       st->range == 10000);
> -
> -		gpio_set_value(st->pdata->gpio_stby, 1);
> +	if (st->gpio_standby) {
> +		gpiod_set_value(st->gpio_range, st->range == 10000);
> +		gpiod_set_value(st->gpio_standby, 1);
>  		ad7606_reset(st);
>  	}
>  
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> index 81e4a0ac..68d72b1 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ b/drivers/staging/iio/adc/ad7606_ring.c
> @@ -23,7 +23,7 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct ad7606_state *st = iio_priv(pf->indio_dev);
>  
> -	gpio_set_value(st->pdata->gpio_convst, 1);
> +	gpiod_set_value(st->gpio_convst, 1);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -49,7 +49,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
>  		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>  						   iio_get_time_ns(indio_dev));
>  
> -	gpio_set_value(st->pdata->gpio_convst, 0);
> +	gpiod_set_value(st->gpio_convst, 0);
>  	iio_trigger_notify_done(indio_dev->trig);
>  }
>  
> 

