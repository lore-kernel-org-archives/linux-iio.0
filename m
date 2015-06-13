Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42201 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbFMTLw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 15:11:52 -0400
Date: Sat, 13 Jun 2015 21:11:40 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, kernel@pengutronix.de,
	Alexandre Courbot <gnurou@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: stk3310: use flags argument of devm_gpiod_get
Message-ID: <20150613191140.GX18985@pengutronix.de>
References: <1434095506-1581-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <557C7125.3010606@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <557C7125.3010606@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

On Sat, Jun 13, 2015 at 07:06:29PM +0100, Jonathan Cameron wrote:
> On 12/06/15 08:51, Uwe Kleine-König wrote:
> > Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> > which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> > parameter that allows to specify direction and initial value for output.
> > 
> > Simplify driver accordingly. Furthermore this is one caller less that
> > stops us making the flags argument to gpiod_get*() mandatory.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> > Hello,
> > 
> > this patch applies to next and is only necessary on top of 3dd477acbdd1
> > (iio: light: Add threshold interrupt support for STK3310) which
> > currently sits in next.
> > 
> > Note I plan to make the flags parameter mandatory for 4.3. So unless
> > this change gets into 4.2, would it be ok to let it go in via the gpio
> > tree?
> yes, that's fine.
that means you won't take it for 4.2, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
