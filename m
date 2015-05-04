Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32135 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbbEDKyK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 May 2015 06:54:10 -0400
Message-ID: <55475052.8040105@intel.com>
Date: Mon, 04 May 2015 13:56:18 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: jlbec@evilplan.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, octavian.purdila@intel.com,
	pebolle@tiscali.nl, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Subject: Re: [PATCH v4 0/4] Add initial configfs support for IIO
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com> <553D3DE7.50608@kernel.org> <554674E8.5000708@kernel.org> <55467581.6090908@metafoo.de>
In-Reply-To: <55467581.6090908@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 05/03/2015 10:22 PM, Lars-Peter Clausen wrote:
> On 05/03/2015 09:20 PM, Jonathan Cameron wrote:
>> On 26/04/15 20:35, Jonathan Cameron wrote:
>>> On 20/04/15 15:02, Daniel Baluta wrote:
>>>> This patchset introduces IIO software triggers, offers a way of
>>>> configuring
>>>> them via configfs and adds the IIO hrtimer based interrupt source to
>>>> be used
>>>> with software triggers.
>>>>
>>>> The arhitecture is now split in 3 parts, to remove all IIO trigger
>>>> specific
>>>> parts from IIO configfs core:
>>>>
>>>> (1) IIO software triggers - are independent of configfs.
>>>> (2) IIO configfs - offers a generic way of creating IIO objects. So
>>>> far we can
>>>>     create software triggers.
>>>> (3) IIO hrtimer trigger - is the first interrupt source for software
>>>> triggers
>>>>     (with syfs to follow). Each trigger type can implement its own
>>>> set of
>>>>     attributes.
>>>>
>>>> Changes since v3:
>>>>     * addressed comments from Jonathan for previous version
>>>>     * https://lkml.org/lkml/2015/4/6/111
>>>
>>> Hi Daniel.
>>>
>>> Thanks for all your hard work on this.  I'm very pleased with the
>>> result.
>>> It's clean, remarkably compact and nice and extensible.
>>>
>>> The only reason I didn't apply it today (other than the odd nit) was
>>> because
>>> it's major new ABI for us so I'd ideally like a few of IIOs main
>>> reviewers
>>> to take a look before we take it.
>>>
>>> Lars, Harmut, Peter, others (our reviewer set is growing very fast!)
>>> if you
>>> guys have time and interest, please take a quick look at this and see
>>> if we've
>>> missed anything.
>>
>> Anyone intending to look at this?  I'm inclined to take it as is, but
>> know that
>> Lars for instance had a particular interest in this support (it was
>> his suggestion
>> in the first place I think!) so if you want more time to have a look,
>> then
>> let me know.
>
> Sorry, I know, I should have long taken a look at it. I'll try to do it
> tomorrow, if you don't hear anything else from me assume I'm ok with it.

I've sent v5 with fixes after Jonathan's last review. Lars please use
this for review :)

http://marc.info/?l=linux-iio&m=143073652331007&w=2

thanks,
Daniel.

