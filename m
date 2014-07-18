Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63166 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbaGRLR4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Jul 2014 07:17:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, jic23@kernel.org,
	My self <ch.naveen@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rdunlap@infradead.org, kyungmin.park@samsung.com,
	t.figa@samsung.com, linux-iio@vger.kernel.org,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCHv6 1/4] iio: adc: exynos_adc: Add exynos_adc_data structure to improve readability
Date: Fri, 18 Jul 2014 13:16:53 +0200
Message-ID: <237819296.s52Lu0h5nW@wuerfel>
In-Reply-To: <CAHfPSqBDOEH5HurG=rECV=d+MM_YjTEpsiwuTgtNgFgCQ0P2bw@mail.gmail.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <6186153.TIYp5NXPIq@wuerfel> <CAHfPSqBDOEH5HurG=rECV=d+MM_YjTEpsiwuTgtNgFgCQ0P2bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday 18 July 2014 15:41:27 Naveen Krishna Ch wrote:
> >
> >         {
> >                 .name           = "s3c24xx-adc",
> >                 .driver_data    = TYPE_ADCV1,
> >         }, {
> >                 .name           = "s3c2443-adc",
> >                 .driver_data    = TYPE_ADCV11,
> >         }, {
> >                 .name           = "s3c2416-adc",
> >                 .driver_data    = TYPE_ADCV12,
> >         }, {
> >                 .name           = "s3c64xx-adc",
> >                 .driver_data    = TYPE_ADCV2,
> >         }, {
> >                 .name           = "samsung-adc-v3",
> >                 .driver_data    = TYPE_ADCV3,
> >         }
> >
> > Where TYPE_ADCV3 seems to be the same as the new ADC_V1 used in this
> > driver. Do you have an explanation for that?
> 
> As per suggestion from Doug Anderson,
> I've implemented IIO based ADC driver to work with Exynos5250.
> keeping the plat-samsung/adc.c unchanged.
> 
> Assuming Exynos5250 is the one using the driver for the first time.
> i've named it v1 and so on.
> 
> Now, This seems to cause a lot of confusion.

Ah, so the version numbers don't come from Samsung hardware
documents but are just counting the versions we have drivers
for?

In this case, I guess using the first SoC that had a particular
version would have been better, and we should probably do that
when we add support for the older hardware in this driver.

	Arnd
