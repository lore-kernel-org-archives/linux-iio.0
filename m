Return-Path: <lee.jones@linaro.org>
Date: Tue, 18 Nov 2014 15:25:41 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, IIO <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Carlo Caione <carlo@caione.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 3/3] iio/axp288_adc: remove THIS_MODULE owner
Message-ID: <20141118152541.GB13792@x1>
References: <1415734210-5657-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1415734210-5657-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1415734210-5657-4-git-send-email-jacob.jun.pan@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, 11 Nov 2014, Jacob Pan wrote:

> This is no longer needed in that platform driver_register will do it.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iio/adc/axp288_adc.c | 1 -
>  1 file changed, 1 deletion(-)

Applied thanks.

> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 4a6cf43..08bcfb0 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -249,7 +249,6 @@ static struct platform_driver axp288_adc_driver = {
>  	.id_table = axp288_adc_id_table,
>  	.driver = {
>  		.name = "axp288_adc",
> -		.owner = THIS_MODULE,
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
