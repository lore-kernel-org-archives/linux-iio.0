Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:50986 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbIOKQh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2015 06:16:37 -0400
Message-ID: <55F7F000.5080104@codethink.co.uk>
Date: Tue, 15 Sep 2015 11:16:32 +0100
From: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
MIME-Version: 1.0
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
CC: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk
Subject: Re: BMA250 support
References: <55F19B6D.7040205@codethink.co.uk> <20150911085733.GR21512@lpalcu-desk>
In-Reply-To: <20150911085733.GR21512@lpalcu-desk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Laurentiu,

Thank you for replying.

On 11/09/15 09:57, Laurentiu Palcu wrote:
> Hi Violeta,
> 
> On Thu, Sep 10, 2015 at 04:02:05PM +0100, Violeta Menendez Gonzalez wrote:
>> Hi,
>>
>> I've been taking a look at the accelerometer drivers meaning to add some
>> features for the chip BMA250.
> Just a heads-up, BMA250 is not recommended for new designs:
> https://www.bosch-sensortec.com/en/homepage/products_3/3_axis_sensors/acceleration_sensors/acceleration_sensors_1
> 

Yes, I'm aware, thank you. Not trying to do new designs, just porting
some features from an out-of-tree driver.

>>
>> I've seen that this chip is supported by the bma180 driver [1], and that
>> there's another driver for bmc150 [2] that supports BMA250E. Looking at
>> the datasheets [3][4][5] I can't really understand why it is that way,
>> as BMA250 and BMA250E register map looks exactly the same except for the
>> FIFO memory, and BMA250 doesn't look similar to BMA180 to me.
>>
>> After some research on the internet and talking to Ben Dooks (who is
>> guiding me through this) we couldn't arrive to a conclusion as to why
>> this is this way. Could anyone clarify this a bit more? Could it make
>> sense to move support of BMA250 to bmc180 driver?
> BMA250 and BMA250E are slightly different, register wise. However, the E
> version is completely register compatible with BMC150, except the
> resolution. So, adding support to it to existing bmc150_accel driver was
> the logical thing to do.
> 

Yes, I agree with that. All the chips in the bmc150_accel driver are
very similar. But my idea was that the BMA250 is also very similar
(register compatible) to them (except FIFO), so I wonder why the support
for the BMA250 was added to bmc180 instead of adding it directly to the
bmc150_accel driver.

> I'm not sure it's worth the trouble to change bmc150_accel driver to
> support BMA250 too. I would recommend to add the features you need to
> the existing bmc180 driver which already supports it.
> 

I thought it would be easier for me to add features to a driver where
the chips are more homogeneous. BMA250 and BMC180 don't look very
register compatible to me, so I thought it may be worth just making the
effort of changing the support first and then trying to add the features.

I'm pretty inexperienced on this, that's why I'm asking for opinion on
it, I may be missing something.

Talking to Ben Dooks he agreed with me, and suggested that it may be
worth adding support for the BMA250 to bmc150_accel for now and then
later on removing it from bma180. I may have misinterpreted something,
but unfortunately he's on holidays now. He may be able to give some
insight on this next week.

> But, Peter/Jonathan will most likely show you the right path to follow!
> :)
> 
> laurentiu
> 

Thank you :-)

-- 
Violeta Menéndez González    http://www.codethink.co.uk/
Software Engineer            Codethink - Providing Genius
