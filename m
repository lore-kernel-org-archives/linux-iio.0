Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-049.synserver.de ([212.40.185.49]:1080 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754947Ab3KZLvH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 06:51:07 -0500
Message-ID: <52948B45.7030505@metafoo.de>
Date: Tue, 26 Nov 2013 12:51:33 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Fugang Duan <B38611@freescale.com>
CC: jic23@kernel.org, sachin.kamat@linaro.org,
	devicetree@vger.kernel.org, shawn.guo@linaro.org,
	b20596@freescale.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
References: <1385463394-11157-1-git-send-email-B38611@freescale.com> <1385463394-11157-3-git-send-email-B38611@freescale.com>
In-Reply-To: <1385463394-11157-3-git-send-email-B38611@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/26/2013 11:56 AM, Fugang Duan wrote:
> Add Freescale Vybrid vf610 adc driver. The driver only support
> ADC software trigger.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>

The driver itself looks mostly fine. I'm not so sure about the dt bindings
though.

> ---
>  drivers/iio/adc/Kconfig     |   11 +
>  drivers/iio/adc/Makefile    |    1 +
>  drivers/iio/adc/vf610_adc.c |  744 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 756 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 2209f28..d0476ec 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -204,4 +204,15 @@ config VIPERBOARD_ADC
>  	  Say yes here to access the ADC part of the Nano River
>  	  Technologies Viperboard.
>  
> +config VF610_ADC

Keep things in alphabetical order...

> +	tristate "Freescale vf610 ADC driver"
> +	help
> +	  Say yes here if you want support for the Vybrid board
> +	  analog-to-digital converter.
> +	  Since the IP is used for i.MX6SLX and i.MX7 serial sillicons, the driver
> +	  also support the subsequent chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called vf610_adc.
> +
>  endmenu
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ba9a10a..c39ae38 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> +obj-$(CONFIG_VF610_ADC) += vf610_adc.o

Same here

> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> new file mode 100644
> index 0000000..0c200d91
> --- /dev/null
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -0,0 +1,744 @@
[...]
> +struct vf610_adc {
> +	struct device           *dev;
> +	void __iomem            *regs;
> +	struct clk              *clk;
> +	unsigned int            irq;

irq doesn't seem to be used outside of the probe function.

> +
> +	u32			vref_uv;
> +	u32			value;
> +	struct regulator        *vref;
> +	struct vf610_adc_feature	adc_feature;
> +
> +	struct completion       completion;
> +};
[...]
> +static void vf610_adc_cfg_of_init(struct vf610_adc *info)
> +{
> +	struct device_node *np = info->dev->of_node;
> +
> +	/*
> +	 * set default Configuration for ADC controller
> +	 * This config may upgrade to require from DT
> +	 */
> +	info->adc_feature.clk_sel = ADCIOC_BUSCLK_SET;
> +	info->adc_feature.vol_ref = VF610_ADCIOC_VR_VREF_SET;
> +	info->adc_feature.calibration = true;
> +	info->adc_feature.tri_hw = false;
> +	info->adc_feature.dataov_en = true;
> +	info->adc_feature.ac_clk_en = false;
> +	info->adc_feature.dma_en = false;
> +	info->adc_feature.cc_en = false;
> +	info->adc_feature.cmp_func_en = false;
> +	info->adc_feature.cmp_range_en = false;
> +	info->adc_feature.cmp_greater_en = false;
> +
> +	if (of_property_read_u32(np, "fsl,adc-io-pinctl",
> +			&info->adc_feature.pctl)) {
> +		info->adc_feature.pctl = VF610_ADC_IOPCTL5;
> +		dev_info(info->dev,
> +			"Miss adc-io-pinctl in dt, enable pin SE5.\n");
> +	}
> +
> +	if (info->vref)
> +		info->vref_uv = regulator_get_voltage(info->vref);
> +	else if (of_property_read_u32(np, "fsl,adc-vref", &info->vref_uv))
> +		dev_err(info->dev,
> +			"Miss adc-vref property or vref regulator in the DT.\n");

If you have a fixed reference voltage use the fixed voltage regulator. Don't
invent custom ways of specifying this.

> +
> +	if (of_property_read_u32(np, "fsl,adc-clk-div",
> +			&info->adc_feature.clk_div_num)) {
> +		info->adc_feature.clk_div_num = 2;
> +		dev_info(info->dev,
> +			"Miss adc-clk-div in dt, set divider to 2.\n");
> +	}
> +
> +	if (of_property_read_u32(np, "fsl,adc-res",
> +			&info->adc_feature.res_mode)) {
> +		info->adc_feature.res_mode = 12;
> +		dev_info(info->dev,
> +			"Miss adc-res property in dt, use 8bit mode.\n");
> +	}
> +
> +	if (of_property_read_u32(np, "fsl,adc-sam-time",
> +			&info->adc_feature.sam_time)) {
> +		info->adc_feature.sam_time = 4;
> +		dev_info(info->dev,
> +			"Miss adc-sam-time property in dt, set to 4.\n");
> +	}
> +
> +	info->adc_feature.hw_average = of_property_read_bool(np,
> +					"fsl,adc-hw-aver-en");
> +	if (info->adc_feature.hw_average &&
> +		 of_property_read_u32(np, "fsl,adc-aver-sam-sel",
> +				&info->adc_feature.hw_sam)) {
> +		info->adc_feature.hw_sam = 4;
> +		dev_info(info->dev,
> +			"Miss adc-aver-sam-sel property in dt, set to 4.\n");
> +	}
> +
> +	info->adc_feature.lpm = of_property_read_bool(np, "fsl,adc-low-power-mode");
> +	info->adc_feature.hs_oper = of_property_read_bool(np, "fsl,adc-high-speed-conv");

Some of the properties look like they should be runtime configurable rather
then board specific settings. E.g. the resolution or the sampling frequency,
or whether averaging is enabled.


> +}
[...]
> +static void vf610_adc_calibration(struct vf610_adc *info)
> +{
> +	int adc_gc, hc_cfg;
> +	int timeout;
> +
> +	if (!info->adc_feature.calibration)
> +		return;
> +
> +	/* enable calibration interrupt */
> +	hc_cfg = VF610_ADC_AIEN | VF610_ADC_CONV_DISABLE;
> +	writel(hc_cfg, info->regs + ADC_HC0);
> +
> +	adc_gc = readl(info->regs + ADC_GC);
> +	writel(adc_gc | VF610_ADC_CAL, info->regs + ADC_GC);
> +
> +	timeout = wait_for_completion_interruptible_timeout
> +			(&info->completion, VF610_ADC_TIMEOUT);

This should probably not be interruptible.

> +	if (timeout == 0)
> +		dev_err(info->dev, "Timeout for adc calibration\n");
> +
> +	adc_gc = readl(info->regs + ADC_GS);
> +	if (adc_gc & VF610_ADC_CALF)
> +		dev_err(info->dev, "ADC calibration failed\n");
> +
> +	info->adc_feature.calibration = false;
> +}
> +
> +static inline void vf610_adc_cfg_set(struct vf610_adc *info)

I'd drop the inline

> +{
[...]
> +}

> +static inline int vf610_adc_read_data(struct vf610_adc *info)
same here
> +{
[...]
> +}
> +
[...]
> +static int vf610_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val,
> +			int *val2,
> +			long mask)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	unsigned int hc_cfg;
> +	unsigned long timeout;
> +
> +	/* Check for invalid channel */
> +	if (chan->channel > VF610_ADC_MAX_CHANS_NUM)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +

