Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34918 "EHLO
	mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbcHOROn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:14:43 -0400
MIME-Version: 1.0
In-Reply-To: <1471279360.20508.20.camel@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <alpine.LNX.2.00.1608071214500.22028@cbobk.fhfr.pm> <884e74df-569e-8218-fbda-f9c7ecfe1e5a@kernel.org>
 <af2d1c90-a0ec-0888-8048-76463bf98ece@kernel.org> <CAKdAkRS-sVHqQ1tUZWVxNTfX5=ZxFzbCAxvsJPHV4=85mdEeRA@mail.gmail.com>
 <1471279360.20508.20.camel@linux.intel.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 15 Aug 2016 10:14:41 -0700
Message-ID: <CAKdAkRRjh+21qOzq28=vSX59RcZsMOAt3pTUhjw4wXdpXXQg-w@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 15, 2016 at 9:42 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2016-08-15 at 08:45 -0700, Dmitry Torokhov wrote:
>> On Mon, Aug 15, 2016 at 7:52 AM, Jonathan Cameron <jic23@kernel.org>
>> wrote:
>> >
>> > On 15/08/16 15:07, Jonathan Cameron wrote:
>> > >
>> > > On 07/08/16 11:15, Jiri Kosina wrote:
>> > > >
>> > > > On Sun, 7 Aug 2016, Srinivas Pandruvada wrote:
>> > > >
>> > > > >
>> > > > > Some platforms power off sensor hubs during S3 suspend, which
>> > > > > will require
>> > > > > longer time to resume. This hurts system resume time, so
>> > > > > resume
>> > > > > asynchronously.
>> > > > >
>> > > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux
>> > > > > .intel.com>
>> > > > Jonathan, are you going to cherry-pick this patch from the
>> > > > series?
>> > > > Alternatively, if you're okay with it, I can pull it in
>> > > > together with the
>> > > > whole set with your Acked-by or Reviewed-by.
>> > > >
>> > > I'll take it via IIO. Got a bit of catching up to do (been on
>> > > holiday)
>> > Applied to the togreg branch of iio.git - initially pushed out as
>> > testing for the autobuilders to play with it.
>> > This one is not really connected to the others so makes sense to
>> > take it separately.
>> >
>> > I'm out of my depth on the rest of the patches in this series
>> > and don't have time to learn enough to follow them! Sorry I
>> > can't help on that front.
>> About this patch: me sees a new work, me does not see new calls to
>> cancel_work_sync() or flush_work() anywhere, me gets worried.
> This work is scheduled during resume and is not delayed call. Only time
> really we need to cancel or flush if module is unloaded before resume
> work, not sure if this case realistic. Do you see any other case
> possible?

Runtime resume can happen at any time, I can unload module or unbind
it at any time. I also wasn't aware that our implementation goal for
locking rules/lifetime rules/etc was "realistic" instead of "correct".

Thanks.

-- 
Dmitry
