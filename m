Return-Path: <SRS0=29Xp=CG=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1510159119.25007.116.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: magnetometer: ak8975: Remove wrong ACPI ID
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan
 Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Hartmut Knaack
 <knaack.h@gmx.de>,  Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Wed, 08 Nov 2017 18:38:39 +0200
In-Reply-To: <1509933795.27882.0.camel@linux.intel.com>
References: <20171103175640.33403-1-andriy.shevchenko@linux.intel.com>
	 <1509732504.10233.205.camel@linux.intel.com>
	 <1509732895.10233.209.camel@linux.intel.com>
	 <1509734767.7135.67.camel@linux.intel.com>
	 <1509885742.10233.229.camel@linux.intel.com>
	 <1509933795.27882.0.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2017-11-05 at 18:03 -0800, Srinivas Pandruvada wrote:
> On Sun, 2017-11-05 at 14:42 +0200, Andy Shevchenko wrote:
> > On Fri, 2017-11-03 at 11:46 -0700, Srinivas Pandruvada wrote:

> > > The AK8963 is using INVN6500. The reason is that this INVN 6500
> > > has
> > > another master mode where a secondary sensor can be connected to
> > > it
> > > as
> > > an i2c slave.
> > > So Windows config uses this mode and hence added in the same
> > > package.
> > > 
> > > But Linux INVN driver is not capable of this master mode. We use
> > > something called "bypass" mode. In this the second sensor will
> > > also
> > > be
> > > directly connected to host i2c. We have another driver handling
> > > this
> > > sensor (ak8975), so we have to add this id.
> > 
> > But ak8975 is enumerated. See above log. So, I think the INVN6500 ID
> > in
> > ak 8975 driver is simple not required.
> 
> This is not true in all platforms. So this is required.

Thanks for clarification. though it would be interesting to test a
behaviour w/o this patch on platform I have and the one that has wrong
data under CNF0 resources.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
