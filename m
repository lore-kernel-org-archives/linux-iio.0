Return-Path: <GGao@invensense.com>
From: Ge Gao <GGao@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: unreliable time function inside IRQ?
Date: Mon, 31 Mar 2014 17:44:03 +0000
Message-ID: <E7747D604FBC9F43A71AA431AFF4476225780BE2@IUSEXCH01.invcorp.invensense.com>
References: <E7747D604FBC9F43A71AA431AFF447622577643E@IUSEXCH01.invcorp.invensense.com>
 <5336A913.1040908@kernel.org>
In-Reply-To: <5336A913.1040908@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan,
	Thanks for answering my question. I am using Panda board(OMAP4430). It is =
using a 32K counter clock as the high resolution clock(arch/arm/plat-omap/c=
outer_32k.c). But I also observe the same thing in Nexus 7 first generation=
(announced in 2012), which uses Nvidia Tegra 3 platform. I suspect the data=
 that represents the time is cached, or it is using some older value in the=
 interrupt case.
It could be the Linux's time function problem. Is that possible? I actually=
 tried using Jiffy, which is the built-in software clock. The time between =
each interrupt also varies big. My HZ setting is 1000. I also tried a later=
 version of Linux, which is 3.7 or later. The result is the same.
	The implementation of the time function is very simple. Below is the funct=
ion from 32K clock counter. It is reading the hardware clock, compute the d=
ifference between a static variable and update the time. For a different cl=
ock, only the "clocksource_32k.mult", "clocksource_32k.shift", would be dif=
ferent.
	Thanks.

Best Regards,

Ge GAO

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
static struct timespec persistent_ts;
static cycles_t cycles, last_cycles;
void read_persistent_clock(struct timespec *ts)
{
unsigned long long nsecs;
cycles_t delta;
struct timespec *tsp =3D &persistent_ts;

last_cycles =3D cycles;
cycles =3D clocksource_32k.read(&clocksource_32k);
delta =3D cycles - last_cycles;

nsecs =3D clocksource_cyc2ns(delta,
   clocksource_32k.mult, clocksource_32k.shift);

timespec_add_ns(tsp, nsecs);
*ts =3D *tsp;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]=20
Sent: Saturday, March 29, 2014 4:06 AM
To: Ge Gao; Lars-Peter Clausen
Cc: linux-iio@vger.kernel.org
Subject: Re: unreliable time function inside IRQ?

On 25/03/14 21:56, Ge Gao wrote:
> Dear all, Had to bring this question again to see whether anyone see=20
> the same problem. IIO fetches the timestamp inside IRQ using=20
> iio_get_time_ns(), which in turn call ktime_get_real_ts(&ts).
> However, I notice that the clock taken during interrupt is not always=20
> reliable. Sometimes the clock does not update. It is updated after one=20
> or more interrupts. It is very easy to reproduce. First find a=20
> hardware generating fixed interval of interrupts and using IIO driver=20
> to run it. Print out the timestamp. You could find that the timestamp=20
> distance is not always correct. For example, if you run a 5 Hz=20
> interrupt, most of time you will interrupt timestamp interval is=20
> around 200ms. However, sometimes, you could see interval sequence like=20
> ...200, 192, 208, 200, 200, 182, 218, 200....... I searched online and=20
> only found one result, which is exactly the same as I observed. Below=20
> is the link:
> http://stackoverflow.com/questions/17080516/unable-unreliable-to-use-c
> lock-gettime-in-hard-irq-context
>
>
But no one answer the question.
> 	Is there anyone see the same problem? Thanks.
Hi Ge,

I'm afraid I don't know the cause of this.
It's also entirely possible that other interrupts are occurring that are de=
laying the processing of some of your interrupts.
The slightly interesting bit is that you seem to be getting interrupts appa=
rently early sometimes.  I would have expected a longer delay then a shorte=
r one if it was something else interfering.

It might be related to the implementation of the high resolution timers on =
your platform.  Perhaps they are being updated by a high precision, low fre=
quency source.  Mind you, in that case I think you'd expect to see only one=
 value being out rather than the single early value you appear to be seeing=
 here.  For some reason it seems that occasionally you are handling interru=
pts earlier than the majority of the time... Odd!


What is the platform you are seeing this on?

Jonathan
>
> Best Regards,
>
> Ge GAO
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
