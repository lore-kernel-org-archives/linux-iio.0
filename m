Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4C56AD80.6050403@cam.ac.uk>
References: <4C56AD80.6050403@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Aug 2010 12:04:13 +0800
Message-ID: <AANLkTik9tF-89fVZEA_dFO31=yC72qYs=e9jyyE6tnFB@mail.gmail.com>
Subject: Re: IIO merge plans for 2.6.36
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 2, 2010 at 7:35 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>
> Hi All,
>
> It is a bit late for this, but I was wondering if anyone had any drivers
> queued up for merge in the window that just opened? =C2=A0I know there ar=
e
> quite a few in the Blackfin tree, but no idea where you guys are on testi=
ng
> etc... =C2=A0As ever I'm happy to assist with bringing them up to date ag=
ainst
> our current tree, but mostly don't have test hardware.
I think one of our customers has used ADE7758 driver, report one bug
and prove it can work in the customer's application field. Then it was
tested now.
We have merged this fix to our trunk head.
You may refer to:
http://blackfin.uclinux.org/gf/forummessage/91823

>
> Personally my only patches not in Greg's tree are adding event support
> to the adis16350 driver. =C2=A0That's not ready and some bits are controv=
ersial
> so I'm quite happy to delay that one for next time round.
>
> Thanks to Barry in particularly for a lot of cleanup work this cycle. =C2=
=A0Sorry
> I stalled the trigger elements of that, but I want to see how things pan =
out
> for a few more fully functional drivers before we dive into that pit of w=
orms!
>
> I think my main focus for the next round will be on cleaning up the event
> handling side of things and perhaps some work on making more of the core
> optional for drivers operating in (or only supporting) only sysfs interfa=
ces.
>
> If things get quiet enough, I'll start taking a look at adding a higher p=
erformance
> buffering solution.
>
> Cheers,
>
> Jonathan
>
