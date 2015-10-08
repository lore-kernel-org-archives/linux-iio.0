Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:35655 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbbJHVMH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Oct 2015 17:12:07 -0400
From: Marek Vasut <marex@denx.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] iio: mxs-lradc: Fix temperature offset
Date: Thu, 8 Oct 2015 23:12:13 +0200
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>,
	Jonathan Cameron <jic23@kernel.org>
References: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com> <20151007004447.GC3485@piout.net> <5614C5F8.5020000@i2se.com>
In-Reply-To: <5614C5F8.5020000@i2se.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201510082312.13495.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday, October 07, 2015 at 09:12:56 AM, Stefan Wahren wrote:
> Am 07.10.2015 um 02:44 schrieb Alexandre Belloni:
> > Hi,
> > 
> > On 07/10/2015 at 01:19:09 +0200, Marek Vasut wrote :
> >>>> /* The calculated value from the ADC is in Kelvin, we
> >>>> * want Celsius for hwmon so the offset is
> >>>> - * -272.15 * scale
> >>>> + * -273.15 * scale
> >>>> */
> >>>> - *val = -1075;
> >>>> - *val2 = 691699;
> >>>> + *val = -1079;
> >>>> + *val2 = 644268;
> >>> 
> >>> i think it would be nice to break down the calculation of these magic
> >>> values in a second patch.
> >> 
> >> Indeed, I agree. I hope Alexandre can send another patch for that soon
> >> :-)
> > 
> > On my side, I'm not sure this is worth more than a comment. If
> > necessary, I can write that the datasheet specifies that the scale is
> > 4/1.012 here also.
> 
> I'm okay with that.

I'm fine either way, it's not worth wasting more time on this trivial stuff.
I'd say just pick this one.

Best regards,
Marek Vasut
