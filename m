Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:36372 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751079AbeBHKTC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Feb 2018 05:19:02 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4460474F12E6E
        for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2018 18:18:49 +0800 (CST)
Date: Thu, 8 Feb 2018 10:18:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Pavel Roskin <plroskin@gmail.com>
CC: <linux-iio@vger.kernel.org>
Subject: Re: Best practices for sending digital data
Message-ID: <20180208101837.00001c55@huawei.com>
In-Reply-To: <CAN_72e2eEoLKNUqte=xmUCyLj6L+asJVL9k_rqXGJd1ky7v=Cw@mail.gmail.com>
References: <CAN_72e2eEoLKNUqte=xmUCyLj6L+asJVL9k_rqXGJd1ky7v=Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Feb 2018 14:15:30 -0800
Pavel Roskin <plroskin@gmail.com> wrote:

> Hi,
> 
> I'm writing an IIO driver for custom IMU hardware. The most important
> output is analog. However, the hardware also provides very important
> digital data about the status of the measurement.

Whey you say analog, are we talking a digital measurement of the
relevant things or are we talking an actual analog signal measured
by a separate ADC?  If the second then your best bet is to use
the consumer interfaces to provide userspace a representation of the
sensor as a whole with digital data combined with control and any
extra digital signals so that userspace doesn't need to know about
the fact the ADC is elsewhere.

> 
> The register is basically a bitmask. Some of the bits are pertinent to
> the specific measurement. They indicate whether the data is valid and
> whether the measurements are saturated. So it makes sense to put them
> to the same buffer as the analog measurements rather than use
> attributes.
> 

The problem is that no standard userspace will have any idea what to
do with them.  They all need to be described - as you have perhaps
guessed this is hard.

> What would be the recommended channel type? Is that IIO_INDEX or maybe
> IIO_COUNT? Or should I patch the kernel to add IIO_DIGITAL or
> IIO_BITMAP?

Firstly you need something that can be standardised.  IIO_DIGITAL is
effectively useless because it isn't descriptive of what these represent.
It's fine if they really are free form general purpose inputs but here
they aren't.

Normally if your data is invalid then there is no point in passing it
to userspace.  If using sysfs interfaces you simply return an error
reflecting whether it is likely to recover.  If using buffered interfaces
then you don't add it to the buffer and if it represents a hardware fault
you look at out of band RAS type error reporting.
It's not a valid reading so what use is it to put in there.

Saturation is a little harder, but I assume the sensor also returns
maximum value of it's range (in the appropriate direction) when that
happens?  Normal assumption is that if you have max range, then chances
are you are saturated (sure this might loose us one value in the overall
range as you might be just sub saturation)

Or are we dealing with filtering artifacts where we need to
know that it was saturated and hence the non maximal value now visible
may be wrong?

One option is to actually represent these as an out of band event
signal (so basically a threshold) but then you loose the visibility
of exactly which values are effected (assuming a finite impulse response
filter).

So the answer is that it could be represented in band as a new
type, but that type would need VERY careful consideration and a whole
specification to userspace of what exactly is in each bit.
So far, every time we have hit this there have been more obvious ways
to indicate the situation to userspace.

> 
> On a related note, why is IIO so hard to extend with new channel types
> and attributes? Why cannot I add angular acceleration in the driver
> without patching the IIO subsystem? Why cannot I use yaw, pitch and
> roll instead of X, Y and Z as the attributes?

Firstly because they are stupid for all sorts of mathematical reason :)
Ignoring that piece of ancient idiocy (quaternions don't suffer from
these problems and can represent everything nicely)

We will support the the moment a device comes along that outputs them.
Realistically a device doing that is often computing them from X, Y and Z
measurements - perhaps with temporal filtering all done on considerably
worse hardware than the nice floating point unit on the host CPU.
I appreciate this does allow manufacturers to wrap up their secret
sauce in the device and don't really mind that so if we have a device
that exports them then fine we'll support it.

> Why is IIO_MOD_CO2
> defined but IIO_MOD_O2 is not, let alone IIO_MOD_DIMETHYLHYDRAZINE?

When someone submits a driver for any of those we'll add them.
We don't go around guessing what hardware is going to exist and
adding support for it.  Waste of time for everyone.

> 
> I understand that the IIO layer tries to be helpful with
> standardization, but I believe it's too restrictive.
> 

So the question is what is the alternative to adding new channel types
when they are needed?

Either
1) New channel types have to be reviewed to ensure the name etc are
  consistent.  This requires documentation to be updated to cover the new
  interface.  No significant burden to adding a new channel type or modifier.
  This documentation driven method is the approach hwmon has traditionally
  taken. Mostly it works but not always.

2) We add magic 'user defined types'.  The problem then is that
   the primary purpose of not just throwing all the drivers in with
   their own interfaces is gone.  There is no standardization at all and
   every device needs it's own userspace code.

So there are a couple of positive reasons for the formal approach.
1) The maintainability aspect.  It gives direct control of what goes in
   and makes it much harder for people to get it wrong and accidentally
   expose non standard ABI to userspace which we have to maintain for
   ever.  If people are doing out of tree drivers they can do what they
   like but they have to live with the fact that it may break randomly.

2) Those formal types are shared with userspace in places such as the
   event interface.  This is the same reason they are so tight in
   the input subsystem.  We need to have a compact representation
   of which channel and what type it is to allow efficient handling of
   events.  So all those defines correspond to decodeable elements of
   the event messages.

3) We support in kernel access to data - that requires a tight well
   defined interface.  For example, if you are doing the case of
   an analog IMU connected to an ADC we need to be able represent
   the binding of that IMU to whatever ADC is there.  To do that
   we have to have very rigid standardization of the representation.

Anyhow, that's my initial comments on why things should be controlled.

I'd have done things differently in some places if we were starting IIO
again, but this rigidity would still be there.

The discussions around new types / modifiers can often get very
involved and sometimes the answer we end up with bares no resemblance
to where things started.  It may seem tedious, but like all review it
is a useful exercise.

Jonathan

