Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39095 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbbADTU6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 4 Jan 2015 14:20:58 -0500
Date: Sun, 4 Jan 2015 20:20:54 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: inv_mpu6050: Added adapter class
Message-ID: <20150104202054.08b93933@endymion.delvare>
In-Reply-To: <20141231102554.GC1461@katana>
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1418678363-22437-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	<549D5690.1070104@kernel.org>
	<20141231102554.GC1461@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Wolfram,

First of all, happy new year :-)

On Wed, 31 Dec 2014 11:25:54 +0100, Wolfram Sang wrote:
> On Fri, Dec 26, 2014 at 12:37:36PM +0000, Jonathan Cameron wrote:
> > On 15/12/14 21:19, Srinivas Pandruvada wrote:
> > > To use i2c auto detect to work we need to have a non zero class.
> > > The closest class is I2C_CLASS_HWMON, as it defined to be used
> > > with all hw monitoring drivers.
> > > 
> > > Also this class is already used by some iio driver, hid drivers, led
> > > and misc drivers. So this is not new that this is used outside
> > > hwmon drivers.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Been meaning to sort this out for a while.  We really shouldn't be camping
> > on the HWMON class (nor should anyone else).

This is correct, side effects could be quite bad.

> > Wolfram, do you mind new classes being added?
> 
> In general, I wouldn't mind but I wonder if it makes sense here. DDC and
> SPD are very special I2C uses where access should be limited, so a
> seperate class makes sense IMO. HWMON has a specific name, but really
> became "everything what people could hook to their I2C bus" these days.

HWMON is there mainly for historical reasons, which still hold due to
the inability of PC hardware vendors to list which I2C devices are
connected to the SMBus (although this is changing, ACPI could help to
some degree now.)

> So, if anything, we could think about renaming I2C_CLASS_HWMON to
> I2C_CLASS_STANDARD or something (or at least add a comment about that in
> i2c.h)? I'd think IIO devices fall into the default category. Please say
> if you think different. If we'd add the IIO class, most drivers will
> need patches to support IIO devices which would have worked otherwise,
> so this change should be justified.
> 
> @Jean: Do you have anything to add?

I2C_CLASS_STANDARD sounds like a rather bad idea to me. But really I
miss the background for the discussion so it's hard for me to make an
educated comment.

Please keep in mind that I2C_CLASS_* is not about which class I2C
devices (or even device drivers) belong to. It is about which drivers
should actively _probe_ for their devices on which I2C bus segments.
This is, in general, a bad idea and should be avoided as much as
possible, in favor of enumeration. I2C device probing is inefficient,
unreliable and dangerous by nature.

The reason why we still do it for DDC and SPD is because the range of
addresses is very limited, and probing is somewhat part of the
specification. The reason why we do it for HWMON is because enumeration
does not exist at the hardware level on popular platforms. For
everything else we have backed out (analog and digital TV, in
particular.)

So I am wondering, which platforms are using IIO drivers and do not
support device enumeration at the firmware / device tree level?

-- 
Jean Delvare
SUSE L3 Support
