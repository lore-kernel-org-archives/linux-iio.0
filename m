Return-Path: <SRS0=j2vj=4C=linaro.org=lee.jones@kernel.org>
Date: Wed, 26 Apr 2017 09:49:58 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Marek Vasut <marex@denx.de>, Wei Yongjun <weiyongjun1@huawei.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
Message-ID: <20170426084958.7myimjuloft4fhxb@dell>
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
 <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 26 Apr 2017, Jonathan Cameron wrote:

> On 25/04/17 04:36, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > In case of error, the function devm_ioremap() returns NULL pointer
> > not ERR_PTR(). The IS_ERR() test in the return value check should
> > be replaced with NULL test.
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> Lee, do you want to pick this up?  If not I'll scoop it up after the merge
> window has unwound as a fix.  Needs to be on top of the series:
> [PATCH v15 0/5] mxs-lradc: Split driver into MFD

I'm inclined to agree with Dmitry:

https://www.spinics.net/lists/linux-input/msg51061.html

> > ---
> >  drivers/iio/adc/mxs-lradc-adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> > index b0c7d8e..493e2a2 100644
> > --- a/drivers/iio/adc/mxs-lradc-adc.c
> > +++ b/drivers/iio/adc/mxs-lradc-adc.c
> > @@ -719,8 +719,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
> >  
> >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> > -	if (IS_ERR(adc->base))
> > -		return PTR_ERR(adc->base);
> > +	if (!adc->base)
> > +		return -ENOMEM;
> >  
> >  	init_completion(&adc->completion);
> >  	spin_lock_init(&adc->lock);
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
