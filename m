Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34971 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbJYHIN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 03:08:13 -0400
Received: by lfbn126 with SMTP id n126so84289436lfb.2
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2015 00:08:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445342112.4432.43.camel@hadess.net>
References: <CAF8px55fZoAPCcvGf3G4trdnLBj7vcWLQJ7k=8S5YbuTqtRVLA@mail.gmail.com>
	<20151019223911.GA7159@jelly.redhat.com>
	<1445334820.4432.42.camel@hadess.net>
	<CAF8px56KtXzccgTw1m8opnwn0LVoKgc7cTPA_7q_0Zy-L60CoQ@mail.gmail.com>
	<1445342112.4432.43.camel@hadess.net>
Date: Sun, 25 Oct 2015 02:08:11 -0500
Message-ID: <CAF8px57uErVvHDSrovDGia9=ATQvJ7qPN6PSP+Mm_hmM4CQsDw@mail.gmail.com>
Subject: Re: iio sensors, acceleration and gyro.
From: Mike Mestnik <cheako+wayland-devel@mikemestnik.net>
To: Bastien Nocera <hadess@hadess.net>,
	linux-iio <linux-iio@vger.kernel.org>,
	linux-input@vger.kernel.org,
	Peter Hutterer <peter.hutterer@who-t.net>,
	wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--- Top Post ---
I've done some more research into this and I feel that the iio project
has the answer, the kernel api.  Looks like the developers of iio had
already considered input events being generated from iio data, this
includes both rotation(6 possible states and reasons other than an
~0,0 pivot) and mouse like movement.  Thus I feel that
devices/input/iio-sensors should replace a userspace process like
iio-sensor-proxy for all the reasons I've previously stated.  For the
mpu6050 this would mean at least two more event devices, when
activated ideally the iio interface would "dry up" to avoid
contention.

As stated I feel that the current detection for rotation leaves a lot
to be desired when compared to how an android opperates, but even they
didn't get it right.  The pice of the puzzel lacking is the pivot
point of the rotation, if it's about 0,0 then the screen should flip.
However if the distance from 0,0 of the pivot point is the distance to
a persons hind end then the user is simply lying down and the head to
screen orientation does not change, thus rotating the screen is in
error.  There are other notable non 0,0 pivot points and in these
cases it's also likely that rotating the screen would be incorrect.

I'm off to work another project, but if i find the time this is high
on my todo list.

Cheers.

On Tue, Oct 20, 2015 at 6:55 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2015-10-20 at 06:52 -0500, Mike Mestnik wrote:
>>
>> On Oct 20, 2015 4:53 AM, "Bastien Nocera" <hadess@hadess.net> wrote:
>> >
>> > On Tue, 2015-10-20 at 08:39 +1000, Peter Hutterer wrote:
>> > > On Mon, Oct 19, 2015 at 12:20:27PM -0500, Mike Mestnik wrote:
>> > > > Hello,
>> > > >   I've been working on a project called iio-sensor-proxy, it's
>> a
>> > > > project to take sensor readings and make them available over
>> > > > dbus.  I
>> > > > feel that this takes away from the generic concept that
>> everything
>> > > > is
>> > > > a file.
>> > > >
>> > > > Does this code perhaps have a better home in libinput?
>> > > >
>> > > > https://github.com/hadess/iio-sensor-proxy
>> > >
>> > > I don't think so. iio-sensor-proxy is not at the same level as
>> > > libinput, and
>> > > the dbus API is there for a reason. in theory, a libinput-based
>> > > solution
>> > > would be for libinput to read the sensors and have iio-sensor-
>> proxy
>> > > wrap
>> > > libinput to provide the dbus API that applications require.
>> > >
>> > > That wouldn't add anything to the current solution though, it'd
>> be
>> > > mostly
>> > > code churn for little benefit. so unless Bastian requests that we
>> add
>> > > this
>> > > to libinput, I don't think this is worth pursuing.
>> >
>> > It's at the wrong level (it needs to be system unique, as IIO
>> doesn't
>> > support concurrent uses), and having a single daemon allows us to
>> share
>> > code to support the other sensor types.
>> It should be far more beneficial to add support to iio, then it is to
>> write a single purpose daemon that fails to fix the cause while
>> addressing only the symptoms.
>
> Be my guest. The ABI of the IIO subsystem in the Linux kernel won't be
> changed.
