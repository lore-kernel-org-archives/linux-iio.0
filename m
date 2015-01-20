Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47472 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbATBeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jan 2015 20:34:10 -0500
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 0/4] iio: mxs-lradc: fix interactions between the touchscreen and the ADC
Date: Tue, 20 Jan 2015 02:32:04 +0100
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>, devel@driverdev.osuosl.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Juergen Beisert <jbe@pengutronix.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <496109820.289562.1421580077115.JavaMail.open-xchange@oxbaltgw03.schlund.de> <54BD6977.4050906@gmail.com>
In-Reply-To: <54BD6977.4050906@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501200232.05084.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday, January 19, 2015 at 09:30:47 PM, Kristina Martšenko wrote:
> On 18/01/15 13:21, Stefan Wahren wrote:
> > Hi Kristina,
> 
> Hi Stefan!

Hi all,

[...]

> > i have a iMX233-Olinuxino-MAXI, but no touchscreen. If it does make sense
> > to you, could you please send me testing instructions and i'll give it a
> > try?
> 
> Thanks a lot for offering! Unfortunately in this case all testing
> involves using the touchscreen while reading other ADC channels, so
> without a touchscreen there isn't much to test, sorry :(

Well it's a resistive touchscreen, when push comes to shove, Stefan can always 
use a couple of variable resistors to simulate it (haha) :)

Best regards,
Marek Vasut
