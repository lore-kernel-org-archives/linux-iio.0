Return-Path: <dmitry.torokhov@gmail.com>
Date: Mon, 25 Apr 2016 14:00:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 1/3] iio: mxs-lradc: simplify TS registration
Message-ID: <20160425210006.GA26059@dtor-ws>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <1461441479-23218-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461441479-23218-2-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Apr 23, 2016 at 07:57:57PM +0000, Stefan Wahren wrote:
> This patch simplifies the TS registration of mxs-lradc by
> using devm_input_allocate_device.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/iio/adc/mxs-lradc.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index ad26da1..3d1d370 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1120,18 +1120,16 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  {
>  	struct input_dev *input;
>  	struct device *dev = lradc->dev;
> -	int ret;
>  
>  	if (!lradc->use_touchscreen)
>  		return 0;
>  
> -	input = input_allocate_device();
> +	input = devm_input_allocate_device(dev);
>  	if (!input)
>  		return -ENOMEM;
>  
>  	input->name = DRIVER_NAME;
>  	input->id.bustype = BUS_HOST;
> -	input->dev.parent = dev;
>  	input->open = mxs_lradc_ts_open;
>  	input->close = mxs_lradc_ts_close;
>  
> @@ -1146,11 +1144,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  
>  	lradc->ts_input = input;
>  	input_set_drvdata(input, lradc);
> -	ret = input_register_device(input);
> -	if (ret)
> -		input_free_device(lradc->ts_input);
>  
> -	return ret;
> +	return input_register_device(input);
>  }
>  
>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> @@ -1159,7 +1154,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>  		return;
>  
>  	mxs_lradc_disable_ts(lradc);
> -	input_unregister_device(lradc->ts_input);
>  }
>  
>  /*
> -- 
> 1.7.9.5
> 

-- 
Dmitry
