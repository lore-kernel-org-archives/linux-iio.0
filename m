Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 4 May 2016 10:24:43 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <cdleonard@gmail.com>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Michael Welling <mwelling@ieee.org>, mranostay@gmail.com,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org
Subject: Re: Regression in inv_mpu6050: 4.6.0-rc5
Message-ID: <20160504172443.GA27422@kroah.com>
References: <20160426232651.099a18d7@lxorguk.ukuu.org.uk>
 <20160426230755.GA6235@deathstar>
 <20160427165613.4d464792@lxorguk.ukuu.org.uk>
 <e65623b5-44bc-b329-b718-c00aaa0b4805@kernel.org>
 <5728F3CD.3000801@gmail.com>
 <0fd48340-63b7-253e-352c-4f98cf6e19b2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0fd48340-63b7-253e-352c-4f98cf6e19b2@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 04, 2016 at 08:49:06AM +0100, Jonathan Cameron wrote:
> On 03/05/16 19:54, Crestez Dan Leonard wrote:
> > On 05/01/2016 10:58 PM, Jonathan Cameron wrote:
> >> On 27/04/16 16:56, One Thousand Gnomes wrote:
> >>> On Tue, 26 Apr 2016 18:07:55 -0500
> >>> Michael Welling <mwelling@ieee.org> wrote:
> >>>
> >>>> On Tue, Apr 26, 2016 at 11:26:51PM +0100, One Thousand Gnomes wrote:
> >>>>>
> >>>>> This now causes us to crash and burn on the ASUS T100TA Baytrail/T
> >>>>> platforms
> >>>>>  
> >>>>
> >>>> I believe this regression has already been patched.
> >>>>
> >>>> Check the latest commits in linux-next.
> >>>>
> >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> >>>>
> >>>> See if the latest patches fix your issue.
> >>>
> >>> It does - as this is a regression can we please get those fixes into the
> >>> next -rc ?
> >>>
> >> I'm afraid I'm lost in this one - which patch caused the regression and
> >> which one fixed it?  The only patches I can immediately see in next
> >> both introduce and then squish a similar bug, but neither of them
> >> has hit Linus' tree yet.
> >>
> >> Or are we dealing with what was fixed in:
> >> c816d9e7 iio: imu: mpu6050: fix possible NULL dereferences
> >> I had understood that one as more hypothetical than real...
> >>
> >> Unfortunately I'm travelling and I suspect that means this will only get
> >> in just after the release (so for 4.6.1) once I've confirmed which fixes
> >> we actually need to backport.
> >>
> > Commit
> >     c816d9e7: iio: imu: mpu6050: fix possible NULL dereferences
> > Fixes:
> >     33da559f: iio: imu: mpu6050: add mpu6500 register settings
> > 
> > As far as I can tell this crash will always happen when the device is
> > probed via ACPI.
> 
> Hi Greg,
> 
> A quick heads up.
> 
> Unfortunately this regression has come up whilst I'm travelling and
> don't have appropriate signing keys with me to do a pull request.
> Should be able to do one tomorrow evening as I'll back home.
> 
> Turns out the 'possible' is quite common and causing a mess.
> Even better the fix actually has a fix as well... 
> 
> Fastest option is probably a cherry pick of:
> 
> c816d9e7: iio: imu: mpu6050: fix possible NULL dereferences
> 718ba46e: iio: imu: mpu6050: Fix name/chip_id when using ACPI

>From where?

> 
> I'll send you a pull request of my 
> togreg-in-a-hurry branch tomorrow.
> 
> Sorry for these being so late in the cycle.
> 
> Anyhow, run for train time. 

You can always just send me patches, no need for it to always be a pull
request if you can't do that for some reason.

thanks,

greg k-h