putting a reinit_completion() here would make sense

> +		hc_cfg = VF610_ADC_ADCHC(chan->channel);
> +		hc_cfg |= VF610_ADC_AIEN;
> +		writel(hc_cfg, info->regs + ADC_HC0);
> +		timeout = wait_for_completion_interruptible_timeout
> +				(&info->completion, VF610_ADC_TIMEOUT);
> +		*val = info->value;
> +
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (timeout == 0)
> +			return -ETIMEDOUT;

timeout can be negative if the thread was interrupted. In that case return
the error code in timeout.

> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = info->vref_uv >> info->adc_feature.res_mode;
> +		*val2 = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;

It's better to use:
		*val = info->vref_uv / 1000;
		*val2 = info->adc_feature.res_mode;
		return IIO_VAL_FACTIONAL_LOG2;

> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
[...]
> +static int vf610_adc_probe(struct platform_device *pdev)
> +{
> +	struct vf610_adc *info = NULL;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	int ret = -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	info = iio_priv(indio_dev);
> +	info->dev = &pdev->dev;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
> +
> +	info->irq = platform_get_irq(pdev, 0);
> +	if (info->irq < 0) {

0 isn't a valid irq number so this should be "irq <= 0"

> +		dev_err(&pdev->dev, "no irq resource?\n");
> +		return -EINVAL;
> +	}
> +
[...]
> +	vf610_adc_cfg_of_init(info);
> +	vf610_adc_hw_init(info);

This should probably be done before registering the device. Same goes for
the clk_enable() call.

> +
> +	return 0;
> +}
[...]
