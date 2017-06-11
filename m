Return-Path: <SRS0=o5fX=5Q=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1497209974.22624.118.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: accel: mma9551: use NULL for GPIO connection ID
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron
	 <jic23@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Hartmut Knaack
 <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Sun, 11 Jun 2017 22:39:34 +0300
In-Reply-To: <CACRpkdZDpxos8XnishRiS2hE7YvXUNvppVwx=PnRKcmDieAZMA@mail.gmail.com>
References: <20170610185841.49911-1-andriy.shevchenko@linux.intel.com>
	 <20170611114610.62fac902@kernel.org>
	 <1497191154.22624.107.camel@linux.intel.com>
	 <20170611160802.788b098c@kernel.org>
	 <CACRpkdZDpxos8XnishRiS2hE7YvXUNvppVwx=PnRKcmDieAZMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2017-06-11 at 19:45 +0200, Linus Walleij wrote:
> On Sun, Jun 11, 2017 at 5:08 PM, Jonathan Cameron <jic23@kernel.org>
> wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > I think the best is to read a documentation portion patch from
> > > here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.
> > > git/co
> > > mmit/?h=for-next&id=ed7fcf1ed5ea4ea01243995ae085757a77cf0f3e
> > 
> > Cool. I think I follow what is going on now.
> > 
> > We don't need the string and it just makes life nasty for ACPI. Fair
> > enough.  Applied to the togreg branch of iio.git with that link
> > added
> > and pushed out as testing for the autobuilders to play with it.
> > 
> > Still time if Linus want's to add anything.
> 
> It's fine. I have a very high level of trust about Andy's patches and
> I
> know he's always doing his best to make ACPI play well with GPIO.
> AFICT this is the best thing to do, but honestly, I see Andy and
> Mika Westerberg as the true GPIO-ACPI maintainers.
> 

By the way, we may add ourselves (still need Mika's Ack on this) to a
separate record in MAINTEINERS. It might make your burden less heavy.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
