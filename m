Return-Path: <zhiyong.tao@mediatek.com>
Message-ID: <1472520599.24148.13.camel@mhfsdcap03>
Subject: Re: [PATCH -next] iio: adc: mt2701: Remove redundant dev_err call
 in mt6577_auxadc_probe()
From: zhiyong tao <zhiyong.tao@mediatek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Matthias Brugger <matthias.bgg@gmail.com>, Wei Yongjun
	<weiyongjun1@huawei.com>, <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <erin.lo@mediatek.com>,
	<zhiyong.tao@mediatek.com>
Date: Tue, 30 Aug 2016 09:29:59 +0800
In-Reply-To: <88307772-dd0f-a2f2-efd8-6c64a0cb14e4@kernel.org>
References: <1472221581-28836-1-git-send-email-weiyj.lk@gmail.com>
	 <88307772-dd0f-a2f2-efd8-6c64a0cb14e4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2016-08-29 at 19:47 +0100, Jonathan Cameron wrote:
> On 26/08/16 15:26, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > There is a error message within devm_ioremap_resource
> > already, so remove the dev_err call to avoid redundant
> > error message.
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Hi Wei,
> 
> I'm not so sure these are actually redundant.  Overly verbose perhaps,
> but they do provide additional information in the log as the
> devm_ioremap_resource doesn't know 'what' has failed, merely how
> it has failed.
> 
> I'm happy to take these, if the driver author / maintainers
> agree, but I'm not keen enough to take them without that.
> 
> Zhiyong Tao, what do you think on this one?
> 
> Jonathan

Dear Jonathan,

Thank you for your suggestion. I think that we can know 'what' has
failed in the driver, if we retain the error message log. It maybe 
advantageous to debug issues.

Zhiyong
> > ---
> >  drivers/iio/adc/mt6577_auxadc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > index 2d104c8..a268954 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -206,10 +206,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> > -	if (IS_ERR(adc_dev->reg_base)) {
> > -		dev_err(&pdev->dev, "failed to get auxadc base address\n");
> > +	if (IS_ERR(adc_dev->reg_base))
> >  		return PTR_ERR(adc_dev->reg_base);
> > -	}
> >  
> >  	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
> >  	if (IS_ERR(adc_dev->adc_clk)) {
> > 
> > 
> > 
> 
