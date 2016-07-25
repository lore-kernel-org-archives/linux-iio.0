Return-Path: <jdelvare@suse.de>
Date: Mon, 25 Jul 2016 10:42:01 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Frey
 <david.frey@sensirion.com>
Subject: Re: [PATCH] hwmon: sht3x: set initial jiffies to last_update
Message-ID: <20160725104201.3b0430f1@endymion>
In-Reply-To: <CAKzfze8Uc3FGG2+d-H3-=md_J2nwDdG6Tp=5KSTad6Pv+0iXeg@mail.gmail.com>
References: <1467945971-23798-1-git-send-email-mranostay@gmail.com>
	<1467964564.3225.12.camel@chaos.suse>
	<CAKzfze82xFRU6A09rXS3OhtLU99cZt_2waRcFGvTgWbx9huZLA@mail.gmail.com>
	<20160721081046.0f658c18@endymion>
	<CAKzfze8Uc3FGG2+d-H3-=md_J2nwDdG6Tp=5KSTad6Pv+0iXeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hi Matt,

On Sun, 24 Jul 2016 16:50:39 -0700, Matt Ranostay wrote:
> On Wed, Jul 20, 2016 at 11:10 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Fri, 8 Jul 2016 17:22:10 -0700, Matt Ranostay wrote:
> >> On Fri, Jul 8, 2016 at 12:56 AM, Jean Delvare <jdelvare@suse.de> wrote:
> >> > On jeu., 2016-07-07 at 19:46 -0700, Matt Ranostay wrote:
> >> >> Handling the wraparound requires the data->last_update to be set to an
> >> >> initial jiffies value. Otherwise you can start in a state where the
> >> >> sensor will never request a reading.
> >> >
> >> > I can't see how. As I read the code, in the worst case, readings can be
> >> > blocked for interval_ms (2 seconds maximum.)
> >>
> >> On 64-bit systems this is never an issue because the jiffies counter
> >> will never wrap around.
> >>
> >> But my system is a 32-bit ARM core, so the the kernel sets the initial
> >> value to 0xfffb6c20 so it will wrap around in 5 minutes to find buggy
> >> code.
> >>
> >> So looking at time_after(0xfffb6c20, 0) will return false always till
> >> it finally rolls over.
> >
> > I've always been confused by how jiffies wrapping is handled. So I
> > tested it, and you are correct.
> 
> Yeah but of course on 64-bit systems most just use the lower 32-bits
> of the jiffies counter.

Actually it seems the jiffies are initialized the same on 32-bit and
64-bit systems, so on 64-bit systems you'll get 33-bit values after 5
minutes, and 34-bit values after about 100 days (if HZ=1000.) But
you'll never realistically wrap, you are right.

> But since that could rollover, and the unlikely event no sensor data
> was read for ~57 days you could be in the same state that couldn't get
> a data sample ....

At HZ=1000 the jiffies wrap after 49 days, IIRC, not 57. Not that it
matters ;-)

> Not sure if we want to check this edge case.. and also this effects a
> few iio drivers (mostly mine :)) if we really care about this.

All other hwmon drivers have the same problem. I can't think of a cheap
way to solve this problem, nor do I think we need to. If you monitor
your system, you are supposed to poll the device on a regular basis,
not once every 49 days.

-- 
Jean Delvare
SUSE L3 Support
