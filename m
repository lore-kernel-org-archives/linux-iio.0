Return-Path: <jic23@kernel.org>
Subject: Re: [iio:togreg 11/13] industrialio-sw-trigger.c:undefined reference
 to `iio_configfs_subsys'
To: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Daniel Baluta <daniel.baluta@intel.com>,
 kbuild test robot <fengguang.wu@intel.com>
References: <201512030723.5UzAF24I%fengguang.wu@intel.com>
 <43E08F24-AB64-4F2B-B422-3425A2D4D182@jic23.retrosnub.co.uk>
 <566003F5.5090001@intel.com>
 <D645C15C-AF9D-47B3-A254-9D6137CCAD69@jic23.retrosnub.co.uk>
 <566068B7.5090408@intel.com> <56608782.7000205@jic23.retrosnub.co.uk>
 <56608B28.1040808@metafoo.de>
Cc: kbuild-all@01.org, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5663115A.4030005@kernel.org>
Date: Sat, 5 Dec 2015 16:31:22 +0000
MIME-Version: 1.0
In-Reply-To: <56608B28.1040808@metafoo.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 03/12/15 18:34, Lars-Peter Clausen wrote:
> On 12/03/2015 07:18 PM, J
onathan Cameron wrote:
>> On 03/12/15 16:07, Daniel Baluta wrote:
>>> I see, strange. It shouldn't complain about it, because it is immediately exported.
>>>
>>> I will have a closer look.
>> Indeed, it's clearly BS (serves me right for fly by sparse fixing during
>> applying patches:).  Looking at the moment like a bug in Sparse which is 
>> unusual...
>>
>> cc'd the list as maybe someone else will be able to suggest what is going on here.
> 
> 
> sparse complains if there is no forward declaration in a header file. This
> could either mean there is non or the header file is not included in the C
> file where it is defined.
Ah, that would do it.  Right now the relevant header is sw_trigger.h which doesn't
make much sense for this element.

I've changed things around a little to have a separate include/linux/iio/configfs.h
file with that one element in it.

Please check I haven't messed this up in the patch that should hit your
inboxes shortly! (not sure how I might have done, but you never know).

I'm going to push this out as testing to get autobuilder coverage on it as well.

Ideally I'd like to send a pull request sometime this weekend so if you guys
can take a 20 second look that would be great (it's hardly a complex patch :)
I might push it out anyway but always nice to have a sanity check!

Jonathan 
> 
>>>
>>>
>>> struct configfs_subsystem iio_configfs_subsys = {
>>> »       .su_group = {
>>> »       »       .cg_item = {
>>> »       »       »       .ci_namebuf = "iio",
>>> »       »       »       .ci_type = &iio_root_group_type,
>>> »       »       },
>>> »       },
>>> »       .su_mutex = __MUTEX_INITIALIZER(iio_configfs_subsys.su_mutex),
>>> };
>>> EXPORT_SYMBOL(iio_configfs_subsys);
>>>
>>>
>>>        
>>>
>>> On 12/03/2015 05:53 PM, Jonathan Cameron wrote:
>>>> Classic symbol not exported should it be static from sparse.
>>>>
>>>> On 3 December 2015 08:57:25 GMT+00:00, Daniel Baluta
>>>> <daniel.baluta@intel.com> wrote:
>>>>
>>>>     Ooops, yes!
>>>>
>>>>     Sorry for the late answer, Jonathan :(.
>>>>
>>>>     What was the warning you got and fixed with adding static?
>>>>
>>>>     thanks,
>>>>     Daniel
>>>>
>>>>     On 12/03/2015 08:41 AM, Jonathan Cameron wrote:
>>>>
>>>>         I'll back that static addition out then!
>>>>
>>>>         On 2 December 2015 23:23:27 GMT+00:00, kbuild test robot
>>>>         <fengguang.wu@intel.com> wrote:
>>>>
>>>>         tree:https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>>>         togreg
>>>>         head: 5a9776becbe3a15f0616883244142b3e6addf93b
>>>>         commit: 13bbe76b0b58c958ea6b9fcb982ca5f969f89d48 [11/13] iio:
>>>>         core: Introduce IIO software triggers
>>>>         config: i386-allyesconfig (attached as .config)
>>>>         reproduce:
>>>>         git checkout 13bbe76b0b58c958ea6b9fcb982ca5f969f89d48
>>>>         # save the attached .config to linux build tree
>>>>         make ARCH=i386
>>>>
>>>>         All errors (new ones prefixed by >>):
>>>>
>>>>         drivers/built-in.o: In function `iio_sw_trigger_init':
>>>>
>>>>         industrialio-sw-trigger.c:(.init.text+0x801d0): undefined
>>>>         reference to `iio_configfs_subsys'
>>>>
>>>>
>>>>         ---
>>>>         0-DAY kernel test infrastructure Open Source Technology Center
>>>>         https://lists.01.org/pipermail/kbuild-all Intel Corporation
>>>>
>>>>
>>>>         --
>>>>         Sent from my Android device with K-9 Mail. Please excuse my brevity.
>>>>
>>>>
>>>> -- 
>>>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>>
> 
