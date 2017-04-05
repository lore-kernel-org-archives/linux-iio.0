Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755590AbdDEU1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 16:27:47 -0400
Date: Wed, 5 Apr 2017 13:27:44 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Rick Altherr <raltherr@google.com>
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        David Lechner <david@lechnology.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-clk@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Alison Schofield <amsfield22@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: Aspeed ADC
Message-ID: <20170405202744.GB7065@codeaurora.org>
References: <20170323184136.7349-1-raltherr@google.com>
 <20170323184136.7349-2-raltherr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323184136.7349-2-raltherr@google.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/23, Rick Altherr wrote:
> +
> +static int aspeed_adc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct aspeed_adc_data *data;
> +	const struct aspeed_adc_model_data *model_data;
> +	struct resource *res;
> +	const char *clk_parent_name;
> +	int ret;
> +	u32 adc_engine_control_reg_val;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->base))
> +		return PTR_ERR(data->base);
> +
> +	/* Register ADC clock prescaler with source specified by device tree. */
> +	spin_lock_init(&data->clk_lock);
> +	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);

What if the parent clk is not registered yet? Or if we're not
always using DT in this driver? Put another way, this code is
fragile. But I guess it probably works well enough for now so no
big deal, just pointing out my fear.

> +
> +	data->clk_prescaler = clk_hw_register_divider(
> +				&pdev->dev, "prescaler", clk_parent_name, 0,
> +				data->base + ASPEED_REG_CLOCK_CONTROL,
> +				17, 15, 0, &data->clk_lock);
> +	if (IS_ERR(data->clk_prescaler))
> +		return PTR_ERR(data->clk_prescaler);
> +
> +	/*
> +	 * Register ADC clock scaler downstream from the prescaler. Allow rate
> +	 * setting to adjust the prescaler as well.
> +	 */
> +	data->clk_scaler = clk_hw_register_divider(
> +				&pdev->dev, "scaler", "prescaler",
> +				CLK_SET_RATE_PARENT,
> +				data->base + ASPEED_REG_CLOCK_CONTROL,
> +				0, 10, 0, &data->clk_lock);
> +	if (IS_ERR(data->clk_scaler)) {
> +		ret = PTR_ERR(data->clk_scaler);
> +		goto scaler_error;
> +	}
> +
> +	/* Start all channels in normal mode. */
> +	clk_prepare_enable(data->clk_scaler->clk);

Eventually we'd like to get rid of hw->clk pointer so that users
have to call some sort of clk_get() API and then we get warm
fuzzies from knowing who is consuming a clk structure. Can you
change this to register a clk provider and call clk_get()? I
think a device that references itself should be OK in DT still,
and would properly reflect what's going on.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
