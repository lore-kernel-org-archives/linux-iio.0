Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <fugang.duan@freescale.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: "jic23@kernel.org" <jic23@kernel.org>, "shawn.guo@linaro.org"
	<shawn.guo@linaro.org>, Frank Li <Frank.Li@freescale.com>,
	"otavio@ossystems.com.br" <otavio@ossystems.com.br>, "lars@metafoo.de"
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Date: Wed, 4 Dec 2013 11:07:41 +0000
Message-ID: <9848F2DB572E5649BA045B288BE08FBE018BBB86@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1386151203-29728-1-git-send-email-B38611@freescale.com>
 <1386151203-29728-3-git-send-email-B38611@freescale.com>
 <alpine.DEB.2.01.1312041131210.9192@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1312041131210.9192@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Peter Meerwald <linux-iio-owner@vger.kernel.org>
Data: Wednesday, December 04, 2013 6:45 PM

>To: Duan Fugang-B38611
>Cc: jic23@kernel.org; shawn.guo@linaro.org; Li Frank-B20596;
>otavio@ossystems.com.br; lars@metafoo.de; linux-iio@vger.kernel.org
>Subject: Re: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc dr=
iver
>
>
>> Add Freescale Vybrid vf610 adc driver. The driver only support ADC
>> software trigger.
>
[...]

>> +#define VF610_ADC_CHAN(_idx, _chan_type) {			\
>> +	.type =3D (_chan_type),					\
>
>chan_type is IIO_VOLTAGE always
The init version is voltage, and I will add temperature type in future.

>
>> +	.indexed =3D 1,						\
>> +	.channel =3D _idx,
>
>(_idx)

Thanks. I will change it.

