Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, jic23@kernel.org, ch.naveen@samsung.com, mark.rutland@arm.com, devicetree@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org, t.figa@samsung.com, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org
Subject: Re: [PATCHv7 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and code clean
Date: Mon, 21 Jul 2014 09:38:55 +0200
Message-ID: <14522743.f6oFhEQVv4@wuerfel>
In-Reply-To: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
References: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Monday 21 July 2014 11:17:44 Chanwoo Choi wrote:
> 
> This patchset support Exynos3250 ADC (Analog Digital Converter) because
> Exynos3250 has additional special clock for ADC IP.
> 
> Changes from v6:
> - Use "exynos3250-adc" compatible string instead of "exynos3250-adc-v2"
> - Use "sclk" clock name instead of "sclk_adc"
> - Remove un-necessary macro for exyno-adc-data-v2 structure.
> - Remove '(void *)' cast and mark the exynos-adc-data structure as 'const'
> - Change the number of ADC channels (Exynos3250 has only two channels for ADC)
> 

Looks good to me. Two small requests:

a) if you don't mind, can you add my patch (1/2) to add support for s3c64xx to
   your series, adding your Signed-off-by line in addition to mine? I think
   that one was noncontroversial, while the second patch (2/2) need some more
   work to address the comments and do testing.

b) For the "compatible" string, I think it makes sense to set a fallback to
   "samsung,exynos-adc-v2" in the case for exynos3250, making the DT
   representation

	compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2";

   It's not entirely compatible because of the addition of the clock, but
   since the register layout is the same, I think it still make sense.

Thanks.

For the entire series,

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
