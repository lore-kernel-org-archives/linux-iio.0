Return-Path: <spk.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1403072503-29246-2-git-send-email-beomho.seo@samsung.com>
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
	<1403072503-29246-2-git-send-email-beomho.seo@samsung.com>
Date: Wed, 18 Jun 2014 12:05:10 +0530
Message-ID: <CAK5sBcEdvXNmcpFSMr+bL8AEy39u3arcuL1hQi6Lm4W8kWxMGQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: adc: exynos_adc: Use devm_* APIs
From: Sachin Kamat <spk.linux@gmail.com>
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, j.anaszewski@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>, naveen krishna <ch.naveen@samsung.com>, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com,
	myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Beomho,

On Wed, Jun 18, 2014 at 11:51 AM, Beomho Seo <beomho.seo@samsung.com> wrote:
> This patch changes APIs from request_irq() and iio_device_register()
> to devm_* APIs. Using them, make code simpler.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/iio/adc/exynos_adc.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index d325aea..37b6eb5 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -337,7 +337,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>         else
>                 indio_dev->num_channels = MAX_ADC_V2_CHANNELS;
>
> -       ret = request_irq(info->irq, exynos_adc_isr,
> +       ret = devm_request_irq(&pdev->dev, info->irq, exynos_adc_isr,
>                                         0, dev_name(&pdev->dev), info);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
> @@ -345,9 +345,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
>                 goto err_disable_clk;
>         }
>
> -       ret = iio_device_register(indio_dev);
> +       ret = devm_iio_device_register(&pdev->dev, indio_dev);
>         if (ret)
> -               goto err_irq;
> +               goto err_disable_clk;
>
>         exynos_adc_hw_init(info);
>
> @@ -362,9 +362,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  err_of_populate:
>         device_for_each_child(&pdev->dev, NULL,
>                                 exynos_adc_remove_devices);
> -       iio_device_unregister(indio_dev);
> -err_irq:
> -       free_irq(info->irq, info);
>  err_disable_clk:
>         writel(0, info->enable_reg);
>         clk_disable_unprepare(info->clk);
> @@ -380,8 +377,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
>
>         device_for_each_child(&pdev->dev, NULL,
>                                 exynos_adc_remove_devices);
> -       iio_device_unregister(indio_dev);
> -       free_irq(info->irq, info);
>         writel(0, info->enable_reg);
>         clk_disable_unprepare(info->clk);
>         regulator_disable(info->vdd);
> --
> 1.7.9.5
>

I am not sure if this change is safe as it changes the order of execution.
With devm_request_irq, irq is freed only after the function completes, i.e.,
the order will now be something like

writel(0, info->enable_reg)
clk_disable_unprepare(info->clk);
regulator_disable(info->vdd);
iio_device_unregister
free_irq

which is not what the original code did.

-- 
Regards,
Sachin.
