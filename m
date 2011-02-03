Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:55446 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046Ab1BCKF7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Feb 2011 05:05:59 -0500
Message-ID: <4D4A7FD5.7020804@cam.ac.uk>
Date: Thu, 03 Feb 2011 10:13:41 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
References: <1296653448-10841-1-git-send-email-michael.hennerich@analog.com> <4D49A0F4.5040408@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324C1659B8@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1659B8@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/11 19:21, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-02-02:
>> On 02/02/11 13:30, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> This patch adds a new trigger that can be invoked by writing the sysfs
>>> file: trigger_now. This approach can be valuable during automated
>>> testing or in situations, where other trigger methods are not
>>> applicable. For example no RTC or spare GPIOs. Last but not least we
>>> can allow user space applications to produce
>> triggers.
>> Excellent.  Very handy for testing as you say.
>>
>> If we really want to commonly use this from userspace we will want a
>> means of registering more than one such trigger but this does fine for
>> test rigs. To do multiple triggers with this we could either just take
>> a module parameter or have a 'request_trigger' attribute under some
>> parent device.
>> Still that's a question for another day.  The current functionality is
>> enough to be getting on with.
> 
> Well - you can register as many triggers as you want.
> This is what platform_device.id is for.
Good point. I was clearly half asleep last night!

Thanks for the clarification.

Jonathan
> 
> See example below -
> 
> static struct platform_device iio_sysfs_trigger = {
>         .name           = "iio_sysfs_trigger",
>         .id             = 0,
>         .dev = {
>                 .platform_data = NULL,
>         },
> };
> 
> static struct platform_device iio_sysfs_trigger1 = {
>         .name           = "iio_sysfs_trigger",
>         .id             = 1,
>         .dev = {
>                 .platform_data = NULL,
>         },
> };
> 
> 
>         &bfin_dpmc,
> 
> static struct platform_device *my_devices[] __initdata = {
> 
> #if defined(CONFIG_IIO_SYSFS_TRIGGER) || defined(CONFIG_IIO_SYSFS_TRIGGER _MODULE)
>         &iio_sysfs_trigger,
>         &iio_sysfs_trigger1,
> #endif
> }
> 
> In the driver use:
> 
>> +     trig->name = kasprintf(GFP_KERNEL, "sysfstrig%d", pdev->id);
> 
> What the gpio trigger driver does is not necessary
> - it only replicates functionality already provided by the platform device bus.
> 
> -Michael
> 
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 

