Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, jic23@kernel.org, ch.naveen@samsung.com, mark.rutland@arm.com, devicetree@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org, t.figa@samsung.com, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org
Subject: Re: [PATCHv6 2/4] iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
Date: Fri, 18 Jul 2014 13:14:55 +0200
Message-ID: <6917971.QKItNU3coA@wuerfel>
In-Reply-To: <53C8F050.6060104@samsung.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <6485839.CnzmD0SeQj@wuerfel> <53C8F050.6060104@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Friday 18 July 2014 19:00:48 Chanwoo Choi wrote:
> On 07/18/2014 06:47 PM, Arnd Bergmann wrote:
> > 
> > Further, why is it called "sclk_adc" rather than just "sclk"?
> 
> The sclk means 'special clock' in Exynos TRM. Exynos SoC has varisou sclk clocks.
> 'sclk_adc' is only used for ADC IP.

But that sounds like sclk_adc is the name of the global name
of the clock signal coming out of the clock controller.

I still think it would be best to name it 'sclk' as the input
for the adc. It shouldn't rely on a particular name of the
clock controller.

	Arnd
