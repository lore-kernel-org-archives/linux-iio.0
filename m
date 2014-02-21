Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:46451
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750852AbaBUGVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2014 01:21:32 -0500
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Date: Fri, 21 Feb 2014 06:06:28 +0000
Message-ID: <83f633db31fb4591a9e7b0ffddc179b0@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-2-git-send-email-B38611@freescale.com>
 <20140216074850.GA2946@S2101-09.ap.freescale.net>
 <20140219050716.GA3010@S2101-09.ap.freescale.net>
 <da1f0ce0784e434d8a384aa34e271a18@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140221053834.GT3010@S2101-09.ap.freescale.net>
In-Reply-To: <20140221053834.GT3010@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>
Data: Friday, February 21, 2014 1:39 PM + 0800

>To: Duan Fugang-B38611
>Cc: jic23@kernel.org; sachin.kamat@linaro.org; pmeerw@pmeerw.net;
>lars@metafoo.de; mark.rutland@arm.com; linux-iio@vger.kernel.org; Rob Herring;
>Grant Likely; Pawel Moll; Ian Campbell; Kumar Gala; devicetree@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org
>Subject: Re: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
>
>On Fri, Feb 21, 2014 at 05:17:20AM +0000, fugang.duan@freescale.com wrote:
>> So, you apply the original patch ? Do I need to resend it again ?
>
>You still need to rebase it against my for-next branch to resolve my comment on
>pinctrl setting.
>
>Shawn

I send the patch to you after moving pinctrl setting to board dts.

Thanks,
Andy
