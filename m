Return-Path: <jkosina@suse.cz>
Date: Thu, 14 Jun 2012 15:25:51 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/8] HID-Sensor: v2
In-Reply-To: <4FD9E33E.8070000@cam.ac.uk>
Message-ID: <alpine.LNX.2.00.1206141516350.8644@pobox.suse.cz>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com> <alpine.LNX.2.00.1206141507000.8644@pobox.suse.cz> <4FD9E33E.8070000@cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 14 Jun 2012, Jonathan Cameron wrote:

> > As this is however a staging driver (and depends on IIO, which is a
> > staging infrastructure), I suggest you resend the patch to staging
> > maintainers so that it gets applied and we can work on polishing the
> > driver there.
> 
> > Also, what are the plans regarding moving IIO out of staging, please?
> The core is out of staging as of the current cycle.  

Ah, you are right, I missed that this has already happened.

> Drivers are moving out whenever someone has time to take a look at each 
> one and clean up any loose ends.  A couple went with the last merge 
> window, lots more a queued up for the next one.
> 
> Generally any new drivers shouldn't go into staging but directly
> into drivers/iio.

For hid sensors I'd probably prefer drivers/hid though.

> Sorry for my lack of responses on this revised version, been a busy
> week and it's a fairly big review to do.

Thanks,

-- 
Jiri Kosina
SUSE Labs
