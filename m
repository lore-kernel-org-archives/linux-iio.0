Return-Path: <todd.e.brandt@linux.intel.com>
Date: Mon, 5 Jan 2015 13:09:22 -0800
From: Todd E Brandt <todd.e.brandt@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lee.jones@linaro.org,
	jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/2] axp20x fuel gauge support
Message-ID: <20150105210922.GA6630@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
References: <20141217210732.GA10978@linux.intel.com>
 <54A9750A.2090306@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54A9750A.2090306@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 04, 2015 at 05:14:50PM +0000, Jonathan Cameron wrote:
> On 17/12/14 21:07, Todd E Brandt wrote:
> > Add fuel gauge support to the axp20x driver
> > 
> > axp20x.c (1/2): change the battery cell name to fuel_gauge
> > axp20x.h (2/2): add the register defs and platform struct for fuel gauge
> > 
> >  drivers/mfd/axp20x.c       | 10 +++++-----
> >  include/linux/mfd/axp20x.h | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 46 insertions(+), 7 deletions(-)
> >
> Hi Todd,
> 
> I'm a little confused by this series.  We have an ACPI name change
> (dropping the original - which I'd imagine will causes regressions?)
> Also we have some header elements that look to be getting ready for
> some driver support.  But no driver?

Sorry for the confusion, I do indeed have a fuel gauge driver ready to go
but I thought I'd start by sending out only the changes I need to the base axp20x code.
I'm probing to see if there are any issues or conflicts. I don't think there will
be issues changing the cell name since the only cell device ATM is the ADC, but I could
be wrong.

I'll send out the full patch set with the new AXP288 fuel gauge driver ASAP.

> 
> Jonathan
> 
> 
