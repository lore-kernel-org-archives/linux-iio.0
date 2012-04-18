Return-Path: <Robin.Getz@analog.com>
From: "Getz, Robin" <robin.getz@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] staging:iio: trigger: Add hrtimer trigger
Date: Wed, 18 Apr 2012 07:58:34 -0400
CC: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Marten Svanfeldt <marten@intuitiveaerial.com>
References: <1334581381-18161-1-git-send-email-lars@metafoo.de> <4a3800e1-986a-4801-87a4-f0246425c87f@email.android.com> <4F8C4F17.5040101@metafoo.de>
In-Reply-To: <4F8C4F17.5040101@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <201204180758.34751.robin.getz@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon 16 Apr 2012 12:55, Lars-Peter Clausen pondered:
> On 04/16/2012 06:17 PM, Jonathan Cameron wrote:
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >> From: Marten Svanfeldt <marten@intuitiveaerial.com>
> >>
> >> This patch adds a IIO trigger driver which uses a highres timer to
> >> provide a
> >> frequency based trigger.
> >
> > Fine as it stands but same issue arises as we had with userspace trigger
> > still.  What are we doing registering a pure software element not
> > associated to any specific hardware via a platform device.  Why not do it
> > on userspace asking for one as we do with the sysfs file based trigger?
>
> I suppose this is a general question how we want to mange our triggers in
> general. None of the other existing trigger drivers does direct IO access
> and just use existing infrastructure. They could all be easily be
> instantiated by writing a string or number to a sysfs file. So where do we
> draw the line?

Isn't there an issue of accuracy? the timing accuracy of sysfs/userspace is 
non-existant with respect to what you need to do in most of these cases.

-Robin
