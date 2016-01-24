Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45428 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbcAXQFN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 11:05:13 -0500
Subject: Re: [PATCHv2] staging: iio: replace clk_get() with devm_clk_get()
To: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"ciorneiioana@gmail.com" <ciorneiioana@gmail.com>,
	"hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>
References: <20160121095653.GA10394@IND12F0122>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stefan Roese <sr@denx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4F633.1030008@kernel.org>
Date: Sun, 24 Jan 2016 16:05:07 +0000
MIME-Version: 1.0
In-Reply-To: <20160121095653.GA10394@IND12F0122>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/16 09:55, Gujulan Elango, Hari Prasath (H.) wrote:
> From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
> 
> This patch replaces the clk_get() with devm_clk_get().
> Accordingly,modified the error paths and removed clk_put() as well.
> 
> Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
What about the clk_put in the remove function?
Drop that one as well as the managed handling will deal with that
anyway.

Also, I'd be happier if you reorganised the probe to do the clk stuff
before the of_iomap.  That way it makes it readily apparent that we
haven't introduced a different in probe / remove (reversed) operations.

I'd largely forgotten about this driver after doing a cleanup set
back in 2014.  Hartmut, you raised a few points back then about
some disagreements between the driver and the datasheet, otherwise
I'd probably have just shifted it out of staging back then.

Stefan has been quiet on this one for a while, I don't suppose anyone
actually has one of these to test?  I was always nervous about making
the other changes Hartmut suggested without someone testing them.

Hari, are you doing this as generic cleanup (always good to have!) or
because you are working with the hardware and hence looking at the code?

Jonathan


> ---
> 	v2: email address was missing in the From field.
> ---
>  drivers/staging/iio/adc/spear_adc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index 712cae0..4ac0f54 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -288,7 +288,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	st->adc_base_spear3xx =
>  		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
>  
> -	st->clk = clk_get(dev, NULL);
> +	st->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(st->clk)) {
>  		dev_err(dev, "failed getting clock\n");
>  		goto errout1;
> @@ -297,7 +297,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	ret = clk_prepare_enable(st->clk);
>  	if (ret) {
>  		dev_err(dev, "failed enabling clock\n");
> -		goto errout2;
> +		goto errout1;
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -356,8 +356,6 @@ static int spear_adc_probe(struct platform_device *pdev)
>  
>  errout3:
>  	clk_disable_unprepare(st->clk);
> -errout2:
> -	clk_put(st->clk);
>  errout1:
>  	iounmap(st->adc_base_spear6xx);
>  	return ret;
> 

