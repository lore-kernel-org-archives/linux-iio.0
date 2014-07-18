Return-Path: <kgene.kim@samsung.com>
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Jonathan Cameron' <jic23@kernel.org>,
 'Chanwoo Choi' <cw00.choi@samsung.com>, ch.naveen@samsung.com,
 t.figa@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org,
 sachin.kamat@linaro.org, kyungmin.park@samsung.com, linux-iio@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <1403843406-28229-1-git-send-email-cw00.choi@samsung.com>
 <53AFFD69.8060702@kernel.org>
In-reply-to: <53AFFD69.8060702@kernel.org>
Subject: RE: [PATCHv5 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and
 code clean
Date: Fri, 18 Jul 2014 14:12:27 +0900
Message-id: <005701cfa246$df97ed40$9ec7c7c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote:
> 
> On 27/06/14 05:30, Chanwoo Choi wrote:
> > Changes from v4:
> > - Use 'exynos_adc_data' structure instead of 'exynos_adc_ops' structure
> >    and remove enum variable of ADC version
> > - Fix wrong name of special clock (sclk_tsadc -> sclk_adc)
> > - Add reviewed message by Naveen Krishna Chatradhi
> > - Add functions for ADC clock control
> >
> > Changes from v3:
> > - Add new 'exynos_adc_ops' structure to improve readability according to
> >   Tomasz Figa comment[1]
> >   [1] https://lkml.org/lkml/2014/4/16/238
> > - Add new 'exynos3250-adc-v2' compatible string to support Exynos3250 ADC
> > - Fix wrong compaitlbe string of ADC in Exynos3250 dtsi file
> >
> > Changes from v2:
> > - Check return value of clock function to deal with error exception
> > - Fix minor coding style to improve readability
> >
> > Changes from v1:
> > - Add new "samsung,exynos-adc-v3" compatible to support Exynos3250 ADC
> > - Add a patch about DT binding documentation
> >
> > Chanwoo Choi (4):
> >    iio: adc: exynos_adc: Add exynos_adc_data structure to improve readability
> >    iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
> >    iio: devicetree: Add DT binding documentation for Exynos3250 ADC
> >    ARM: dts: Fix wrong compatible string for Exynos3250 ADC
> >
> >   .../devicetree/bindings/arm/samsung/exynos-adc.txt |  26 +-
> >   arch/arm/boot/dts/exynos3250.dtsi                  |   4 +-
> >   drivers/iio/adc/exynos_adc.c                       | 326 +++++++++++++++------
> >   3 files changed, 268 insertions(+), 88 deletions(-)
> >
> I am happy with this series, but given it touches some exynos bindings, I would
> like an ack from Kukjin Kim (or according to MAINTAINERS Ben Dooks) before taking it
> all through IIO.
> 
Hi,

Sorry for late response...

The change looks good to me, so please go ahead with my ack on exynos stuff.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin
