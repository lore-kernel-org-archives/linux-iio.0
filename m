Return-Path: <GGao@invensense.com>
From: Ge Gao <GGao@invensense.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: unreliable time function inside IRQ?
Date: Mon, 31 Mar 2014 21:25:09 +0000
Message-ID: <E7747D604FBC9F43A71AA431AFF4476225780C4E@IUSEXCH01.invcorp.invensense.com>
References: <E7747D604FBC9F43A71AA431AFF447622577643E@IUSEXCH01.invcorp.invensense.com>
 <5336A913.1040908@kernel.org>
 <E7747D604FBC9F43A71AA431AFF4476225780BE2@IUSEXCH01.invcorp.invensense.com>
 <5339BCDC.80609@metafoo.de>
In-Reply-To: <5339BCDC.80609@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

If there is other IRQ running causing this, the IRQ time would be late. How=
ever, this is not the case. I can see the time stamp value is smaller than =
it should be, while I observe from scope that IRQ comes in at a steady rate=
.
Thanks.

Ge


-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]=20
Sent: Monday, March 31, 2014 12:07 PM
To: Ge Gao
Cc: Jonathan Cameron; linux-iio@vger.kernel.org
Subject: Re: unreliable time function inside IRQ?

On 03/31/2014 07:44 PM, Ge Gao wrote:
> Dear Jonathan,
> 	Thanks for answering my question. I am using Panda board(OMAP4430). It i=
s using a 32K counter clock as the high resolution clock(arch/arm/plat-omap=
/couter_32k.c). But I also observe the same thing in Nexus 7 first generati=
on(announced in 2012), which uses Nvidia Tegra 3 platform. I suspect the da=
ta that represents the time is cached, or it is using some older value in t=
he interrupt case.
> It could be the Linux's time function problem. Is that possible? I actual=
ly tried using Jiffy, which is the built-in software clock. The time betwee=
n each interrupt also varies big. My HZ setting is 1000. I also tried a lat=
er version of Linux, which is 3.7 or later. The result is the same.
> 	The implementation of the time function is very simple. Below is the fun=
ction from 32K clock counter. It is reading the hardware clock, compute the=
 difference between a static variable and update the time. For a different =
clock, only the "clocksource_32k.mult", "clocksource_32k.shift", would be d=
ifferent.
> 	Thanks.

You have to consider that there will be other things running with IRQs off,=
=20
which will cause some jitter for your IRQ handler. This is nothing IIO spec=
ific.

- Lars
