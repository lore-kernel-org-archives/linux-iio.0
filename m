Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: jic23@kernel.org, ch.naveen@samsung.com, kgene.kim@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, kyungmin.park@samsung.com, t.figa@samsung.com, linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCHv6 3/4] iio: devicetree: Add DT binding documentation for Exynos3250 ADC
Date: Fri, 18 Jul 2014 11:50:23 +0200
Message-ID: <6104032.PNRl85V92G@wuerfel>
In-Reply-To: <1405663186-26464-4-git-send-email-cw00.choi@samsung.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <1405663186-26464-4-git-send-email-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Friday 18 July 2014 14:59:45 Chanwoo Choi wrote:
>                         Must be "samsung,exynos-adc-v2" for
>                                 future controllers.

It would be good to change 'future controllers' to something else now.
Presumably that word was used before the actual products were announced,
but now they are publically known.

> +                       Must be "samsung,exynos3250-adc-v2" for
> +                               controllers compatible with ADC of Exynos3250.

Doesn't this version have a specific name as well? The ADC block
seems to use version numbers, so better put those in here to avoid
confusion when another Exynos7890 comes out that uses the same
ADC as exynos3250.

	Arnd
