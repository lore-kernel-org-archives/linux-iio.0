Return-Path: <SRS0=PNad=7D=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1501602838.29303.337.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] iio: tools: move to tools buildsystem
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	eter Meerwald-Stadler
	 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, David Lechner
	 <david@lechnology.com>
Date: Tue, 01 Aug 2017 18:53:58 +0300
In-Reply-To: <20170730172854.57d1bd8b@kernel.org>
References: <20170729003605.73790-1-andriy.shevchenko@linux.intel.com>
	 <20170730172854.57d1bd8b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2017-07-30 at 17:28 +0100, Jonathan Cameron wrote:
> On Sat, 29 Jul 2017 03:36:04 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > There is a nice buildsystem dedicated for userspace tools in Linux
> > kernel tree.
> > Switch iio target to be built by it.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks very nice to me (and very very similar to gpio tools
> which makes checking it is sane easy ;)

Thanks for review!

> Would like this to sit on the list a little while longer
> in case someone with more Make foo than me wanders by
> and spots something.

Of course!


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
