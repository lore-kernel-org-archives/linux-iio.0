Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55870 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbcGZDXM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 23:23:12 -0400
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Explicitly disable ADC on
 probe
To: Caesar Wang <wxt@rock-chips.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
References: <1469475540-26855-1-git-send-email-linux@roeck-us.net>
 <5796D036.1060101@rock-chips.com>
Cc: linux-iio@vger.kernel.org, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5796D792.4080407@roeck-us.net>
Date: Mon, 25 Jul 2016 20:22:58 -0700
MIME-Version: 1.0
In-Reply-To: <5796D036.1060101@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/25/2016 07:51 PM, Caesar Wang wrote:
> Hi Guenter,
>
> Thanks for fixing it.
>
> On 2016年07月26日 03:39, Guenter Roeck wrote:
>> If the ADC is read for the first time, the caller gets a timeout error,
>> and the kernel log shows
>>
>> read channel() error: -110
>>
>> The ADC may be enabled on boot, and needs to be explicitly disabled
>> for a read sequence to work (otherwise there is no completion interrupt).
>> Disaple it explicitly in the probe function.
>>
>> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/iio/adc/rockchip_saradc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
>> index f9ad6c2d6821..6aa3271d86b5 100644
>> --- a/drivers/iio/adc/rockchip_saradc.c
>> +++ b/drivers/iio/adc/rockchip_saradc.c
>> @@ -280,6 +280,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>           goto err_pclk;
>>       }
>> +    /* Make sure ADC is disabled */
>> +    writel_relaxed(0, info->regs + SARADC_CTRL);
>
> I think we should reset the saradc controller.
> Since make sure the reset value is 0 and loader-->kernel may even cause harm, as my experience on tsadc. (drivers/thermal/rockchip_thermal.c)
>
>
> e.g.:
> /**
> * Reset SARADC Controller, reset all saradc registers.
> */
> static void rockchip_saradc_reset_controller(struct reset_control *reset)
> {
> reset_control_assert(reset);
> usleep_range(10, 20);
> reset_control_deassert(reset);
> }
>
> ..probe()
> {
> ...
> rockchip_saradc_reset_controller();
> ...
> }
>

Ok, I'll give it a try.

Guenter

>
> -
> Caesar
>
>> +
>>       platform_set_drvdata(pdev, indio_dev);
>>       indio_dev->name = dev_name(&pdev->dev);
>
>

