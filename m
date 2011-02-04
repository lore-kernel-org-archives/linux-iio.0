Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41003 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab1BDP1W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Feb 2011 10:27:22 -0500
Message-ID: <4D4C1AD9.3030608@cam.ac.uk>
Date: Fri, 04 Feb 2011 15:27:21 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com> <20110202194242.GA27065@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C1659DD@LIMKCMBX1.ad.analog.com> <20110202205807.GB29053@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C165AEC@LIMKCMBX1.ad.analog.com> <20110203171334.GA11204@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C1BA310@LIMKCMBX1.ad.analog.com> <20110204145555.GA11581@kroah.com>
In-Reply-To: <20110204145555.GA11581@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

On 02/04/11 14:55, Greg KH wrote:
> On Fri, Feb 04, 2011 at 08:38:16AM +0000, Hennerich, Michael wrote:
>> Greg KH wrote on 2011-02-03:
>>> On Thu, Feb 03, 2011 at 09:58:33AM +0000, Hennerich, Michael wrote:
>>>> Greg KH wrote on 2011-02-02:
>>>>> On Wed, Feb 02, 2011 at 08:36:27PM +0000, Hennerich, Michael wrote:
>>>>>> Greg KH wrote on 2011-02-02:
>>>>>>> On Wed, Feb 02, 2011 at 08:21:08PM +0100,
>>>>>>> michael.hennerich@analog.com
>>>>>>> wrote:
>>>>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>>
>>>>>>>> This patch adds a new trigger that can be invoked by writing the
>>>>>>>> sysfs file: trigger_now. This approach can be valuable during
>>>>>>>> automated testing or in situations, where other trigger methods are
>>>>>>>> not applicable. For example no RTC or spare GPIOs. Last but not
>>>>>>>> least we can allow user space applications to produce triggers.
>>>>>>>>
>>>>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>>>>>
>>>>>>> If you add a new sysfs file, you need to document it.  I'll not
>>>>>>> take this patch as-is because of that.
>>>>>>>
>>>>>>>> ---
>>>>>>>>  drivers/staging/iio/trigger/Kconfig          |    6 ++
>>>>>>>>  drivers/staging/iio/trigger/Makefile         |    1 +
>>>>>>>>  drivers/staging/iio/trigger/iio-trig-sysfs.c |  108
>>>>>>>> ++++++++++++++++++++++++++ 3 files changed, 115 insertions(+),
>>>>>>>> ++++++++++++++++++++++++++ 0
>>>>>>>>  deletions(-)  create mode
>>>>>>>> 100644 drivers/staging/iio/trigger/iio-trig-sysfs.c
>>>>>>>>
>>>>>>>> diff --git a/drivers/staging/iio/trigger/Kconfig
>>>>>>>> b/drivers/staging/iio/trigger/Kconfig
>>>>>>>> index d842a58..c185e47 100644
>>>>>>>> --- a/drivers/staging/iio/trigger/Kconfig
>>>>>>>> +++ b/drivers/staging/iio/trigger/Kconfig
>>>>>>>> @@ -18,4 +18,10 @@ config IIO_GPIO_TRIGGER
>>>>>>>>      help
>>>>>>>>        Provides support for using GPIO pins as IIO triggers.
>>>>>>>> +config IIO_SYSFS_TRIGGER
>>>>>>>> +    tristate "SYSFS trigger"
>>>>>>>> +    depends on SYSFS
>>>>>>>> +    help
>>>>>>>> +      Provides support for using SYSFS entry as IIO triggers.
>>>>>>>
>>>>>>> Why would you ever want to not have this enabled?  Why is it a
>>>>>>> config option?  And shouldn't it depend on the IIO subsystem?
>>>>>>
>>>>>> You won't see this if you don't have IIO + triggers enabled.
>>>>>
>>>>> Ok, the dependancy on IIO comes from other parts of the Kconfig
>>>>> file, my mistake.
>>>>>
>>>>>> Are you asking me to add more help text here - or you didn't read the
>>>>>> commit log? Alternatively are you asking why IIO common trigger core
>>>>>> doesn't provide this flexibility?
>>>>>>
>>>>>> Sorry - please explain.
>>>>>
>>>>> My question is, why is this a config option at all?  Why would it
>>>>> not always be enabled?  What benefit is it if it is not enabled?
>>>>
>>>> It's a config option, since the user must provide a platform
>>>> resource for it.
>>>
>>> What platform resource?
>>
>> Resource is probably a bit misleading -
>> But your platform/board dependant init code must register a struct platform_device
>> using platform_add_device() and friends. If it does it multiple times, with different ids.
>> multiple triggers are created.
> 
> That's fine, but it's not what you are doing here, right?
Over to Michael for that one, but I think that is exactly what he is doing.
> 
>>>> If you're not planning to use it, why compile and include it at all?
>>>
>>> If you are a distro, how are you supposed to know if this is something
>>> you want or not?
>>
>> It's likely something that you don't want.
> 
> Then say so in the help section of the Kconfig file.
> 
> And also consider not including the file at all, if it's not something
> you really want :)
I think moving to a dynamic creation approach as per my other email makes
this discussion moot.  That way we build it into the core (optional for
anyone bothered about code bloat) and userspace apps can
create them only when needed.  That way the 'right' option is 
for them to always be enabled by default. There just wont be any
such triggers created until someone asks for one.
> 
>>> If this is going to be the proper API for interacting with iio
>>> devices, then it needs to always be present in the core, otherwise
>>> your userspace tools are going to get messy, right?
>>
>> Consider it as something like all the other iio drivers.
>> The user has the option to enable the drivers that are required for its
>> application. The hardware interacting with these drivers need to be present,
>> and the user has to provide information on how these are physically connected.
> 
> No, the "other" drivers get loaded on demand if the hardware is present
> or not, which is a big difference, right?
> 
>> If you don't enable a IIO input driver that supports triggered sampling support.
>> You won't need any trigger driver. If you enable multiple of such drivers.
>> You may want to trigger a few with GPIO some others with RTC and maybe one with this
>> sysfs based trigger.
> 
> And how does a user know to do one vs. the other?
Depends entirely on what they are trying to do with the sensor in question. The main
use case for a lot of these sensor (well my main use anyway ;))
is on generic sensor board where people wire them up to all sorts of strange rigs
to grab data with all sorts of inter channel sampling setups.

If a given sensor has it's own internal clock and data ready signal it will have the
default trigger set to point at the one it provides.  The user is welcome to change
this in most cases (some hardware has periods in which you really don't want to attempt
to read from it so this isn't always possible).  Note other sensors can also use this trigger
(e.g. grab a voltage as close as possible to the timing of a an accelerometer sampling).

The gpio case actually exists to sync capture against systems over which we have no
control whatsoever (in our case, motion capture rigs).  The RTC one is a legacy of
an old case of mine and I'm inclined to drop it when we have something equivalent to inputs
polled reading in place.

So the upshot is:  If the user doesn't know what they want, then the default configuration
should be right, but if they need to change the trigger then the functionality is there.

This userspace trigger has been on the todo list for a long time, but until now none of
us writing drivers have actually needed it so it hadn't happened.  It's also needed for
the input bridge code to handle polled devices (not yet done).  Note the input bridge
version will need to do dynamic creation of these triggers, but I can add that when I
need it.
> 
>> Userspace tools to date, search the sysfs bus iio device hierarchy and query for names.
> 
> Where are these tools?
> 
Example code in iio/Documentation does this.

Bus browsing tools (lsusb equivalent) at http://sourceforge.net/projects/iioutils/
(might be lagging kernel tree somewhat).

Jonathan
