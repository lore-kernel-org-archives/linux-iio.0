Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:60871 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbbIOQLz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2015 12:11:55 -0400
Message-ID: <1442333505.17316.7.camel@codethink.co.uk>
Subject: Re: [Linux-kernel] BMA250 support
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Cc: Laurentiu Palcu <laurentiu.palcu@intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Date: Tue, 15 Sep 2015 17:11:45 +0100
In-Reply-To: <55F7F000.5080104@codethink.co.uk>
References: <55F19B6D.7040205@codethink.co.uk>
	 <20150911085733.GR21512@lpalcu-desk> <55F7F000.5080104@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2015-09-15 at 11:16 +0100, Violeta Menendez Gonzalez wrote:
> Hi Laurentiu,
> 
> Thank you for replying.
> 
> On 11/09/15 09:57, Laurentiu Palcu wrote:
> > Hi Violeta,
> > 
> > On Thu, Sep 10, 2015 at 04:02:05PM +0100, Violeta Menendez Gonzalez wrote:
> >> Hi,
> >>
> >> I've been taking a look at the accelerometer drivers meaning to add some
> >> features for the chip BMA250.
> > Just a heads-up, BMA250 is not recommended for new designs:
> > https://www.bosch-sensortec.com/en/homepage/products_3/3_axis_sensors/acceleration_sensors/acceleration_sensors_1
> > 
> 
> Yes, I'm aware, thank you. Not trying to do new designs, just porting
> some features from an out-of-tree driver.
> 
> >>
> >> I've seen that this chip is supported by the bma180 driver [1], and that
> >> there's another driver for bmc150 [2] that supports BMA250E. Looking at
> >> the datasheets [3][4][5] I can't really understand why it is that way,
> >> as BMA250 and BMA250E register map looks exactly the same except for the
> >> FIFO memory, and BMA250 doesn't look similar to BMA180 to me.
> >>
> >> After some research on the internet and talking to Ben Dooks (who is
> >> guiding me through this) we couldn't arrive to a conclusion as to why
> >> this is this way. Could anyone clarify this a bit more? Could it make
> >> sense to move support of BMA250 to bmc180 driver?
> > BMA250 and BMA250E are slightly different, register wise. However, the E
> > version is completely register compatible with BMC150, except the
> > resolution. So, adding support to it to existing bmc150_accel driver was
> > the logical thing to do.
> > 
> 
> Yes, I agree with that. All the chips in the bmc150_accel driver are
> very similar. But my idea was that the BMA250 is also very similar
> (register compatible) to them (except FIFO), so I wonder why the support
> for the BMA250 was added to bmc180 instead of adding it directly to the
> bmc150_accel driver.

Both the bmc150_accel driver and the BMA250 support in bma180 were added
in Linux 3.18.  As they seem to have been independently developed around
the same time, neither developer could see that support for the other
version of the chip was going into a different driver.

[...]
> Talking to Ben Dooks he agreed with me, and suggested that it may be
> worth adding support for the BMA250 to bmc150_accel for now and then
> later on removing it from bma180. I may have misinterpreted something,
> but unfortunately he's on holidays now. He may be able to give some
> insight on this next week.

I think you should remove support from bma180 immediately afterward, or
at least make it conditional on !IS_ENABLED(CONFIG_BMC150_ACCEL) so that
the selection of driver for these devices isn't randomised.

Ben.



