Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
Date: Mon, 15 Apr 2013 13:52:26 +0530
Message-ID: <CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] adc: exynos_adc: Convert to devm_ioremap_resource()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 3 April 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/iio/adc/exynos_adc.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 9f3a8ef..22d034a 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -270,16 +270,16 @@ static int exynos_adc_probe(struct platform_device *pdev)
>         info = iio_priv(indio_dev);
>
>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       info->regs = devm_request_and_ioremap(&pdev->dev, mem);
> -       if (!info->regs) {
> -               ret = -ENOMEM;
> +       info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +       if (IS_ERR(info->regs)) {
> +               ret = PTR_ERR(info->regs);
>                 goto err_iio;
>         }
>
>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       info->enable_reg = devm_request_and_ioremap(&pdev->dev, mem);
> -       if (!info->enable_reg) {
> -               ret = -ENOMEM;
> +       info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
> +       if (IS_ERR(info->enable_reg)) {
> +               ret = PTR_ERR(info->enable_reg);
>                 goto err_iio;
>         }
>
> --
> 1.7.9.5
>

Ping, Jonathan.


-- 
With warm regards,
Sachin
