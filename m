Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57706 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbaH2Ojc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Aug 2014 10:39:32 -0400
Message-ID: <1409323160.2839.8.camel@spandruv-hsb-test>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Elad Alfassa <elad@fedoraproject.org>
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-iio <linux-iio@vger.kernel.org>
Date: Fri, 29 Aug 2014 07:39:20 -0700
In-Reply-To: <CAN0s7yQAP9ZkPd+E3StKutM4YLE-xyOz8QRFBsh=vo3KfHNG6A@mail.gmail.com>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
	 <CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
	 <CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
	 <CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com>
	 <CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
	 <CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com>
	 <CAN0s7yT017sCS9K4q5avRBz5JM+Oj4RM-M8oYVStbWEDx1yWXg@mail.gmail.com>
	 <CA+BWVUSXXhFFTUg_NUu6KochOnpg7LF9L3Q8pZHe4Lt7JJrEXw@mail.gmail.com>
	 <CAN0s7ySG9rbDXZ6XDtQmPWD5QGRdnHf7SwGxjh0er39EZFGO6w@mail.gmail.com>
	 <CA+BWVUTraeqgTJqJndzpY6+_c+600q=MKChtA7OdG3uBG7+f6w@mail.gmail.com>
	 <CAN0s7yQJfekw_iWhS5o6xArY91fwN6=o7mqyanmk_UCQL=y1HQ@mail.gmail.com>
	 <1408985781.21294.149.camel@spandruv-desktop.jf.intel.com>
	 <CAN0s7yQAP9ZkPd+E3StKutM4YLE-xyOz8QRFBsh=vo3KfHNG6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2014-08-25 at 20:04 +0300, Elad Alfassa wrote:
> Hi Srinivas.
> 
> I sent this to Reyad previously:
> Here's the dmeg output: https://elad.fedorapeople.org/iio-debug/dmesg.txt
> and here's the rdesc file: https://elad.fedorapeople.org/iio-debug/rdesc.txt
> 
> It's indeed a usb hub, Bus 002 Device 003: ID 0483:91d1 STMicroelectronics
> 
> So what happens is that when I use iio-sensor-proxy
> (https://github.com/hadess/iio-sensor-proxy) it gets one read and gets
> EAGAIN for all next reads.
> So I kept it running, and while it was running I used cat on the raw
> values, which were read without error. And when I ran the cat I saw
> that iio-sensor-proxy managed to get another read,

I want to make sure that this hub doesn't require some GPIO magic to
wake up. So when you cat raw values, are they sane? Do they change when
you move?

Thanks,
Srinivas

> it happens every time I cat, ie. if I run cat in an endless loop while
> iio-sensor-proxy is running then all the reads it tries to do succeed.
> 
> I'll send you acpidump later.
> 
> On Mon, Aug 25, 2014 at 7:56 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > So I understand you are using buffered mode. When you get this error
> > what happens if you just cat raw values? Do you get the same error?
> >
> > Also kernel debug logs as suggested by Reyad will be helpful to debug.
> > Can you confirm that the sensor hub is an usb hub (with lsusb for
> > vendor/product id) not i2c.
> > Send me also output of acpidump (you can install acpidump in most of the
> > distros)
> >
> > Thanks,
> > Srinivas
> >
> > On Sat, 2014-08-23 at 18:19 +0300, Elad Alfassa wrote:
> >> Hey Reyad.
> >>
> >> I don't see the
> >> hid_sensor_hub:sensor_hub_report_fixup:540: hid-sensor-hub
> >> 0003:0483:91D1.0003: No Enum quirks
> >> line in my dmesg, so the patch did enable the enum quirk.
> >> However, the symptoms are still the same.
> >>
> >> Thanks for your help.
> >>
> >> On Sat, Aug 23, 2014 at 6:14 PM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> >> > Hey Elad,
> >> >
> >> > That is unfortunate that the patch doesn't work. If the patch did
> >> > enable the enum quirk you should no longer see this line in your dmesg
> >> > when hid-sensor-hub module is loaded:
> >> > hid_sensor_hub:sensor_hub_report_fixup:540: hid-sensor-hub
> >> > 0003:0483:91D1.0003: No Enum quirks
> >> >
> >> > I'll CC Srinivas for you to try and get additional help.
> >> >
> >> > Hey Srinivas,
> >> >
> >> > Elad has a hid sensor hub from STM that is failing to produce new
> >> > data, any ideas what might cause this. He is getting a resource
> >> > temporarily unavailable after only one value is read. I had thought it
> >> > might need the quirk to change logical minimum to 1 for the state
> >> > enums but it had no effect. Any other ideas?
> >> >
> >> > On Fri, Aug 22, 2014 at 4:34 PM, Elad Alfassa <elad@fedoraproject.org> wrote:
> >> >> Hey Reyad.
> >> >>
> >> >> Unfortunately, this patch does not fix the issue.
> >> >> The symptoms are exactly like before.
> >> >>
> >> >> Thanks,
> >> >> --
> >> >> -Elad Alfassa.
> >>
> >>
> >>
> >
> >
> 
> 
> 


