Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48348 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbLCSSq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2015 13:18:46 -0500
Subject: Re: [iio:togreg 11/13] industrialio-sw-trigger.c:undefined reference
 to `iio_configfs_subsys'
To: Daniel Baluta <daniel.baluta@intel.com>,
	kbuild test robot <fengguang.wu@intel.com>
References: <201512030723.5UzAF24I%fengguang.wu@intel.com>
 <43E08F24-AB64-4F2B-B422-3425A2D4D182@jic23.retrosnub.co.uk>
 <566003F5.5090001@intel.com>
 <D645C15C-AF9D-47B3-A254-9D6137CCAD69@jic23.retrosnub.co.uk>
 <566068B7.5090408@intel.com>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <56608782.7000205@jic23.retrosnub.co.uk>
Date: Thu, 3 Dec 2015 18:18:42 +0000
MIME-Version: 1.0
In-Reply-To: <566068B7.5090408@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/15 16:07, Daniel Baluta wrote:
> I see, strange. It shouldn't complain about it, because it is immediately exported.
> 
> I will have a closer look.
Indeed, it's clearly BS (serves me right for fly by sparse fixing during
applying patches:).  Looking at the moment like a bug in Sparse which is 
unusual...

cc'd the list as maybe someone else will be able to suggest what is going on here.
> 
> 
> struct configfs_subsystem iio_configfs_subsys = {
> »       .su_group = {
> »       »       .cg_item = {
> »       »       »       .ci_namebuf = "iio",
> »       »       »       .ci_type = &iio_root_group_type,
> »       »       },
> »       },
> »       .su_mutex = __MUTEX_INITIALIZER(iio_configfs_subsys.su_mutex),
> };
> EXPORT_SYMBOL(iio_configfs_subsys);
> 
> 
>        
> 
> On 12/03/2015 05:53 PM, Jonathan Cameron wrote:
>> Classic symbol not exported should it be static from sparse.
>>
>> On 3 December 2015 08:57:25 GMT+00:00, Daniel Baluta
>> <daniel.baluta@intel.com> wrote:
>>
>>     Ooops, yes!
>>
>>     Sorry for the late answer, Jonathan :(.
>>
>>     What was the warning you got and fixed with adding static?
>>
>>     thanks,
>>     Daniel
>>
>>     On 12/03/2015 08:41 AM, Jonathan Cameron wrote:
>>
>>         I'll back that static addition out then!
>>
>>         On 2 December 2015 23:23:27 GMT+00:00, kbuild test robot
>>         <fengguang.wu@intel.com> wrote:
>>
>>         tree:https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>         togreg
>>         head: 5a9776becbe3a15f0616883244142b3e6addf93b
>>         commit: 13bbe76b0b58c958ea6b9fcb982ca5f969f89d48 [11/13] iio:
>>         core: Introduce IIO software triggers
>>         config: i386-allyesconfig (attached as .config)
>>         reproduce:
>>         git checkout 13bbe76b0b58c958ea6b9fcb982ca5f969f89d48
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>>         All errors (new ones prefixed by >>):
>>
>>         drivers/built-in.o: In function `iio_sw_trigger_init':
>>
>>         industrialio-sw-trigger.c:(.init.text+0x801d0): undefined
>>         reference to `iio_configfs_subsys'
>>
>>
>>         ---
>>         0-DAY kernel test infrastructure Open Source Technology Center
>>         https://lists.01.org/pipermail/kbuild-all Intel Corporation
>>
>>
>>         --
>>         Sent from my Android device with K-9 Mail. Please excuse my brevity.
>>
>>
>> -- 
>> Sent from my Android device with K-9 Mail. Please excuse my brevity.

