Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58133 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaIJNgO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Sep 2014 09:36:14 -0400
Date: Wed, 10 Sep 2014 15:36:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	Yan Burman <burman.yan@gmail.com>,
	Yan Burman <yanb@mellanox.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: st-sensors: add support for lis3lv02d accelerometer
Message-ID: <20140910133607.GA13361@xo-6d-61-c0.localdomain>
References: <1408815064-5763-1-git-send-email-linus.walleij@linaro.org>
 <53FB6205.5020704@kernel.org>
 <CACRpkdb5NXJiTvaHz9_nJiZcFsyVnjPYjaYZ1YH9meBgJhoTJA@mail.gmail.com>
 <54104B26.5080707@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54104B26.5080707@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

> I'm sorry but I was in business trip. I think that current lis3lv02d 
> supports more things, I want to support everything in the current IIO 
> drivers but always I have no time.

Ok then, can you add hwmon interfaces from the other driver to your one? That way,
we can deprecate one of them...

									Pavel

> 
> BR,
> Denis
> 
> 
> On 08/27/14 15:38, Linus Walleij wrote:
> > On Mon, Aug 25, 2014 at 6:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> >> On 23/08/14 18:31, Linus Walleij wrote:
> >>> This adds support for the LIS3LV02 accelerometer found in the
> >>> ST Microelectronics Nomadik board series.
> >>>
> >>> Cc: devicetree@vger.kernel.org
> >>> Cc: Denis CIOCCA <denis.ciocca@st.com>
> >>> Cc: Lee Jones <lee.jones@linaro.org>
> >>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> This is a little 'interesting', given the part is already supported by
> >> drivers/misc/lis3lv02d*.c and already has bindings under there.
> >> Documentation/devicetree/bindings/misc/lis302.txt
> >> (some of these are interesting).
> > Grrr how come I missed this... It was originally merged as a
> > hwmon driver.
> >
> >
> >>> +/* CUSTOM VALUES FOR SENSOR 4 */
> >>>
> >> I wish now we'd nipped this naming convention in the bud and insisted
> >> on naming after a relevant part. Oh well.
> > Well we can always make an invasive patch fixing that. I can
> > probably do it using sed or something.
> >
> >> Do we think this is the right way to handle the alternative support
> >> here?
> > Well this patch is a driver using the IIO framework and was written
> > by ST, but the other driver support a few other interesting features
> > and seems to be for the laptop usecase.
> >
> > Adding the other authors to the TO: line...
> >
> > Yours,
> > Linus Walleij

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
