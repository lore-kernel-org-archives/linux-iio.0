Return-Path: <SRS0=AjrS=6J=linaro.org=lee.jones@kernel.org>
Date: Thu, 6 Jul 2017 08:10:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jack Andersen <jackoalan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 2/3] mfd: dln2: Add cell for initializing DLN2 ADC
Message-ID: <20170706071012.57dau6suwyqbqp3a@dell>
References: <b5ede0cc2cb36695b86edf44c0dddbc4736a6420>
 <1499289168-14392-2-git-send-email-jackoalan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1499289168-14392-2-git-send-email-jackoalan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 05 Jul 2017, Jack Andersen wrote:

> Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> ---
>  drivers/mfd/dln2.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Patch looks fine, but you need a commit message.

Once you have one, you may apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 704e189..a22ab8c 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -53,6 +53,7 @@ enum dln2_handle {
>  	DLN2_HANDLE_GPIO,
>  	DLN2_HANDLE_I2C,
>  	DLN2_HANDLE_SPI,
> +	DLN2_HANDLE_ADC,
>  	DLN2_HANDLES
>  };
>  
> @@ -663,6 +664,12 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
>  	.port = 0,
>  };
>  
> +/* Only one ADC port supported */
> +static struct dln2_platform_data dln2_pdata_adc = {
> +	.handle = DLN2_HANDLE_ADC,
> +	.port = 0,
> +};
> +
>  static const struct mfd_cell dln2_devs[] = {
>  	{
>  		.name = "dln2-gpio",
> @@ -679,6 +686,11 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
>  		.platform_data = &dln2_pdata_spi,
>  		.pdata_size = sizeof(struct dln2_platform_data),
>  	},
> +	{
> +		.name = "dln2-adc",
> +		.platform_data = &dln2_pdata_adc,
> +		.pdata_size = sizeof(struct dln2_platform_data),
> +	},
>  };
>  
>  static void dln2_stop(struct dln2_dev *dln2)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
