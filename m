Return-Path: <jkosina@suse.cz>
Date: Wed, 5 Sep 2012 11:41:03 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/9] HID-Sensor v8
In-Reply-To: <20120904212101.GA2463@kroah.com>
Message-ID: <alpine.LNX.2.00.1209051140250.11079@pobox.suse.cz>
References: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com> <503D1D4F.2030805@kernel.org> <20120904212101.GA2463@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Tue, 4 Sep 2012, Greg KH wrote:

> > I am pretty happy with the whole series now, so next question from
> > my end is what route this takes into the kernel?
> > 
> > Patch 1 should go through the IIO tree (as it touches
> > a fairly high churn area of the IIO core).
> > 
> > 2-4 are very much in HID...
> > 5-9 very much IIO.
> > 
> > My personal preference is to take the lot though the IIO tree
> > but then I know we have a few patches in the pipeline that will
> > touch this driver after it merges (internal api changes) and have
> > no idea what is going on from the HID side so naturally I full on
> > the side of least work for me :)
> > 
> > Jiri what are you thoughts on this series?
> > 
> > CC'd Greg given he's the one who will get the fishy pull request
> > from me if it goes though IIO...
> 
> If Jiri says it is ok, that's fine with me, whatever works easier for
> you two.

I just sent some feedback to Srinivas. After that is handled, I am OK with 
adding my signoff to the patches creating the HID infrastructure and 
having it pushed through Greg.

Thanks,

-- 
Jiri Kosina
SUSE Labs
