Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59189 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934041Ab3DOLHS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Apr 2013 07:07:18 -0400
Message-ID: <516BDA77.5060402@jic23.retrosnub.co.uk>
Date: Mon, 15 Apr 2013 11:46:15 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/2] adc: exynos_adc: Convert to devm_ioremap_resource()
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com>
In-Reply-To: <CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/13 09:22, Sachin Kamat wrote:
> On 3 April 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error handling.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Not sure why I missed this one.  I think I marked the entire thread
as not ready based on the responses to patch 2.  Clearly nothing wrong
with this one!  Will pick up for the next cycle now as I think it
is a cleanup rather than an actual bug fix?

Thanks for the ping.

Jonathan
>> ---
>>   drivers/iio/adc/exynos_adc.c |   12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>> index 9f3a8ef..22d034a 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -270,16 +270,16 @@ static int exynos_adc_probe(struct platform_device *pdev)
>>          info = iio_priv(indio_dev);
>>
>>          mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       info->regs = devm_request_and_ioremap(&pdev->dev, mem);
>> -       if (!info->regs) {
>> -               ret = -ENOMEM;
>> +       info->regs = devm_ioremap_resource(&pdev->dev, mem);
>> +       if (IS_ERR(info->regs)) {
>> +               ret = PTR_ERR(info->regs);
>>                  goto err_iio;
>>          }
>>
>>          mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -       info->enable_reg = devm_request_and_ioremap(&pdev->dev, mem);
>> -       if (!info->enable_reg) {
>> -               ret = -ENOMEM;
>> +       info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
>> +       if (IS_ERR(info->enable_reg)) {
>> +               ret = PTR_ERR(info->enable_reg);
>>                  goto err_iio;
>>          }
>>
>> --
>> 1.7.9.5
>>
>
> Ping, Jonathan.
>
>

