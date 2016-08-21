Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53352 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcHUUBX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 16:01:23 -0400
Subject: Re: [PATCH v3 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
To: Caesar Wang <wxt@rock-chips.com>, heiko@sntech.de
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <5b6602f2-23f9-e5e5-8479-cddd365f7e71@kernel.org>
 <57B20584.3090502@rock-chips.com>
 <7e84e59d-48ee-3e17-feff-8e57ae7c2b4b@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        john@metanate.com, linux-arm-kernel@lists.infradead.org,
        linux@roeck-us.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b25cda21-0e24-de46-fb23-2142135eca03@kernel.org>
Date: Sun, 21 Aug 2016 21:01:19 +0100
MIME-Version: 1.0
In-Reply-To: <7e84e59d-48ee-3e17-feff-8e57ae7c2b4b@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Something in here got it blocked by the lists. I'm guessing it
was the characters my email client didn't like so trying again
with them dropped.

Jonathan
On 21/08/16 20:11, Jonathan Cameron wrote:
> On 15/08/16 19:10, Caesar Wang wrote:
>>
>>> On 27/07/16 15:24, Caesar Wang wrote:
>>>> SARADC controller needs to be reset before programming it, otherwise
>>>> it will not function properly.
>>>>
>>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: linux-iio@vger.kernel.org
>>>> Cc: linux-rockchip@lists.infradead.org
>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>> Hi
>>>
>>> Patch is fine (I'll fix up the wording issue) however...
>>>
>>> I'm not clear on the severity of the issue. Is this something
>>> we should be pushing for stable?
>>
>> I think that should be pushing for stable, since the common isssue for the ADC is initially enabled on loader,
>> and only disabled after the first read.
>>
>> cat /sys/class/hwmon/hwmon1/device/temp1_input
>> cat: /sys/class/hwmon/hwmon1/device/temp1_input: Connection timed out
>>
>> The kernel log shows:
>>
>> [ 32.209451] read channel() error: -110
>> ..
>>
>> Also, for my experience. Some other reasons caused the adc (controller) glitch for the kernel side.
> Fine.  So now the only question is who is handling it. The
> fix is useless (I think) without the dts changes to support it.
> Normally we'd route the dts and driver changes separately as it
> should not matter, but here I think I'd prefer it if the whole
> thing went via rockchip -> arm-soc tree so it goes in together.
> 
> Hence (with wording fixed)
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Cc: <Stable@vger.kernel.org> 
> (for the driver patch).
> 
> If people want me to take it via IIO then I'll need acks for
> the dts changes with explicit agreement that they can be marked
> for stable. Would image Heiko, these would come from you.
> 
> Thanks,
> 
> Jonathan
>>
>> -
>> Caesar
>>
>>> Jonathan
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - %s/devm_reset_control_get_optional()/devm_reset_control_get()
>>>> - add Guente's test tag.
>>>>
>>>> Changes in v2:
>>>> - Make the reset as an optional property, since it should work
>>>> with old devicetrees as well.
>>>>
>>>>  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
>>>>  drivers/iio/adc/Kconfig                            |  1 +
>>>>  drivers/iio/adc/rockchip_saradc.c                  | 30 ++++++++++++++++++++++
>>>>  3 files changed, 38 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>>>> index bf99e2f..205593f 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>>>> @@ -16,6 +16,11 @@ Required properties:
>>>>  - vref-supply: The regulator supply ADC reference voltage.
>>>>  - #io-channel-cells: Should be 1, see ../iio-bindings.txt
>>>>  
>>>> +Optional properties:
>>>> +- resets: Must contain an entry for each entry in reset-names if need support
>>>> +	  this option. See ../reset/reset.txt for details.
>>>> +- reset-names: Must include the name "saradc-apb".
>>>> +
>>>>  Example:
>>>>  	saradc: saradc@2006c000 {
>>>>  		compatible = "rockchip,saradc";
>>>> @@ -23,6 +28,8 @@ Example:
>>>>  		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>>>>  		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>>>>  		clock-names = "saradc", "apb_pclk";
>>>> +		resets = <&cru SRST_SARADC>;
>>>> +		reset-names = "saradc-apb";
>>>>  		#io-channel-cells = <1>;
>>>>  		vref-supply = <&vcc18>;
>>>>  	};
>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>> index 1de31bd..7675772 100644
>>>> --- a/drivers/iio/adc/Kconfig
>>>> +++ b/drivers/iio/adc/Kconfig
>>>> @@ -389,6 +389,7 @@ config QCOM_SPMI_VADC
>>>>  config ROCKCHIP_SARADC
>>>>  	tristate "Rockchip SARADC driver"
>>>>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>>>> +	depends on RESET_CONTROLLER
>>>>  	help
>>>>  	  Say yes here to build support for the SARADC found in SoCs from
>>>>  	  Rockchip.
>>>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
>>>> index f9ad6c2..85d7012 100644
>>>> --- a/drivers/iio/adc/rockchip_saradc.c
>>>> +++ b/drivers/iio/adc/rockchip_saradc.c
>>>> @@ -21,6 +21,8 @@
>>>>  #include <linux/of_device.h>
>>>>  #include <linux/clk.h>
>>>>  #include <linux/completion.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/reset.h>
>>>>  #include <linux/regulator/consumer.h>
>>>>  #include <linux/iio/iio.h>
>>>>  
>>>> @@ -53,6 +55,7 @@ struct rockchip_saradc {
>>>>  	struct clk		*clk;
>>>>  	struct completion	completion;
>>>>  	struct regulator	*vref;
>>>> +	struct reset_control	*reset;
>>>>  	const struct rockchip_saradc_data *data;
>>>>  	u16			last_val;
>>>>  };
>>>> @@ -190,6 +193,16 @@ static const struct of_device_id rockchip_saradc_match[] = {
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
>>>>  
>>>> +/**
>>>> + * Reset SARADC Controller.
>>>> + */
>>>> +static void rockchip_saradc_reset_controller(struct reset_control *reset)
>>>> +{
>>>> +	reset_control_assert(reset);
>>>> +	usleep_range(10, 20);
>>>> +	reset_control_deassert(reset);
>>>> +}
>>>> +
>>>>  static int rockchip_saradc_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct rockchip_saradc *info = NULL;
>>>> @@ -218,6 +231,20 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>>>  	if (IS_ERR(info->regs))
>>>>  		return PTR_ERR(info->regs);
>>>>  
>>>> +	/*
>>>> +	 * The reset should be an optional property, as it should work
>>>> +	 * with old devicetrees as well
>>>> +	 */
>>>> +	info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
>>>> +	if (IS_ERR(info->reset)) {
>>>> +		ret = PTR_ERR(info->reset);
>>>> +		if (ret != -ENOENT)
>>>> +			return ret;
>>>> +
>>>> +		dev_dbg(&pdev->dev, "no reset control found\n");
>>>> +		info->reset = NULL;
>>>> +	}
>>>> +
>>>>  	init_completion(&info->completion);
>>>>  
>>>>  	irq = platform_get_irq(pdev, 0);
>>>> @@ -252,6 +279,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>>>  		return PTR_ERR(info->vref);
>>>>  	}
>>>>  
>>>> +	if (info->reset)
>>>> +		rockchip_saradc_reset_controller(info->reset);
>>>> +
>>>>  	/*
>>>>  	 * Use a default value for the converter clock.
>>>>  	 * This may become user-configurable in the future.
>>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>>
>> -- 
>> caesar wang | software engineer | wxt@rock-chip.com 
>>
> 

