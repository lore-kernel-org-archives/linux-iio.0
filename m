Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:48574 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476AbcG0Am1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 20:42:27 -0400
Message-ID: <57980362.3000406@rock-chips.com>
Date: Wed, 27 Jul 2016 08:42:10 +0800
From: Caesar Wang <wxt@rock-chips.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
	heiko@sntech.de, linux-iio@vger.kernel.org, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, john@metanate.com,
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com> <57976814.3040605@roeck-us.net> <579777F4.2090002@rock-chips.com> <20160726170023.GA6590@roeck-us.net>
In-Reply-To: <20160726170023.GA6590@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2016年07月27日 01:00, Guenter Roeck wrote:
> On Tue, Jul 26, 2016 at 10:47:16PM +0800, Caesar Wang wrote:
>> On 2016年07月26日 21:39, Guenter Roeck wrote:
>>>> static int rockchip_saradc_probe(struct platform_device *pdev)
>>>> {
>>>> struct rockchip_saradc *info = NULL;
>>>> @@ -218,6 +231,21 @@ static int rockchip_saradc_probe(struct
>>>> platform_device *pdev)
>>>> if (IS_ERR(info->regs))
>>>> return PTR_ERR(info->regs);
>>>>
>>>> + /*
>>>> + * The reset should be an optional property, as it should work
>>>> + * with old devicetrees as well
>>>> + */
>>>> + info->reset = devm_reset_control_get_optional(&pdev->dev,
>>>> + "saradc-apb");
>>> Does anyone know what the _optional API is for ? It seems to be exactly
>>> the same
>>> as devm_reset_control_get().
>> “
>> As far as I see, the difference is WARN_ON(1)
>> when CONFIG_RESET_CONTROLLER is not defined.
>>
>>
>> The _optional functions were introduced by the following commit:
>>
>> ----------------->8-----------------
>> commit b424080a9e086e683ad5fdc624a7cf3c024e0c0f
>> Author: Philipp Zabel <p.zabel@xxxxxxxxxxxxxx>
>> Date: Fri Mar 7 15:18:47 2014 +0100
>>
>> reset: Add optional resets and stubs
>>
>> This patch adds device_reset_optional and (devm_)reset_control_get_optional
>> variants that drivers can use to indicate they can function without control
>> over the reset line. For those functions, stubs are added so the drivers can
>> be compiled with CONFIG_RESET_CONTROLLER disabled.
>> Also, device_reset is annotated with __must_check. Drivers
>> ignoring the return
>> value should use device_reset_optional instead.
>>
> Is that really what we are looking for here ? CONFIG_RESET_CONTROLLER
> is required for other functions of rk3399, isn't it ?

Right, as the DRM and thermal are depend on the CONFIG_RESET_CONTROLLER 
.....


>
> Guenter
>
>> Signed-off-by: Philipp Zabel <p.zabel@xxxxxxxxxxxxxx>
>> ------------------8<-----------------------------
>> ”
>>
>> for more information on http://www.spinics.net/lists/kernel/msg2306677.html
>> :-)
>>
>>> Guenter
>>>
>>>> + if (IS_ERR(info->reset)) {
>>>> + ret = PTR_ERR(info->reset);
>>>> + if (ret != -ENOENT)
>>>> + return ret;
>>>> +
>>>> + dev_dbg(&pdev->dev, "no reset control found\n");
>>>> + info->reset = NULL;
>>>> + }
>>>> +
>>>> init_completion(&info->completion);
>>>>
>>>> irq = platform_get_irq(pdev, 0);
>>>> @@ -252,6 +280,9 @@ static int rockchip_saradc_probe(struct
>>>> platform_device *pdev)
>>>> return PTR_ERR(info->vref);
>>>> }
>>>>
>>>> + if (info->reset)
>>>> + rockchip_saradc_reset_controller(info->reset);
>>>> +
>>>> /*
>>>> * Use a default value for the converter clock.
>>>> * This may become user-configurable in the future.
>>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>> -- 
>> caesar wang | software engineer | wxt@rock-chip.com
>>
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt@rock-chip.com


