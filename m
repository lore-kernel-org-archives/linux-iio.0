Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49016 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933885AbdCVHVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 03:21:30 -0400
Subject: Re: [PATCH v2 2/2] iio: Aspeed AST2400/AST2500 ADC
To: Rick Altherr <raltherr@google.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20170321204828.31303-1-raltherr@google.com>
 <20170321204828.31303-2-raltherr@google.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jacopo Mondi <jacopo@jmondi.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <5f245e55-4d4a-b744-3351-e8215432c315@free-electrons.com>
Date: Wed, 22 Mar 2017 08:21:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170321204828.31303-2-raltherr@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 21/03/2017 21:48, Rick Altherr wrote:
> Aspeed AST2400/AST2500 BMC SoCs include a 16 channel, 10-bit ADC. Low
> and high threshold interrupts are supported by the hardware but are not
> currently implemented.
> 
> Signed-off-by: Rick Altherr <raltherr@google.com>
> ---
> 
> Changes in v2:
> - Rewritten as an IIO device
> - Renamed register macros to describe the register's purpose
> - Replaced awkward reading of 16-bit data registers with readw()
> - Added Kconfig dependency on COMPILE_TEST
> 
[...]
> +struct aspeed_adc_data {
> +	struct device	*dev;
> +	void __iomem	*base;
> +

Useless empty line?

> +	spinlock_t	clk_lock;
> +	struct clk_hw	*clk_prescaler;
> +	struct clk_hw	*clk_scaler;
> +};
> +
> +#define ASPEED_ADC_CHAN(_idx, _addr) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = (_idx),					\
> +	.address = (_addr),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
> +	ASPEED_ADC_CHAN(0, 0x10),
> +	ASPEED_ADC_CHAN(1, 0x12),
> +	ASPEED_ADC_CHAN(2, 0x14),
> +	ASPEED_ADC_CHAN(3, 0x16),
> +	ASPEED_ADC_CHAN(4, 0x18),
> +	ASPEED_ADC_CHAN(5, 0x1A),
> +	ASPEED_ADC_CHAN(6, 0x1C),
> +	ASPEED_ADC_CHAN(7, 0x1E),
> +	ASPEED_ADC_CHAN(8, 0x20),
> +	ASPEED_ADC_CHAN(9, 0x22),
> +	ASPEED_ADC_CHAN(10, 0x24),
> +	ASPEED_ADC_CHAN(11, 0x26),
> +	ASPEED_ADC_CHAN(12, 0x28),
> +	ASPEED_ADC_CHAN(13, 0x2A),
> +	ASPEED_ADC_CHAN(14, 0x2C),
> +	ASPEED_ADC_CHAN(15, 0x2E),

It would make sense to name the registers (the _addr parameter of your
macro) so it's easier to understand what it refers to.

[...]
> +static int aspeed_adc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct aspeed_adc_data *data;
> +	struct resource *res;
> +	const char *clk_parent_name;
> +	int ret;
> +	u32 adc_engine_control_reg_val;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->base)) {
> +		dev_err(&pdev->dev, "Failed allocating device resources\n");
> +		ret = PTR_ERR(data->base);
> +		goto resource_error;
> +	}
> +
> +	/* Register ADC clock prescaler with source specified by device tree. */
> +	spin_lock_init(&data->clk_lock);
> +	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
> +
> +	data->clk_prescaler = clk_hw_register_divider(
> +				&pdev->dev, "prescaler", clk_parent_name, 0,
> +				data->base + ASPEED_ADC_REG_CLOCK_CONTROL,
> +				17, 15, 0, &data->clk_lock);
> +	if (IS_ERR(data->clk_prescaler)) {
> +		dev_err(&pdev->dev, "Failed allocating prescaler clock\n");
> +		ret = PTR_ERR(data->clk_prescaler);
> +		goto prescaler_error;
> +	}
> +
> +	/*
> +	 * Register ADC clock scaler downstream from the prescaler. Allow rate
> +	 * setting to adjust the prescaler as well.
> +	 */
> +	data->clk_scaler = clk_hw_register_divider(
> +				&pdev->dev, "scaler", "prescaler",
> +				CLK_SET_RATE_PARENT,
> +				data->base + ASPEED_ADC_REG_CLOCK_CONTROL,
> +				0, 10, 0, &data->clk_lock);
> +	if (IS_ERR(data->clk_scaler)) {
> +		dev_err(&pdev->dev, "Failed allocating scaler clock\n");
> +		ret = PTR_ERR(data->clk_scaler);
> +		goto scaler_error;
> +	}
> +
> +	/* Start all channels in normal mode. */
> +	clk_prepare_enable(data->clk_scaler->clk);
> +	adc_engine_control_reg_val = GENMASK(31, 16) |
> +		ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE;
> +	writel(adc_engine_control_reg_val,
> +		data->base + ASPEED_ADC_REG_ENGINE_CONTROL);
> +
> +	indio_dev->name = dev_name(&pdev->dev);

This isn't good practice (cf.: https://lkml.org/lkml/2017/1/28/145 end
of the mail in the probe function). Better name it aspeed-adc or even
better to have a different name per compatible: ast2400-adc or ast2500-adc.

> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &aspeed_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = aspeed_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could't register the device.\n");
> +		goto iio_register_error;
> +	}
> +
> +	return 0;
> +
> +iio_register_error:
> +	writel(0x0, data->base + ASPEED_ADC_REG_ENGINE_CONTROL);
> +	clk_disable_unprepare(data->clk_scaler->clk);
> +	clk_hw_unregister_divider(data->clk_scaler);
> +
> +scaler_error:
> +	clk_hw_unregister_divider(data->clk_prescaler);
> +
> +prescaler_error:
> +resource_error:
> +	return ret;
> +}
[...]

Thanks,Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
