Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34706 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdAUM7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 07:59:15 -0500
Subject: Re: [PATCH v3 3/4] iio: adc: add a driver for the SAR ADC found in
 Amlogic Meson SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
References: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-4-martin.blumenstingl@googlemail.com>
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d8b9779a-1647-dbe5-2c4e-a820beae2c00@kernel.org>
Date: Sat, 21 Jan 2017 12:52:16 +0000
MIME-Version: 1.0
In-Reply-To: <20170119145822.26239-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/01/17 14:58, Martin Blumenstingl wrote:
> This adds support for the SAR (Successive Approximation Register) ADC
> on the Amlogic Meson SoCs.
> 
> The code is based on the public S805 (Meson8b) and S905 (GXBB)
> datasheets (see [0] and [1]), as well as by reading (various versions
> of) the vendor driver and by inspecting the registers on the vendor
> kernels of my testing-hardware.
> 
> Currently the GXBB, GXL and GXM SoCs are supported. GXBB hardware has
> 10-bit ADC resolution, while GXL and GXM have 12-bit ADC resolution.
> The code was written to support older SoCs (Meson8 and Meson8b) as well,
> but due to lack of actual testing-hardware no of_device_id was added for
> these.
> 
> Two "features" from the vendor driver are currently missing:
> - the vendor driver uses channel #7 for calibration (this improves the
>   accuracy of the results - in my tests the results were less than 3%
>   off without calibration compared to the vendor driver). Adding support
>   for this should be easy, but is not required for most applications.
> - channel #6 is connected to the SoCs internal temperature sensor.
>   Adding support for this is probably not so easy since (based on the
>   u-boot sources) most SoC versions are using different registers and
>   algorithms for the conversion from "ADC value" to temperature.
> 
> Supported by the hardware but currently not supported by the driver:
> - reading multiple channels at the same time (the hardware has a FIFO
>   buffer which stores multiple results)
> - continuous sampling (this would require a way to enable this
>   individually because otherwise the ADC would be drawing power
>   constantly)
> - interrupt support (similar to the vendor driver this new driver is
>   polling the results. It is unclear if the IRQ-mode is supported on
>   older (Meson6 or Meson8) hardware as well or if there are any errata)
> 
> [0]
> http://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> [1] http://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Very nice.  One really minor comment inline, that I'd only bother
dealing with should you be rolling a V4 for some other reason.

I'll take this if Rob / Mark are happy with the device tree bindings.
Give me a bump if we see nothing from them in the next week or so (or if
I miss it!)

thanks

