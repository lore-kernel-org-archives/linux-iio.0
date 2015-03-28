Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbC1MIC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 08:08:02 -0400
Message-ID: <5516999E.7010809@kernel.org>
Date: Sat, 28 Mar 2015 12:07:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Agner <stefan@agner.ch>, shawn.guo@linaro.org,
	kernel@pengutronix.de
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, maitysanchayan@gmail.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: vf610: implement configurable conversion
 modes
References: <1427201269-4902-1-git-send-email-stefan@agner.ch> <1427201269-4902-3-git-send-email-stefan@agner.ch>
In-Reply-To: <1427201269-4902-3-git-send-email-stefan@agner.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/15 12:47, Stefan Agner wrote:
> Support configurable conversion mode through sysfs. So far, the
> mode used was low-power, which is enabled by default now. Beside
> that, the modes normal and high-speed are selectable as well.
> 
> Use the new device tree property which specifies the maximum ADC
> conversion clock frequencies. Depending on the mode used, the
> available resulting conversion frequency are calculated
> dynamically.
> 
One trivial bit inline, otherwise looks good to me.
I wish there was a better way of 'hinting' to drivers what power mode
is required, but in the absense of this I guess explicit control is
all we can do.
> Acked-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   7 +
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 ++
>  drivers/iio/adc/vf610_adc.c                        | 146 +++++++++++++++------
>  3 files changed, 120 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-vf610
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vf610 b/Documentation/ABI/testing/sysfs-bus-iio-vf610
> new file mode 100644
> index 0000000..85fd0ecd5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-vf610
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/conversion_mode
> +KernelVersion:	4.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the hardware conversion mode used. The three
> +		available modes are "normal", "high-speed" and "low-power",
> +		whereas the last is the default mode.
Fussy English of the day.  where rather than whereas (whereas is only
used if you say something like. A is normally the case, whereas here B is the case)
I like the default that isn't 'normal' :)

> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> index 1a4a43d..3eb40e2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> @@ -11,6 +11,13 @@ Required properties:
>  - clock-names: Must contain "adc", matching entry in the clocks property.
>  - vref-supply: The regulator supply ADC reference voltage.
>  
> +Recommended properties:
> +- fsl,adck-max-frequency: Maximum frequencies according to datasheets operating
> +  requirements. Three values are required, depending on conversion mode:
> +  - Frequency in normal mode (ADLPC=0, ADHSC=0)
> +  - Frequency in high-speed mode (ADLPC=0, ADHSC=1)
> +  - Frequency in low-power mode (ADLPC=1, ADHSC=0)
> +
>  Example:
>  adc0: adc@4003b000 {
>  	compatible = "fsl,vf610-adc";
> @@ -18,5 +25,7 @@ adc0: adc@4003b000 {
>  	interrupts = <0 53 0x04>;
>  	clocks = <&clks VF610_CLK_ADC0>;
>  	clock-names = "adc";
> +	fsl,adck-max-frequency = <30000000>, <40000000>,
> +				<20000000>;
>  	vref-supply = <&reg_vcc_3v3_mcu>;
>  };
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index e63b8e7..b5f94ab8 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -118,15 +118,21 @@ enum average_sel {
>  	VF610_ADC_SAMPLE_32,
>  };
>  
> +enum conversion_mode_sel {
> +	VF610_ADC_CONV_NORMAL,
> +	VF610_ADC_CONV_HIGH_SPEED,
> +	VF610_ADC_CONV_LOW_POWER,
> +};
> +
>  struct vf610_adc_feature {
>  	enum clk_sel	clk_sel;
>  	enum vol_ref	vol_ref;
> +	enum conversion_mode_sel conv_mode;
>  
>  	int	clk_div;
>  	int     sample_rate;
>  	int	res_mode;
>  
> -	bool	lpm;
>  	bool	calibration;
>  	bool	ovwren;
>  };
> @@ -139,6 +145,8 @@ struct vf610_adc {
>  	u32 vref_uv;
>  	u32 value;
>  	struct regulator *vref;
> +
> +	u32 max_adck_rate[3];
>  	struct vf610_adc_feature adc_feature;
>  
>  	u32 sample_freq_avail[5];
> @@ -148,46 +156,22 @@ struct vf610_adc {
>  
>  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
>  
> -#define VF610_ADC_CHAN(_idx, _chan_type) {			\
> -	.type = (_chan_type),					\
> -	.indexed = 1,						\
> -	.channel = (_idx),					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> -}
> -
> -#define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
> -	.type = (_chan_type),	\
> -	.channel = (_idx),		\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> -}
> -
> -static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> -	VF610_ADC_CHAN(0, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(1, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(2, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(3, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(4, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(5, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(6, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(7, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(8, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(9, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(10, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(11, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(12, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(13, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(14, IIO_VOLTAGE),
> -	VF610_ADC_CHAN(15, IIO_VOLTAGE),
> -	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
> -	/* sentinel */
> -};
> -
>  static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>  {
> +	struct vf610_adc_feature *adc_feature = &info->adc_feature;
>  	unsigned long adck_rate, ipg_rate = clk_get_rate(info->clk);
> -	int i;
> +	int divisor, i;
> +
> +	adck_rate = info->max_adck_rate[adc_feature->conv_mode];
> +
> +	if (adck_rate) {
> +		/* calculate clk divider which is within specification */
> +		divisor = ipg_rate / adck_rate;
> +		adc_feature->clk_div = 1 << fls(divisor + 1);
> +	} else {
> +		/* fall-back value using a safe divisor */
> +		adc_feature->clk_div = 8;
> +	}
>  
>  	/*
>  	 * Calculate ADC sample frequencies
> @@ -219,10 +203,8 @@ static inline void vf610_adc_cfg_init(struct vf610_adc *info)
>  
>  	adc_feature->res_mode = 12;
>  	adc_feature->sample_rate = 1;
> -	adc_feature->lpm = true;
>  
> -	/* Use a save ADCK which is below 20MHz on all devices */
> -	adc_feature->clk_div = 8;
> +	adc_feature->conv_mode = VF610_ADC_CONV_LOW_POWER;
>  
>  	vf610_adc_calculate_rates(info);
>  }
> @@ -307,10 +289,12 @@ static void vf610_adc_cfg_set(struct vf610_adc *info)
>  	cfg_data = readl(info->regs + VF610_REG_ADC_CFG);
>  
>  	cfg_data &= ~VF610_ADC_ADLPC_EN;
> -	if (adc_feature->lpm)
> +	if (adc_feature->conv_mode == VF610_ADC_CONV_LOW_POWER)
>  		cfg_data |= VF610_ADC_ADLPC_EN;
>  
>  	cfg_data &= ~VF610_ADC_ADHSC_EN;
> +	if (adc_feature->conv_mode == VF610_ADC_CONV_HIGH_SPEED)
> +		cfg_data |= VF610_ADC_ADHSC_EN;
>  
>  	writel(cfg_data, info->regs + VF610_REG_ADC_CFG);
>  }
> @@ -412,6 +396,81 @@ static void vf610_adc_hw_init(struct vf610_adc *info)
>  	vf610_adc_cfg_set(info);
>  }
>  
> +static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     unsigned int mode)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +
> +	mutex_lock(&indio_dev->mlock);
> +	info->adc_feature.conv_mode = mode;
> +	vf610_adc_calculate_rates(info);
> +	vf610_adc_hw_init(info);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return 0;
> +}
> +
> +static int vf610_get_conversion_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +
> +	return info->adc_feature.conv_mode;
> +}
> +
> +static const char * const vf610_conv_modes[] = { "normal", "high-speed",
> +						 "low-power" };
> +
> +static const struct iio_enum vf610_conversion_mode = {
> +	.items = vf610_conv_modes,
> +	.num_items = ARRAY_SIZE(vf610_conv_modes),
> +	.get = vf610_get_conversion_mode,
> +	.set = vf610_set_conversion_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
> +	IIO_ENUM("conversion_mode", IIO_SHARED_BY_DIR, &vf610_conversion_mode),
> +	{},
> +};
> +
> +#define VF610_ADC_CHAN(_idx, _chan_type) {			\
> +	.type = (_chan_type),					\
> +	.indexed = 1,						\
> +	.channel = (_idx),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.ext_info = vf610_ext_info,				\
> +}
> +
> +#define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
> +	.type = (_chan_type),	\
> +	.channel = (_idx),		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> +}
> +
> +static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> +	VF610_ADC_CHAN(0, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(1, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(2, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(3, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(4, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(5, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(6, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(7, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(8, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(9, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(10, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(11, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(12, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(13, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(14, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(15, IIO_VOLTAGE),
> +	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
> +	/* sentinel */
> +};
> +
>  static int vf610_adc_read_data(struct vf610_adc *info)
>  {
>  	int result;
> @@ -654,6 +713,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  
>  	info->vref_uv = regulator_get_voltage(info->vref);
>  
> +	of_property_read_u32_array(pdev->dev.of_node, "fsl,adck-max-frequency",
> +			info->max_adck_rate, 3);
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	init_completion(&info->completion);
> 

