Return-Path: <jic23@kernel.org>
Message-ID: <51555DFF.2020000@kernel.org>
Date: Fri, 29 Mar 2013 09:25:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk, ch.naveen@samsung.com,
 patches@linaro.org
Subject: Re: [PATCH 1/2] iio: exynos_adc: Remove redundant of_match_ptr macro
References: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/26/2013 09:42 AM, Sachin Kamat wrote:
> exynos_adc is a DT only driver and exynos_adc_match table is always
> compiled in. Hence remove the macro.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git
> ---
>  drivers/iio/adc/exynos_adc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 4a8a9a3..9f3a8ef 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -440,7 +440,7 @@ static struct platform_driver exynos_adc_driver = {
>  	.driver		= {
>  		.name	= "exynos-adc",
>  		.owner	= THIS_MODULE,
> -		.of_match_table = of_match_ptr(exynos_adc_match),
> +		.of_match_table = exynos_adc_match,
>  		.pm	= &exynos_adc_pm_ops,
>  	},
>  };
> 
