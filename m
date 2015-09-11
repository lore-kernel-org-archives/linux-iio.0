Return-Path: <laurentiu.palcu@intel.com>
Date: Fri, 11 Sep 2015 11:57:34 +0300
From: Laurentiu Palcu <laurentiu.palcu@intel.com>
To: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk
Subject: Re: BMA250 support
Message-ID: <20150911085733.GR21512@lpalcu-desk>
References: <55F19B6D.7040205@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F19B6D.7040205@codethink.co.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Violeta,

On Thu, Sep 10, 2015 at 04:02:05PM +0100, Violeta Menendez Gonzalez wrote:
> Hi,
> 
> I've been taking a look at the accelerometer drivers meaning to add some
> features for the chip BMA250.
Just a heads-up, BMA250 is not recommended for new designs:
https://www.bosch-sensortec.com/en/homepage/products_3/3_axis_sensors/acceleration_sensors/acceleration_sensors_1

> 
> I've seen that this chip is supported by the bma180 driver [1], and that
> there's another driver for bmc150 [2] that supports BMA250E. Looking at
> the datasheets [3][4][5] I can't really understand why it is that way,
> as BMA250 and BMA250E register map looks exactly the same except for the
> FIFO memory, and BMA250 doesn't look similar to BMA180 to me.
> 
> After some research on the internet and talking to Ben Dooks (who is
> guiding me through this) we couldn't arrive to a conclusion as to why
> this is this way. Could anyone clarify this a bit more? Could it make
> sense to move support of BMA250 to bmc180 driver?
BMA250 and BMA250E are slightly different, register wise. However, the E
version is completely register compatible with BMC150, except the
resolution. So, adding support to it to existing bmc150_accel driver was
the logical thing to do.

I'm not sure it's worth the trouble to change bmc150_accel driver to
support BMA250 too. I would recommend to add the features you need to
the existing bmc180 driver which already supports it.

But, Peter/Jonathan will most likely show you the right path to follow!
:)

laurentiu
