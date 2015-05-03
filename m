Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40061 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbbECTUL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2015 15:20:11 -0400
Message-ID: <554674E8.5000708@kernel.org>
Date: Sun, 03 May 2015 20:20:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: jlbec@evilplan.org, lars@metafoo.de, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	octavian.purdila@intel.com, pebolle@tiscali.nl,
	patrick.porlan@intel.com, adriana.reus@intel.com,
	constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: Re: [PATCH v4 0/4] Add initial configfs support for IIO
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com> <553D3DE7.50608@kernel.org>
In-Reply-To: <553D3DE7.50608@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/04/15 20:35, Jonathan Cameron wrote:
> On 20/04/15 15:02, Daniel Baluta wrote:
>> This patchset introduces IIO software triggers, offers a way of configuring
>> them via configfs and adds the IIO hrtimer based interrupt source to be used
>> with software triggers.
>>
>> The arhitecture is now split in 3 parts, to remove all IIO trigger specific
>> parts from IIO configfs core:
>>
>> (1) IIO software triggers - are independent of configfs.
>> (2) IIO configfs - offers a generic way of creating IIO objects. So far we can
>> 	create software triggers.
>> (3) IIO hrtimer trigger - is the first interrupt source for software triggers
>> 	(with syfs to follow). Each trigger type can implement its own set of
>> 	attributes.
>>
>> Changes since v3:
>> 	* addressed comments from Jonathan for previous version
>> 	* https://lkml.org/lkml/2015/4/6/111
> 
> Hi Daniel.
> 
> Thanks for all your hard work on this.  I'm very pleased with the result.
> It's clean, remarkably compact and nice and extensible.
> 
> The only reason I didn't apply it today (other than the odd nit) was because
> it's major new ABI for us so I'd ideally like a few of IIOs main reviewers
> to take a look before we take it.
> 
> Lars, Harmut, Peter, others (our reviewer set is growing very fast!) if you
> guys have time and interest, please take a quick look at this and see if we've
> missed anything.  

Anyone intending to look at this?  I'm inclined to take it as is, but know that
Lars for instance had a particular interest in this support (it was his suggestion
in the first place I think!) so if you want more time to have a look, then
let me know. 

I'm travelling for the next couple of days, so should have plenty of time in airports
to get some reviewing done.
> 
> It's actually remarkably straightforward in the end due to all of Daniel's hard
> work so shouldn't take you long unless you want to dig right down into the configfs
> side of things.  If you do, then the best reference I found (Daniel may have others)
> is the usb-gadget driver.
> 
> Jonathan
>>  
>> Daniel Baluta (4):
>>   iio: core: Introduce IIO software triggers
>>   iio: core: Introduce IIO configfs support
>>   iio: trigger: Introduce IIO hrtimer based trigger
>>   iio: Documentation: Add IIO configfs documentation
>>
>>  Documentation/iio/iio_configfs.txt     |  67 +++++++++++
>>  drivers/iio/Kconfig                    |  16 +++
>>  drivers/iio/Makefile                   |   2 +
>>  drivers/iio/industrialio-configfs.c    | 117 +++++++++++++++++++
>>  drivers/iio/industrialio-sw-trigger.c  | 111 ++++++++++++++++++
>>  drivers/iio/trigger/Kconfig            |   9 ++
>>  drivers/iio/trigger/Makefile           |   2 +
>>  drivers/iio/trigger/iio-trig-hrtimer.c | 201 +++++++++++++++++++++++++++++++++
>>  include/linux/iio/sw_trigger.h         |  50 ++++++++
>>  9 files changed, 575 insertions(+)
>>  create mode 100644 Documentation/iio/iio_configfs.txt
>>  create mode 100644 drivers/iio/industrialio-configfs.c
>>  create mode 100644 drivers/iio/industrialio-sw-trigger.c
>>  create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
>>  create mode 100644 include/linux/iio/sw_trigger.h
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

