Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50783 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdA2Lx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 06:53:57 -0500
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0d474586-89d9-9019-698d-bc47f4510573@kernel.org>
Date: Sun, 29 Jan 2017 11:53:35 +0000
MIME-Version: 1.0
In-Reply-To: <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/17 16:32, Arnaud Pouliquen wrote:
> DFSDM hardware IP can be used at the same time for ADC sigma delta
> conversion and audio PDM microphone.
> MFD driver is in charge of configuring IP registers and managing IP clocks.
> For this it exports an API to handles filters and channels resources.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
This is somewhat of a beast.  I would be tempted to build it up in more
bite sized chunks.

Obvious things to drop from a first version (basically to make it easier
to review) would be injected supported.  There may well be others but you'll
have a better feel for that than me.

I really don't like the wrappers round the regmap functions though.
They mean you are papering over errors if they occur and make the code
slightly harder to read by implying that something else is going on.

Yes the code will be longer without them, but you will also be forced to think
properly about error paths.

Anyhow, was mostly reading this to get a feel for what was going on in the
whole series so not really a terribly thorough review I'm afraid. Sorry about
that!

Jonathan
> ---
>  drivers/mfd/Kconfig             |   11 +
>  drivers/mfd/Makefile            |    2 +
>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
>  5 files changed, 1601 insertions(+)
>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
>  create mode 100644 drivers/mfd/stm32-dfsdm.c
>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c6df644..4bb660b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1607,6 +1607,17 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
>  
> +config MFD_STM32_DFSDM
> +	tristate "ST Microelectronics STM32 DFSDM"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the STM32 Digital Filter
> +	  for Sigma Delta Modulators (DFSDM) driver used
> +	  in various STM32 series.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9834e66..1f095e5 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -211,3 +211,5 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +
> +obj-$(CONFIG_MFD_STM32_DFSDM)	+= stm32-dfsdm.o
> \ No newline at end of file
> diff --git a/drivers/mfd/stm32-dfsdm-reg.h b/drivers/mfd/stm32-dfsdm-reg.h
> new file mode 100644
> index 0000000..05ff702
> --- /dev/null
> +++ b/drivers/mfd/stm32-dfsdm-reg.h
> @@ -0,0 +1,220 @@
> +/*
> + * This file is part of STM32 DFSDM mfd driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
> + *
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + */
> +
> +#ifndef MDF_STM32_DFSDM_REG_H
> +#define MDF_STM32_DFSDM_REG_H
> +
> +#include <linux/bitfield.h>
> +/*
> + * Channels definitions
> + */
> +#define DFSDM_CHCFGR1(y)  ((y) * 0x20 + 0x00)
> +#define DFSDM_CHCFGR2(y)  ((y) * 0x20 + 0x04)
> +#define DFSDM_AWSCDR(y)   ((y) * 0x20 + 0x08)
> +#define DFSDM_CHWDATR(y)  ((y) * 0x20 + 0x0C)
> +#define DFSDM_CHDATINR(y) ((y) * 0x20 + 0x10)
> +
> +/* CHCFGR1: Channel configuration register 1 */
> +#define DFSDM_CHCFGR1_SITP_MASK     GENMASK(1, 0)
> +#define DFSDM_CHCFGR1_SITP(v)       FIELD_PREP(DFSDM_CHCFGR1_SITP_MASK, v)
> +#define DFSDM_CHCFGR1_SPICKSEL_MASK GENMASK(3, 2)
> +#define DFSDM_CHCFGR1_SPICKSEL(v)   FIELD_PREP(DFSDM_CHCFGR1_SPICKSEL_MASK, v)
> +#define DFSDM_CHCFGR1_SCDEN_MASK    BIT(5)
> +#define DFSDM_CHCFGR1_SCDEN(v)      FIELD_PREP(DFSDM_CHCFGR1_SCDEN_MASK, v)
> +#define DFSDM_CHCFGR1_CKABEN_MASK   BIT(6)
> +#define DFSDM_CHCFGR1_CKABEN(v)     FIELD_PREP(DFSDM_CHCFGR1_CKABEN_MASK, v)
> +#define DFSDM_CHCFGR1_CHEN_MASK     BIT(7)
> +#define DFSDM_CHCFGR1_CHEN(v)       FIELD_PREP(DFSDM_CHCFGR1_CHEN_MASK, v)
> +#define DFSDM_CHCFGR1_CHINSEL_MASK  BIT(8)
> +#define DFSDM_CHCFGR1_CHINSEL(v)    FIELD_PREP(DFSDM_CHCFGR1_CHINSEL_MASK, v)
> +#define DFSDM_CHCFGR1_DATMPX_MASK   GENMASK(13, 12)
> +#define DFSDM_CHCFGR1_DATMPX(v)     FIELD_PREP(DFSDM_CHCFGR1_DATMPX_MASK, v)
> +#define DFSDM_CHCFGR1_DATPACK_MASK  GENMASK(15, 14)
> +#define DFSDM_CHCFGR1_DATPACK(v)    FIELD_PREP(DFSDM_CHCFGR1_DATPACK_MASK, v)
> +#define DFSDM_CHCFGR1_CKOUTDIV_MASK GENMASK(23, 16)
> +#define DFSDM_CHCFGR1_CKOUTDIV(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTDIV_MASK, v)
> +#define DFSDM_CHCFGR1_CKOUTSRC_MASK BIT(30)
> +#define DFSDM_CHCFGR1_CKOUTSRC(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTSRC_MASK, v)
> +#define DFSDM_CHCFGR1_DFSDMEN_MASK  BIT(31)
> +#define DFSDM_CHCFGR1_DFSDMEN(v)    FIELD_PREP(DFSDM_CHCFGR1_DFSDMEN_MASK, v)
> +
> +/* CHCFGR2: Channel configuration register 2 */
> +#define DFSDM_CHCFGR2_DTRBS_MASK    GENMASK(7, 3)
> +#define DFSDM_CHCFGR2_DTRBS(v)      FIELD_PREP(DFSDM_CHCFGR2_DTRBS_MASK, v)
> +#define DFSDM_CHCFGR2_OFFSET_MASK   GENMASK(31, 8)
> +#define DFSDM_CHCFGR2_OFFSET(v)     FIELD_PREP(DFSDM_CHCFGR2_OFFSET_MASK, v)
> +
> +/* AWSCDR: Channel analog watchdog and short circuit detector */
> +#define DFSDM_AWSCDR_SCDT_MASK    GENMASK(7, 0)
> +#define DFSDM_AWSCDR_SCDT(v)      FIELD_PREP(DFSDM_AWSCDR_SCDT_MASK, v)
> +#define DFSDM_AWSCDR_BKSCD_MASK   GENMASK(15, 12)
> +#define DFSDM_AWSCDR_BKSCD(v)	  FIELD_PREP(DFSDM_AWSCDR_BKSCD_MASK, v)
> +#define DFSDM_AWSCDR_AWFOSR_MASK  GENMASK(20, 16)
> +#define DFSDM_AWSCDR_AWFOSR(v)    FIELD_PREP(DFSDM_AWSCDR_AWFOSR_MASK, v)
> +#define DFSDM_AWSCDR_AWFORD_MASK  GENMASK(23, 22)
> +#define DFSDM_AWSCDR_AWFORD(v)    FIELD_PREP(DFSDM_AWSCDR_AWFORD_MASK, v)
> +
> +/*
> + * Filters definitions
> + */
> +#define DFSDM_FILTER_BASE_ADR		0x100
> +#define DFSDM_FILTER_REG_MASK		0x7F
> +#define DFSDM_FILTER_X_BASE_ADR(x)	((x) * 0x80 + DFSDM_FILTER_BASE_ADR)
> +
> +#define DFSDM_CR1(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x00)
> +#define DFSDM_CR2(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x04)
> +#define DFSDM_ISR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x08)
> +#define DFSDM_ICR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x0C)
> +#define DFSDM_JCHGR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x10)
> +#define DFSDM_FCR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x14)
> +#define DFSDM_JDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x18)
> +#define DFSDM_RDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x1C)
> +#define DFSDM_AWHTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x20)
> +#define DFSDM_AWLTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x24)
> +#define DFSDM_AWSR(x)    (DFSDM_FILTER_X_BASE_ADR(x)  + 0x28)
> +#define DFSDM_AWCFR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x2C)
> +#define DFSDM_EXMAX(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x30)
> +#define DFSDM_EXMIN(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x34)
> +#define DFSDM_CNVTIMR(x) (DFSDM_FILTER_X_BASE_ADR(x)  + 0x38)
> +
> +/* CR1 Control register 1 */
> +#define DFSDM_CR1_DFEN_MASK	BIT(0)
> +#define DFSDM_CR1_DFEN(v)	FIELD_PREP(DFSDM_CR1_DFEN_MASK, v)
> +#define DFSDM_CR1_JSWSTART_MASK	BIT(1)
> +#define DFSDM_CR1_JSWSTART(v)	FIELD_PREP(DFSDM_CR1_JSWSTART_MASK, v)
> +#define DFSDM_CR1_JSYNC_MASK	BIT(3)
> +#define DFSDM_CR1_JSYNC(v)	FIELD_PREP(DFSDM_CR1_JSYNC_MASK, v)
> +#define DFSDM_CR1_JSCAN_MASK	BIT(4)
> +#define DFSDM_CR1_JSCAN(v)	FIELD_PREP(DFSDM_CR1_JSCAN_MASK, v)
> +#define DFSDM_CR1_JDMAEN_MASK	BIT(5)
> +#define DFSDM_CR1_JDMAEN(v)	FIELD_PREP(DFSDM_CR1_JDMAEN_MASK, v)
> +#define DFSDM_CR1_JEXTSEL_MASK	GENMASK(12, 8)
> +#define DFSDM_CR1_JEXTSEL(v)	FIELD_PREP(DFSDM_CR1_JEXTSEL_MASK, v)
> +#define DFSDM_CR1_JEXTEN_MASK	GENMASK(14, 13)
> +#define DFSDM_CR1_JEXTEN(v)	FIELD_PREP(DFSDM_CR1_JEXTEN_MASK, v)
> +#define DFSDM_CR1_RSWSTART_MASK	BIT(17)
> +#define DFSDM_CR1_RSWSTART(v)	FIELD_PREP(DFSDM_CR1_RSWSTART_MASK, v)
> +#define DFSDM_CR1_RCONT_MASK	BIT(18)
> +#define DFSDM_CR1_RCONT(v)	FIELD_PREP(DFSDM_CR1_RCONT_MASK, v)
> +#define DFSDM_CR1_RSYNC_MASK	BIT(19)
> +#define DFSDM_CR1_RSYNC(v)	FIELD_PREP(DFSDM_CR1_RSYNC_MASK, v)
> +#define DFSDM_CR1_RDMAEN_MASK	BIT(21)
> +#define DFSDM_CR1_RDMAEN(v)	FIELD_PREP(DFSDM_CR1_RDMAEN_MASK, v)
> +#define DFSDM_CR1_RCH_MASK	GENMASK(26, 24)
> +#define DFSDM_CR1_RCH(v)	FIELD_PREP(DFSDM_CR1_RCH_MASK, v)
> +#define DFSDM_CR1_FAST_MASK	BIT(29)
> +#define DFSDM_CR1_FAST(v)	FIELD_PREP(DFSDM_CR1_FAST_MASK, v)
> +#define DFSDM_CR1_AWFSEL_MASK	BIT(30)
> +#define DFSDM_CR1_AWFSEL(v)	FIELD_PREP(DFSDM_CR1_AWFSEL_MASK, v)
> +
> +/* CR2: Control register 2 */
> +#define DFSDM_CR2_IE_MASK	GENMASK(6, 0)
> +#define DFSDM_CR2_IE(v)		FIELD_PREP(DFSDM_CR2_IE_MASK, v)
> +#define DFSDM_CR2_JEOCIE_MASK	BIT(0)
> +#define DFSDM_CR2_JEOCIE(v)	FIELD_PREP(DFSDM_CR2_JEOCIE_MASK, v)
> +#define DFSDM_CR2_REOCIE_MASK	BIT(1)
> +#define DFSDM_CR2_REOCIE(v)	FIELD_PREP(DFSDM_CR2_REOCIE_MASK, v)
> +#define DFSDM_CR2_JOVRIE_MASK	BIT(2)
> +#define DFSDM_CR2_JOVRIE(v)	FIELD_PREP(DFSDM_CR2_JOVRIE_MASK, v)
> +#define DFSDM_CR2_ROVRIE_MASK	BIT(3)
> +#define DFSDM_CR2_ROVRIE(v)	FIELD_PREP(DFSDM_CR2_ROVRIE_MASK, v)
> +#define DFSDM_CR2_AWDIE_MASK	BIT(4)
> +#define DFSDM_CR2_AWDIE(v)	FIELD_PREP(DFSDM_CR2_AWDIE_MASK, v)
> +#define DFSDM_CR2_SCDIE_MASK	BIT(5)
> +#define DFSDM_CR2_SCDIE(v)	FIELD_PREP(DFSDM_CR2_SCDIE_MASK, v)
> +#define DFSDM_CR2_CKABIE_MASK	BIT(6)
> +#define DFSDM_CR2_CKABIE(v)	FIELD_PREP(DFSDM_CR2_CKABIE_MASK, v)
> +#define DFSDM_CR2_EXCH_MASK	GENMASK(15, 8)
> +#define DFSDM_CR2_EXCH(v)	FIELD_PREP(DFSDM_CR2_EXCH_MASK, v)
> +#define DFSDM_CR2_AWDCH_MASK	GENMASK(23, 16)
> +#define DFSDM_CR2_AWDCH(v)	FIELD_PREP(DFSDM_CR2_AWDCH_MASK, v)
> +
> +/* ISR: Interrupt status register */
> +#define DFSDM_ISR_JEOCF_MASK	BIT(0)
> +#define DFSDM_ISR_JEOCF(v)	FIELD_PREP(DFSDM_ISR_JEOCF_MASK, v)
> +#define DFSDM_ISR_REOCF_MASK	BIT(1)
> +#define DFSDM_ISR_REOCF(v)	FIELD_PREP(DFSDM_ISR_REOCF_MASK, v)
> +#define DFSDM_ISR_JOVRF_MASK	BIT(2)
> +#define DFSDM_ISR_JOVRF(v)	FIELD_PREP(DFSDM_ISR_JOVRF_MASK, v)
> +#define DFSDM_ISR_ROVRF_MASK	BIT(3)
> +#define DFSDM_ISR_ROVRF(v)	FIELD_PREP(DFSDM_ISR_ROVRF_MASK, v)
> +#define DFSDM_ISR_AWDF_MASK	BIT(4)
> +#define DFSDM_ISR_AWDF(v)	FIELD_PREP(DFSDM_ISR_AWDF_MASK, v)
> +#define DFSDM_ISR_JCIP_MASK	BIT(13)
> +#define DFSDM_ISR_JCIP(v)	FIELD_PREP(DFSDM_ISR_JCIP_MASK, v)
> +#define DFSDM_ISR_RCIP_MASK	BIT(14)
> +#define DFSDM_ISR_RCIP(v)	FIELD_PREP(DFSDM_ISR_RCIP, v)
> +#define DFSDM_ISR_CKABF_MASK	GENMASK(23, 16)
> +#define DFSDM_ISR_CKABF(v)	FIELD_PREP(DFSDM_ISR_CKABF_MASK, v)
> +#define DFSDM_ISR_SCDF_MASK	GENMASK(31, 24)
> +#define DFSDM_ISR_SCDF(v)	FIELD_PREP(DFSDM_ISR_SCDF_MASK, v)
> +
> +/* ICR: Interrupt flag clear register */
> +#define DFSDM_ICR_CLRJOVRF_MASK	      BIT(2)
> +#define DFSDM_ICR_CLRJOVRF(v)	      FIELD_PREP(DFSDM_ICR_CLRJOVRF_MASK, v)
> +#define DFSDM_ICR_CLRROVRF_MASK	      BIT(3)
> +#define DFSDM_ICR_CLRROVRF(v)	      FIELD_PREP(DFSDM_ICR_CLRROVRF_MASK, v)
> +#define DFSDM_ICR_CLRCKABF_MASK	      GENMASK(23, 16)
> +#define DFSDM_ICR_CLRCKABF(v)	      FIELD_PREP(DFSDM_ICR_CLRCKABF_MASK, v)
> +#define DFSDM_ICR_CLRCKABF_CH_MASK(y) BIT(16 + (y))
> +#define DFSDM_ICR_CLRCKABF_CH(v, y)   \
> +			   (((v) << (16 + (y))) & DFSDM_ICR_CLRCKABF_CH_MASK(y))
> +#define DFSDM_ICR_CLRSCDF_MASK	      GENMASK(31, 24)
> +#define DFSDM_ICR_CLRSCDF(v)	      FIELD_PREP(DFSDM_ICR_CLRSCDF_MASK, v)
> +#define DFSDM_ICR_CLRSCDF_CH_MASK(y)  BIT(24 + (y))
> +#define DFSDM_ICR_CLRSCDF_CH(v, y)    \
> +			       (((v) << (24 + (y))) & DFSDM_ICR_CLRSCDF_MASK(y))
> +
> +/* FCR: Filter control register */
> +#define DFSDM_FCR_IOSR_MASK	GENMASK(7, 0)
> +#define DFSDM_FCR_IOSR(v)	FIELD_PREP(DFSDM_FCR_IOSR_MASK, v)
> +#define DFSDM_FCR_FOSR_MASK	GENMASK(25, 16)
> +#define DFSDM_FCR_FOSR(v)	FIELD_PREP(DFSDM_FCR_FOSR_MASK, v)
> +#define DFSDM_FCR_FORD_MASK	GENMASK(31, 29)
> +#define DFSDM_FCR_FORD(v)	FIELD_PREP(DFSDM_FCR_FORD_MASK, v)
> +
> +/* RDATAR: Filter data register for regular channel */
> +#define DFSDM_DATAR_CH_MASK	GENMASK(2, 0)
> +#define DFSDM_DATAR_DATA_OFFSET 8
> +#define DFSDM_DATAR_DATA_MASK	GENMASK(31, DFSDM_DATAR_DATA_OFFSET)
> +
> +/* AWLTR: Filter analog watchdog low threshold register */
> +#define DFSDM_AWLTR_BKAWL_MASK	GENMASK(3, 0)
> +#define DFSDM_AWLTR_BKAWL(v)	FIELD_PREP(DFSDM_AWLTR_BKAWL_MASK, v)
> +#define DFSDM_AWLTR_AWLT_MASK	GENMASK(31, 8)
> +#define DFSDM_AWLTR_AWLT(v)	FIELD_PREP(DFSDM_AWLTR_AWLT_MASK, v)
> +
> +/* AWHTR: Filter analog watchdog low threshold register */
> +#define DFSDM_AWHTR_BKAWH_MASK	GENMASK(3, 0)
> +#define DFSDM_AWHTR_BKAWH(v)	FIELD_PREP(DFSDM_AWHTR_BKAWH_MASK, v)
> +#define DFSDM_AWHTR_AWHT_MASK	GENMASK(31, 8)
> +#define DFSDM_AWHTR_AWHT(v)	FIELD_PREP(DFSDM_AWHTR_AWHT_MASK, v)
> +
> +/* AWSR: Filter watchdog status register */
> +#define DFSDM_AWSR_AWLTF_MASK	GENMASK(7, 0)
> +#define DFSDM_AWSR_AWLTF(v)	FIELD_PREP(DFSDM_AWSR_AWLTF_MASK, v)
> +#define DFSDM_AWSR_AWHTF_MASK	GENMASK(15, 8)
> +#define DFSDM_AWSR_AWHTF(v)	FIELD_PREP(DFSDM_AWSR_AWHTF_MASK, v)
> +
> +/* AWCFR: Filter watchdog status register */
> +#define DFSDM_AWCFR_AWLTF_MASK	GENMASK(7, 0)
> +#define DFSDM_AWCFR_AWLTF(v)	FIELD_PREP(DFSDM_AWCFR_AWLTF_MASK, v)
> +#define DFSDM_AWCFR_AWHTF_MASK	GENMASK(15, 8)
> +#define DFSDM_AWCFR_AWHTF(v)	FIELD_PREP(DFSDM_AWCFR_AWHTF_MASK, v)
> +
> +#endif
> diff --git a/drivers/mfd/stm32-dfsdm.c b/drivers/mfd/stm32-dfsdm.c
> new file mode 100644
> index 0000000..81ca29c
> --- /dev/null
> +++ b/drivers/mfd/stm32-dfsdm.c
> @@ -0,0 +1,1044 @@
> +/*
> + * This file is part of STM32 DFSDM mfd driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
> + *
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/stm32-dfsdm.h>
> +
> +#include "stm32-dfsdm-reg.h"
> +
> +#define DFSDM_UPDATE_BITS(regm, reg, mask, val) \
> +		WARN_ON(regmap_update_bits(regm, reg, mask, val))
Don't do these wrappers please. Handle error correctly in all cases.
Reviewing as I tend to do backwards through the driver, I thought these
were doing something interesting.

Effectively you have no error handling as a result of these which needs
fixing.

> +
> +#define DFSDM_REG_READ(regm, reg, val) \
> +		WARN_ON(regmap_read(regm, reg, val))
> +
> +#define DFSDM_REG_WRITE(regm, reg, val) \
> +		WARN_ON(regmap_write(regm, reg, val))
> +
> +#define STM32H7_DFSDM_NUM_FILTERS	4
> +#define STM32H7_DFSDM_NUM_INPUTS	8
> +
> +enum dfsdm_clkout_src {
> +	DFSDM_CLK,
> +	AUDIO_CLK
> +};
> +
> +struct stm32_dev_data {
> +	const struct stm32_dfsdm dfsdm;
> +	const struct regmap_config *regmap_cfg;
> +};
> +
> +struct dfsdm_priv;
> +
> +struct filter_params {
> +	unsigned int id;
> +	int irq;
> +	struct stm32_dfsdm_fl_event event;
> +	u32 event_mask;
> +	struct dfsdm_priv *priv; /* Cross ref for context */
> +	unsigned int ext_ch_mask;
> +	unsigned int scan_ch;
> +};
> +
> +struct ch_params {
> +	struct stm32_dfsdm_channel ch;
> +};
> +
I'd like to see a lot more comments in here.  Perhaps full kernel-doc
as some elements are not that obvious at least to a fairly casual read.

