Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH 2/2] staging:iio: Allow to build SoC specific drivers when COMPILE_TEST is set
Date: Mon, 7 Oct 2013 16:35:49 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 Stefan Roese <sr@denx.de>,
 Roland Stigge <stigge@antcom.de>
References: <1381152374-16567-1-git-send-email-lars@metafoo.de> <1381152374-16567-2-git-send-email-lars@metafoo.de> <5252B6BB.8020902@metafoo.de>
In-Reply-To: <5252B6BB.8020902@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310071635.49502.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter Clausen,

> On 10/07/2013 03:26 PM, Lars-Peter Clausen wrote:
> > None of the SPEAr, LPC32XX or MXS ADC drivers have a compile time
> > dependency on their respective platform. So make it possible to build
> > the drivers when CONFIG_COMPILE_TEST is set. This makes it easier to
> > compile test changes.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Stefan Roese <sr@denx.de>
> > Cc: Marek Vasut <marex@denx.de
> 
> Missing > here, added Marek to Cc manually

Thanks. Makes sense to me

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
