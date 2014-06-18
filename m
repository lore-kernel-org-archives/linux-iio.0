Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36470 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbaFRTsn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 15:48:43 -0400
Message-ID: <53A1ED91.5050407@kernel.org>
Date: Wed, 18 Jun 2014 20:50:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sachin Kamat <spk.linux@gmail.com>
CC: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org,
	j.anaszewski@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>,
	naveen krishna <ch.naveen@samsung.com>, ktsai@capellamicro.com,
	t.figa@samsung.com, myungjoo.ham@samsung.com,
	jh80.chung@samsung.com, cw00.choi@samsung.com
Subject: Re: [PATCH 1/5] iio: adc: exynos_adc: Use devm_* APIs
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com> <1403072503-29246-2-git-send-email-beomho.seo@samsung.com> <CAK5sBcEdvXNmcpFSMr+bL8AEy39u3arcuL1hQi6Lm4W8kWxMGQ@mail.gmail.com> <53A1A7FA.7040605@linux.intel.com>
In-Reply-To: <53A1A7FA.7040605@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/06/14 15:53, Srinivas Pandruvada wrote:
> On 06/17/2014 11:35 PM, Sachin Kamat wrote:
>> Hi Beomho,
>>
>> On Wed, Jun 18, 2014 at 11:51 AM, Beomho Seo <beomho.seo@samsung.com> wrote:
>>> This patch changes APIs from request_irq() and iio_device_register()
>>> to devm_* APIs. Using them, make code simpler.
>>>
>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>>> ---
>>>   drivers/iio/adc/exynos_adc.c |   11 +++--------
>>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>>> index d325aea..37b6eb5 100644
>>> --- a/drivers/iio/adc/exynos_adc.c
>>> +++ b/drivers/iio/adc/exynos_adc.c
>>> @@ -337,7 +337,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>>>          else
>>>                  indio_dev->num_channels = MAX_ADC_V2_CHANNELS;
>>>
>>> -       ret = request_irq(info->irq, exynos_adc_isr,
>>> +       ret = devm_request_irq(&pdev->dev, info->irq, exynos_adc_isr,
>>>                                          0, dev_name(&pdev->dev), info);
>>>          if (ret < 0) {
>>>                  dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
>>> @@ -345,9 +345,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
>>>                  goto err_disable_clk;
>>>          }
>>>
>>> -       ret = iio_device_register(indio_dev);
>>> +       ret = devm_iio_device_register(&pdev->dev, indio_dev);
> Same here. The remove operation needs some clock / regulator disable.
> So devm_xx may be not be correct based on Jonathan's recent comments.
devm will be fine for anything before non devm elements that need to be
reversed.  After that the ordering gets messed up in the driver tear down
as described.
>
> Thanks,
> Srinivas
>>>          if (ret)
>>> -               goto err_irq;
>>> +               goto err_disable_clk;
>>>
>>>          exynos_adc_hw_init(info);
>>>
>>> @@ -362,9 +362,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
>>>   err_of_populate:
>>>          device_for_each_child(&pdev->dev, NULL,
>>>                                  exynos_adc_remove_devices);
>>> -       iio_device_unregister(indio_dev);
>>> -err_irq:
>>> -       free_irq(info->irq, info);
>>>   err_disable_clk:
>>>          writel(0, info->enable_reg);
>>>          clk_disable_unprepare(info->clk);
>>> @@ -380,8 +377,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
>>>
>>>          device_for_each_child(&pdev->dev, NULL,
>>>                                  exynos_adc_remove_devices);
>>> -       iio_device_unregister(indio_dev);
>>> -       free_irq(info->irq, info);
>>>          writel(0, info->enable_reg);
>>>          clk_disable_unprepare(info->clk);
>>>          regulator_disable(info->vdd);
>>> --
>>> 1.7.9.5
>>>
>>
>> I am not sure if this change is safe as it changes the order of execution.
>> With devm_request_irq, irq is freed only after the function completes, i.e.,
>> the order will now be something like
>>
>> writel(0, info->enable_reg)
>> clk_disable_unprepare(info->clk);
>> regulator_disable(info->vdd);
>> iio_device_unregister
>> free_irq
>>
>> which is not what the original code did.
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

