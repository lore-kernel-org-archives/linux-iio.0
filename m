Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <cwchoi00@gmail.com>, jic23@kernel.org, naveen krishna <ch.naveen@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh+dt@kernel.org>, pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, Kumar Gala <galak@codeaurora.org>, rdunlap@infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <t.figa@samsung.com>, linux-iio@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCHv6 3/4] iio: devicetree: Add DT binding documentation for Exynos3250 ADC
Date: Mon, 21 Jul 2014 12:47:01 +0200
Message-ID: <5314104.0WdOMs1CRl@wuerfel>
In-Reply-To: <53CCEDBF.7010300@gmail.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <7477106.gq1AqisQx4@wuerfel> <53CCEDBF.7010300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Monday 21 July 2014 12:38:55 Tomasz Figa wrote:
> 
> I believe we should be enforcing as much correctness on DT data as
> possible without too much burden in the code. Otherwise how we are
> supposed to know if an error is caused by wrong/missing data in DT, bug
> in the driver or who knows else?
> 
> In this case making this clock required depending on compatible string
> doesn't seem too bothersome to me.

It makes some sense given that we already need the separate compatible
string (for the number of channels). Without that part, I'd probably
prefer not having the new string just for the extra clock being required,
that could be handled more easily by just making it an optional clock.

	Arnd
