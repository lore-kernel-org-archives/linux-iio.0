Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 12 Nov 2012 10:16:46 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL V2] IIO fixes for v3.7-rc1 set 2 (tiny fixes and
 regressions only)
Message-ID: <20121112181646.GA2920@kroah.com>
References: <50969678.6020700@kernel.org>
 <20121112023031.GB17405@kroah.com>
 <50A0BB98.2020802@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50A0BB98.2020802@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 12, 2012 at 09:04:24AM +0000, Jonathan Cameron wrote:
> On 12/11/12 02:30, Greg KH wrote:
> >On Sun, Nov 04, 2012 at 04:23:20PM +0000, Jonathan Cameron wrote:
> >>Axel Lin (2):
> >>       iio: hid-sensor: Use __devexit annotation for remove()
> >
> >This one, while maybe nice, sure isn't necessary as CONFIG_HOTPLUG can't
> >be turned off anymore.  So it's not needed for 3.7, right?
> >
> Sorry that patch title doesn't mention why this is done. I should have
> cleaned it up before merging (or poked Axel to do so)
> 
> Right now they are completely incorrectly marked as __devinit rather
> than __devexit.
> 
> Hence if any platform is being clever about ditching init.text after
> module insertion it's not going to be there on removal.

No platform that I know of does this.  And also, __devexit is defined
away as nothing as well due to CONFIG_HOTPLUG always being set.

> If this was simply a case of adding __devexit I'd agree.
> 
> If this annotation still doesn't actually matter I've definitely missed
> something.

It doesn't matter anymore :)

So could we hold off on this one until 3.8?

thanks,

greg k-h