>					\
>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>> +}
>> +
>> +static const struct iio_chan_spec vf610_adc_iio_channels[] =3D {
>> +	VF610_ADC_CHAN(0, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(1, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(2, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(3, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(4, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(5, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(6, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(7, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(8, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(9, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(10, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(11, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(12, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(13, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(14, IIO_VOLTAGE),
>> +	VF610_ADC_CHAN(15, IIO_VOLTAGE),
>> +};
>> +
>> +/*
>> + * ADC sample frequency, unit is ADCK cycles.
>> + * ADC clk source is ipg clock, which is the same as bus clock.
>> + *
>> + * ADC conversion time =3D SFCAdder + AverageNum x (BCT + LSTAdder)
>> + * SFCAdder: fix to 8 ADCK cycles
>> + * AverageNum: 1, 4, 32 samples for hardware average.
>> + * BCT(base Conversion Time):
>
>for clarity: BCT (Base Conversion Time)
>
Thanks.

>> + *	- 17 ADCK cycles for 8 bit mode
>> + *	- 21 ADCK cycles for 10 bit mode
>> + *	- 25 ADCK cycles for 25 bit mode
>> + *LSTAdder(Long Sample Time):
>> + *	- 3 ADCK cycles
>> + *	- 13 ADCK cycles
>> + *	- 25 ADCK cycles
>> + *
>> + * The first group of sample frequency for 8 bit mode.
>
>frequencies
>
>> + * The second is for 10 bit, and the third is for 12 bit.
>> + *
>> + * For each group freqency:
>
>frequency group
>
>> + * Entry 0,1,2 -> 1 sample for each conversion
>
>what happened to 3?

It is my mistake.
3,4,5 -> hardware average 4 samples
6,7,8 -> hardware average 32 samples

>
>> + * Entry 4,5,6 -> hardware average 4 samples
>> + * Entry 7,8,9 -> hardware average 32 samples
>> + * Note: software trigger use 1 sample for one conversion.
>> + */
>> +static const u16 vf610_sample_freq_avail[3][9] =3D {
>> +	{28, 38, 50, 88, 128, 176, 648, 968, 1352},
>> +	{32, 42, 54, 104, 144, 192, 776, 1096, 1480},
>> +	{36, 46, 58, 120, 160, 208, 904, 1224, 1608}, };
>> +
>> +static void vf610_adc_cfg_init(struct vf610_adc *info) {
>> +	struct device_node *np =3D info->dev->of_node;
>> +
>> +	/* set default Configuration for ADC controller */
>> +	info->adc_feature.clk_sel =3D VF610_ADCIOC_BUSCLK_SET;
>> +	info->adc_feature.vol_ref =3D VF610_ADCIOC_VR_VREF_SET;
>> +
>> +	info->adc_feature.calibration =3D true;
>> +	info->adc_feature.continual =3D false;
>> +	info->adc_feature.ovwren =3D true;
>> +	info->adc_feature.hw_trig =3D false;
>> +	info->adc_feature.dma_en =3D false;
>> +	info->adc_feature.async_clk_en =3D false;
>> +	info->adc_feature.hw_average_en	=3D false;
>> +	info->adc_feature.cmp_func_en =3D false;
>> +	info->adc_feature.cmp_range_en =3D false;
>> +	info->adc_feature.cmp_greater_en =3D false;
>> +	info->adc_feature.high_speed =3D false;
>> +
>> +	info->adc_feature.clk_div =3D 1;
>> +	info->adc_feature.sample_rate =3D 1;
>> +	info->adc_feature.res_mode =3D 12;
>> +	info->adc_feature.lpm =3D true;
>> +
>> +	if (of_property_read_u32(np, "fsl,adc-io-pinctl",
>> +			&info->adc_feature.pctl)) {
>> +		info->adc_feature.pctl =3D VF610_ADC_IOPCTL5;
>> +		dev_info(info->dev,
>> +			"Missing adc-io-pinctl in dt, enable pin SE5.\n");
>> +	}
>> +}
>> +
>> +static void vf610_adc_cfg_post_set(struct vf610_adc *info) {
>> +	struct vf610_adc_feature *adc_feature =3D &info->adc_feature;
>> +	int cfg_data =3D 0;
>> +	int gc_data =3D 0;
>> +
>> +	switch (adc_feature->clk_sel) {
>> +	case VF610_ADCIOC_ALTCLK_SET:
>> +		cfg_data |=3D VF610_ADC_ALTCLK_SEL;
>> +		break;
>> +	case VF610_ADCIOC_ADACK_SET:
>> +		cfg_data |=3D VF610_ADC_ADACK_SEL;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	/* low power set for calibration */
>> +	cfg_data |=3D VF610_ADC_ADLPC_EN;
>> +
>> +	/* enable high speed for calibration */
>> +	cfg_data |=3D VF610_ADC_ADHSC_EN;
>> +
>> +	/* voltage reference */
>> +	switch (adc_feature->vol_ref) {
>> +	case VF610_ADCIOC_VR_VREF_SET:
>> +		break;
>> +	case VF610_ADCIOC_VR_VALT_SET:
>> +		cfg_data |=3D VF610_ADC_REFSEL_VALT;
>> +		break;
>> +	case VF610_ADCIOC_VR_VBG_SET:
>> +		cfg_data |=3D VF610_ADC_REFSEL_VBG;
>> +		break;
>> +	default:
>> +		dev_err(info->dev, "error voltage reference\n");
>> +	}
>> +
>> +	/* trigger select */
>> +	if (adc_feature->hw_trig)
>> +		cfg_data |=3D VF610_ADC_ADTRG_HARD;
>> +
>> +	/* data overwrite enable */
>> +	if (adc_feature->ovwren)
>> +		cfg_data |=3D VF610_ADC_OVWREN;
>> +
>> +	/* Asynchronous clock output enable */
>> +	if (adc_feature->async_clk_en)
>> +		gc_data |=3D VF610_ADC_ADACKEN;
>> +
>> +	/* dma enable */
>> +	if (adc_feature->dma_en)
>> +		gc_data |=3D VF610_ADC_DMAEN;
>> +
>> +	/* continue function enable */
>> +	if (adc_feature->continual)
>> +		gc_data |=3D VF610_ADC_ADCON;
>> +
>> +	/* compare function enable */
>> +	if (adc_feature->cmp_func_en)
>> +		gc_data |=3D VF610_ADC_ACFE;
>> +
>> +	/* greater than enable */
>> +	if (adc_feature->cmp_greater_en)
>> +		gc_data |=3D VF610_ADC_ACFGT;
>> +
>> +	/* range enable */
>> +	if (adc_feature->cmp_range_en)
>> +		gc_data |=3D VF610_ADC_ACREN;
>> +
>> +	writel(cfg_data, info->regs + VF610_REG_ADC_CFG);
>> +	writel(gc_data, info->regs + VF610_REG_ADC_GC); }
>> +
>> +static void vf610_adc_calibration(struct vf610_adc *info) {
>> +	int adc_gc, hc_cfg;
>> +	int timeout;
>> +
>> +	if (!info->adc_feature.calibration)
>> +		return;
>> +
>> +	/* enable calibration interrupt */
>> +	hc_cfg =3D VF610_ADC_AIEN | VF610_ADC_CONV_DISABLE;
>> +	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
>> +
>> +	adc_gc =3D readl(info->regs + VF610_REG_ADC_GC);
>> +	writel(adc_gc | VF610_ADC_CAL, info->regs + VF610_REG_ADC_GC);
>> +
>> +	timeout =3D wait_for_completion_timeout
>> +			(&info->completion, VF610_ADC_TIMEOUT);
>> +	if (timeout =3D=3D 0)
>> +		dev_err(info->dev, "Timeout for adc calibration\n");
>> +
>> +	adc_gc =3D readl(info->regs + VF610_REG_ADC_GS);
>> +	if (adc_gc & VF610_ADC_CALF)
>> +		dev_err(info->dev, "ADC calibration failed\n");
>> +
>> +	info->adc_feature.calibration =3D false; }
>> +
>> +static void vf610_adc_cfg_set(struct vf610_adc *info) {
>> +	struct vf610_adc_feature *adc_feature =3D &(info->adc_feature);
>> +	int cfg_data;
>> +
>> +	cfg_data =3D readl(info->regs + VF610_REG_ADC_CFG);
>> +
>> +	/* low power configuration */
>> +	cfg_data &=3D ~VF610_ADC_ADLPC_EN;
>> +	if (adc_feature->lpm)
>> +		cfg_data |=3D VF610_ADC_ADLPC_EN;
>> +
>> +	/* high speed operation */
>> +	cfg_data &=3D ~VF610_ADC_ADHSC_EN;
>> +	if (adc_feature->high_speed)
>> +		cfg_data |=3D VF610_ADC_ADHSC_EN;
>> +
>> +	writel(cfg_data, info->regs + VF610_REG_ADC_CFG); }
>> +
>> +static void vf610_adc_sample_set(struct vf610_adc *info) {
>> +	struct vf610_adc_feature *adc_feature =3D &(info->adc_feature);
>> +	int cfg_data, gc_data;
>> +
>> +	cfg_data =3D readl(info->regs + VF610_REG_ADC_CFG);
>> +	gc_data =3D readl(info->regs + VF610_REG_ADC_GC);
>> +
>> +	/* resolution mode */
>> +	cfg_data &=3D ~VF610_ADC_MODE_MASK;
>> +	switch (adc_feature->res_mode) {
>> +	case 8:
>> +		cfg_data |=3D VF610_ADC_MODE_BIT8;
>> +		break;
>> +	case 10:
>> +		cfg_data |=3D VF610_ADC_MODE_BIT10;
>> +		break;
>> +	case 12:
>> +		cfg_data |=3D VF610_ADC_MODE_BIT12;
>> +		break;
>> +	default:
>> +		dev_err(info->dev, "error resolution mode\n");
>> +		break;
>> +	}
>> +
>> +	/* clock select and clock devider */
>
>divider

Thanks.
>
>> +	cfg_data &=3D ~(VF610_ADC_CLK_MASK | VF610_ADC_ADCCLK_MASK);
>> +	switch (adc_feature->clk_div) {
>> +	case 1:
>> +		break;
>> +	case 2:
>> +		cfg_data |=3D VF610_ADC_CLK_DIV2;
>> +		break;
>> +	case 4:
>> +		cfg_data |=3D VF610_ADC_CLK_DIV4;
>> +		break;
>> +	case 8:
[...]

Thanks,
Andy
