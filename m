Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33147 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1437741AbdDZPKi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 11:10:38 -0400
Date: Wed, 26 Apr 2017 08:02:06 -0700
In-Reply-To: <20170426084958.7myimjuloft4fhxb@dell>
References: <20170425033612.27251-1-weiyj.lk@gmail.com> <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org> <20170426084958.7myimjuloft4fhxb@dell>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in mxs_lradc_adc_probe()
To: Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
CC: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <C1698951-84D6-475D-8383-9C935CA7E179@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 26 April 2017 01:49:58 GMT-07:00, Lee Jones <lee.jones@linaro.org> wrote:
>On Wed, 26 Apr 2017, Jonathan Cameron wrote:
>
>> On 25/04/17 04:36, Wei Yongjun wrote:
>> > From: Wei Yongjun <weiyongjun1@huawei.com>
>> > 
>> > In case of error, the function devm_ioremap() returns NULL pointer
>> > not ERR_PTR(). The IS_ERR() test in the return value check should
>> > be replaced with NULL test.
>> > 
>> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> 
>> Lee, do you want to pick this up?  If not I'll scoop it up after the
>merge
>> window has unwound as a fix.  Needs to be on top of the series:
>> [PATCH v15 0/5] mxs-lradc: Split driver into MFD
>
>I'm inclined to agree with Dmitry:
>
>https://www.spinics.net/lists/linux-input/msg51061.html
Agreed. Tidier fix
>
>> > ---
>> >  drivers/iio/adc/mxs-lradc-adc.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/drivers/iio/adc/mxs-lradc-adc.c
>b/drivers/iio/adc/mxs-lradc-adc.c
>> > index b0c7d8e..493e2a2 100644
>> > --- a/drivers/iio/adc/mxs-lradc-adc.c
>> > +++ b/drivers/iio/adc/mxs-lradc-adc.c
>> > @@ -719,8 +719,8 @@ static int mxs_lradc_adc_probe(struct
>platform_device *pdev)
>> >  
>> >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >  	adc->base = devm_ioremap(dev, iores->start,
>resource_size(iores));
>> > -	if (IS_ERR(adc->base))
>> > -		return PTR_ERR(adc->base);
>> > +	if (!adc->base)
>> > +		return -ENOMEM;
>> >  
>> >  	init_completion(&adc->completion);
>> >  	spin_lock_init(&adc->lock);
>> > 
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
