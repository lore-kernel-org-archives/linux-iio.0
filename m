Return-Path: <naveenkrishna.ch@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1364290931-25772-2-git-send-email-sachin.kamat@linaro.org>
References: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org> <1364290931-25772-2-git-send-email-sachin.kamat@linaro.org>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Tue, 26 Mar 2013 18:53:04 +0530
Message-ID: <CAHfPSqA188F0FFUv1jxiD1WTAmsS72TcN0gkPR24iisb-Qp=TA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: exynos_adc: Fix a typo in Kconfig help text
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, jic23@cam.ac.uk,
	My self <ch.naveen@samsung.com>, patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 26 March 2013 15:12, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Fixes a trivial typo.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/iio/adc/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ab0767e6..718084f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -108,7 +108,7 @@ config EXYNOS_ADC
>         depends on OF
>         help
>           Core support for the ADC block found in the Samsung EXYNOS series
> -         of SoCs for drivers such as the touchscreen and hwmon to use to share
I took these lines from arch/arm/plat-samsung/Kconfig for S3C ADC.
Sure if this change makes sence.
> +         of SoCs for drivers such as the touchscreen and hwmon to use and share
>           this resource.
>
>  config LP8788_ADC
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Shine bright,
(: Nav :)
