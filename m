Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35231 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2997071AbdDZKHM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 06:07:12 -0400
Received: by mail-wm0-f54.google.com with SMTP id w64so45552211wma.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Apr 2017 03:07:11 -0700 (PDT)
Date: Wed, 26 Apr 2017 11:07:08 +0100
From: Lee Jones <lee.jones@linaro.org>
To: "weiyongjun (A)" <weiyongjun1@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Wei Yongjun <weiyj.lk@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
Message-ID: <20170426100708.vtv7uijpdp3emmn5@dell>
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
 <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org>
 <20170426084958.7myimjuloft4fhxb@dell>
 <6AADFAC011213A4C87B956458587ADB47C87B2@SZXEMI508-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <6AADFAC011213A4C87B956458587ADB47C87B2@SZXEMI508-MBX.china.huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 26 Apr 2017, weiyongjun (A) wrote:

> > 
> > On Wed, 26 Apr 2017, Jonathan Cameron wrote:
> > 
> > > On 25/04/17 04:36, Wei Yongjun wrote:
> > > > From: Wei Yongjun <weiyongjun1@huawei.com>
> > > >
> > > > In case of error, the function devm_ioremap() returns NULL pointer
> > > > not ERR_PTR(). The IS_ERR() test in the return value check should
> > > > be replaced with NULL test.
> > > >
> > > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > >
> > > Lee, do you want to pick this up?  If not I'll scoop it up after the merge
> > > window has unwound as a fix.  Needs to be on top of the series:
> > > [PATCH v15 0/5] mxs-lradc: Split driver into MFD
> > 
> > I'm inclined to agree with Dmitry:
> > 
> > https://www.spinics.net/lists/linux-input/msg51061.html
> 
> Not sure we can use devm_ioremap_resource(), if it is safe, I will
> send v2 version patch to use devm_ioremap_resource() instead.

What makes you think it might not be safe?

> > > > ---
> > > >  drivers/iio/adc/mxs-lradc-adc.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-
> > adc.c
> > > > index b0c7d8e..493e2a2 100644
> > > > --- a/drivers/iio/adc/mxs-lradc-adc.c
> > > > +++ b/drivers/iio/adc/mxs-lradc-adc.c
> > > > @@ -719,8 +719,8 @@ static int mxs_lradc_adc_probe(struct
> > platform_device *pdev)
> > > >
> > > >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >  	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> > > > -	if (IS_ERR(adc->base))
> > > > -		return PTR_ERR(adc->base);
> > > > +	if (!adc->base)
> > > > +		return -ENOMEM;
> > > >
> > > >  	init_completion(&adc->completion);
> > > >  	spin_lock_init(&adc->lock);
> > > >
> > >
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
