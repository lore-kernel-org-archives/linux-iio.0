Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58098 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaGUI6K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jul 2014 04:58:10 -0400
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
Date: Mon, 21 Jul 2014 10:57:35 +0200
Message-ID: <10938575.0qbHyHWX4J@wuerfel>
In-Reply-To: <53CCCB20.50802@samsung.com>
References: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com> <14522743.f6oFhEQVv4@wuerfel> <53CCCB20.50802@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 21 July 2014 17:11:12 Chanwoo Choi wrote:
> >    work to address the comments and do testing.
> 
> OK, I'll add this patch.
> But, I have a question.
> 
> Your patch add following compatible string.
> "s3c64100-adc" is right?
> 
>  static const struct of_device_id exynos_adc_match[] = {
>         {
> +               .compatible = "samsung,s3c64100-adc",
> +               .data = &exynos_adc_s3c64xx_data,
> +       }, {

There is a typo, thanks for spotting this. It should be
"samsung,s3c6410-adc", not "samsung,s3c64100-adc".

> > b) For the "compatible" string, I think it makes sense to set a fallback to
> >    "samsung,exynos-adc-v2" in the case for exynos3250, making the DT
> >    representation
> > 
> >       compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2";
> > 
> >    It's not entirely compatible because of the addition of the clock, but
> >    since the register layout is the same, I think it still make sense.
> 
> OK, I'll add it in exynos3250.dtsi as following:
> 
>                 adc: adc@126C0000 {
> -                       compatible = "samsung,exynos-adc-v3";
> +                       compatible = "samsung,exynos3250-adc",
> +                                    "samsung,exynos-adc-v2";
>                         reg = <0x126C0000 0x100>, <0x10020718 0x4>;
>                         interrupts = <0 137 0>;
> -                       clock-names = "adc", "sclk_tsadc";
> +                       clock-names = "adc", "sclk";
>                         clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
>                         #io-channel-cells = <1>;
>                         io-channel-ranges;

Ok, looks good.

	Arnd
