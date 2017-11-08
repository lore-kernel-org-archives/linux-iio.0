Return-Path: <SRS0=29Xp=CG=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1510174330.25007.117.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] iio: proximity: sx9500: Set IRQ pin to
 direction-input if necessary
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg
	 <mika.westerberg@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron
 <jic23@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Wed, 08 Nov 2017 22:52:10 +0200
In-Reply-To: <CACRpkdZkopuQ2KwNxQyj-KfDawjrhgFVt_2L0-EjJMrMHCXdDw@mail.gmail.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
	 <20171103130340.42459-3-andriy.shevchenko@linux.intel.com>
	 <20171104032059.0000049a@huawei.com>
	 <1510158946.25007.112.camel@linux.intel.com>
	 <20171108170357.GN18997@lahna.fi.intel.com>
	 <CACRpkdZkopuQ2KwNxQyj-KfDawjrhgFVt_2L0-EjJMrMHCXdDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2017-11-08 at 21:45 +0100, Linus Walleij wrote:
> On Wed, Nov 8, 2017 at 6:03 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Nov 08, 2017 at 06:35:46PM +0200, Andy Shevchenko wrote:

> This looks like an elegant solution to me.
> 
> Can it be done?

I'm on it, though it will require some refactoring and clean ups.
(Business as usual, as I can say)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
