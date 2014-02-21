Return-Path: <shawn.guo@linaro.org>
Date: Fri, 21 Feb 2014 13:38:36 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
CC: "jic23@kernel.org" <jic23@kernel.org>, "sachin.kamat@linaro.org"
	<sachin.kamat@linaro.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"lars@metafoo.de" <lars@metafoo.de>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely
	<grant.likely@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Message-ID: <20140221053834.GT3010@S2101-09.ap.freescale.net>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-2-git-send-email-B38611@freescale.com>
 <20140216074850.GA2946@S2101-09.ap.freescale.net>
 <20140219050716.GA3010@S2101-09.ap.freescale.net>
 <da1f0ce0784e434d8a384aa34e271a18@BLUPR03MB373.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <da1f0ce0784e434d8a384aa34e271a18@BLUPR03MB373.namprd03.prod.outlook.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 21, 2014 at 05:17:20AM +0000, fugang.duan@freescale.com wrote:
> So, you apply the original patch ? Do I need to resend it again ?

You still need to rebase it against my for-next branch to resolve my
comment on pinctrl setting.

Shawn
