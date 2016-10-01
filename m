Return-Path: <masneyb@onstation.org>
Date: Sat, 1 Oct 2016 11:30:31 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 5/5] staging: iio: isl29018: check if the chip is in a
 suspended state
Message-ID: <20161001153031.GA16708@basecamp.onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
 <1474935620-13151-5-git-send-email-masneyb@onstation.org>
 <547487cf-87f7-0922-ad30-cf8dff599d71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547487cf-87f7-0922-ad30-cf8dff599d71@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Oct 01, 2016 at 02:59:49PM +0100, Jonathan Cameron wrote:
> On 27/09/16 01:20, Brian Masney wrote:
> > Add a check to isl29018_write_raw() to ensure that the chip is not in a
> > suspended state. This makes the code consistent with what is present
> > in isl29018_read_raw().
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> Applied to the togreg branch of iio.git.
> 
> Out of curiosity, do you actually have one of these?
> 
> At a quick glance, the only remaining bit keeping this driver
> in staging is the lack of docs on the infrared_supression
> attribute.  If you want to add something on that and a patch
> moving it out of staging that would be great.
> 
> However, note that the graduation patch is usually the one
> that gets the driver thoroughly reviewed by several people so
> more stuff may come out of the woodwork.

I do not have a device with this hardware. I picked a random driver in
the IIO subsystem to cleanup with the goal of getting it closer towards
graduation from staging. I'm planning to move on to another driver in
IIO once I can't get any further without having the hardware on
hand.

I see two other issues that need to be addressed with that driver:

- in_illuminance_scale_available_show() and
  in_illuminance_integration_time_available_show() each return four
  different values in their sysfs attribute. My understanding is that
  only a single value should be in the sysfs attribute. If that is the
  case, then should the attributes be something like:

  in_illuminance_scale_available_16
  in_illuminance_scale_available_12
  in_illuminance_scale_available_8
  in_illuminance_scale_available_4

  in_illuminance_integration_time_available_16
  ...

  I got the numbers from the isl29018_int_time enum. If this is
  acceptable, then I'll submit some patches with these changes.

- checkpatch - need to add device tree documentation

I'll also investigate adding the infrared supression documentation
although I'm not sure how far I'll get on that without having the
hardware available.

Brian
