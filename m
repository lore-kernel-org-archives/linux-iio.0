Return-Path: <gregkh@suse.de>
Date: Thu, 28 Oct 2010 18:30:11 -0700
From: Greg KH <gregkh@suse.de>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [Device-drivers-devel] [PATCH 1/3] staging: iio: new adis16201
	driver
Message-ID: <20101029013011.GC9344@suse.de>
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org> <4CC320D2.6030300@cam.ac.uk> <AANLkTim+czzJ__zuMCpjv4nV6rOJ9n50_4MR2VkQk6T_@mail.gmail.com> <4CC413F8.1030908@cam.ac.uk> <AANLkTinbc9-Vibzf1Vy1bZ1WcjerLEtMEfoqCteSfO3G@mail.gmail.com> <4CC479C0.9030607@cam.ac.uk> <AANLkTikuRJWN5OtVK4ysvEpsU6f9gfo6v3O+Zpp81v0D@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikuRJWN5OtVK4ysvEpsU6f9gfo6v3O+Zpp81v0D@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 02:22:11PM -0400, Mike Frysinger wrote:
> On Sun, Oct 24, 2010 at 14:24, Jonathan Cameron wrote:
> > On 10/24/10 16:58, Mike Frysinger wrote:
> >> On Sun, Oct 24, 2010 at 07:09, Jonathan Cameron wrote:
> >>> Unfortunately that isn't where they are going to merge. ??The change
> >>> required won't be huge, but Greg isn't going to take them if they
> >>> don't merge cleanly.
> >>
> >> they merge cleanly, they just dont compile :p. ??what tree exactly
> >> contains these changes you're referring to ?
> >>
> > either linux-next or staging-next branch of
> > http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-next-2.6.git;a=summary
> >
> > The all went in a few weeks back.
> 
> i guess the trouble is that that tree is labeled as "junk tree, please
> ignore".  maybe gregkh can fix the labeling of his trees to reflect
> reality.

Oops, sorry about that, now fixed.

greg k-h
