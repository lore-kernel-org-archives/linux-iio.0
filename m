Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55648 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbaGUI6k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jul 2014 04:58:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, jic23@kernel.org,
	ch.naveen@samsung.com, mark.rutland@arm.com,
	devicetree@vger.kernel.org, kgene.kim@samsung.com,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-iio@vger.kernel.org, t.figa@samsung.com,
	rdunlap@infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org
Subject: Re: [PATCHv7 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and code clean
Date: Mon, 21 Jul 2014 10:58:16 +0200
Message-ID: <4966271.WeZIcVN3eT@wuerfel>
In-Reply-To: <53CCCCA8.1030509@samsung.com>
References: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com> <53CCCB20.50802@samsung.com> <53CCCCA8.1030509@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 21 July 2014 17:17:44 Chanwoo Choi wrote:
> On 07/21/2014 05:11 PM, Chanwoo Choi wrote:
> > On 07/21/2014 04:38 PM, Arnd Bergmann wrote:
> >> On Monday 21 July 2014 11:17:44 Chanwoo Choi wrote:
> >>>
> >>> This patchset support Exynos3250 ADC (Analog Digital Converter) because
> >>> Exynos3250 has additional special clock for ADC IP.
> >>>
> >>> Changes from v6:
> >>> - Use "exynos3250-adc" compatible string instead of "exynos3250-adc-v2"
> >>> - Use "sclk" clock name instead of "sclk_adc"
> >>> - Remove un-necessary macro for exyno-adc-data-v2 structure.
> >>> - Remove '(void *)' cast and mark the exynos-adc-data structure as 'const'
> >>> - Change the number of ADC channels (Exynos3250 has only two channels for ADC)
> >>>
> >>
> >> Looks good to me. Two small requests:
> >>
> >> a) if you don't mind, can you add my patch (1/2) to add support for s3c64xx to
> >>    your series, adding your Signed-off-by line in addition to mine? I think
> >>    that one was noncontroversial, while the second patch (2/2) need some more
> >>    work to address the comments and do testing.
> > 
> > OK, I'll add this patch.
> > But, I have a question.
> > 
> > Your patch add following compatible string.
> > "s3c64100-adc" is right?
> > 
> >  static const struct of_device_id exynos_adc_match[] = {
> >  	{
> > +		.compatible = "samsung,s3c64100-adc",
> > +		.data = &exynos_adc_s3c64xx_data,
> > +	}, {
> 
> Additionally,
> Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt has not included
> "samsung,s3c6410-adc" compatible string. Should I add this string in exynos-adc.txt?
> 
> drivers/iio/adc/exynos-adc.c has not includeded following compatible string.
> Should I add this compatible string on exynos-adc.c?
> 
> +			Must be "samsung,s3c2410-adc" for
> +				the ADC in s3c2410 and compatibles
> +			Must be "samsung,s3c2416-adc" for
> +				the ADC in s3c2416 and compatibles
> +			Must be "samsung,s3c2440-adc" for
> +				the ADC in s3c2440 and compatibles
> +			Must be "samsung,s3c2440-adc" for
> +				the ADC in s3c2440 and compatibles
> +			Must be "samsung,s3c2443-adc" for
> +				the ADC in s3c2443 and compatibles
> 


Yes, please.

	Arnd
