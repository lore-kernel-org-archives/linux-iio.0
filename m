Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46643 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbDLPpy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2015 11:45:54 -0400
Message-ID: <552A9330.9070409@kernel.org>
Date: Sun, 12 Apr 2015 16:45:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com>	<5526B398.8050806@kernel.org>	<5526B9AB.4060700@kernel.org>	<5526C112.1090609@kernel.org> <CAEnQRZBdzmn20_hZoM-OF2sbxKD8Ecknh-u=w7JcT_EA0UoRng@mail.gmail.com>
In-Reply-To: <CAEnQRZBdzmn20_hZoM-OF2sbxKD8Ecknh-u=w7JcT_EA0UoRng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/15 14:50, Daniel Baluta wrote:
> On Thu, Apr 9, 2015 at 9:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 09/04/15 18:40, Jonathan Cameron wrote:
>>> On 09/04/15 18:15, Jonathan Cameron wrote:
>>>> On 06/04/15 15:18, Daniel Baluta wrote:
>>>>> This module is the core of IIO configfs. It creates the "iio" subsystem under
>>>>> configfs mount point root, with one default group for "triggers".
>>>>>
>>>>> It offers basic interface for registering software trigger types. Next patches
>>>>> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
>>>>> create a new kernel module which implements iio_configfs_trigger.h interface.
>>>>>
>>>>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>>>>> support for IIO works.
>>>>>
>>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>>> Looks good and is actually a fair bit simpler than I expected which is nice!
>>>> As an ideal aim, I'd like there to be no need for the core to have any
>>>> idea what triggers exist and can be registered (beyond preventing naming
>>>> clashes etc). Actually, not much would be needed to implement that I think, just
>>>> using a list and looking up in it (we aren't on a particularly fast path so
>>>> don't need anything clever) instead of a simple array.  A touch of locking
>>>> probably to avoid two many simultaneous users of that list...
>>>>
>>>> Hmm. having read through the patches, are we fundamentally limited to having to
>>>> specify the entire directory structure before bringing up configfs?
>>> As I read more on this, I think the definition of a 'subsystem' in configfs is
>>> very restricted. It means a tight group of devices sharing a prior
>>> known interface with no ability to add extras later.
> 
> It looked fairly easy for me to add new attributes to an existing
> interface. But this
> is also my first experience with configfs.
> 
>>> It's sort of like the difference between a class and a bus in sysfs (but more limited
>>> actually that's a rubbish analogy).  Thus either we have to do as here
>>> and have the core know all about everything it might want to setup in advance
>>> of registering the iio configfs subsystem or we need to make a whole load of
>>> different configfs subsystems. Basically boils down to one per module.  We lose
>>> the grouping convenience of the current structure but gain in separation.
>>>
>>> So option 1 we have effectively to predefine anything that might turn up
>>> in a module...
>>>
>>> /config/iio/triggers/hrtimer/instance1/..
>>> /config/iio/triggers/sysfs/instance2/..
>>> /config/iio/virtualdevs/hwmon/iiohwmoninstance1/..
>>> /config/iio/virtualdevs/input/iioinputinstance1/..
>>> /config/iio/maps/channelmapisntance1/..
>>> etc (actually fine for the maps as they are coming from the core anyway
>>> and will be known in advance)
> 
> We predefine the files that would appear inside instace1/instance2. But we
> do not predefine the instances. Also, we can easaily add new attributes for
> a given type of trigger type ("hrtimer", "sysfs", etc).
The issue is that what we can get away with not predefining because
we don't want the core to have any idea what a given trigger implementation
is going to want to have in the way of attrs.
> 
> These instances directories would be created with mkdir.
> 
>>>
>>> Option 2 we have complete flexibility as its down to the relevant drivers
>>>
>>> /config/iio-trigger-hrtimer/instance/..
>>> /config/iio-trigger-sysfs/instance/..
>>> /config/iio-virtual-hwmon/instance/..
>>> /config/iio-virtual-input/instance/..
>>>
>>> but we lose the grouping by directory which is a conceptual shame.
>>>
>>> Am I missing something important here?  (pretty new to configfs!)
> 
> Not sure exactly :), also my first experience with configs. But I woul prefer
> option 1.
> 
>>>
>>> Just for others not familiar with IIO who might read this. We have a number
>>> of userspace created elements but each type is provided by a different module,
>>> hence it's a real pain having to have them all defined at configfs subsystem
>>> initialization as it adds tight coupling we don't otherwise have!
>>
>> For reference of others the usb gadget code is a good example of how to handle
>> these sort of cross dependencies..
>>
>> the approach used for function drivers there would give us the cleaner option of
>>
>> /config/iio/triggers/hrtimer-instance1
>> /config/iio/triggers/hrtimer-instance2
>> /config/iio/triggers/sysfs-instance1
>> /config/iio/virtualdevs/hwmon-instance1
>> etc
> 
> I will look again at the gadget code, this was also my source of inspiration
> since there are not so many users of configfs.
Quite. Been around a while, but never picked up wide usage...

What I don't think it allows is sub directories of sub directories of a directory that has
not been defined at startup.  There is only one layer of dynamic creation possible.

So we can only do 
/config/iio/triggers/hrtimer/instance1 if we have hrtimer defined in the core.
That's pretty much a non starter and why (I think) the gadget driver uses the
<type>-instance name syntax to avoid the same problem. Otherwise, function/type/instance
would make more sense (to my mind) for them as well.
> 
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

