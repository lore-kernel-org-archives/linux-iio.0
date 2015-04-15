Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <552A9570.1020800@kernel.org>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com>
	<5526B398.8050806@kernel.org>
	<CAEnQRZBUZSRekmcNtJhWfEUzbZiNVQB6Pxn=67TCoJkU_5DySg@mail.gmail.com>
	<552A9570.1020800@kernel.org>
Date: Wed, 15 Apr 2015 18:17:33 +0300
Message-ID: <CAEnQRZBzOgnUf1oxF70TTwF-1WKOFpuKo=0zEprVeDMBdc-PAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Paul Bolle <pebolle@tiscali.nl>,
	patrick.porlan@intel.com, adriana.reus@intel.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 12, 2015 at 6:55 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/04/15 12:08, Daniel Baluta wrote:
>> On Thu, Apr 9, 2015 at 8:15 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 06/04/15 15:18, Daniel Baluta wrote:
>>>> This module is the core of IIO configfs. It creates the "iio" subsystem under
>>>> configfs mount point root, with one default group for "triggers".
>>>>
>>>> It offers basic interface for registering software trigger types. Next patches
>>>> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
>>>> create a new kernel module which implements iio_configfs_trigger.h interface.
>>>>
>>>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>>>> support for IIO works.
>>>>
>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>> Looks good and is actually a fair bit simpler than I expected which is nice!
>>> As an ideal aim, I'd like there to be no need for the core to have any
>>> idea what triggers exist and can be registered (beyond preventing naming
>>> clashes etc). Actually, not much would be needed to implement that I think, just
>>> using a list and looking up in it (we aren't on a particularly fast path so
>>> don't need anything clever) instead of a simple array.  A touch of locking
>>> probably to avoid two many simultaneous users of that list...
>>
>> Good point. Will do.
>>
>> I will create a list holding the list with the registered trigger types using
>> the trigger type name as the searching key (e.g. : "hrtimer", "sysfs").
>>
>>>
>>> Hmm. having read through the patches, are we fundamentally limited to having to
>>> specify the entire directory structure before bringing up configfs?
>>
>> AFAIK, directories can be created in two ways:
>>
>> *  as default groups registered at iio trigger configfs init time.
>> *  when userspace applications call mkdir.
>>
>> So, unless we agree that userspace applications should be aware of IIO
>> trigger types and manually call mkdir /config/iio/triggers/hrtimer (for example)
>> we are limited to specifying the entire directory structure in the IIO
>> configs module.
> That's my understanding as well and the reason the usb gadget stuff
> uses <type>-instancename instead of type/instancename
>
> At the moment I think we will need to go the same way.
> Of course from the point of view of what userspace needs to know
> it's actually the same as
>
> mkdir hrtimer
> cd hrtime
> mkdir instancename
> though so perhaps we should just do that.

Ok, I see your point here. I will try to send a new version with this in mind.
