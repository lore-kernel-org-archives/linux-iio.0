Return-Path: <greg@kroah.com>
Date: Fri, 4 Feb 2011 06:55:55 -0800
From: Greg KH <greg@kroah.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110204145555.GA11581@kroah.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194242.GA27065@kroah.com>
 <544AC56F16B56944AEC3BD4E3D591771324C1659DD@LIMKCMBX1.ad.analog.com>
 <20110202205807.GB29053@kroah.com>
 <544AC56F16B56944AEC3BD4E3D591771324C165AEC@LIMKCMBX1.ad.analog.com>
 <20110203171334.GA11204@kroah.com>
 <544AC56F16B56944AEC3BD4E3D591771324C1BA310@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1BA310@LIMKCMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 04, 2011 at 08:38:16AM +0000, Hennerich, Michael wrote:
> Greg KH wrote on 2011-02-03:
> > On Thu, Feb 03, 2011 at 09:58:33AM +0000, Hennerich, Michael wrote:
> >> Greg KH wrote on 2011-02-02:
> >>> On Wed, Feb 02, 2011 at 08:36:27PM +0000, Hennerich, Michael wrote:
> >>>> Greg KH wrote on 2011-02-02:
> >>>>> On Wed, Feb 02, 2011 at 08:21:08PM +0100,
> >>>>> michael.hennerich@analog.com
> >>>>> wrote:
> >>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
> >>>>>>
> >>>>>> This patch adds a new trigger that can be invoked by writing the
> >>>>>> sysfs file: trigger_now. This approach can be valuable during
> >>>>>> automated testing or in situations, where other trigger methods are
> >>>>>> not applicable. For example no RTC or spare GPIOs. Last but not
> >>>>>> least we can allow user space applications to produce triggers.
> >>>>>>
> >>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >>>>>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> >>>>>
> >>>>> If you add a new sysfs file, you need to document it.  I'll not
> >>>>> take this patch as-is because of that.
> >>>>>
> >>>>>> ---
> >>>>>>  drivers/staging/iio/trigger/Kconfig          |    6 ++
> >>>>>>  drivers/staging/iio/trigger/Makefile         |    1 +
> >>>>>>  drivers/staging/iio/trigger/iio-trig-sysfs.c |  108
> >>>>>> ++++++++++++++++++++++++++ 3 files changed, 115 insertions(+),
> >>>>>> ++++++++++++++++++++++++++ 0
> >>>>>>  deletions(-)  create mode
> >>>>>> 100644 drivers/staging/iio/trigger/iio-trig-sysfs.c
> >>>>>>
> >>>>>> diff --git a/drivers/staging/iio/trigger/Kconfig
> >>>>>> b/drivers/staging/iio/trigger/Kconfig
> >>>>>> index d842a58..c185e47 100644
> >>>>>> --- a/drivers/staging/iio/trigger/Kconfig
> >>>>>> +++ b/drivers/staging/iio/trigger/Kconfig
> >>>>>> @@ -18,4 +18,10 @@ config IIO_GPIO_TRIGGER
> >>>>>>      help
> >>>>>>        Provides support for using GPIO pins as IIO triggers.
> >>>>>> +config IIO_SYSFS_TRIGGER
> >>>>>> +    tristate "SYSFS trigger"
> >>>>>> +    depends on SYSFS
> >>>>>> +    help
> >>>>>> +      Provides support for using SYSFS entry as IIO triggers.
> >>>>>
> >>>>> Why would you ever want to not have this enabled?  Why is it a
> >>>>> config option?  And shouldn't it depend on the IIO subsystem?
> >>>>
> >>>> You won't see this if you don't have IIO + triggers enabled.
> >>>
> >>> Ok, the dependancy on IIO comes from other parts of the Kconfig
> >>> file, my mistake.
> >>>
> >>>> Are you asking me to add more help text here - or you didn't read the
> >>>> commit log? Alternatively are you asking why IIO common trigger core
> >>>> doesn't provide this flexibility?
> >>>>
> >>>> Sorry - please explain.
> >>>
> >>> My question is, why is this a config option at all?  Why would it
> >>> not always be enabled?  What benefit is it if it is not enabled?
> >>
> >> It's a config option, since the user must provide a platform
> >> resource for it.
> >
> > What platform resource?
> 
> Resource is probably a bit misleading -
> But your platform/board dependant init code must register a struct platform_device
> using platform_add_device() and friends. If it does it multiple times, with different ids.
> multiple triggers are created.

That's fine, but it's not what you are doing here, right?

> >> If you're not planning to use it, why compile and include it at all?
> >
> > If you are a distro, how are you supposed to know if this is something
> > you want or not?
> 
> It's likely something that you don't want.

Then say so in the help section of the Kconfig file.

And also consider not including the file at all, if it's not something
you really want :)

> > If this is going to be the proper API for interacting with iio
> > devices, then it needs to always be present in the core, otherwise
> > your userspace tools are going to get messy, right?
> 
> Consider it as something like all the other iio drivers.
> The user has the option to enable the drivers that are required for its
> application. The hardware interacting with these drivers need to be present,
> and the user has to provide information on how these are physically connected.

No, the "other" drivers get loaded on demand if the hardware is present
or not, which is a big difference, right?

> If you don't enable a IIO input driver that supports triggered sampling support.
> You won't need any trigger driver. If you enable multiple of such drivers.
> You may want to trigger a few with GPIO some others with RTC and maybe one with this
> sysfs based trigger.

And how does a user know to do one vs. the other?

> Userspace tools to date, search the sysfs bus iio device hierarchy and query for names.

Where are these tools?

> >> In embedded systems, people try to minimize kernel or rootfs size.
> >
> > Sure, and how much size does this code really take?
> >
> >> And last but not least kernel startup time.
> >
> > How much extra time does this module take at startup time that you
> > have measured?
> >
> > I've spent weeks working on boot speedup times for products, and a
> > tiny module like this, built into the kernel, would have no measurable
> > affect on boot time that I can see.  What am I missing?
> 
> Ok - I see this argument doesn't count.

So, you tried to make an argument saying something you haven't measured
or tested?

{sigh}

Why do I waste my time...

bah,

greg k-h
