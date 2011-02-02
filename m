Return-Path: <greg@kroah.com>
Date: Wed, 2 Feb 2011 12:27:02 -0800
From: Greg KH <greg@kroah.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202202702.GB28479@kroah.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194242.GA27065@kroah.com>
 <544AC56F16B56944AEC3BD4E3D591771324C1659C7@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1659C7@LIMKCMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 02, 2011 at 07:55:23PM +0000, Hennerich, Michael wrote:
> Greg KH wrote on 2011-02-02:
> > On Wed, Feb 02, 2011 at 08:21:08PM +0100, michael.hennerich@analog.com
> > wrote:
> >> From: Michael Hennerich <michael.hennerich@analog.com>
> >>
> >> This patch adds a new trigger that can be invoked by writing the sysfs
> >> file: trigger_now. This approach can be valuable during automated
> >> testing or in situations, where other trigger methods are not
> >> applicable. For example no RTC or spare GPIOs. Last but not least we
> >> can allow user space applications to produce triggers.
> >>
> >> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> >
> > If you add a new sysfs file, you need to document it.  I'll not take
> > this patch as-is because of that.
> 
> Fair enough - I'll resubmit with the file added do the documentation.

What about my other questions?
