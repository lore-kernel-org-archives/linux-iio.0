Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33206 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdEAWWG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 18:22:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id c45so18005668qtb.0
        for <linux-iio@vger.kernel.org>; Mon, 01 May 2017 15:22:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1fffc4ab-8952-1252-8e84-6e9b6583dfc3@kernel.org>
References: <20170425033612.27251-1-weiyj.lk@gmail.com> <20170427151413.23843-1-weiyj.lk@gmail.com>
 <1fffc4ab-8952-1252-8e84-6e9b6583dfc3@kernel.org>
From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Date: Tue, 2 May 2017 00:22:05 +0200
Message-ID: <CAL7P5j+rw0VoQkKgM=ZvNtEdfKtuEqUyJmRyfdtZfjKQfysCLw@mail.gmail.com>
Subject: Re: [PATCH -next v2] iio: adc: mxs-lradc: Fix return value check in mxs_lradc_adc_probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Wei,

On Sun, Apr 30, 2017 at 6:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/04/17 16:14, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> In case of error, the function devm_ioremap() returns NULL pointer not
>> ERR_PTR(). Use devm_ioremap_resource() instead of devm_ioremap().
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> I'll be wanting a tested-by for this one.
>
> Thanks,
>
> Jonathan
>> ---
>> v1 -> v2: use devm_ioremap_resource()
>> ---
>>  drivers/iio/adc/mxs-lradc-adc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
>> index b0c7d8e..2faf65f 100644
>> --- a/drivers/iio/adc/mxs-lradc-adc.c
>> +++ b/drivers/iio/adc/mxs-lradc-adc.c
>> @@ -718,7 +718,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>>       adc->dev = dev;
>>
>>       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -     adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
>> +     adc->base = devm_ioremap_resource(dev, iores);
>>       if (IS_ERR(adc->base))
>>               return PTR_ERR(adc->base);
>>


I tested your patch on i.mx28 and it causes probe failure. Here's dmesg output:

[    3.065959] mxs-lradc-adc mxs-lradc-adc: can't request region for
resource [mem 0x80050000-0x80051fff]
[    3.075537] mxs-lradc-adc: probe of mxs-lradc-adc failed with error -16

Ksenija
