Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57457 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778AbaGRPXj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Jul 2014 11:23:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Chanwoo Choi <cwchoi00@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree <devicetree@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org,
	Tomasz Figa <t.figa@samsung.com>, rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	galak@codeaurora.org, naveen krishna <ch.naveen@samsung.com>,
	jic23@kernel.org
Subject: Re: [PATCHv6 2/4] iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
Date: Fri, 18 Jul 2014 17:23:30 +0200
Message-ID: <32226622.5gSmvBRKvZ@wuerfel>
In-Reply-To: <CAGTfZH1EHiTpo2Abua=+kDfNoOQx+ydPHU51=+qW8mgCL4Lwvg@mail.gmail.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <6917971.QKItNU3coA@wuerfel> <CAGTfZH1EHiTpo2Abua=+kDfNoOQx+ydPHU51=+qW8mgCL4Lwvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday 19 July 2014 00:15:35 Chanwoo Choi wrote:
> On Fri, Jul 18, 2014 at 8:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 18 July 2014 19:00:48 Chanwoo Choi wrote:
> >> On 07/18/2014 06:47 PM, Arnd Bergmann wrote:
> >> >
> >> > Further, why is it called "sclk_adc" rather than just "sclk"?
> >>
> >> The sclk means 'special clock' in Exynos TRM. Exynos SoC has varisou sclk clocks.
> >> 'sclk_adc' is only used for ADC IP.
> >
> > But that sounds like sclk_adc is the name of the global name
> > of the clock signal coming out of the clock controller.
> >
> > I still think it would be best to name it 'sclk' as the input
> > for the adc. It shouldn't rely on a particular name of the
> > clock controller.
> 
> I think 'sclk' is too common name. 'sclk' don't include specific device name.
> As I know, usual clock name includes the name of IP or includes the
> specific meaning for each IP.

No, normally it does not include the name of the IP, that's my whole point.
Including the name of the IP is completely pointless because that is
implied by the fact that it's being used by that particular IP.

Ideally you would find the data sheet for the ADC IP block and figure
out what this clock is used for, then find the right name for that.
In a lot of cases, we are actually better off not naming the clocks
at all but simply enumerating them if nobody knows what they are good
for. In that case, you would simply have the first clock and the second
clock of the ADC part and enable them both.

	Arnd
