Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42603 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbcH2Srz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 14:47:55 -0400
Subject: Re: [PATCH -next] iio: adc: mt2701: Remove redundant dev_err call in
 mt6577_auxadc_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
References: <1472221581-28836-1-git-send-email-weiyj.lk@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <88307772-dd0f-a2f2-efd8-6c64a0cb14e4@kernel.org>
Date: Mon, 29 Aug 2016 19:47:51 +0100
MIME-Version: 1.0
In-Reply-To: <1472221581-28836-1-git-send-email-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/08/16 15:26, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Hi Wei,

I'm not so sure these are actually redundant.  Overly verbose perhaps,
but they do provide additional information in the log as the
devm_ioremap_resource doesn't know 'what' has failed, merely how
it has failed.

I'm happy to take these, if the driver author / maintainers
agree, but I'm not keen enough to take them without that.

Zhiyong Tao, what do you think on this one?

Jonathan
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 2d104c8..a268954 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -206,10 +206,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(adc_dev->reg_base)) {
> -		dev_err(&pdev->dev, "failed to get auxadc base address\n");
> +	if (IS_ERR(adc_dev->reg_base))
>  		return PTR_ERR(adc_dev->reg_base);
> -	}
>  
>  	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
>  	if (IS_ERR(adc_dev->adc_clk)) {
> 
> 
> 

