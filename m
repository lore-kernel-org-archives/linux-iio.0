Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Greg KH <greg@kroah.com>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Thu, 3 Feb 2011 09:58:33 +0000
Subject: RE: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C165AEC@LIMKCMBX1.ad.analog.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194242.GA27065@kroah.com>
 <544AC56F16B56944AEC3BD4E3D591771324C1659DD@LIMKCMBX1.ad.analog.com>
 <20110202205807.GB29053@kroah.com>
In-Reply-To: <20110202205807.GB29053@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Greg KH wrote on 2011-02-02:
> On Wed, Feb 02, 2011 at 08:36:27PM +0000, Hennerich, Michael wrote:
>> Greg KH wrote on 2011-02-02:
>>> On Wed, Feb 02, 2011 at 08:21:08PM +0100,
>>> michael.hennerich@analog.com
>>> wrote:
>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>
>>>> This patch adds a new trigger that can be invoked by writing the
>>>> sysfs
>>>> file: trigger_now. This approach can be valuable during automated
>>>> testing or in situations, where other trigger methods are not
>>>> applicable. For example no RTC or spare GPIOs. Last but not least
>>>> we can allow user space applications to produce triggers.
>>>>
>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>
>>> If you add a new sysfs file, you need to document it.  I'll not take
>>> this patch as-is because of that.
>>>
>>>> ---
>>>>  drivers/staging/iio/trigger/Kconfig          |    6 ++
>>>>  drivers/staging/iio/trigger/Makefile         |    1 +
>>>>  drivers/staging/iio/trigger/iio-trig-sysfs.c |  108
>>>>  ++++++++++++++++++++++++++ 3 files changed, 115 insertions(+), 0
>>>>  deletions(-)  create mode
>>>> 100644 drivers/staging/iio/trigger/iio-trig-sysfs.c
>>>>
>>>> diff --git a/drivers/staging/iio/trigger/Kconfig
>>>> b/drivers/staging/iio/trigger/Kconfig
>>>> index d842a58..c185e47 100644
>>>> --- a/drivers/staging/iio/trigger/Kconfig
>>>> +++ b/drivers/staging/iio/trigger/Kconfig
>>>> @@ -18,4 +18,10 @@ config IIO_GPIO_TRIGGER
>>>>      help
>>>>        Provides support for using GPIO pins as IIO triggers.
>>>> +config IIO_SYSFS_TRIGGER
>>>> +    tristate "SYSFS trigger"
>>>> +    depends on SYSFS
>>>> +    help
>>>> +      Provides support for using SYSFS entry as IIO triggers.
>>>
>>> Why would you ever want to not have this enabled?  Why is it a
>>> config option?  And shouldn't it depend on the IIO subsystem?
>>
>> You won't see this if you don't have IIO + triggers enabled.
>
> Ok, the dependancy on IIO comes from other parts of the Kconfig file,
> my mistake.
>
>> Are you asking me to add more help text here - or you didn't read the
>> commit log? Alternatively are you asking why IIO common trigger core
>> doesn't provide this flexibility?
>>
>> Sorry - please explain.
>
> My question is, why is this a config option at all?  Why would it not
> always be enabled?  What benefit is it if it is not enabled?

It's a config option, since the user must provide a platform resource for
it. If you're not planning to use it, why compile and include it at all?
In embedded systems, people try to minimize kernel or rootfs size.
And last but not least kernel startup time.

>>>> +
>>>>  endif # IIO_TRIGGER
>>>> diff --git a/drivers/staging/iio/trigger/Makefile
>>>> b/drivers/staging/iio/trigger/Makefile
>>>> index 10aeca5..504b9c0 100644
>>>> --- a/drivers/staging/iio/trigger/Makefile
>>>> +++ b/drivers/staging/iio/trigger/Makefile
>>>> @@ -4,3 +4,4 @@
>>>>
>>>>  obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) +=3D iio-trig-periodic-rtc.o
>>>>  obj-$(CONFIG_IIO_GPIO_TRIGGER) +=3D iio-trig-gpio.o
>>>> +obj-$(CONFIG_IIO_SYSFS_TRIGGER) +=3D iio-trig-sysfs.o
>>>> diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c
>>>> b/drivers/staging/iio/trigger/iio-trig-sysfs.c
>>>> new file mode 100644
>>>> index 0000000..3434f3c
>>>> --- /dev/null
>>>> +++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
>>>> @@ -0,0 +1,108 @@
>>>> +/*
>>>> + * Copyright 2011 Analog Devices Inc.
>>>> + *
>>>> + * Licensed under the GPL-2 or later.
>>>
>>> Are you sure you really mean "or later"?  Seriously, do your lawyers
>>> agree that this is what they want to have happen to this file?
>>
>> Why not later?
>
> Do you really mean for this code to be used in GPLv3 and newer
> licensed bodies of work, as well as other types of code bases?
>
> Also, as you have probably based it on gplv2 only code, you might not
> be able to make this type of claim.
>
> My original question remains, is this ok with your company's lawyers
> to have the file licensed in this manner?  If so, that's fine, but I
> need to ask.

Thanks you're right - I don't like the 'or later' anymore.

>>>> + *
>>>> + * iio-trig-sysfs.c
>>>
>>> Don't put the file name in the file itself, that's pointless :)
>>>
>>>> +MODULE_AUTHOR("Michael Hennerich
>>>> +<hennerich@blackfin.uclinux.org>");
>>>> +MODULE_DESCRIPTION("Sysfs based trigger for the iio subsystem");
>>>> +MODULE_LICENSE("GPL v2");
>>>
>>> What is going to cause this module to be loaded in the system?
>>> Are you relying on userspace to load it if it "knows" it is needed?
>>> That's really not nice, we should trigger off of some type of
> hardware.
>>
>> Well again - I don't understand what you mean here - you can load this
>> driver as module or more likely build into the kernel - which both
> works fine.
>
> Sure, but how will a system know to load it automatically, like all
> other modules are?  You should never have to manually load it, that's
> not the way Linux works anymore thanks to udev and friends.

I'll add the MODULE_ALIAS.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