> +struct dfsdm_priv {
> +	struct platform_device *pdev;
> +	struct stm32_dfsdm dfsdm;
> +
> +	spinlock_t lock; /* Used for resource sharing & interrupt lock */
> +
> +	/* Filters */
> +	struct filter_params *filters;
> +	unsigned int free_filter_mask;
> +	unsigned int scd_filter_mask;
> +	unsigned int ckab_filter_mask;
> +
> +	/* Channels */
> +	struct stm32_dfsdm_channel *channels;
> +	unsigned int free_channel_mask;
> +	atomic_t n_active_ch;
> +
> +	/* Clock */
> +	struct clk *clk;
> +	struct clk *aclk;
> +	unsigned int clkout_div;
> +	unsigned int clkout_freq_req;
> +
> +	/* Registers*/
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	phys_addr_t phys_base;
> +};
> +
> +/*
> + * Common
> + */
> +static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	if (reg < DFSDM_FILTER_BASE_ADR)
> +		return false;
> +
> +	/*
> +	 * Mask is done on register to avoid to list registers of all them
> +	 * filter instances.
> +	 */
> +	switch (reg & DFSDM_FILTER_REG_MASK) {
> +	case DFSDM_CR1(0) & DFSDM_FILTER_REG_MASK:
> +	case DFSDM_ISR(0) & DFSDM_FILTER_REG_MASK:
> +	case DFSDM_JDATAR(0) & DFSDM_FILTER_REG_MASK:
> +	case DFSDM_RDATAR(0) & DFSDM_FILTER_REG_MASK:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config stm32h7_dfsdm_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = DFSDM_CNVTIMR(STM32H7_DFSDM_NUM_FILTERS - 1),
> +	.volatile_reg = stm32_dfsdm_volatile_reg,
> +	.fast_io = true,
> +};
> +
> +static const struct stm32_dev_data stm32h7_data = {
> +	.dfsdm.max_channels = STM32H7_DFSDM_NUM_INPUTS,
> +	.dfsdm.max_filters = STM32H7_DFSDM_NUM_FILTERS,
> +	.regmap_cfg = &stm32h7_dfsdm_regmap_cfg,
> +};
> +
> +static int stm32_dfsdm_start_dfsdm(struct dfsdm_priv *priv)
> +{
> +	int ret;
> +	struct device *dev = &priv->pdev->dev;
> +
> +	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> +		ret = clk_prepare_enable(priv->clk);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to start clock\n");
> +			return ret;
> +		}
> +		if (priv->aclk) {
> +			ret = clk_prepare_enable(priv->aclk);
> +			if (ret < 0) {
> +				dev_err(dev, "Failed to start audio clock\n");
> +				return ret;
> +			}
> +		}
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(0),
> +				  DFSDM_CHCFGR1_CKOUTDIV_MASK,
> +				  DFSDM_CHCFGR1_CKOUTDIV(priv->clkout_div));
> +
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(0),
> +				  DFSDM_CHCFGR1_DFSDMEN_MASK,
> +				  DFSDM_CHCFGR1_DFSDMEN(1));
> +	}
> +
> +	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
> +		atomic_read(&priv->n_active_ch));
> +
> +	return 0;
> +}
> +
> +static void stm32_dfsdm_stop_dfsdm(struct dfsdm_priv *priv)
> +{
> +	if (atomic_dec_and_test(&priv->n_active_ch)) {
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(0),
> +				  DFSDM_CHCFGR1_DFSDMEN_MASK,
> +				  DFSDM_CHCFGR1_DFSDMEN(0));
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(0),
> +				  DFSDM_CHCFGR1_CKOUTDIV_MASK,
> +				  DFSDM_CHCFGR1_CKOUTDIV(0));
> +		clk_disable_unprepare(priv->clk);
> +		if (priv->aclk)
> +			clk_disable_unprepare(priv->aclk);
> +	}
> +	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
> +		atomic_read(&priv->n_active_ch));
> +}
> +
> +static unsigned int stm32_dfsdm_get_clkout_divider(struct dfsdm_priv *priv,
> +						   unsigned long rate)
> +{
> +	unsigned int delta, div;
> +
> +	/* div = 0 disables the clockout */
> +	if (!priv->clkout_freq_req)
> +		return 0;
> +
> +	div = DIV_ROUND_CLOSEST(rate, priv->clkout_freq_req);
> +
> +	delta = rate - (priv->clkout_freq_req * div);
> +	if (delta)
> +		dev_warn(&priv->pdev->dev,
> +			 "clkout not accurate. delta (Hz): %d\n", delta);
> +
> +	dev_dbg(&priv->pdev->dev, "%s: clk: %lu (Hz), div %u\n",
> +		__func__, rate, div);
> +
> +	return (div - 1);
> +}
> +
> +/*
> + * Filters
> + */
> +
> +static int stm32_dfsdm_clear_event(struct dfsdm_priv *priv, unsigned int fl_id,
> +				   unsigned int event, int mask)
> +{
> +	int val;
> +
> +	switch (event) {
> +	case DFSDM_EVENT_INJ_EOC:
> +		DFSDM_REG_READ(priv->regmap, DFSDM_JDATAR(fl_id), &val);
> +		break;
> +	case DFSDM_EVENT_REG_EOC:
> +		DFSDM_REG_READ(priv->regmap, DFSDM_RDATAR(fl_id), &val);
> +		break;
> +	case DFSDM_EVENT_INJ_XRUN:
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_ICR(fl_id),
> +				  DFSDM_ICR_CLRJOVRF_MASK,
> +				  DFSDM_ICR_CLRJOVRF_MASK);
> +		break;
> +	case DFSDM_EVENT_REG_XRUN:
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_ICR(fl_id),
> +				  DFSDM_ICR_CLRROVRF_MASK,
> +				  DFSDM_ICR_CLRROVRF_MASK);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> +{
> +	struct filter_params *params = arg;
> +	unsigned int status;
> +	struct dfsdm_priv *priv = params->priv;
> +	unsigned int event_mask = params->event_mask;
> +
> +	DFSDM_REG_READ(priv->regmap, DFSDM_ISR(params->id), &status);
> +
> +	if (status & DFSDM_ISR_JOVRF_MASK) {
> +		if (event_mask & DFSDM_EVENT_INJ_XRUN) {
> +			params->event.cb(&priv->dfsdm, params->id,
> +					 DFSDM_EVENT_INJ_XRUN, 0,
> +					 params->event.context);
> +		}
> +		stm32_dfsdm_clear_event(priv, params->id, DFSDM_EVENT_INJ_XRUN,
> +					0);
> +	}
> +
> +	if (status & DFSDM_ISR_ROVRF_MASK) {
> +		if (event_mask & DFSDM_EVENT_REG_XRUN) {
> +			params->event.cb(&priv->dfsdm, params->id,
> +					 DFSDM_EVENT_REG_XRUN, 0,
> +					 params->event.context);
> +		}
> +		stm32_dfsdm_clear_event(priv, params->id, DFSDM_EVENT_REG_XRUN,
> +					0);
> +	}
> +
> +	if (status & DFSDM_ISR_JEOCF_MASK) {
> +		if (event_mask & DFSDM_EVENT_INJ_EOC)
> +			params->event.cb(&priv->dfsdm, params->id,
> +					 DFSDM_EVENT_INJ_EOC, 0,
> +					 params->event.context);
> +		else
> +			stm32_dfsdm_clear_event(priv, params->id,
> +						DFSDM_EVENT_INJ_EOC, 0);
> +	}
> +
> +	if (status & DFSDM_ISR_REOCF_MASK) {
> +		if (event_mask & DFSDM_EVENT_REG_EOC)
> +			params->event.cb(&priv->dfsdm, params->id,
> +					 DFSDM_EVENT_REG_EOC, 0,
> +					 params->event.context);
> +		else
> +			stm32_dfsdm_clear_event(priv, params->id,
> +						DFSDM_EVENT_REG_EOC, 0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void stm32_dfsdm_configure_reg_conv(struct dfsdm_priv *priv,
> +					   unsigned int fl_id,
> +					   struct stm32_dfsdm_regular *params)
> +{
> +	unsigned int ch_id = params->ch_src;
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_RCH_MASK,
> +			  DFSDM_CR1_RCH(ch_id));
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_FAST_MASK,
> +			  DFSDM_CR1_FAST(params->fast_mode));
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_RCONT_MASK,
> +			  DFSDM_CR1_RCONT(params->cont_mode));
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_RDMAEN_MASK,
> +			  DFSDM_CR1_RDMAEN(params->dma_mode));
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_RSYNC_MASK,
> +			  DFSDM_CR1_RSYNC(params->sync_mode));
> +
> +	priv->filters[fl_id].scan_ch = BIT(ch_id);
> +}
> +
> +static void stm32_dfsdm_configure_inj_conv(struct dfsdm_priv *priv,
> +					   unsigned int fl_id,
> +					   struct stm32_dfsdm_injected *params)
> +{
> +	int val;
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_JSCAN_MASK,
> +			  DFSDM_CR1_JSCAN(params->scan_mode));
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_JDMAEN_MASK,
> +			  DFSDM_CR1_JDMAEN(params->dma_mode));
> +
> +	val = (params->trigger == DFSDM_FILTER_EXT_TRIGGER) ?
> +	      params->trig_src : 0;
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id),
> +			  DFSDM_CR1_JEXTSEL_MASK,
> +			  DFSDM_CR1_JEXTSEL(val));
> +
> +	val = (params->trigger == DFSDM_FILTER_SYNC_TRIGGER) ? 1 : 0;
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_JSYNC_MASK,
> +			  DFSDM_CR1_JSYNC(val));
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_JEXTEN_MASK,
> +			  DFSDM_CR1_JEXTEN(params->trig_pol));
> +	priv->filters[fl_id].scan_ch = params->ch_group;
> +
> +	DFSDM_REG_WRITE(priv->regmap, DFSDM_JCHGR(fl_id), params->ch_group);
> +}
> +
> +/**
> + * stm32_dfsdm_configure_filter - Configure filter.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + * @conv: Conversion type regular or injected.
> + */
> +int stm32_dfsdm_configure_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +				 struct stm32_dfsdm_filter *fl_cfg)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv,
> +					       dfsdm);
> +	struct stm32_dfsdm_sinc_filter *sparams = &fl_cfg->sinc_params;
> +
> +	dev_dbg(&priv->pdev->dev, "%s:config filter %d\n", __func__, fl_id);
> +
> +	/* Average integrator oversampling */
> +	if ((!fl_cfg->int_oversampling) ||
> +	    (fl_cfg->int_oversampling > DFSDM_MAX_INT_OVERSAMPLING)) {
> +		dev_err(&priv->pdev->dev, "invalid integrator oversampling %d\n",
> +			fl_cfg->int_oversampling);
> +		return -EINVAL;
> +	}
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_FCR(fl_id), DFSDM_FCR_IOSR_MASK,
> +			  DFSDM_FCR_IOSR((fl_cfg->int_oversampling - 1)));
> +
> +	/* Oversamplings and filter*/
> +	if ((!sparams->oversampling) ||
> +	    (sparams->oversampling > DFSDM_MAX_FL_OVERSAMPLING)) {
> +		dev_err(&priv->pdev->dev, "invalid oversampling %d\n",
> +			sparams->oversampling);
> +		return -EINVAL;
> +	}
> +
> +	if (sparams->order > DFSDM_SINC5_ORDER) {
> +		dev_err(&priv->pdev->dev, "invalid filter order %d\n",
> +			sparams->order);
> +		return -EINVAL;
> +	}
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_FCR(fl_id), DFSDM_FCR_FOSR_MASK,
> +			  DFSDM_FCR_FOSR((sparams->oversampling - 1)));
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_FCR(fl_id), DFSDM_FCR_FORD_MASK,
> +			  DFSDM_FCR_FORD(sparams->order));
> +
> +	/* Conversion */
> +	if (fl_cfg->inj_params)
> +		stm32_dfsdm_configure_inj_conv(priv, fl_id, fl_cfg->inj_params);
> +	else if (fl_cfg->reg_params)
> +		stm32_dfsdm_configure_reg_conv(priv, fl_id, fl_cfg->reg_params);
> +
> +	priv->filters[fl_id].event = fl_cfg->event;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_configure_filter);
> +
> +/**
> + * stm32_dfsdm_start_filter - Start filter conversion.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + * @conv: Conversion type regular or injected.
> + */
> +void stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +			      enum stm32_dfsdm_conv_type conv)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +
> +	dev_dbg(&priv->pdev->dev, "%s:start filter %d\n", __func__, fl_id);
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_DFEN_MASK,
> +			  DFSDM_CR1_DFEN(1));
> +
> +	if (conv == DFSDM_FILTER_REG_CONV) {
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id),
> +				  DFSDM_CR1_RSWSTART_MASK,
> +				  DFSDM_CR1_RSWSTART(1));
> +	} else if (conv == DFSDM_FILTER_SW_INJ_CONV) {
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id),
> +				  DFSDM_CR1_JSWSTART_MASK,
> +				  DFSDM_CR1_JSWSTART(1));
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_start_filter);
> +
> +/**
> + * stm32_dfsdm_stop_filter - Stop filter conversion.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + */
> +void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +
> +	dev_dbg(&priv->pdev->dev, "%s:stop filter %d\n", __func__, fl_id);
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR1(fl_id), DFSDM_CR1_DFEN_MASK,
> +			  DFSDM_CR1_DFEN(0));
> +	priv->filters[fl_id].scan_ch = 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_stop_filter);
> +
> +/**
> + * stm32_dfsdm_read_fl_conv - Read filter conversion.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + * @type: Regular or injected conversion.
> + */
> +void stm32_dfsdm_read_fl_conv(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +			      u32 *val, int *ch_id,
> +			      enum stm32_dfsdm_conv_type type)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	int reg_v, offset;
> +
> +	if (type == DFSDM_FILTER_REG_CONV)
> +		offset = DFSDM_RDATAR(fl_id);
> +	else
> +		offset = DFSDM_JDATAR(fl_id);
> +
> +	DFSDM_REG_READ(priv->regmap, offset, &reg_v);
> +
> +	*ch_id = reg_v & DFSDM_DATAR_CH_MASK;
> +	*val = reg_v & DFSDM_DATAR_DATA_MASK;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_read_fl_conv);
> +
> +/**
> + * stm32_dfsdm_get_filter - Get filter instance.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter instance to reserve.
> + *
> + * Reserves a DFSDM filter resource.
> + */
> +int stm32_dfsdm_get_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv,
> +					       dfsdm);
> +	struct device *dev = &priv->pdev->dev;
> +
> +	spin_lock(&priv->lock);
> +	if (!(priv->free_filter_mask & BIT(fl_id))) {
> +		spin_unlock(&priv->lock);
> +		dev_err(dev, "filter resource %d available\n", fl_id);
> +		return -EBUSY;
> +	}
> +	priv->free_filter_mask &= ~BIT(fl_id);
> +
> +	spin_unlock(&priv->lock);
> +
> +	dev_dbg(dev, "%s: new mask %#x\n", __func__, priv->free_filter_mask);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_get_filter);
> +
> +/**
> + * stm32_dfsdm_release_filter - Release filter instance.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + *
> + * Free the DFSDM filter resource.
> + */
> +void stm32_dfsdm_release_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +
> +	spin_lock(&priv->lock);
> +	priv->free_filter_mask |= BIT(fl_id);
> +	spin_unlock(&priv->lock);
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_release_filter);
> +
> +/**
> + * stm32_dfsdm_get_filter_dma_addr - Get register address for dma transfer.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + * @conv: Conversion type.
> + */
> +dma_addr_t stm32_dfsdm_get_filter_dma_phy_addr(struct stm32_dfsdm *dfsdm,
> +					       unsigned int fl_id,
> +					       enum stm32_dfsdm_conv_type conv)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +
> +	if (conv == DFSDM_FILTER_REG_CONV)
> +		return (dma_addr_t)(priv->phys_base + DFSDM_RDATAR(fl_id));
> +	else
> +		return (dma_addr_t)(priv->phys_base + DFSDM_JDATAR(fl_id));
> +}
> +
> +/**
> + * stm32_dfsdm_register_fl_event - Register filter event.
What is a filter event?  More details good on things that are very
device specific like this.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + * @event: Event to unregister.
> + * @chan_mask: Mask of channels associated to filter.
> + *
> + * The function enables associated IRQ.
> + */
> +int stm32_dfsdm_register_fl_event(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +				  enum stm32_dfsdm_events event,
> +				  unsigned int chan_mask)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	unsigned long flags, ulmask = chan_mask;
> +	int ret, i;
> +
> +	dev_dbg(&priv->pdev->dev, "%s:for filter %d: event %#x ch_mask %#x\n",
> +		__func__, fl_id, event, chan_mask);
> +
> +	if (event > DFSDM_EVENT_CKA)
> +		return -EINVAL;
> +
> +	/* Clear interrupt before enable them */
> +	ret = stm32_dfsdm_clear_event(priv, fl_id, event, chan_mask);
> +	if (ret < 0)
> +		return ret;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	/* Enable interrupts */
> +	switch (event) {
> +	case DFSDM_EVENT_SCD:
> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
> +					  DFSDM_CHCFGR1_SCDEN_MASK,
> +					  DFSDM_CHCFGR1_SCDEN(1));
> +		}
> +		if (!priv->scd_filter_mask)
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
> +					  DFSDM_CR2_SCDIE_MASK,
> +					  DFSDM_CR2_SCDIE(1));
> +		priv->scd_filter_mask |= BIT(fl_id);
> +		break;
> +	case DFSDM_EVENT_CKA:
> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
> +					  DFSDM_CHCFGR1_CKABEN_MASK,
> +					  DFSDM_CHCFGR1_CKABEN(1));
> +		}
> +		if (!priv->ckab_filter_mask)
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
> +					  DFSDM_CR2_CKABIE_MASK,
> +					  DFSDM_CR2_CKABIE(1));
> +		priv->ckab_filter_mask |= BIT(fl_id);
> +		break;
> +	default:
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(fl_id), event, event);
> +	}
> +	priv->filters[fl_id].event_mask |= event;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_register_fl_event);
> +
> +/**
> + * stm32_dfsdm_unregister_fl_event - Unregister filter event.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @fl_id: Filter id.
> + * @event: Event to unregister.
> + * @chan_mask: Mask of channels associated to filter.
> + *
> + * The function disables associated IRQ.
> + */
> +int stm32_dfsdm_unregister_fl_event(struct stm32_dfsdm *dfsdm,
> +				    unsigned int fl_id,
> +				    enum stm32_dfsdm_events event,
> +				    unsigned int chan_mask)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	unsigned long flags, ulmask = chan_mask;
> +	int i;
> +
> +	dev_dbg(&priv->pdev->dev, "%s:for filter %d: event %#x ch_mask %#x\n",
> +		__func__, fl_id, event, chan_mask);
> +
> +	if (event > DFSDM_EVENT_CKA)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	/* Disable interrupts */
> +	switch (event) {
> +	case DFSDM_EVENT_SCD:
> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
> +					  DFSDM_CHCFGR1_SCDEN_MASK,
> +					  DFSDM_CHCFGR1_SCDEN(0));
> +		}
> +		priv->scd_filter_mask &= ~BIT(fl_id);
> +		if (!priv->scd_filter_mask)
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
> +					  DFSDM_CR2_SCDIE_MASK,
> +					  DFSDM_CR2_SCDIE(0));
> +		break;
> +	case DFSDM_EVENT_CKA:
> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
> +					  DFSDM_CHCFGR1_CKABEN_MASK,
> +					  DFSDM_CHCFGR1_CKABEN(0));
> +		}
> +		priv->ckab_filter_mask &= ~BIT(fl_id);
> +		if (!priv->ckab_filter_mask)
> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
> +					  DFSDM_CR2_CKABIE_MASK,
> +					  DFSDM_CR2_CKABIE(0));
> +		break;
> +	default:
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(fl_id), event, 0);
> +	}
> +
> +	priv->filters[fl_id].event_mask &= ~event;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_unregister_fl_event);
> +
> +/*
> + * Channels
> + */
> +static void stm32_dfsdm_init_channel(struct dfsdm_priv *priv,
> +				     struct stm32_dfsdm_channel *ch)
> +{
Comments in here for what the various bits are doing would be great.
The naming makes it just about possible to work out, but not nice
to read!
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch->id),
> +			  DFSDM_CHCFGR1_DATMPX_MASK,
> +			  DFSDM_CHCFGR1_DATMPX(ch->type.source));
> +	if (ch->type.source == DFSDM_CHANNEL_EXTERNAL_INPUTS) {
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch->id),
> +				  DFSDM_CHCFGR1_SITP_MASK,
> +				  DFSDM_CHCFGR1_SITP(ch->serial_if.type));
> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch->id),
> +				  DFSDM_CHCFGR1_SPICKSEL_MASK,
> +				DFSDM_CHCFGR1_SPICKSEL(ch->serial_if.spi_clk));
> +	}
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch->id),
> +			  DFSDM_CHCFGR1_DATPACK_MASK,
> +			  DFSDM_CHCFGR1_DATPACK(ch->type.DataPacking));
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch->id),
> +			  DFSDM_CHCFGR1_CHINSEL_MASK,
> +			  DFSDM_CHCFGR1_CHINSEL(ch->serial_if.pins));
> +}
> +
> +/**
> + * stm32_dfsdm_start_channel - Configure and activate DFSDM channel.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @ch: Filter id.
> + * @cfg: Filter configuration.
> + */
> +int stm32_dfsdm_start_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id,
> +			      struct stm32_dfsdm_ch_cfg *cfg)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv,
> +					       dfsdm);
> +	struct regmap *reg = priv->regmap;
> +	int ret;
> +
> +	dev_dbg(&priv->pdev->dev, "%s: for channel %d\n", __func__, ch_id);
> +
> +	ret = stm32_dfsdm_start_dfsdm(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	DFSDM_UPDATE_BITS(reg, DFSDM_CHCFGR2(ch_id), DFSDM_CHCFGR2_DTRBS_MASK,
> +			  DFSDM_CHCFGR2_DTRBS(cfg->right_bit_shift));
> +	DFSDM_UPDATE_BITS(reg, DFSDM_CHCFGR2(ch_id), DFSDM_CHCFGR2_OFFSET_MASK,
> +			  DFSDM_CHCFGR2_OFFSET(cfg->offset));
> +
> +	DFSDM_UPDATE_BITS(reg, DFSDM_CHCFGR1(ch_id), DFSDM_CHCFGR1_CHEN_MASK,
> +			  DFSDM_CHCFGR1_CHEN(1));
> +
> +	/* Clear absence detection IRQ */
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_ICR(0),
> +			  DFSDM_ICR_CLRCKABF_CH_MASK(ch_id),
> +			  DFSDM_ICR_CLRCKABF_CH(1, ch_id));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_start_channel);
> +
> +/**
> + * stm32_dfsdm_stop_channel - Deactivate channel.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @ch_id: DFSDM channel identifier.
> + */
> +void stm32_dfsdm_stop_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +
> +	dev_dbg(&priv->pdev->dev, "%s:for channel %d\n", __func__, ch_id);
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch_id),
> +			  DFSDM_CHCFGR1_CHEN_MASK,
> +			  DFSDM_CHCFGR1_CHEN(0));
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch_id),
> +			  DFSDM_CHCFGR1_CKABEN_MASK, DFSDM_CHCFGR1_CKABEN(0));
> +
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(ch_id),
> +			  DFSDM_CHCFGR1_SCDEN_MASK, DFSDM_CHCFGR1_SCDEN(0));
> +
> +	stm32_dfsdm_stop_dfsdm(priv);
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_stop_channel);
> +
> +/**
> + * stm32_dfsdm_get_channel - Get channel instance.
> + *
> + * @dfsdm: handle used to retrieve dfsdm context.
> + * @ch: DFSDM channel hardware parameters.
> + *
> + * Reserve DFSDM channel resource.
> + */
> +int stm32_dfsdm_get_channel(struct stm32_dfsdm *dfsdm,
> +			    struct stm32_dfsdm_channel *ch)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	unsigned int id = ch->id;
> +
> +	dev_dbg(&priv->pdev->dev, "%s:get channel %d\n", __func__, id);
> +
> +	if (id >= priv->dfsdm.max_channels) {
> +		dev_err(&priv->pdev->dev, "channel (%d) is not valid\n", id);
> +		return -EINVAL;
> +	}
> +
> +	if ((ch->type.source != DFSDM_CHANNEL_EXTERNAL_INPUTS) &
> +	    (ch->serial_if.spi_clk != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL) &
> +	    (!priv->clkout_freq_req)) {
> +		dev_err(&priv->pdev->dev, "clkout not present\n");
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&priv->lock);
> +	if (!(BIT(id) & priv->free_channel_mask)) {
> +		spin_unlock(&priv->lock);
> +		dev_err(&priv->pdev->dev, "channel (%d) already in use\n", id);
> +		return -EBUSY;
> +	}
> +
> +	priv->free_channel_mask &= ~BIT(id);
> +	priv->channels[id] = *ch;
> +	spin_unlock(&priv->lock);
> +
> +	dev_dbg(&priv->pdev->dev, "%s: new mask %#x\n", __func__,
> +		priv->free_channel_mask);
> +
> +	/**
> +	 * Check clock constrainst between clkout and either
> +	 * dfsdm/audio clock:
> +	 * - In SPI mode (clkout is used): Fclk >= 4 * Fclkout
> +	 *   (e.g. CKOUTDIV >= 3)
> +	 * - In mancherster mode: Fclk >= 6 * Fclkout
> +	 */
> +	switch (ch->serial_if.type) {
> +	case DFSDM_CHANNEL_SPI_RISING:
> +	case DFSDM_CHANNEL_SPI_FALLING:
> +		if (priv->clkout_div && priv->clkout_div < 3)
> +			dev_warn(&priv->pdev->dev,
> +				 "Clock div should be higher than 3\n");
Really only warnings?  If requirements then error out. If not, then
a description of what the side effects of these would be would be great
here and perhaps even in the warning message.
> +		break;
> +	case DFSDM_CHANNEL_MANCHESTER_RISING:
> +	case DFSDM_CHANNEL_MANCHESTER_FALLING:
> +		if (priv->clkout_div && priv->clkout_div < 5)
> +			dev_warn(&priv->pdev->dev,
> +				 "Clock div should be higher than 5\n");
> +		break;
> +	}
> +
> +	stm32_dfsdm_init_channel(priv, ch);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_get_channel);
> +
> +/**
> + * stm32_dfsdm_release_channel - Release channel instance.
> + *
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + * @ch_id: DFSDM channel identifier.
> + *
> + * Free the DFSDM channel resource.
> + */
> +void stm32_dfsdm_release_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +
> +	spin_lock(&priv->lock);
> +	priv->free_channel_mask |= BIT(ch_id);
> +	spin_unlock(&priv->lock);
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_release_channel);
> +
> +/**
> + * stm32_dfsdm_get_clk_out_rate - get clkout frequency.
> + *
> + * @dfsdm: handle used to retrieve dfsdm context.
> + * @rate: clock out rate in Hz.
> + *
> + * Provide output frequency used for external ADC.
> + * return EINVAL if clockout is not used else return 0.
> + */
> +int stm32_dfsdm_get_clk_out_rate(struct stm32_dfsdm *dfsdm, unsigned long *rate)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	unsigned long int clk_rate;
> +
> +	if (!priv->clkout_div)
> +		return -EINVAL;
> +
> +	clk_rate = clk_get_rate(priv->aclk ? priv->aclk : priv->clk);
> +	*rate = clk_rate / (priv->clkout_div + 1);
> +	dev_dbg(&priv->pdev->dev, "%s: clkout: %ld (Hz)\n", __func__, *rate);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfsdm_get_clk_out_rate);
> +
> +static int stm32_dfsdm_parse_of(struct platform_device *pdev,
> +				struct dfsdm_priv *priv)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct resource *res;
> +	int ret, val;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	/* Get resources */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get memory resource\n");
> +		return -ENODEV;
> +	}
> +	priv->phys_base = res->start;
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	ret = of_property_read_u32(node, "st,clkout-freq", &val);
> +	if (!ret) {
> +		if (!val) {
> +			dev_err(&priv->pdev->dev,
> +				"st,clkout-freq cannot be 0\n");
> +			return -EINVAL;
> +		}
> +		priv->clkout_freq_req = val;
> +	} else if (ret != -EINVAL) {
> +		dev_err(&priv->pdev->dev, "Failed to get st,clkout-freq\n");
> +		return ret;
> +	}
> +
> +	/* Source clock */
> +	priv->clk = devm_clk_get(&pdev->dev, "dfsdm_clk");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->aclk = devm_clk_get(&pdev->dev, "audio_clk");
> +	if (IS_ERR(priv->aclk))
> +		priv->aclk = NULL;
> +
> +	return 0;
> +};
> +
> +static const struct of_device_id stm32_dfsdm_of_match[] = {
> +	{
> +		.compatible = "st,stm32h7-dfsdm",
> +		.data = &stm32h7_data
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
> +
> +static int stm32_dfsdm_remove(struct platform_device *pdev)
> +{
> +	of_platform_depopulate(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_probe(struct platform_device *pdev)
> +{
> +	struct dfsdm_priv *priv;
> +	struct device_node *pnode = pdev->dev.of_node;
> +	const struct of_device_id *of_id;
> +	const struct stm32_dev_data *dev_data;
> +	enum dfsdm_clkout_src clk_src;
> +	int ret, i;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;
> +
> +	/* Populate data structure depending on compatibility */
> +	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
> +	if (!of_id->data) {
> +		dev_err(&pdev->dev, "Data associated to device is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_data = (const struct stm32_dev_data *)of_id->data;
> +
> +	ret = stm32_dfsdm_parse_of(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->regmap = devm_regmap_init_mmio(&pdev->dev, priv->base,
> +					    dev_data->regmap_cfg);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	priv->dfsdm = dev_data->dfsdm;
> +
> +	priv->filters = devm_kcalloc(&pdev->dev, dev_data->dfsdm.max_filters,
> +				     sizeof(*priv->filters), GFP_KERNEL);
> +	if (IS_ERR(priv->filters)) {
> +		ret = PTR_ERR(priv->filters);
> +		goto probe_err;
> +	}
> +
> +	for (i = 0; i < dev_data->dfsdm.max_filters; i++) {
> +		struct filter_params *params = &priv->filters[i];
> +
> +		params->id = i;
> +		params->irq = platform_get_irq(pdev, i);
> +		if (params->irq < 0) {
> +			dev_err(&pdev->dev, "Failed to get IRQ resource\n");
> +			ret = params->irq;
> +			goto probe_err;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev, params->irq, stm32_dfsdm_irq,
> +				       0, dev_name(&pdev->dev), params);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register interrupt\n");
> +			goto probe_err;
> +		}
> +
> +		params->priv = priv;
> +	}
> +
> +	priv->channels = devm_kcalloc(&pdev->dev, priv->dfsdm.max_channels,
> +				      sizeof(*priv->channels), GFP_KERNEL);
> +	if (IS_ERR(priv->channels)) {
> +		ret = PTR_ERR(priv->channels);
> +		goto probe_err;
> +	}
> +	priv->free_filter_mask = BIT(priv->dfsdm.max_filters) - 1;
> +	priv->free_channel_mask = BIT(priv->dfsdm.max_channels) - 1;
> +
> +	platform_set_drvdata(pdev, &priv->dfsdm);
> +	spin_lock_init(&priv->lock);
> +
> +	priv->clkout_div = stm32_dfsdm_get_clkout_divider(priv,
> +						    clk_get_rate(priv->clk));
> +
> +	ret = of_platform_populate(pnode, NULL, NULL, &pdev->dev);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	clk_src = priv->aclk ? AUDIO_CLK : DFSDM_CLK;
> +
I'd like to see a comment here saying what this is doing.
> +	DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(0),
> +			  DFSDM_CHCFGR1_CKOUTSRC_MASK,
> +			  DFSDM_CHCFGR1_CKOUTSRC(clk_src));
> +	return 0;
> +
> +probe_err:
> +	return ret;
> +}
> +
> +static struct platform_driver stm32_dfsdm_driver = {
> +	.probe = stm32_dfsdm_probe,
> +	.remove = stm32_dfsdm_remove,
> +	.driver = {
> +		.name = "stm32-dfsdm",
> +		.of_match_table = stm32_dfsdm_of_match,
> +	},
> +};
> +
> +module_platform_driver(stm32_dfsdm_driver);
> +
> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 dfsdm driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/stm32-dfsdm.h b/include/linux/mfd/stm32-dfsdm.h
> new file mode 100644
> index 0000000..f6eb788
> --- /dev/null
> +++ b/include/linux/mfd/stm32-dfsdm.h
> @@ -0,0 +1,324 @@
> +/*
> + * This file is part of STM32 DFSDM mfd driver API
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
> + *
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + */
> +#ifndef MDF_STM32_DFSDM_H
> +#define MDF_STM32_DFSDM_H
> +
> +/*
> + * Channel definitions
> + */
> +#define DFSDM_CHANNEL_0    BIT(0)
> +#define DFSDM_CHANNEL_1    BIT(1)
> +#define DFSDM_CHANNEL_2    BIT(2)
> +#define DFSDM_CHANNEL_3    BIT(3)
> +#define DFSDM_CHANNEL_4    BIT(4)
> +#define DFSDM_CHANNEL_5    BIT(5)
> +#define DFSDM_CHANNEL_6    BIT(6)
> +#define DFSDM_CHANNEL_7    BIT(7)
> +
> +/* DFSDM channel input data packing */
> +enum stm32_dfsdm_data_packing {
> +	DFSDM_CHANNEL_STANDARD_MODE,    /* Standard data packing mode */
> +	DFSDM_CHANNEL_INTERLEAVED_MODE, /* Interleaved data packing mode */
> +	DFSDM_CHANNEL_DUAL_MODE         /* Dual data packing mode */
> +};
> +
> +/* DFSDM channel input multiplexer */
> +enum stm32_dfsdm_input_multiplexer {
> +	DFSDM_CHANNEL_EXTERNAL_INPUTS,    /* Data taken from external inputs */
> +	DFSDM_CHANNEL_INTERNAL_ADC,       /* Data taken from internal ADC */
> +	DFSDM_CHANNEL_INTERNAL_REGISTER,  /* Data taken from register */
> +};
> +
> +/* DFSDM channel serial interface type */
> +enum stm32_dfsdm_serial_in_type {
> +	DFSDM_CHANNEL_SPI_RISING,         /* SPI with rising edge */
> +	DFSDM_CHANNEL_SPI_FALLING,        /* SPI with falling edge */
We could use standard SPI naming for these first two. That would I think
describe these as clock phases. However, perhaps alongside the machester
coding it doesn't make sense to do so.

> +	DFSDM_CHANNEL_MANCHESTER_RISING,  /* Manchester with rising edge */
> +	DFSDM_CHANNEL_MANCHESTER_FALLING, /* Manchester with falling edge */
> +};
> +
> +/* DFSDM channel serial spi clock source */
> +enum stm32_dfsdm_spi_clk_src {
> +	/* External SPI clock */
> +	DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL,
> +	/* Internal SPI clock */
> +	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL,
> +	/* Internal SPI clock divided by 2, falling edge */
> +	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING,
> +	/* Internal SPI clock divided by 2, rising edge */
> +	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING
> +};
> +
> +/* DFSDM channel input pins */
> +enum stm32_dfsdm_serial_in_select {
> +	/* Serial input taken from pins of the same channel (y) */
> +	DFSDM_CHANNEL_SAME_CHANNEL_PINS,
> +	/* Serial input taken from pins of the following channel (y + 1)*/
> +	DFSDM_CHANNEL_NEXT_CHANNEL_PINS,
> +};
> +
> +/**
> + * struct stm32_dfsdm_input_type - DFSDM channel init structure definition.
> + * @DataPacking: Standard, interleaved or dual mode for internal register.
> + * @source: channel source: internal DAC, serial input or memory.
> + */
> +struct stm32_dfsdm_input_type {
> +	enum stm32_dfsdm_data_packing DataPacking;
> +	enum stm32_dfsdm_input_multiplexer source;
> +};
> +
> +/**
> + * struct stm32_dfsdm_serial_if - DFSDM serial interface parameters.
> + * @type:	Serial interface type.
> + * @spi_clk:	SPI clock source.
> + * @pins:	select serial interface associated to the channel
> + */
> +struct stm32_dfsdm_serial_if {
> +	enum stm32_dfsdm_serial_in_type type;
> +	enum stm32_dfsdm_spi_clk_src spi_clk;
> +	enum stm32_dfsdm_serial_in_select pins;
> +};
> +
> +/**
> + * struct stm32_dfsdm_channel - DFSDM channel hardware parameters.
> + * @id:		DFSDM channel identifier.
> + * @type:	DFSDM channel input parameters.
> + * @serial_if:	DFSDM channel serial interface parameters.
> + *		Mandatory for DFSDM_CHANNEL_EXTERNAL_INPUTS.
> + */
> +struct stm32_dfsdm_channel {
> +	unsigned int id;
> +	struct stm32_dfsdm_input_type type;
> +	struct stm32_dfsdm_serial_if serial_if;
> +};
> +
> +/**
> + * struct stm32_dfsdm_ch_cfg - DFSDM channel config.
> + * @offset:		DFSDM channel 24 bit calibration offset.
> + * @right_bit_shift:	DFSDM channel right bit shift of the data result.
> + */
> +struct stm32_dfsdm_ch_cfg {
> +	unsigned int offset;
> +	unsigned int right_bit_shift;
> +};
> +
> +/*
> + * Filter definitions
Single line comment syntax.  Make sure this is correct throughout as otherwise
we'll only get 'fix' patches turning up after this hits linux-next.
> + */
> +
> +#define DFSDM_MIN_INT_OVERSAMPLING 1
> +#define DFSDM_MAX_INT_OVERSAMPLING 256
> +#define DFSDM_MIN_FL_OVERSAMPLING 1
Oversampling of 1 is effectively not oversampling so do we need this?

> +#define DFSDM_MAX_FL_OVERSAMPLING 1024
> +
> +enum stm32_dfsdm_events {
Slightly clunky enum usage.  I'd just use the value and put the BIT around
whereever it is used.
> +	DFSDM_EVENT_INJ_EOC =	BIT(0), /* Injected end of conversion event */
> +	DFSDM_EVENT_REG_EOC =	BIT(1), /* Regular end of conversion event */
> +	DFSDM_EVENT_INJ_XRUN =	BIT(2), /* Injected conversion overrun event */
> +	DFSDM_EVENT_REG_XRUN =	BIT(3), /* Regular conversion overrun event */
> +	DFSDM_EVENT_AWD =	BIT(4), /* Analog watchdog event */
> +	DFSDM_EVENT_SCD =	BIT(5), /* Short circuit detector event */
> +	DFSDM_EVENT_CKA =	BIT(6), /* Clock abscence detection event */
> +};
> +
> +#define STM32_DFSDM_EVENT_MASK 0x3F
> +
> +/* DFSDM filter order  */
> +enum stm32_dfsdm_sinc_order {
> +	DFSDM_FASTSINC_ORDER, /* FastSinc filter type */
> +	DFSDM_SINC1_ORDER,    /* Sinc 1 filter type */
> +	DFSDM_SINC2_ORDER,    /* Sinc 2 filter type */
> +	DFSDM_SINC3_ORDER,    /* Sinc 3 filter type */
> +	DFSDM_SINC4_ORDER,    /* Sinc 4 filter type (N.A. for watchdog) */
> +	DFSDM_SINC5_ORDER,    /* Sinc 5 filter type (N.A. for watchdog) */
> +	DFSDM_NB_SINC_ORDER,
> +};
> +
> +/* DFSDM filter order */
Please check your comments - this one is clearly wrong.

> +enum stm32_dfsdm_state {
> +	DFSDM_DISABLE,
> +	DFSDM_ENABLE,
> +};
> +
> +/**
> + * struct stm32_dfsdm_sinc_filter - DFSDM Sinc filter structure definition
> + * @order: DFSM filter order.
> + * @oversampling: DFSDM filter oversampling:
> + *		  post processing filter: min = 1, max = 1024.
> + */
> +struct stm32_dfsdm_sinc_filter {
> +	enum stm32_dfsdm_sinc_order order;
> +	unsigned int oversampling;
> +};
> +
> +/* DFSDM filter conversion trigger */
> +enum stm32_dfsdm_trigger {
> +	DFSDM_FILTER_SW_TRIGGER,   /* Software trigger */
> +	DFSDM_FILTER_SYNC_TRIGGER, /* Synchronous with DFSDM0 */
> +	DFSDM_FILTER_EXT_TRIGGER,  /* External trigger (only for injected) */
> +};
> +
> +/* DFSDM filter external trigger polarity */
> +enum stm32_dfsdm_filter_ext_trigger_pol {
> +	DFSDM_FILTER_EXT_TRIG_NO_TRIG,      /* Trigger disable */
> +	DFSDM_FILTER_EXT_TRIG_RISING_EDGE,  /* Rising edge */
> +	DFSDM_FILTER_EXT_TRIG_FALLING_EDGE, /* Falling edge */
> +	DFSDM_FILTER_EXT_TRIG_BOTH_EDGES,   /* Rising and falling edges */
> +};
> +
> +/* DFSDM filter conversion type */
> +enum stm32_dfsdm_conv_type {
> +	DFSDM_FILTER_REG_CONV,      /* Regular conversion */
> +	DFSDM_FILTER_SW_INJ_CONV,   /* Injected conversion */
> +	DFSDM_FILTER_TRIG_INJ_CONV, /* Injected conversion */
> +};
> +
> +/* DFSDM filter regular synchronous mode */
> +enum stm32_dfsdm_conv_rsync {
> +	DFSDM_FILTER_RSYNC_OFF, /* regular conversion asynchronous */
> +	DFSDM_FILTER_RSYNC_ON,  /* regular conversion synchronous with filter0*/
stray 0?
> +};
> +
> +/**
> + * struct stm32_dfsdm_regular - DFSDM filter conversion parameters structure
> + * @ch_src:	Channel source from 0 to 7.
> + * @fast_mode:	Enable/disable fast mode for regular conversion.
> + * @dma_mode:	Enable/disable dma mode.
> + * @cont_mode	Enable/disable continuous conversion.
> + * @sync_mode	Enable/disable synchro mode.
> + */
> +struct stm32_dfsdm_regular {
> +	unsigned int ch_src;
> +	bool fast_mode;
> +	bool dma_mode;
> +	bool cont_mode;
> +	bool sync_mode;
> +};
> +
> +/**
> + * struct stm32_dfsdm_injected - DFSDM filter  conversion parameters structure
> + * @trigger:	Trigger used to start injected conversion.
> + * @trig_src:	External trigger, 0 to 30 (refer to datasheet for details).
> + * @trig_pol:	External trigger edge: software, rising, falling or both.
> + * @scan_mode:	Enable/disable scan mode for injected conversion.
> + * @ch_group:	mask containing channels to scan ( set bit y to scan
> + *		channel y).
> + * @dma_mode:	DFSDM channel input parameters.
> + */
> +struct stm32_dfsdm_injected {
> +	enum stm32_dfsdm_trigger trigger;
> +	unsigned int trig_src;
> +	enum stm32_dfsdm_filter_ext_trigger_pol trig_pol;
> +	bool scan_mode;
> +	unsigned int ch_group;
> +	bool dma_mode;
> +};
> +
> +struct stm32_dfsdm;
> +
> +/**
> + * struct stm32_dfsdm_fl_event - DFSDM filters event
> + * @cb:	User event callback with parameters. be carful this function
> + *		is called under threaded IRQ context:
> + *			struct stm32_dfsdm *dfsdm: dfsdm handle,
> + *			unsigned int fl_id: filter id,
> + *			num stm32_dfsdm_events flag: event,
> + *			param: parameter associated to the event,
> + *			void *context: user context provided on registration.
> + * @context: User param to retrieve context.
> + */
> +struct stm32_dfsdm_fl_event {
> +	void (*cb)(struct stm32_dfsdm *, int, enum stm32_dfsdm_events,
> +		   unsigned int, void *);
> +	void *context;
> +};
> +
> +/**
> + * struct stm32_dfsdm_filter - DFSDM filter  conversion parameters structure
> + * @reg_params:		DFSDM regular conversion parameters.
> + *			this param is optional and not taken into account if
> + *			@inj_params is defined.
> + * @inj_params:		DFSDM injected conversion parameters (optional).
> + * @filter_params:	DFSDM filter parameters.
> + * @event:		Events callback.
> + * @int_oversampling:	Integrator oversampling ratio for average purpose
> + *			(range from 1 to 256).
> + * @ext_det_ch_mask:	Extreme detector mask for channel selection
> + *			mask generated using DFSDM_CHANNEL_0 to
> + *			DFSDM_CHANNEL_7. If 0 feature is disable.
> + */
> +struct stm32_dfsdm_filter {
> +	struct stm32_dfsdm_regular *reg_params;
> +	struct stm32_dfsdm_injected *inj_params;
> +	struct stm32_dfsdm_sinc_filter sinc_params;
> +	struct stm32_dfsdm_fl_event event;
> +	unsigned int int_oversampling;
> +};
> +
> +/**
> + * struct stm32_dfsdm - DFSDM context structure.
> + *
> + * @trig_info: Trigger name and id available last member name is null.
> + * @max_channels: max number of channels available.
> + * @max_filters: max number of filters available.
> + *
> + * Notice That structure is filled by mdf driver and must not be updated by
mfd
> + * user.
> + */
> +struct stm32_dfsdm {
> +	unsigned int max_channels;
> +	unsigned int max_filters;
> +};
> +
> +int stm32_dfsdm_get_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id);
> +void stm32_dfsdm_release_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id);
> +
> +dma_addr_t stm32_dfsdm_get_filter_dma_phy_addr(struct stm32_dfsdm *dfsdm,
> +					       unsigned int fl_id,
> +					       enum stm32_dfsdm_conv_type conv);
> +
> +int stm32_dfsdm_configure_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +				 struct stm32_dfsdm_filter *filter);
> +void stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +			      enum stm32_dfsdm_conv_type conv);
> +void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id);
> +
> +void stm32_dfsdm_read_fl_conv(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +			      u32 *val, int *ch_id,
> +			      enum stm32_dfsdm_conv_type type);
> +
> +int stm32_dfsdm_unregister_fl_event(struct stm32_dfsdm *dfsdm,
> +				    unsigned int fl_id,
> +				    enum stm32_dfsdm_events event,
> +				    unsigned int ch_mask);
> +int stm32_dfsdm_register_fl_event(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
> +				  enum stm32_dfsdm_events event,
> +				  unsigned int ch_mask);
> +
> +int stm32_dfsdm_get_channel(struct stm32_dfsdm *dfsdm,
> +			    struct stm32_dfsdm_channel *ch);
> +void stm32_dfsdm_release_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id);
> +
> +int stm32_dfsdm_start_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id,
> +			      struct stm32_dfsdm_ch_cfg *cfg);
> +void stm32_dfsdm_stop_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id);
> +
> +int stm32_dfsdm_get_clk_out_rate(struct stm32_dfsdm *dfsdm,
> +				 unsigned long *rate);
> +
> +#endif
> 

