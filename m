Return-Path: <SRS0=PNad=7D=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1501602676.29303.335.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-ads7951: Allow to use on ACPI
 platforms
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <david@lechnology.com>, Jonathan Cameron
 <jic23@kernel.org>,  linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Tue, 01 Aug 2017 18:51:16 +0300
In-Reply-To: <9e1b33ff-565c-5a6a-bd42-0bf34c1bf7c7@lechnology.com>
References: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
	 <9e1b33ff-565c-5a6a-bd42-0bf34c1bf7c7@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2017-07-28 at 15:55 -0500, David Lechner wrote:
> On 07/26/2017 10:59 AM, Andy Shevchenko wrote:
> > ACPI enabled platforms do not have a mean of regulators. Instead we
> > use
> > hard coded voltage value for reference pin. When value is 0
> > (default) we
> > fall back to request a regulator.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I can't test the ACPI stuff, but I made sure this doesn't break me.
> 
> Tested-By: David Lechner <david@lechnology.com>

Thanks for testing, though I see you noticed v2 of the series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
