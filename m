Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34914 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbdD3Qhj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:37:39 -0400
Subject: Re: [PATCH 6/7] iio: adc: twl4030: Remove
 twl4030_madc_request.func_cb
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-7-sebastian.reichel@collabora.co.uk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b6da9ee-b8b9-0dbd-c944-af2d446fdf15@kernel.org>
Date: Sun, 30 Apr 2017 17:37:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170427153012.32310-7-sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 16:30, Sebastian Reichel wrote:
> This functionality is not used by the IIO subsystem. Due
> to removal of legacy API it can also be removed.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/twl4030-madc.c   | 70 ----------------------------------------
>  include/linux/i2c/twl4030-madc.h |  1 -
>  2 files changed, 71 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index be60f76d1a50..21df5b932bd1 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -86,7 +86,6 @@ static int twl4030_madc_read(struct iio_dev *iio_dev,
>  
>  	req.channels = BIT(chan->channel);
>  	req.active = false;
> -	req.func_cb = NULL;
>  	req.type = TWL4030_MADC_WAIT;
>  	req.raw = !(mask == IIO_CHAN_INFO_PROCESSED);
>  	req.do_avg = (mask == IIO_CHAN_INFO_AVERAGE_RAW);
> @@ -343,37 +342,6 @@ static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
>  }
>  
>  /*
> - * Enables irq.
> - * @madc - pointer to twl4030_madc_data struct
> - * @id - irq number to be enabled
> - * can take one of TWL4030_MADC_RT, TWL4030_MADC_SW1, TWL4030_MADC_SW2
> - * corresponding to RT, SW1, SW2 conversion requests.
> - * If the i2c read fails it returns an error else returns 0.
> - */
> -static int twl4030_madc_enable_irq(struct twl4030_madc_data *madc, u8 id)
> -{
> -	u8 val;
> -	int ret;
> -
> -	ret = twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, madc->imr);
> -	if (ret) {
> -		dev_err(madc->dev, "unable to read imr register 0x%X\n",
> -			madc->imr);
> -		return ret;
> -	}
> -
> -	val &= ~(1 << id);
> -	ret = twl_i2c_write_u8(TWL4030_MODULE_MADC, val, madc->imr);
> -	if (ret) {
> -		dev_err(madc->dev,
> -			"unable to write imr register 0x%X\n", madc->imr);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
>   * Disables irq.
>   * @madc - pointer to twl4030_madc_data struct
>   * @id - irq number to be disabled
> @@ -442,11 +410,6 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
>  		/* Read results */
>  		len = twl4030_madc_read_channels(madc, method->rbase,
>  						 r->channels, r->rbuf, r->raw);
> -		/* Return results to caller */
> -		if (r->func_cb != NULL) {
> -			r->func_cb(len, r->channels, r->rbuf);
> -			r->func_cb = NULL;
> -		}
>  		/* Free request */
>  		r->result_pending = 0;
>  		r->active = 0;
> @@ -468,11 +431,6 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
>  		/* Read results */
>  		len = twl4030_madc_read_channels(madc, method->rbase,
>  						 r->channels, r->rbuf, r->raw);
> -		/* Return results to caller */
> -		if (r->func_cb != NULL) {
> -			r->func_cb(len, r->channels, r->rbuf);
> -			r->func_cb = NULL;
> -		}
>  		/* Free request */
>  		r->result_pending = 0;
>  		r->active = 0;
> @@ -482,23 +440,6 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
>  	return IRQ_HANDLED;
>  }
>  
> -static int twl4030_madc_set_irq(struct twl4030_madc_data *madc,
> -				struct twl4030_madc_request *req)
> -{
> -	struct twl4030_madc_request *p;
> -	int ret;
> -
> -	p = &madc->requests[req->method];
> -	memcpy(p, req, sizeof(*req));
> -	ret = twl4030_madc_enable_irq(madc, req->method);
> -	if (ret < 0) {
> -		dev_err(madc->dev, "enable irq failed!!\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * Function which enables the madc conversion
>   * by writing to the control register.
> @@ -607,17 +548,6 @@ static int twl4030_madc_conversion(struct twl4030_madc_request *req)
>  			goto out;
>  		}
>  	}
> -	if (req->type == TWL4030_MADC_IRQ_ONESHOT && req->func_cb != NULL) {
> -		ret = twl4030_madc_set_irq(twl4030_madc, req);
> -		if (ret < 0)
> -			goto out;
> -		ret = twl4030_madc_start_conversion(twl4030_madc, req->method);
> -		if (ret < 0)
> -			goto out;
> -		twl4030_madc->requests[req->method].active = 1;
> -		ret = 0;
> -		goto out;
> -	}
>  	/* With RT method we should not be here anymore */
>  	if (req->method == TWL4030_MADC_RT) {
>  		ret = -EINVAL;
> diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
> index f395700fb933..34e94747b61e 100644
> --- a/include/linux/i2c/twl4030-madc.h
> +++ b/include/linux/i2c/twl4030-madc.h
> @@ -51,7 +51,6 @@ struct twl4030_madc_request {
>  	bool result_pending;
>  	bool raw;
>  	int rbuf[TWL4030_MADC_MAX_CHANNELS];
> -	void (*func_cb)(int len, int channels, int *buf);
>  };
>  
>  enum conversion_methods {
> 

