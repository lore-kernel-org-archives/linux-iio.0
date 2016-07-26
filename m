Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40721 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcGZWl0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 18:41:26 -0400
Date: Tue, 26 Jul 2016 15:41:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Caesar Wang <wxt@rock-chips.com>
Cc: jic23@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	john@metanate.com, dianders@chromium.org
Subject: Re: [PATCH v2 1/4] iio: adc: rockchip_saradc: reset saradc
 controller before programming it
Message-ID: <20160726224115.GA25307@roeck-us.net>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 26, 2016 at 08:13:12PM +0800, Caesar Wang wrote:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org

Tested-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Changes in v2:
> - Make the reset as an optional property, since it should work
> with old devicetrees as well.
> 
>  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
>  drivers/iio/adc/Kconfig                            |  1 +
>  drivers/iio/adc/rockchip_saradc.c                  | 31 ++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> index bf99e2f..205593f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> @@ -16,6 +16,11 @@ Required properties:
>  - vref-supply: The regulator supply ADC reference voltage.
>  - #io-channel-cells: Should be 1, see ../iio-bindings.txt
>  
> +Optional properties:
> +- resets: Must contain an entry for each entry in reset-names if need support
> +	  this option. See ../reset/reset.txt for details.
> +- reset-names: Must include the name "saradc-apb".
> +
>  Example:
>  	saradc: saradc@2006c000 {
>  		compatible = "rockchip,saradc";
> @@ -23,6 +28,8 @@ Example:
>  		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>  		clock-names = "saradc", "apb_pclk";
> +		resets = <&cru SRST_SARADC>;
> +		reset-names = "saradc-apb";
>  		#io-channel-cells = <1>;
>  		vref-supply = <&vcc18>;
>  	};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1de31bd..7675772 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -389,6 +389,7 @@ config QCOM_SPMI_VADC
>  config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> +	depends on RESET_CONTROLLER
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index f9ad6c2..dc1379f 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -21,6 +21,8 @@
>  #include <linux/of_device.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/reset.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/iio/iio.h>
>  
> @@ -53,6 +55,7 @@ struct rockchip_saradc {
>  	struct clk		*clk;
>  	struct completion	completion;
>  	struct regulator	*vref;
> +	struct reset_control	*reset;
>  	const struct rockchip_saradc_data *data;
>  	u16			last_val;
>  };
> @@ -190,6 +193,16 @@ static const struct of_device_id rockchip_saradc_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
>  
> +/**
> + * Reset SARADC Controller.
> + */
> +static void rockchip_saradc_reset_controller(struct reset_control *reset)
> +{
> +	reset_control_assert(reset);
> +	usleep_range(10, 20);
> +	reset_control_deassert(reset);
> +}
> +
>  static int rockchip_saradc_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_saradc *info = NULL;
> @@ -218,6 +231,21 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	if (IS_ERR(info->regs))
>  		return PTR_ERR(info->regs);
>  
> +	/*
> +	 * The reset should be an optional property, as it should work
> +	 * with old devicetrees as well
> +	 */
> +	info->reset = devm_reset_control_get_optional(&pdev->dev,
> +			"saradc-apb");
> +	if (IS_ERR(info->reset)) {
> +		ret = PTR_ERR(info->reset);
> +		if (ret != -ENOENT)
> +			return ret;
> +
> +		dev_dbg(&pdev->dev, "no reset control found\n");
> +		info->reset = NULL;
> +	}
> +
>  	init_completion(&info->completion);
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -252,6 +280,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		return PTR_ERR(info->vref);
>  	}
>  
> +	if (info->reset)
> +		rockchip_saradc_reset_controller(info->reset);
> +
>  	/*
>  	 * Use a default value for the converter clock.
>  	 * This may become user-configurable in the future.
> -- 
> 1.9.1
> 
