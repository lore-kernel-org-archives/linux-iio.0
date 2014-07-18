Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51598 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbaGRSt5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Jul 2014 14:49:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Chanwoo Choi <cwchoi00@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, jic23@kernel.org,
	naveen krishna <ch.naveen@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Rob Herring <robh+dt@kernel.org>, pawel.moll@arm.com,
	Mark Rutland <mark.rutland@arm.com>,
	ijc+devicetree@hellion.org.uk, Kumar Gala <galak@codeaurora.org>,
	rdunlap@infradead.org, Kyungmin Park <kyungmin.park@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>, linux-iio@vger.kernel.org,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCHv6 3/4] iio: devicetree: Add DT binding documentation for Exynos3250 ADC
Date: Fri, 18 Jul 2014 20:48:43 +0200
Message-ID: <5381273.c6GzlyQ7Ea@wuerfel>
In-Reply-To: <CAGTfZH3mnPJ72wi7aFYoChe_OeuRVsUVo3KGRRLTV5scwPbO4g@mail.gmail.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <5835825.JtcDoyOP8b@wuerfel> <CAGTfZH3mnPJ72wi7aFYoChe_OeuRVsUVo3KGRRLTV5scwPbO4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday 19 July 2014 02:02:09 Chanwoo Choi wrote:
> On Sat, Jul 19, 2014 at 1:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday 19 July 2014 01:23:15 Chanwoo Choi wrote:
> >> If don't add new compatible including specific exynos version,
> >> I would add new 'adc-needs-sclk' property with existing 'exynos-adc-v2'
> >> compatible name.

What I actually meant is using compatible="exynos-adc-v2.1" or similar
rather than "exynos3250-adc". However, as you already explained, the
version numbers are apparently just made up, so using "exynos3250-adc"
is actually better here. If a future exynos7890 uses the same clocks
as exynos3250, it can simply use the same "exynos3250-adc" string here.

> >> Dear Naveen, Tomasz,
> >>
> >> If existing exynos-adc driver add just one property for 'sclk_adc'
> >> as following, exynos-adc could not include the exynos version
> >> in compatible name.
> >>
> >> I need your opinion about it.
> >>
> >>                 adc: adc@126C0000 {
> >>                         compatible = "samsung,exynos-adc-v2";
> >>                         reg = <0x126C0000 0x100>, <0x10020718 0x4>;
> >>                         interrupts = <0 137 0>;
> >>                         clock-names = "adc", "sclk_adc";
> >>                         clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
> >> +                        adc-needs-sclk;
> >>                         #io-channel-cells = <1>;
> >>                         io-channel-ranges;
> >>                 }
> >
> > How about just making it an optional clock? That would be much
> > easier because then you can simply see if the clock itself is
> > there and use it, or otherwise ignore it.
> 
> The v1 of this patchset[1] got the clock of 'sclk_adc'  but if the dt node
> of ADC in dtsi file didn't include 'sclk_adc', print just warning message
> without stopping probe as following:
> 
>  [1] https://lkml.org/lkml/2014/4/10/710
> 
> +       info->sclk = devm_clk_get(&pdev->dev, "sclk_adc");
> +       if (IS_ERR(info->sclk)) {
> +               dev_warn(&pdev->dev, "failed getting sclk clock, err = %ld\n",
> +                                                       PTR_ERR(info->sclk));
> +               info->sclk = NULL;
> +       }
> 
> But, Tomasz Figa suggested the method[2] of this patchset(v6).
>  [2] https://lkml.org/lkml/2014/4/11/189

Yes, your current version is certainly better than this, but another way
to address Tomasz' comment would be to change the binding to list the "sclk"
as optional for any device and make the code silently ignore missing sclk
entries, like:


	info->sclk = devm_clk_get(&pdev->dev, "sclk");
	if (IS_ERR(info->sclk)) {
		switch (PTR_ERR(info->sclk)) {
		case -EPROBE_DEFER:
			/* silently return error so we can retry */
			return -EPROBE_DEFER:
		case -ENOENT:
			/* silently ignore missing optional clk */
			info->sclk = NULL;
			break;
		default:
			/* any other error: clk is defined by doesn't work  */
			dev_err(&pdev->dev, "failed getting sclk clock, err = %ld\n",
				PTR_ERR(info->sclk));
			return PTR_ERR(info->sclk));
		}
	}

One more comment about the name: Both in the code you use "sclk" as the
name, so presumably that is the actual name of the clk as known to this
driver, and it makes sense to use clock-names="sclk" as well, if you want
to have any name.

	Arnd
