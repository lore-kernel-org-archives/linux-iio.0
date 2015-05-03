Return-Path: <lars@metafoo.de>
Message-ID: <55467581.6090908@metafoo.de>
Date: Sun, 03 May 2015 21:22:41 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Daniel Baluta <daniel.baluta@intel.com>
CC: jlbec@evilplan.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, octavian.purdila@intel.com,
 pebolle@tiscali.nl, patrick.porlan@intel.com, adriana.reus@intel.com,
 constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: Re: [PATCH v4 0/4] Add initial configfs support for IIO
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com> <553D3DE7.50608@kernel.org> <554674E8.5000708@kernel.org>
In-Reply-To: <554674E8.5000708@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/03/2015 09:20 PM, Jonathan Cameron wrote:
> On 26/04/15 20:35, Jonathan Cameron wrote:
>> On 20/04/15 15:02, Daniel Baluta wrote:
>>> This patchset introduces IIO software triggers, offers a way of configuring
>>> them via configfs and adds the IIO hrtimer based interrupt source to be used
>>> with software triggers.
>>>
>>> The arhitecture is now split in 3 parts, to remove all IIO trigger specific
>>> parts from IIO configfs core:
>>>
>>> (1) IIO software triggers - are independent of configfs.
>>> (2) IIO configfs - offers a generic way of creating IIO objects. So far we can
>>> 	create software triggers.
>>> (3) IIO hrtimer trigger - is the first interrupt source for software triggers
>>> 	(with syfs to follow). Each trigger type can implement its own set of
>>> 	attributes.
>>>
>>> Changes since v3:
>>> 	* addressed comments from Jonathan for previous version
>>> 	* https://lkml.org/lkml/2015/4/6/111
>>
>> Hi Daniel.
>>
>> Thanks for all your hard work on this.  I'm very pleased with the result.
>> It's clean, remarkably compact and nice and extensible.
>>
>> The only reason I didn't apply it today (other than the odd nit) was because
>> it's major new ABI for us so I'd ideally like a few of IIOs main reviewers
>> to take a look before we take it.
>>
>> Lars, Harmut, Peter, others (our reviewer set is growing very fast!) if you
>> guys have time and interest, please take a quick look at this and see if we've
>> missed anything.
>
> Anyone intending to look at this?  I'm inclined to take it as is, but know that
> Lars for instance had a particular interest in this support (it was his suggestion
> in the first place I think!) so if you want more time to have a look, then
> let me know.

Sorry, I know, I should have long taken a look at it. I'll try to do it 
tomorrow, if you don't hear anything else from me assume I'm ok with it.
