Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 30 Nov 2013 09:07:32 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jkosina@suse.cz, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensors: Fix power and report state
Message-ID: <20131130170732.GA16738@kroah.com>
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1385590783-27604-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <5299CBD0.4030403@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5299CBD0.4030403@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 30, 2013 at 11:28:16AM +0000, Jonathan Cameron wrote:
> On 11/27/13 22:19, Srinivas Pandruvada wrote:
> > In the original HID sensor hub firmwares all Named array enums were
> > to 0-based. But the most recent hub implemented as 1-based,
> > because of the implementation by one of the major OS vendor.
> > Using logical minimum for the field as the base of enum. So we add
> > logical minimum to the selector values before setting those fields.
> > Some sensor hub FWs already changed logical minimum from 0 to 1
> > to reflect this and hope every other vendor will follow.
> > There is no easy way to add a common HID quirk for NAry elements,
> > even if the standard specifies these field as NAry, the collection
> > used to describe selectors is still just "logical".
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Looks like a good solution to me.
> 
> This one is a little interesting.  Technically I 'believe' we don't have
> a bug as it is possible to make these devices work via the kconfig option
> and it definitely isn't a regression.  As such I have applied this to the
> branch intended for the next kernel cycled (togreg) rather than to the
> fixes branch.
> 
> If people have a very strong feeling about this then shout reasonably quickly - I'll
> probably hold off sending that branch to Greg for a few days anyway.
> 
> I've cc'd GregKH to see if he has any input on the path this should take.

Making things "dynamic" and not depending on a random Kconfig option
(which one should a distro pick?) is a -fix in my mind...

thanks,

greg k-h
