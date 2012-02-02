Return-Path: <wellsk40@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1328194978-20064-1-git-send-email-stigge@antcom.de>
References: <1328194978-20064-1-git-send-email-stigge@antcom.de>
Date: Thu, 2 Feb 2012 14:53:15 -0800
Message-ID: <CADEiroq7=c6gqc-nT3V_HHDWhExfWw=hFY4XVz+-7UYd4Zze4w@mail.gmail.com>
Subject: Re: [PATCH] ARM: LPC32xx: ADC support
From: Kevin Wells <wellsk40@gmail.com>
To: stigge@antcom.de
Cc: w.sang@pengutronix.de, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org, kevin.wells@nxp.com,
	linux-arm-kernel@lists.infradead.org, jic23@cam.ac.uk,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 2, 2012 at 7:02 AM,  <stigge@antcom.de> wrote:
> This patch adds a 3-channel ADC driver for the LPC32xx ARM SoC
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.=
c
> index c269ef5..9cda6fa 100644
> --- a/arch/arm/mach-lpc32xx/clock.c
> +++ b/arch/arm/mach-lpc32xx/clock.c
> @@ -760,6 +760,36 @@ static struct clk clk_tsc =3D {
> =A0 =A0 =A0 =A0.get_rate =A0 =A0 =A0 =3D local_return_parent_rate,
> =A0};
>
> +static int adc_onoff_enable(struct clk *clk, int enable)
> +{
> + =A0 =A0 =A0 u32 tmp;
> +
> + =A0 =A0 =A0 /* Use PERIPH_CLOCK */
> + =A0 =A0 =A0 tmp =3D __raw_readl(LPC32XX_CLKPWR_ADC_CLK_CTRL_1);
> + =A0 =A0 =A0 tmp |=3D LPC32XX_CLKPWR_ADCCTRL1_PCLK_SEL;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set clock divider so that we have equal to or less tha=
n
> + =A0 =A0 =A0 =A0* 4.5MHz clock at ADC
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 tmp |=3D clk->get_rate(clk) / 4500000 + 1;
> + =A0 =A0 =A0 __raw_writel(tmp, LPC32XX_CLKPWR_ADC_CLK_CTRL_1);

For this clock, also set clk->rate =3D (actual rate of the ADC input clock)=
.
Something like clk->rate =3D clk->get_rate(clk->parent) / (computed divider=
)
If the clk->rate stays at 0, the clk_get_rate() function for the ADC will
return 13Mhz instead of around 4.5MHz.

(I know the driver doesn't use clk_get_rate(), but this might save some
debugging later if it ever does).

> +
> + =A0 =A0 =A0 if (enable =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, clk->enable_reg);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(clk->enable_mask, clk->enable_=
reg);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +

...
...

> +config LPC32XX_ADC
> + =A0 =A0 =A0 tristate "NXP LPC32XX ADC"
> + =A0 =A0 =A0 depends on ARCH_LPC32XX && !TOUCHSCREEN_LPC32XX
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say yes here to build support for the integrated ADC in=
side the
> + =A0 =A0 =A0 =A0 LPC32XX SoC. Note that this feature uses the same hardw=
are as the
> + =A0 =A0 =A0 =A0 touchscreen driver, so you can only select one of the t=
wo drivers
> + =A0 =A0 =A0 =A0 (lpc32xx_adc or lpc32xx_ts). Provides direct access via=
 sysfs.

I like how clean this driver is. Thanks for taking the time to write and su=
bmit
this.

> +
> =A0endmenu
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/M=
akefile
> index ceee7f3..f83ab95 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -37,3 +37,4 @@ obj-$(CONFIG_AD7192) +=3D ad7192.o

...
...

> + =A0 =A0 =A0 platform_set_drvdata(pdev, info);
> +
> + =A0 =A0 =A0 device_init_wakeup(&pdev->dev, 1);

I don't think you need this for this driver.

> + =A0 =A0 =A0 init_completion(&info->completion);
> +
> + =A0 =A0 =A0 printk(KERN_INFO "LPC32XX ADC driver loaded, IRQ %d\n", inf=
o->irq);

dev_info instead of printk

> +
> + =A0 =A0 =A0 return 0;
> +
> +errout6:
> + =A0 =A0 =A0 clk_disable(info->clk);
> + =A0 =A0 =A0 clk_put(info->clk);
> +errout5:
> + =A0 =A0 =A0 iio_device_unregister(info->dev);
> +errout4:
> + =A0 =A0 =A0 iounmap(info->adc_base);
> +errout3:
> + =A0 =A0 =A0 iio_free_device(info->dev);
> +errout1:
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static int __devexit lpc32xx_adc_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct lpc32xx_adc_info *info =3D platform_get_drvdata(pdev=
);
> +
> + =A0 =A0 =A0 free_irq(info->irq, info->dev);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 clk_disable(info->clk);
> + =A0 =A0 =A0 clk_put(info->clk);
> + =A0 =A0 =A0 iio_device_unregister(info->dev);
> + =A0 =A0 =A0 iio_free_device(info->dev);
> + =A0 =A0 =A0 iounmap(info->adc_base);
> + =A0 =A0 =A0 kfree(info);

This may be ok. Needs a sanity check only.
kfree() is used in remove() but not used in probe() failure path. Might be
missing in probe() or not needed here.

> +
> + =A0 =A0 =A0 printk(KERN_INFO "LPC32XX ADC driver unloaded\n");

dev_info()

> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#if defined(CONFIG_SUSPEND)
> +static int lpc32xx_adc_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct lpc32xx_adc_info *info =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 clk_disable(info->clk);

The ADC block doesn't have to remain clocked when it's not being used.
You might just encapsulate the main ADC read code with clock enable/disable
and remove the suspend code and enable/disable code in probe/remove.
This should save a little power when the ADC is idle.

> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int lpc32xx_adc_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct lpc32xx_adc_info *info =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 clk_enable(info->clk);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct dev_pm_ops lpc32xx_adc_pm_ops =3D {
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D lpc32xx_adc_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D lpc32xx_adc_resume,
> +};
> +#define LPC32XX_ADC_PM_OPS (&lpc32xx_adc_pm_ops)
> +#else
> +#define LPC32XX_ADC_PM_OPS NULL
> +#endif
> +
> +static struct platform_driver lpc32xx_adc_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D lpc32xx_adc_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(lpc32xx_adc_remove)=
,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D MOD_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D LPC32XX_ADC_PM_OPS,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init lpc32xx_adc_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&lpc32xx_adc_driver);
> +}
> +
> +static void __exit lpc32xx_adc_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&lpc32xx_adc_driver);
> +}
> +
> +module_init(lpc32xx_adc_init);
> +module_exit(lpc32xx_adc_exit);
> +
> +MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
> +MODULE_DESCRIPTION("LPC32XX ADC driver");
> +MODULE_LICENSE("GPL");
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
