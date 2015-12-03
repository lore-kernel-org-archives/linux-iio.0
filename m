Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-188.synserver.de ([212.40.185.188]:1225 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752406AbbLCSeU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2015 13:34:20 -0500
Message-ID: <56608B28.1040808@metafoo.de>
Date: Thu, 03 Dec 2015 19:34:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Daniel Baluta <daniel.baluta@intel.com>,
	kbuild test robot <fengguang.wu@intel.com>
CC: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [iio:togreg 11/13] industrialio-sw-trigger.c:undefined reference
 to `iio_configfs_subsys'
References: <201512030723.5UzAF24I%fengguang.wu@intel.com> <43E08F24-AB64-4F2B-B422-3425A2D4D182@jic23.retrosnub.co.uk> <566003F5.5090001@intel.com> <D645C15C-AF9D-47B3-A254-9D6137CCAD69@jic23.retrosnub.co.uk> <566068B7.5090408@intel.com> <56608782.7000205@jic23.retrosnub.co.uk>
In-Reply-To: <56608782.7000205@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/2015 07:18 PM, Jonathan Cameron wrote:
> On 03/12/15 16:07, Daniel Baluta wrote:
>> I see, strange. It shouldn't complain about it, because it is immediately exported.
>>
>> I will have a closer look.
> Indeed, it's clearly BS (serves me right for fly by sparse fixing during
> applying patches:).  Looking at the moment like a bug in Sparse which is 
> unusual...
> 
> cc'd the list as maybe someone else will be able to suggest what is going on here.


sparse complains if there is no forward declaration in a header file. This
could either mean there is non or the header file is not included in the C
file where it is defined.

>>
>>
>> struct configfs_subsystem iio_configfs_subsys = {
>> »       .su_group = {
>> »       »       .cg_item = {
>> »       »       »       .ci_namebuf = "iio",
>> »       »       »       .ci_type = &iio_root_group_type,
>> »       »       },
>> »       },
>> »       .su_mutex = __MUTEX_INITIALIZER(iio_configfs_subsys.su_mutex),
>> };
>> EXPORT_SYMBOL(iio_configfs_subsys);
>>
>>
>>        
>>
>> On 12/03/2015 05:53 PM, Jonathan Cameron wrote:
>>> Classic symbol not exported should it be static from sparse.
>>>
>>> On 3 December 2015 08:57:25 GMT+00:00, Daniel Baluta
>>> <daniel.baluta@intel.com> wrote:
>>>
>>>     Ooops, yes!
>>>
>>>     Sorry for the late answer, Jonathan :(.
>>>
>>>     What was the warning you got and fixed with adding static?
>>>
>>>     thanks,
>>>     Daniel
>>>
>>>     On 12/03/2015 08:41 AM, Jonathan Cameron wrote:
>>>
>>>         I'll back that static addition out then!
>>>
>>>         On 2 December 2015 23:23:27 GMT+00:00, kbuild test robot
>>>         <fengguang.wu@intel.com> wrote:
>>>
>>>         tree:https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>>         togreg
>>>         head: 5a9776becbe3a15f0616883244142b3e6addf93b
>>>         commit: 13bbe76b0b58c958ea6b9fcb982ca5f969f89d48 [11/13] iio:
>>>         core: Introduce IIO software triggers
>>>         config: i386-allyesconfig (attached as .config)
>>>         reproduce:
>>>         git checkout 13bbe76b0b58c958ea6b9fcb982ca5f969f89d48
>>>         # save the attached .config to linux build tree
>>>         make ARCH=i386
>>>
>>>         All errors (new ones prefixed by >>):
>>>
>>>         drivers/built-in.o: In function `iio_sw_trigger_init':
>>>
>>>         industrialio-sw-trigger.c:(.init.text+0x801d0): undefined
>>>         reference to `iio_configfs_subsys'
>>>
>>>
>>>         ---
>>>         0-DAY kernel test infrastructure Open Source Technology Center
>>>         https://lists.01.org/pipermail/kbuild-all Intel Corporation
>>>
>>>
>>>         --
>>>         Sent from my Android device with K-9 Mail. Please excuse my brevity.
>>>
>>>
>>> -- 
>>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> 