Jonathan
> ---
>  drivers/iio/adc/Kconfig        |  12 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/meson_saradc.c | 916 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 929 insertions(+)
>  create mode 100644 drivers/iio/adc/meson_saradc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9c8b558ba19e..86059b9b91bf 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -371,6 +371,18 @@ config MEN_Z188_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called men_z188_adc.
>  
> +config MESON_SARADC
> +	tristate "Amlogic Meson SAR ADC driver"
> +	default ARCH_MESON
> +	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
> +	select REGMAP_MMIO
> +	help
> +	  Say yes here to build support for the SAR ADC found in Amlogic Meson
> +	  SoCs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called meson_saradc.
> +
>  config MXS_LRADC
>          tristate "Freescale i.MX23/i.MX28 LRADC"
>          depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d36c4be8d1fc..de05b9e75f8f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
> +obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
>  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> new file mode 100644
> index 000000000000..11a9686d2a9c
> --- /dev/null
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -0,0 +1,916 @@
> +/*
> + * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
> + *
> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define MESON_SAR_ADC_REG0					0x00
> +	#define MESON_SAR_ADC_REG0_PANEL_DETECT			BIT(31)
> +	#define MESON_SAR_ADC_REG0_BUSY_MASK			GENMASK(30, 28)
> +	#define MESON_SAR_ADC_REG0_DELTA_BUSY			BIT(30)
> +	#define MESON_SAR_ADC_REG0_AVG_BUSY			BIT(29)
> +	#define MESON_SAR_ADC_REG0_SAMPLE_BUSY			BIT(28)
> +	#define MESON_SAR_ADC_REG0_FIFO_FULL			BIT(27)
> +	#define MESON_SAR_ADC_REG0_FIFO_EMPTY			BIT(26)
> +	#define MESON_SAR_ADC_REG0_FIFO_COUNT_MASK		GENMASK(25, 21)
> +	#define MESON_SAR_ADC_REG0_ADC_BIAS_CTRL_MASK		GENMASK(20, 19)
> +	#define MESON_SAR_ADC_REG0_CURR_CHAN_ID_MASK		GENMASK(18, 16)
> +	#define MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL		BIT(15)
> +	#define MESON_SAR_ADC_REG0_SAMPLING_STOP		BIT(14)
> +	#define MESON_SAR_ADC_REG0_CHAN_DELTA_EN_MASK		GENMASK(13, 12)
> +	#define MESON_SAR_ADC_REG0_DETECT_IRQ_POL		BIT(10)
> +	#define MESON_SAR_ADC_REG0_DETECT_IRQ_EN		BIT(9)
> +	#define MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK		GENMASK(8, 4)
> +	#define MESON_SAR_ADC_REG0_FIFO_IRQ_EN			BIT(3)
> +	#define MESON_SAR_ADC_REG0_SAMPLING_START		BIT(2)
> +	#define MESON_SAR_ADC_REG0_CONTINUOUS_EN		BIT(1)
> +	#define MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE		BIT(0)
> +
> +#define MESON_SAR_ADC_CHAN_LIST					0x04
> +	#define MESON_SAR_ADC_CHAN_LIST_MAX_INDEX_MASK		GENMASK(26, 24)
> +	#define MESON_SAR_ADC_CHAN_LIST_ENTRY_MASK(_chan)	\
> +					(GENMASK(2, 0) << ((_chan) * 3))
> +
> +#define MESON_SAR_ADC_AVG_CNTL					0x08
> +	#define MESON_SAR_ADC_AVG_CNTL_AVG_MODE_SHIFT(_chan)	\
> +					(16 + ((_chan) * 2))
> +	#define MESON_SAR_ADC_AVG_CNTL_AVG_MODE_MASK(_chan)	\
> +					(GENMASK(17, 16) << ((_chan) * 2))
> +	#define MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_SHIFT(_chan)	\
> +					(0 + ((_chan) * 2))
> +	#define MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_MASK(_chan)	\
> +					(GENMASK(1, 0) << ((_chan) * 2))
> +
> +#define MESON_SAR_ADC_REG3					0x0c
> +	#define MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY		BIT(31)
> +	#define MESON_SAR_ADC_REG3_CLK_EN			BIT(30)
> +	#define MESON_SAR_ADC_REG3_BL30_INITIALIZED		BIT(28)
> +	#define MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN	BIT(27)
> +	#define MESON_SAR_ADC_REG3_CTRL_SAMPLING_CLOCK_PHASE	BIT(26)
> +	#define MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK	GENMASK(25, 23)
> +	#define MESON_SAR_ADC_REG3_DETECT_EN			BIT(22)
> +	#define MESON_SAR_ADC_REG3_ADC_EN			BIT(21)
> +	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
> +	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
> +	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
> +	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
> +	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
> +	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
> +
> +#define MESON_SAR_ADC_DELAY					0x10
> +	#define MESON_SAR_ADC_DELAY_INPUT_DLY_SEL_MASK		GENMASK(25, 24)
> +	#define MESON_SAR_ADC_DELAY_BL30_BUSY			BIT(15)
> +	#define MESON_SAR_ADC_DELAY_KERNEL_BUSY			BIT(14)
> +	#define MESON_SAR_ADC_DELAY_INPUT_DLY_CNT_MASK		GENMASK(23, 16)
> +	#define MESON_SAR_ADC_DELAY_SAMPLE_DLY_SEL_MASK		GENMASK(9, 8)
> +	#define MESON_SAR_ADC_DELAY_SAMPLE_DLY_CNT_MASK		GENMASK(7, 0)
> +
> +#define MESON_SAR_ADC_LAST_RD					0x14
> +	#define MESON_SAR_ADC_LAST_RD_LAST_CHANNEL1_MASK	GENMASK(23, 16)
> +	#define MESON_SAR_ADC_LAST_RD_LAST_CHANNEL0_MASK	GENMASK(9, 0)
> +
> +#define MESON_SAR_ADC_FIFO_RD					0x18
> +	#define MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK		GENMASK(14, 12)
> +	#define MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK		GENMASK(11, 0)
> +
> +#define MESON_SAR_ADC_AUX_SW					0x1c
> +	#define MESON_SAR_ADC_AUX_SW_MUX_SEL_CHAN_MASK(_chan)	\
> +					(GENMASK(10, 8) << (((_chan) - 2) * 2))
> +	#define MESON_SAR_ADC_AUX_SW_VREF_P_MUX			BIT(6)
> +	#define MESON_SAR_ADC_AUX_SW_VREF_N_MUX			BIT(5)
> +	#define MESON_SAR_ADC_AUX_SW_MODE_SEL			BIT(4)
> +	#define MESON_SAR_ADC_AUX_SW_YP_DRIVE_SW		BIT(3)
> +	#define MESON_SAR_ADC_AUX_SW_XP_DRIVE_SW		BIT(2)
> +	#define MESON_SAR_ADC_AUX_SW_YM_DRIVE_SW		BIT(1)
> +	#define MESON_SAR_ADC_AUX_SW_XM_DRIVE_SW		BIT(0)
> +
> +#define MESON_SAR_ADC_CHAN_10_SW				0x20
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_MUX_SEL_MASK	GENMASK(25, 23)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_VREF_P_MUX	BIT(22)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_VREF_N_MUX	BIT(21)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_MODE_SEL		BIT(20)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW	BIT(19)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW	BIT(18)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_YM_DRIVE_SW	BIT(17)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN1_XM_DRIVE_SW	BIT(16)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_MUX_SEL_MASK	GENMASK(9, 7)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_VREF_P_MUX	BIT(6)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_VREF_N_MUX	BIT(5)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_MODE_SEL		BIT(4)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW	BIT(3)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW	BIT(2)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_YM_DRIVE_SW	BIT(1)
> +	#define MESON_SAR_ADC_CHAN_10_SW_CHAN0_XM_DRIVE_SW	BIT(0)
> +
> +#define MESON_SAR_ADC_DETECT_IDLE_SW				0x24
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_SW_EN	BIT(26)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_MUX_MASK	GENMASK(25, 23)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_VREF_P_MUX	BIT(22)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_VREF_N_MUX	BIT(21)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_MODE_SEL	BIT(20)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_YP_DRIVE_SW	BIT(19)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_XP_DRIVE_SW	BIT(18)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_YM_DRIVE_SW	BIT(17)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_XM_DRIVE_SW	BIT(16)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK	GENMASK(9, 7)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_VREF_P_MUX	BIT(6)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_VREF_N_MUX	BIT(5)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MODE_SEL	BIT(4)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_YP_DRIVE_SW	BIT(3)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_XP_DRIVE_SW	BIT(2)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_YM_DRIVE_SW	BIT(1)
> +	#define MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_XM_DRIVE_SW	BIT(0)
> +
> +#define MESON_SAR_ADC_DELTA_10					0x28
> +	#define MESON_SAR_ADC_DELTA_10_TEMP_SEL			BIT(27)
> +	#define MESON_SAR_ADC_DELTA_10_TS_REVE1			BIT(26)
> +	#define MESON_SAR_ADC_DELTA_10_CHAN1_DELTA_VALUE_MASK	GENMASK(25, 16)
> +	#define MESON_SAR_ADC_DELTA_10_TS_REVE0			BIT(15)
> +	#define MESON_SAR_ADC_DELTA_10_TS_C_SHIFT		11
> +	#define MESON_SAR_ADC_DELTA_10_TS_C_MASK		GENMASK(14, 11)
> +	#define MESON_SAR_ADC_DELTA_10_TS_VBG_EN		BIT(10)
> +	#define MESON_SAR_ADC_DELTA_10_CHAN0_DELTA_VALUE_MASK	GENMASK(9, 0)
> +
> +/*
> + * NOTE: registers from here are undocumented (the vendor Linux kernel driver
> + * and u-boot source served as reference). These only seem to be relevant on
> + * GXBB and newer.
> + */
> +#define MESON_SAR_ADC_REG11					0x2c
> +	#define MESON_SAR_ADC_REG11_BANDGAP_EN			BIT(13)
> +
> +#define MESON_SAR_ADC_REG13					0x34
> +	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
> +
> +#define MESON_SAR_ADC_MAX_FIFO_SIZE				32
> +
> +#define MESON_SAR_ADC_CHAN(_chan) {					\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = _chan,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.datasheet_name = "SAR_ADC_CH"#_chan,				\
> +}
> +
> +/*
> + * TODO: the hardware supports IIO_TEMP for channel 6 as well which is
> + * currently not supported by this driver.
> + */
> +static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
> +	MESON_SAR_ADC_CHAN(0),
> +	MESON_SAR_ADC_CHAN(1),
> +	MESON_SAR_ADC_CHAN(2),
> +	MESON_SAR_ADC_CHAN(3),
> +	MESON_SAR_ADC_CHAN(4),
> +	MESON_SAR_ADC_CHAN(5),
> +	MESON_SAR_ADC_CHAN(6),
> +	MESON_SAR_ADC_CHAN(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +};
> +
> +enum meson_sar_adc_avg_mode {
> +	NO_AVERAGING = 0x0,
> +	MEAN_AVERAGING = 0x1,
> +	MEDIAN_AVERAGING = 0x2,
> +};
> +
> +enum meson_sar_adc_num_samples {
> +	ONE_SAMPLE = 0x0,
> +	TWO_SAMPLES = 0x1,
> +	FOUR_SAMPLES = 0x2,
> +	EIGHT_SAMPLES = 0x3,
> +};
> +
> +enum meson_sar_adc_chan7_mux_sel {
> +	CHAN7_MUX_VSS = 0x0,
> +	CHAN7_MUX_VDD_DIV4 = 0x1,
> +	CHAN7_MUX_VDD_DIV2 = 0x2,
> +	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
> +	CHAN7_MUX_VDD = 0x4,
> +	CHAN7_MUX_CH7_INPUT = 0x7,
> +};
> +
> +struct meson_sar_adc_data {
> +	unsigned int				resolution;
> +	const char				*name;
> +};
> +
> +struct meson_sar_adc_priv {
> +	struct regmap				*regmap;
> +	struct regulator			*vref;
> +	const struct meson_sar_adc_data		*data;
> +	struct clk				*clkin;
> +	struct clk				*core_clk;
> +	struct clk				*sana_clk;
> +	struct clk				*adc_sel_clk;
> +	struct clk				*adc_clk;
> +	struct clk_gate				clk_gate;
> +	struct clk				*adc_div_clk;
> +	struct clk_divider			clk_div;
> +};
> +
> +static const struct regmap_config meson_sar_adc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MESON_SAR_ADC_REG13,
> +};
> +
> +static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	u32 regval;
> +
> +	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +
> +	return FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
> +}
> +
> +static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int regval, timeout = 10000;
> +
> +	/*
> +	 * NOTE: we need a small delay before reading the status, otherwise
> +	 * the sample engine may not have started internally (which would
> +	 * seem to us that sampling is already finished).
> +	 */
> +	do {
> +		udelay(1);
> +		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
> +
> +	if (timeout < 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 int *val)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int ret, regval, fifo_chan, fifo_val, sum = 0, count = 0;
> +
> +	ret = meson_sar_adc_wait_busy_clear(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	while (meson_sar_adc_get_fifo_count(indio_dev) > 0 &&
> +	       count < MESON_SAR_ADC_MAX_FIFO_SIZE) {
> +		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
> +
> +		fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK,
> +				      regval);
> +		if (fifo_chan != chan->channel)
> +			continue;
> +
> +		fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
> +				     regval);
> +		fifo_val &= (BIT(priv->data->resolution) - 1);
> +
> +		sum += fifo_val;
> +		count++;
> +	}
> +
> +	if (!count)
> +		return -ENOENT;
> +
> +	*val = sum / count;
> +
> +	return 0;
> +}
> +
> +static void meson_sar_adc_set_averaging(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum meson_sar_adc_avg_mode mode,
> +					enum meson_sar_adc_num_samples samples)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int val, channel = chan->channel;
> +
> +	val = samples << MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_SHIFT(channel);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_AVG_CNTL,
> +			   MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_MASK(channel),
> +			   val);
> +
> +	val = mode << MESON_SAR_ADC_AVG_CNTL_AVG_MODE_SHIFT(channel);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_AVG_CNTL,
> +			   MESON_SAR_ADC_AVG_CNTL_AVG_MODE_MASK(channel), val);
> +}
> +
> +static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	u32 regval;
> +
> +	/*
> +	 * the SAR ADC engine allows sampling multiple channels at the same
> +	 * time. to keep it simple we're only working with one *internal*
> +	 * channel, which starts counting at index 0 (which means: count = 1).
> +	 */
> +	regval = FIELD_PREP(MESON_SAR_ADC_CHAN_LIST_MAX_INDEX_MASK, 0);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_LIST,
> +			   MESON_SAR_ADC_CHAN_LIST_MAX_INDEX_MASK, regval);
> +
> +	/* map channel index 0 to the channel which we want to read */
> +	regval = FIELD_PREP(MESON_SAR_ADC_CHAN_LIST_ENTRY_MASK(0),
> +			    chan->channel);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_LIST,
> +			   MESON_SAR_ADC_CHAN_LIST_ENTRY_MASK(0), regval);
> +
> +	regval = FIELD_PREP(MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_MUX_MASK,
> +			    chan->channel);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DETECT_IDLE_SW,
> +			   MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_MUX_MASK,
> +			   regval);
> +
> +	regval = FIELD_PREP(MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK,
> +			    chan->channel);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DETECT_IDLE_SW,
> +			   MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK,
> +			   regval);
> +
> +	if (chan->channel == 6)
> +		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TEMP_SEL, 0);
> +}
> +
> +static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
> +					enum meson_sar_adc_chan7_mux_sel sel)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	u32 regval;
> +
> +	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, sel);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
> +			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
> +
> +	usleep_range(10, 20);
> +}
> +
> +static void meson_sar_adc_start_sample_engine(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE,
> +			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_SAMPLING_START,
> +			   MESON_SAR_ADC_REG0_SAMPLING_START);
> +}
> +
> +static void meson_sar_adc_stop_sample_engine(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_SAMPLING_STOP,
> +			   MESON_SAR_ADC_REG0_SAMPLING_STOP);
> +
> +	/* wait until all modules are stopped */
> +	meson_sar_adc_wait_busy_clear(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE, 0);
> +}
> +
> +static int meson_sar_adc_lock(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int val, timeout = 10000;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	/* prevent BL30 from using the SAR ADC while we are using it */
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
> +			   MESON_SAR_ADC_DELAY_KERNEL_BUSY,
> +			   MESON_SAR_ADC_DELAY_KERNEL_BUSY);
> +
> +	/* wait until BL30 releases it's lock (so we can use the SAR ADC) */
> +	do {
> +		udelay(1);
> +		regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> +	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
> +
> +	if (timeout < 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +
> +	/* allow BL30 to use the SAR ADC again */
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
> +			   MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
> +
> +	mutex_unlock(&indio_dev->mlock);
> +}
> +
> +static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int count;
> +
> +	for (count = 0; count < MESON_SAR_ADC_MAX_FIFO_SIZE; count++) {
> +		if (!meson_sar_adc_get_fifo_count(indio_dev))
> +			break;
> +
> +		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
> +	}
> +}
> +
> +static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum meson_sar_adc_avg_mode avg_mode,
> +				    enum meson_sar_adc_num_samples avg_samples,
> +				    int *val)
> +{
> +	int ret;
> +
> +	ret = meson_sar_adc_lock(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* clear the FIFO to make sure we're not reading old values */
> +	meson_sar_adc_clear_fifo(indio_dev);
> +
> +	meson_sar_adc_set_averaging(indio_dev, chan, avg_mode, avg_samples);
> +
> +	meson_sar_adc_enable_channel(indio_dev, chan);
> +
> +	meson_sar_adc_start_sample_engine(indio_dev);
> +	ret = meson_sar_adc_read_raw_sample(indio_dev, chan, val);
> +	meson_sar_adc_stop_sample_engine(indio_dev);
> +
> +	meson_sar_adc_unlock(indio_dev);
> +
> +	if (ret) {
> +		dev_warn(indio_dev->dev.parent,
> +			 "failed to read sample for channel %d: %d\n",
> +			 chan->channel, ret);
> +		return ret;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   int *val, int *val2, long mask)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return meson_sar_adc_get_sample(indio_dev, chan, NO_AVERAGING,
> +						ONE_SAMPLE, val);
> +		break;
> +
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		return meson_sar_adc_get_sample(indio_dev, chan,
> +						MEAN_AVERAGING, EIGHT_SAMPLES,
> +						val);
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(priv->vref);
> +		if (ret < 0) {
> +			dev_err(indio_dev->dev.parent,
> +				"failed to get vref voltage: %d\n", ret);
> +			return ret;
> +		}
> +
> +		*val = ret / 1000;
> +		*val2 = priv->data->resolution;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
> +				  void __iomem *base)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	struct clk_init_data init;
> +	const char *clk_parents[1];
> +
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
> +				   of_node_full_name(indio_dev->dev.of_node));
> +	init.flags = 0;
> +	init.ops = &clk_divider_ops;
> +	clk_parents[0] = __clk_get_name(priv->clkin);
> +	init.parent_names = clk_parents;
> +	init.num_parents = 1;
> +
> +	priv->clk_div.reg = base + MESON_SAR_ADC_REG3;
> +	priv->clk_div.shift = MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT;
> +	priv->clk_div.width = MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH;
> +	priv->clk_div.hw.init = &init;
> +	priv->clk_div.flags = 0;
> +
> +	priv->adc_div_clk = devm_clk_register(&indio_dev->dev,
> +					      &priv->clk_div.hw);
> +	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
> +		return PTR_ERR(priv->adc_div_clk);
> +
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
> +				   of_node_full_name(indio_dev->dev.of_node));
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.ops = &clk_gate_ops;
> +	clk_parents[0] = __clk_get_name(priv->adc_div_clk);
> +	init.parent_names = clk_parents;
> +	init.num_parents = 1;
> +
> +	priv->clk_gate.reg = base + MESON_SAR_ADC_REG3;
> +	priv->clk_gate.bit_idx = fls(MESON_SAR_ADC_REG3_CLK_EN);
> +	priv->clk_gate.hw.init = &init;
> +
> +	priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);
> +	if (WARN_ON(IS_ERR(priv->adc_clk)))
> +		return PTR_ERR(priv->adc_clk);
> +
> +	return 0;
> +}
> +
> +static int meson_sar_adc_init(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int regval, ret;
> +
> +	/*
> +	 * make sure we start at CH7 input since the other muxes are only used
> +	 * for internal calibration.
> +	 */
> +	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
> +
> +	/*
> +	 * leave sampling delay and the input clocks as configured by BL30 to
> +	 * make sure BL30 gets the values it expects when reading the
> +	 * temperature sensor.
> +	 */
> +	regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> +	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
> +		return 0;
> +
> +	meson_sar_adc_stop_sample_engine(indio_dev);
> +
> +	/* update the channel 6 MUX to select the temperature sensor */
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL,
> +			MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL);
> +
> +	/* disable all channels by default */
> +	regmap_write(priv->regmap, MESON_SAR_ADC_CHAN_LIST, 0x0);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
> +			   MESON_SAR_ADC_REG3_CTRL_SAMPLING_CLOCK_PHASE, 0);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
> +			   MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY,
> +			   MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY);
> +
> +	/* delay between two samples = (10+1) * 1uS */
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
> +			   MESON_SAR_ADC_DELAY_INPUT_DLY_CNT_MASK,
> +			   FIELD_PREP(MESON_SAR_ADC_DELAY_SAMPLE_DLY_CNT_MASK,
> +				      10));
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
> +			   MESON_SAR_ADC_DELAY_SAMPLE_DLY_SEL_MASK,
> +			   FIELD_PREP(MESON_SAR_ADC_DELAY_SAMPLE_DLY_SEL_MASK,
> +				      0));
> +
> +	/* delay between two samples = (10+1) * 1uS */
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
> +			   MESON_SAR_ADC_DELAY_INPUT_DLY_CNT_MASK,
> +			   FIELD_PREP(MESON_SAR_ADC_DELAY_INPUT_DLY_CNT_MASK,
> +				      10));
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
> +			   MESON_SAR_ADC_DELAY_INPUT_DLY_SEL_MASK,
> +			   FIELD_PREP(MESON_SAR_ADC_DELAY_INPUT_DLY_SEL_MASK,
> +				      1));
> +
> +	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to set adc parent to clkin\n");
> +		return ret;
> +	}
> +
> +	ret = clk_set_rate(priv->adc_clk, 1200000);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to set adc clock rate\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = meson_sar_adc_lock(indio_dev);
> +	if (ret)
> +		goto err_lock;
> +
> +	ret = regulator_enable(priv->vref);
> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to enable vref regulator\n");
> +		goto err_vref;
> +	}
> +
> +	ret = clk_prepare_enable(priv->core_clk);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "failed to enable core clk\n");
> +		goto err_core_clk;
> +	}
> +
> +	ret = clk_prepare_enable(priv->sana_clk);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "failed to enable sana clk\n");
> +		goto err_sana_clk;
> +	}
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
> +			   MESON_SAR_ADC_REG11_BANDGAP_EN,
> +			   MESON_SAR_ADC_REG11_BANDGAP_EN);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
> +			   MESON_SAR_ADC_REG3_ADC_EN,
> +			   MESON_SAR_ADC_REG3_ADC_EN);
> +
> +	udelay(5);
> +
> +	ret = clk_prepare_enable(priv->adc_clk);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "failed to enable adc clk\n");
> +		goto err_adc_clk;
> +	}
> +
> +	meson_sar_adc_unlock(indio_dev);
> +
> +	return 0;
> +
> +err_adc_clk:
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
> +			   MESON_SAR_ADC_REG3_ADC_EN, 0);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
> +			   MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
> +	clk_disable_unprepare(priv->sana_clk);
> +err_sana_clk:
> +	clk_disable_unprepare(priv->core_clk);
> +err_core_clk:
> +	regulator_disable(priv->vref);
> +err_vref:
> +	meson_sar_adc_unlock(indio_dev);
> +err_lock:
> +	return ret;
> +}
> +
> +static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = meson_sar_adc_lock(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(priv->adc_clk);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
> +			   MESON_SAR_ADC_REG3_ADC_EN, 0);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
> +			   MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
> +
> +	clk_disable_unprepare(priv->sana_clk);
> +	clk_disable_unprepare(priv->core_clk);
> +
> +	regulator_disable(priv->vref);
> +
> +	meson_sar_adc_unlock(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info meson_sar_adc_iio_info = {
> +	.read_raw = meson_sar_adc_iio_info_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
> +	.resolution = 10,
> +	.name = "meson-gxbb-saradc",
> +};
> +
> +struct meson_sar_adc_data meson_sar_adc_gxl_data = {
> +	.resolution = 12,
> +	.name = "meson-gxl-saradc",
> +};
> +
> +static const struct of_device_id meson_sar_adc_of_match[] = {
> +	{
> +		.compatible = "amlogic,meson-gxbb-saradc",
> +		.data = &meson_sar_adc_gxbb_data,
> +	}, {
> +		.compatible = "amlogic,meson-gxl-saradc",
> +		.data = &meson_sar_adc_gxl_data,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, meson_sar_adc_of_match);
> +
> +static int meson_sar_adc_probe(struct platform_device *pdev)
> +{
> +	struct meson_sar_adc_priv *priv;
> +	struct iio_dev *indio_dev;
> +	struct resource *res;
> +	void __iomem *base;
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv = iio_priv(indio_dev);
> +
> +	match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
> +	priv->data = match->data;
> +
> +	indio_dev->name = priv->data->name;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &meson_sar_adc_iio_info;
> +
> +	indio_dev->channels = meson_sar_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(meson_sar_adc_iio_channels);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +					     &meson_sar_adc_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->clkin = devm_clk_get(&pdev->dev, "clkin");
> +	if (IS_ERR(priv->clkin)) {
> +		dev_err(&pdev->dev, "failed to get clkin\n");
> +		return PTR_ERR(priv->clkin);
> +	}
> +
> +	priv->core_clk = devm_clk_get(&pdev->dev, "core");
> +	if (IS_ERR(priv->core_clk)) {
> +		dev_err(&pdev->dev, "failed to get core clk\n");
> +		return PTR_ERR(priv->core_clk);
> +	}
> +
> +	priv->sana_clk = devm_clk_get(&pdev->dev, "sana");
> +	if (IS_ERR(priv->sana_clk)) {
> +		if (PTR_ERR(priv->sana_clk) == -ENOENT) {
> +			priv->sana_clk = NULL;
> +		} else {
> +			dev_err(&pdev->dev, "failed to get sana clk\n");
> +			return PTR_ERR(priv->sana_clk);
> +		}
> +	}
> +
> +	priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
> +	if (IS_ERR(priv->adc_clk)) {
> +		if (PTR_ERR(priv->adc_clk) == -ENOENT) {
> +			priv->adc_clk = NULL;
> +		} else {
> +			dev_err(&pdev->dev, "failed to get adc clk\n");
> +			return PTR_ERR(priv->adc_clk);
> +		}
> +	}
> +
> +	priv->adc_sel_clk = devm_clk_get(&pdev->dev, "adc_sel");
> +	if (IS_ERR(priv->adc_sel_clk)) {
> +		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT) {
> +			priv->adc_sel_clk = NULL;
> +		} else {
> +			dev_err(&pdev->dev, "failed to get adc_sel clk\n");
> +			return PTR_ERR(priv->adc_sel_clk);
> +		}
> +	}
> +
> +	/* on pre-GXBB SoCs the SAR ADC itself provides the ADC clock: */
> +	if (!priv->adc_clk) {
> +		ret = meson_sar_adc_clk_init(indio_dev, base);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	priv->vref = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR(priv->vref)) {
> +		dev_err(&pdev->dev, "failed to get vref regulator\n");
> +		return PTR_ERR(priv->vref);
> +	}
> +
> +	ret = meson_sar_adc_init(indio_dev);
> +	if (ret)
> +		goto err;
> +
> +	ret = meson_sar_adc_hw_enable(indio_dev);
> +	if (ret)
> +		goto err;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_hw;
> +
> +	return 0;
> +
> +err_hw:
> +	meson_sar_adc_hw_disable(indio_dev);
> +err:
> +	return ret;
> +}
> +
> +static int meson_sar_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return meson_sar_adc_hw_disable(indio_dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
Slight perference for not bothing with the if def fun which
can go wrong, but instead use __maybe_unused.

Arnd is busy pushing this into lots of drivers and I think it
is neater.

I don't care about this enough to insist on a respin if it's all
that anyone comes up with.

> +static int meson_sar_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return meson_sar_adc_hw_disable(indio_dev);
> +}
> +
> +static int meson_sar_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return meson_sar_adc_hw_enable(indio_dev);
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(meson_sar_adc_pm_ops,
> +			 meson_sar_adc_suspend, meson_sar_adc_resume);
> +
> +static struct platform_driver meson_sar_adc_driver = {
> +	.probe		= meson_sar_adc_probe,
> +	.remove		= meson_sar_adc_remove,
> +	.driver		= {
> +		.name	= "meson-saradc",
> +		.of_match_table = meson_sar_adc_of_match,
> +		.pm = &meson_sar_adc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(meson_sar_adc_driver);
> +
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> +MODULE_DESCRIPTION("Amlogic Meson SAR ADC driver");
> +MODULE_LICENSE("GPL v2");
> 

