Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60540 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab1BDPoG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Feb 2011 10:44:06 -0500
Message-ID: <4D4C1EC4.4080709@cam.ac.uk>
Date: Fri, 04 Feb 2011 15:44:04 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Greg KH <greg@kroah.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com> <20110202194242.GA27065@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C1659DD@LIMKCMBX1.ad.analog.com> <20110202205807.GB29053@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C165AEC@LIMKCMBX1.ad.analog.com> <20110203171334.GA11204@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C1BA310@LIMKCMBX1.ad.analog.com> <20110204145555.GA11581@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C1BA5BE@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1BA5BE@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/11 15:34, Hennerich, Michael wrote:
> Greg KH wrote on 2011-02-04:
>> On Fri, Feb 04, 2011 at 08:38:16AM +0000, Hennerich, Michael wrote:
>>> Greg KH wrote on 2011-02-03:
>>>> On Thu, Feb 03, 2011 at 09:58:33AM +0000, Hennerich, Michael wrote:
>>>>> Greg KH wrote on 2011-02-02:
>>>>>> On Wed, Feb 02, 2011 at 08:36:27PM +0000, Hennerich, Michael
>> wrote:
>>>>>>> Greg KH wrote on 2011-02-02:
>>>>>>>> On Wed, Feb 02, 2011 at 08:21:08PM +0100,
>>>>>>>> michael.hennerich@analog.com
>>>>>>>> wrote:
>>>>>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>>>
>>>>>>>>> This patch adds a new trigger that can be invoked by writing the
>>>>>>>>> sysfs file: trigger_now. This approach can be valuable during
>>>>>>>>> automated testing or in situations, where other trigger methods
>>>>>>>>> are not applicable. For example no RTC or spare GPIOs. Last but
>>>>>>>>> not least we can allow user space applications to produce
>>>>>>>>> triggers.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>>>>>>
>>>>>>>> If you add a new sysfs file, you need to document it.  I'll
>>>>>>>> not take this patch as-is because of that.
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>  drivers/staging/iio/trigger/Kconfig          |    6 ++
>>>>>>>>>  drivers/staging/iio/trigger/Makefile         |    1 +
>>>>>>>>>  drivers/staging/iio/trigger/iio-trig-sysfs.c |  108
>>>>>>>>> ++++++++++++++++++++++++++ 3 files changed, 115
>>>>>>>>> ++++++++++++++++++++++++++ insertions(+), 0
>>>>>>>>>  deletions(-)  create mode
>>>>>>>>> 100644 drivers/staging/iio/trigger/iio-trig-sysfs.c
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/staging/iio/trigger/Kconfig
>>>>>>>>> b/drivers/staging/iio/trigger/Kconfig
>>>>>>>>> index d842a58..c185e47 100644
>>>>>>>>> --- a/drivers/staging/iio/trigger/Kconfig
>>>>>>>>> +++ b/drivers/staging/iio/trigger/Kconfig
>>>>>>>>> @@ -18,4 +18,10 @@ config IIO_GPIO_TRIGGER
>>>>>>>>>      help
>>>>>>>>>        Provides support for using GPIO pins as IIO triggers.
>>>>>>>>> +config IIO_SYSFS_TRIGGER
>>>>>>>>> +    tristate "SYSFS trigger"
>>>>>>>>> +    depends on SYSFS
>>>>>>>>> +    help
>>>>>>>>> +      Provides support for using SYSFS entry as IIO triggers.
>>>>>>>>
>>>>>>>> Why would you ever want to not have this enabled?  Why is it a
>>>>>>>> config option?  And shouldn't it depend on the IIO subsystem?
>>>>>>>
>>>>>>> You won't see this if you don't have IIO + triggers enabled.
>>>>>>
>>>>>> Ok, the dependancy on IIO comes from other parts of the Kconfig
>>>>>> file, my mistake.
>>>>>>
>>>>>>> Are you asking me to add more help text here - or you didn't read
>>>>>>> the commit log? Alternatively are you asking why IIO common trigger
>>>>>>> core doesn't provide this flexibility?
>>>>>>>
>>>>>>> Sorry - please explain.
>>>>>>
>>>>>> My question is, why is this a config option at all?  Why would
>>>>>> it not always be enabled?  What benefit is it if it is not enabled?
>>>>>
>>>>> It's a config option, since the user must provide a platform
>>>>> resource for it.
>>>>
>>>> What platform resource?
>>>
>>> Resource is probably a bit misleading - But your platform/board
>>> dependant init code must register a struct platform_device using
>>> platform_add_device() and friends. If it does it multiple times, with
>>> different ids. multiple triggers are created.
>>
>> That's fine, but it's not what you are doing here, right?
> 
> That's what I'm doing in my board setup code, it's just not part of this patch.
> 
> static struct platform_device iio_sysfs_trigger = {
>         .name           = "iio_sysfs_trigger",
>         .id             = 0,
> };
> 
> static struct platform_device iio_sysfs_trigger1 = {
>         .name           = "iio_sysfs_trigger",
>         .id             = 1,
> };
> 
> static struct platform_device *my_devices[] __initdata = {
> 
> #if defined(CONFIG_IIO_SYSFS_TRIGGER) || defined(CONFIG_IIO_SYSFS_TRIGGER _MODULE)
>         &iio_sysfs_trigger,
>         &iio_sysfs_trigger1,
> #endif
> }
> 
>>>>> If you're not planning to use it, why compile and include it at
>> all?
>>>>
>>>> If you are a distro, how are you supposed to know if this is
>>>> something you want or not?
>>>
>>> It's likely something that you don't want.
>>
>> Then say so in the help section of the Kconfig file.
> 
> ok
> 
>> And also consider not including the file at all, if it's not something
>> you really want :)
> 
> It's useful for everyone doing automated driver tests.
> And this driver is provided in the hope it will be useful for others too.
> 
> Jonathan - can do you think it is useful?
It is. I'll probably try adding dynamic instantiation when I have a chance,
but in the meantime definitely a handy bit of functionality to have.
> 
> 
>>>> If this is going to be the proper API for interacting with iio
>>>> devices, then it needs to always be present in the core, otherwise
>>>> your userspace tools are going to get messy, right?
>>>
>>> Consider it as something like all the other iio drivers.
>>> The user has the option to enable the drivers that are required for
>>> its application. The hardware interacting with these drivers need to
>>> be present, and the user has to provide information on how these are
>> physically connected.
>>
>> No, the "other" drivers get loaded on demand if the hardware is
>> present or not, which is a big difference, right?
> 
> None of the IIO drivers work that way.
> 
> Unlike PCI or USB devices, SPI or I2C devices are not enumerated at the hardware level.
> Instead, the software must know which devices are connected on each SPI bus segment,
> and what slave selects/address these devices are using.
> For this reason, the kernel code must instantiate SPI devices explicitly.
> The most common method is to declare the SPI devices by bus number.
> 
>>> If you don't enable a IIO input driver that supports triggered sampling
>>> support. You won't need any trigger driver. If you enable multiple of
>>> such drivers. You may want to trigger a few with GPIO some others with
>>> RTC and maybe one with this sysfs based trigger.
>>
>> And how does a user know to do one vs. the other?
> 
> It's purely application specific.
> It's like connecting wires on a PCB.
Not quite.  There are generic boards which get used for a number of applications
(take the memsic imote2's or gumstix for example). It's this that would motivate
the addition of on demand registration of these.


<snip>

> Isn't is still an argument that you don't enable kernel options or drivers
> that you don't understand or likely going to use?
Not everyone seems to keep to that or to take a look at whether the
things they build are applicable to any box their distro will actually work on.

Ubuntu 10.10 on one of my x86 boxes (2.6.35) currently has:
iio/accel:
adis16209.ko  adis16220.ko  adis16240.ko  kxsd9.ko  lis3l02dq.ko  sca3000.ko
iio/adc:
max1363.ko
iio/gyro:
adis16260.ko
iio/imu:
adis16300.ko  adis16350.ko  adis16400.ko
iio/light:
tsl2563.ko
iio/trigger:
iio-trig-gpio.ko  iio-trig-periodic-rtc.ko

Looking at it another way... We get a lot of free build testing from the distros ;)

