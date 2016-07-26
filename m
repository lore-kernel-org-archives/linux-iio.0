Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:42103 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbcGZKuI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 06:50:08 -0400
Message-ID: <57974054.8040700@rock-chips.com>
Date: Tue, 26 Jul 2016 18:49:56 +0800
From: Caesar Wang <wxt@rock-chips.com>
MIME-Version: 1.0
To: John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>
CC: Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, linux@roeck-us.net, jic23@kernel.org
Subject: Re: [PATCH 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
References: <1469513510-1516-1-git-send-email-wxt@rock-chips.com> <20160726100007.5166e7f9.john@metanate.com>
In-Reply-To: <20160726100007.5166e7f9.john@metanate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2016年07月26日 17:00, John Keeping wrote:
> On Tue, 26 Jul 2016 14:11:47 +0800, Caesar Wang wrote:
>
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-iio@vger.kernel.org
>> Cc: linux-rockchip@lists.infradead.org
>> ---
>>
>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
>> index f9ad6c2..2f0e110 100644
>> --- a/drivers/iio/adc/rockchip_saradc.c
>> +++ b/drivers/iio/adc/rockchip_saradc.c
>> @@ -218,6 +231,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>   	if (IS_ERR(info->regs))
>>   		return PTR_ERR(info->regs);
>>   
>> +	info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
>> +	if (IS_ERR(info->reset)) {
>> +		ret = PTR_ERR(info->reset);
>> +		dev_err(&pdev->dev, "failed to get saradc reset: %d\n", ret);
>> +		return ret;
>> +	}
> Does this need to handle ENOENT so as to avoid failing with old device
> tree blobs?

I'm no sure why we have to support the old device tree,
We can apply this series patches if we need to support the reset property.
---

Maybe, I can follow you suggestion to handle the ENOENT, as following:

+ /*
+ * The reset should be an optional property, as it should work
+ * with old devicetrees as well
+ */
+ info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
+ if (IS_ERR(info->reset)) {
+ if (PTR_ERR(info->reset) == -EPROBE_DEFER) {
+ ret = -EPROBE_DEFER;
+ return ret;
+ }
+ dev_dbg(&pdev->dev, "no reset control found\n");
+ info->reset = NULL;
+ }
...

+ if (info->reset)
+ rockchip_saradc_reset_controller(info->reset);
+

How about it?


-
Caesar
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt@rock-chip.com


