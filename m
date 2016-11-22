Return-Path: <benjamin.gaignard@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20161122164106.GJ10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-3-git-send-email-benjamin.gaignard@st.com>
 <20161122163018.GI10134@dell.home> <20161122164106.GJ10134@dell.home>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 22 Nov 2016 17:40:19 +0100
Message-ID: <CA+M3ks6neH0HHoBGNzTAyYX=f6GOZO_SuGxBzrms2oQJXauD6A@mail.gmail.com>
Subject: Re: [PATCH 2/7] add MFD for stm32 timer IP
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Your comments are welcome on all of them ;-)

2016-11-22 17:41 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Tue, 22 Nov 2016, Lee Jones wrote:
>
>> On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
>>
>> > This hardware block could at used at same time for PWM generation
>> > and IIO timer for other IPs like DAC, ADC or other timers.
>> > PWM and IIO timer configuration are mixed in the same registers
>> > so we need a MFD to be able to share those registers.
>> >
>> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> > ---
>> >  drivers/mfd/Kconfig                 |  10 ++
>> >  drivers/mfd/Makefile                |   2 +
>> >  drivers/mfd/stm32-mfd-timer.c       | 236 +++++++++++++++++++++++++++=
+++++++++
>> >  include/linux/mfd/stm32-mfd-timer.h |  78 ++++++++++++
>> >  4 files changed, 326 insertions(+)
>> >  create mode 100644 drivers/mfd/stm32-mfd-timer.c
>> >  create mode 100644 include/linux/mfd/stm32-mfd-timer.h
>>
>> This driver is going to need a re-write.
>>
>> However, it's difficult to provide suggestions, since I've been left
>> off of the Cc: list for all the other patches.
>>
>> Please re-send the set with all of the Maintainers Cc'ed on all of
>> the patches.
>
> Scrap that -- they all just came trickling through!
>
>> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> > index c6df644..63aee36 100644
>> > --- a/drivers/mfd/Kconfig
>> > +++ b/drivers/mfd/Kconfig
>> > @@ -1607,6 +1607,15 @@ config MFD_STW481X
>> >       in various ST Microelectronics and ST-Ericsson embedded
>> >       Nomadik series.
>> >
>> > +config MFD_STM32_TIMER
>> > +   tristate "Support for STM32 multifunctions timer"
>> > +   select MFD_CORE
>> > +   select REGMAP
>> > +   depends on ARCH_STM32
>> > +   depends on OF
>> > +   help
>> > +     Select multifunction driver (pwm, IIO trigger) for stm32 timers
>> > +
>> >  menu "Multimedia Capabilities Port drivers"
>> >     depends on ARCH_SA1100
>> >
>> > @@ -1644,4 +1653,5 @@ config MFD_VEXPRESS_SYSREG
>> >       on the ARM Ltd. Versatile Express board.
>> >
>> >  endmenu
>> > +
>> >  endif
>> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> > index 9834e66..b348c3e 100644
>> > --- a/drivers/mfd/Makefile
>> > +++ b/drivers/mfd/Makefile
>> > @@ -211,3 +211,5 @@ obj-$(CONFIG_INTEL_SOC_PMIC)    +=3D intel-soc-pmi=
c.o
>> >  obj-$(CONFIG_MFD_MT6397)   +=3D mt6397-core.o
>> >
>> >  obj-$(CONFIG_MFD_ALTERA_A10SR)     +=3D altera-a10sr.o
>> > +
>> > +obj-$(CONFIG_MFD_STM32_TIMER)      +=3D stm32-mfd-timer.o
>> > diff --git a/drivers/mfd/stm32-mfd-timer.c b/drivers/mfd/stm32-mfd-tim=
er.c
>> > new file mode 100644
>> > index 0000000..67e7db3
>> > --- /dev/null
>> > +++ b/drivers/mfd/stm32-mfd-timer.c
>> > @@ -0,0 +1,236 @@
>> > +/*
>> > + * stm32-timer.c
>> > + *
>> > + * Copyright (C) STMicroelectronics 2016
>> > + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroel=
ectronics.
>> > + * License terms:  GNU General Public License (GPL), version 2
>> > + */
>> > +
>> > +#include <linux/device.h>
>> > +#include <linux/init.h>
>> > +#include <linux/module.h>
>> > +#include <linux/of.h>
>> > +
>> > +#include <linux/mfd/stm32-mfd-timer.h>
>> > +
>> > +static const struct stm32_mfd_timer_cfg mfd_cells_cfg[] =3D {
>> > +   {
>> > +           .pwm_name =3D "pwm1",
>> > +           .pwm_compatible =3D "st,stm32-pwm1",
>> > +           .trigger_name =3D "iiotimer1",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer1",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm2",
>> > +           .pwm_compatible =3D "st,stm32-pwm2",
>> > +           .trigger_name =3D "iiotimer2",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer2",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm3",
>> > +           .pwm_compatible =3D "st,stm32-pwm3",
>> > +           .trigger_name =3D "iiotimer3",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer3",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm4",
>> > +           .pwm_compatible =3D "st,stm32-pwm4",
>> > +           .trigger_name =3D "iiotimer4",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer4",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm5",
>> > +           .pwm_compatible =3D "st,stm32-pwm5",
>> > +           .trigger_name =3D "iiotimer5",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer5",
>> > +   },
>> > +   {
>> > +           .trigger_name =3D "iiotimer6",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer6",
>> > +   },
>> > +   {
>> > +           .trigger_name =3D "iiotimer7",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer7",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm8",
>> > +           .pwm_compatible =3D "st,stm32-pwm8",
>> > +           .trigger_name =3D "iiotimer8",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer8",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm9",
>> > +           .pwm_compatible =3D "st,stm32-pwm9",
>> > +           .trigger_name =3D "iiotimer9",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer9",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm10",
>> > +           .pwm_compatible =3D "st,stm32-pwm10",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm11",
>> > +           .pwm_compatible =3D "st,stm32-pwm11",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm12",
>> > +           .pwm_compatible =3D "st,stm32-pwm12",
>> > +           .trigger_name =3D "iiotimer12",
>> > +           .trigger_compatible =3D "st,stm32-iio-timer12",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm13",
>> > +           .pwm_compatible =3D "st,stm32-pwm13",
>> > +   },
>> > +   {
>> > +           .pwm_name =3D "pwm14",
>> > +           .pwm_compatible =3D "st,stm32-pwm14",
>> > +   },
>> > +};
>> > +
>> > +static const struct of_device_id stm32_timer_of_match[] =3D {
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer1",
>> > +           .data =3D &mfd_cells_cfg[0],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer2",
>> > +           .data =3D &mfd_cells_cfg[1],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer3",
>> > +           .data =3D &mfd_cells_cfg[2],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer4",
>> > +           .data =3D &mfd_cells_cfg[3],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer5",
>> > +           .data =3D &mfd_cells_cfg[4],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer6",
>> > +           .data =3D &mfd_cells_cfg[5],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer7",
>> > +           .data =3D &mfd_cells_cfg[6],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer8",
>> > +           .data =3D &mfd_cells_cfg[7],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer9",
>> > +           .data =3D &mfd_cells_cfg[8],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer10",
>> > +           .data =3D &mfd_cells_cfg[9],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer11",
>> > +           .data =3D &mfd_cells_cfg[10],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer12",
>> > +           .data =3D &mfd_cells_cfg[11],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer13",
>> > +           .data =3D &mfd_cells_cfg[12],
>> > +   },
>> > +   {
>> > +           .compatible =3D "st,stm32-mfd-timer14",
>> > +           .data =3D &mfd_cells_cfg[13],
>> > +   },
>> > +};
>> > +
>> > +static const struct regmap_config stm32_timer_regmap_cfg =3D {
>> > +   .reg_bits =3D 32,
>> > +   .val_bits =3D 32,
>> > +   .reg_stride =3D sizeof(u32),
>> > +   .max_register =3D 0x400,
>> > +   .fast_io =3D true,
>> > +};
>> > +
>> > +static int stm32_mfd_timer_probe(struct platform_device *pdev)
>> > +{
>> > +   struct device *dev =3D &pdev->dev;
>> > +   struct device_node *np =3D dev->of_node;
>> > +   struct stm32_mfd_timer_dev *mfd;
>> > +   struct resource *res;
>> > +   int ret, nb_cells =3D 0;
>> > +   struct mfd_cell *cell =3D NULL;
>> > +   void __iomem *mmio;
>> > +
>> > +   mfd =3D devm_kzalloc(dev, sizeof(*mfd), GFP_KERNEL);
>> > +   if (!mfd)
>> > +           return -ENOMEM;
>> > +
>> > +   res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > +   if (!res)
>> > +           return -ENOMEM;
>> > +
>> > +   mmio =3D devm_ioremap_resource(dev, res);
>> > +   if (IS_ERR(mmio))
>> > +           return PTR_ERR(mmio);
>> > +
>> > +   mfd->regmap =3D devm_regmap_init_mmio_clk(dev, "mfd_timer_clk", mm=
io,
>> > +                                           &stm32_timer_regmap_cfg);
>> > +   if (IS_ERR(mfd->regmap))
>> > +           return PTR_ERR(mfd->regmap);
>> > +
>> > +   mfd->clk =3D devm_clk_get(dev, NULL);
>> > +   if (IS_ERR(mfd->clk))
>> > +           return PTR_ERR(mfd->clk);
>> > +
>> > +   mfd->irq =3D platform_get_irq(pdev, 0);
>> > +   if (mfd->irq < 0)
>> > +           return -EINVAL;
>> > +
>> > +   /* populate data structure depending on compatibility */
>> > +   if (!of_match_node(stm32_timer_of_match, np)->data)
>> > +           return -EINVAL;
>> > +
>> > +   mfd->cfg =3D
>> > +   (struct stm32_mfd_timer_cfg *)of_match_node(stm32_timer_of_match, =
np)->data;
>> > +
>> > +   if (mfd->cfg->pwm_name && mfd->cfg->pwm_compatible) {
>> > +           cell =3D &mfd->cells[nb_cells++];
>> > +           cell->name =3D mfd->cfg->pwm_name;
>> > +           cell->of_compatible =3D mfd->cfg->pwm_compatible;
>> > +           cell->platform_data =3D mfd;
>> > +           cell->pdata_size =3D sizeof(*mfd);
>> > +   }
>> > +
>> > +   if (mfd->cfg->trigger_name && mfd->cfg->trigger_compatible) {
>> > +           cell =3D &mfd->cells[nb_cells++];
>> > +           cell->name =3D mfd->cfg->trigger_name;
>> > +           cell->of_compatible =3D mfd->cfg->trigger_compatible;
>> > +           cell->platform_data =3D mfd;
>> > +           cell->pdata_size =3D sizeof(*mfd);
>> > +   }
>> > +
>> > +   ret =3D devm_mfd_add_devices(&pdev->dev, pdev->id, mfd->cells,
>> > +                              nb_cells, NULL, 0, NULL);
>> > +   if (ret)
>> > +           return ret;
>> > +
>> > +   platform_set_drvdata(pdev, mfd);
>> > +
>> > +   return 0;
>> > +}
>> > +
>> > +static struct platform_driver stm32_mfd_timer_driver =3D {
>> > +   .probe          =3D stm32_mfd_timer_probe,
>> > +   .driver =3D {
>> > +           .name   =3D "stm32-mfd-timer",
>> > +           .of_match_table =3D stm32_timer_of_match,
>> > +   },
>> > +};
>> > +module_platform_driver(stm32_mfd_timer_driver);
>> > +
>> > +MODULE_DESCRIPTION("STMicroelectronics STM32 Timer MFD");
>> > +MODULE_LICENSE("GPL");
>> > diff --git a/include/linux/mfd/stm32-mfd-timer.h b/include/linux/mfd/s=
tm32-mfd-timer.h
>> > new file mode 100644
>> > index 0000000..4a79c22
>> > --- /dev/null
>> > +++ b/include/linux/mfd/stm32-mfd-timer.h
>> > @@ -0,0 +1,78 @@
>> > +/*
>> > + * stm32-mfd-timer.h
>> > + *
>> > + * Copyright (C) STMicroelectronics 2016
>> > + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroel=
ectronics.
>> > + * License terms:  GNU General Public License (GPL), version 2
>> > + */
>> > +
>> > +#ifndef _LINUX_MFD_STM32_TIMER_H_
>> > +#define _LINUX_MFD_STM32_TIMER_H_
>> > +
>> > +#include <linux/clk.h>
>> > +#include <linux/mfd/core.h>
>> > +#include <linux/regmap.h>
>> > +#include <linux/reset.h>
>> > +
>> > +#define TIM_CR1            0x00    /* Control Register 1      */
>> > +#define TIM_CR2            0x04    /* Control Register 2      */
>> > +#define TIM_SMCR   0x08    /* Slave mode control reg  */
>> > +#define TIM_DIER   0x0C    /* DMA/interrupt register  */
>> > +#define TIM_SR             0x10    /* Status register         */
>> > +#define TIM_EGR            0x14    /* Event Generation Reg    */
>> > +#define TIM_CCMR1  0x18    /* Capt/Comp 1 Mode Reg    */
>> > +#define TIM_CCMR2  0x1C    /* Capt/Comp 2 Mode Reg    */
>> > +#define TIM_CCER   0x20    /* Capt/Comp Enable Reg    */
>> > +#define TIM_PSC            0x28    /* Prescaler               */
>> > +#define TIM_ARR            0x2c    /* Auto-Reload Register    */
>> > +#define TIM_CCR1   0x34    /* Capt/Comp Register 1    */
>> > +#define TIM_CCR2   0x38    /* Capt/Comp Register 2    */
>> > +#define TIM_CCR3   0x3C    /* Capt/Comp Register 3    */
>> > +#define TIM_CCR4   0x40    /* Capt/Comp Register 4    */
>> > +#define TIM_BDTR   0x44    /* Break and Dead-Time Reg */
>> > +
>> > +#define TIM_CR1_CEN        BIT(0)  /* Counter Enable          */
>> > +#define TIM_CR1_ARPE       BIT(7)  /* Auto-reload Preload Ena */
>> > +#define TIM_CR2_MMS        (BIT(4) | BIT(5) | BIT(6)) /* Master mode =
selection */
>> > +#define TIM_SMCR_SMS       (BIT(0) | BIT(1) | BIT(2)) /* Slave mode s=
election */
>> > +#define TIM_SMCR_TS        (BIT(4) | BIT(5) | BIT(6)) /* Trigger sele=
ction */
>> > +#define TIM_DIER_UIE       BIT(0)  /* Update interrupt        */
>> > +#define TIM_SR_UIF BIT(0)  /* Update interrupt flag   */
>> > +#define TIM_EGR_UG BIT(0)  /* Update Generation       */
>> > +#define TIM_CCMR_PE        BIT(3)  /* Channel Preload Enable  */
>> > +#define TIM_CCMR_M1        (BIT(6) | BIT(5))  /* Channel PWM Mode 1 *=
/
>> > +#define TIM_CCER_CC1E      BIT(0)  /* Capt/Comp 1  out Ena    */
>> > +#define TIM_CCER_CC1P      BIT(1)  /* Capt/Comp 1  Polarity   */
>> > +#define TIM_CCER_CC1NE     BIT(2)  /* Capt/Comp 1N out Ena    */
>> > +#define TIM_CCER_CC1NP     BIT(3)  /* Capt/Comp 1N Polarity   */
>> > +#define TIM_CCER_CCXE      (BIT(0) | BIT(4) | BIT(8) | BIT(12))
>> > +#define TIM_BDTR_BKE       BIT(12) /* Break input enable      */
>> > +#define TIM_BDTR_BKP       BIT(13) /* Break input polarity    */
>> > +#define TIM_BDTR_AOE       BIT(14) /* Automatic Output Enable */
>> > +#define TIM_BDTR_MOE       BIT(15) /* Main Output Enable      */
>> > +
>> > +#define STM32_TIMER_CELLS  2
>> > +#define MAX_TIM_PSC                0xFFFF
>> > +
>> > +struct stm32_mfd_timer_cfg {
>> > +   const char *pwm_name;
>> > +   const char *pwm_compatible;
>> > +   const char *trigger_name;
>> > +   const char *trigger_compatible;
>> > +};
>> > +
>> > +struct stm32_mfd_timer_dev {
>> > +   /* Device data */
>> > +   struct device *dev;
>> > +   struct clk *clk;
>> > +   int irq;
>> > +
>> > +   /* Registers mapping */
>> > +   struct regmap *regmap;
>> > +
>> > +   /* Private data */
>> > +   struct mfd_cell cells[STM32_TIMER_CELLS];
>> > +   struct stm32_mfd_timer_cfg *cfg;
>> > +};
>> > +
>> > +#endif
>>
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
