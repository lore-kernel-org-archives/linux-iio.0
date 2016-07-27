Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5897 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbcG0A1M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jul 2016 20:27:12 -0400
Date: Wed, 27 Jul 2016 08:27:07 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: lkp@lists.01.org, linux-iio@vger.kernel.org
Subject: Re: [LKP] drivers/iio & kbuild test robot
Message-ID: <20160727002707.GC15811@wfg-t540p.sh.intel.com>
References: <20160726224911.GA16097@d830.WORKGROUP>
 <20160726233503.GA15811@wfg-t540p.sh.intel.com>
 <20160726235358.GA30527@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <20160726235358.GA30527@d830.WORKGROUP>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 26, 2016 at 04:54:05PM -0700, Alison Schofield wrote:
>On Wed, Jul 27, 2016 at 07:35:03AM +0800, Fengguang Wu wrote:
>> Hi Alison,
>>
>> On Tue, Jul 26, 2016 at 03:49:19PM -0700, Alison Schofield wrote:
>> >Hi Fengguang,
>> >
>> >I recently submitted a patch that adds Kconfig options required
>> >to build a few drivers in IIO.  The kbuild robot did not find
>> >these.
>> >
>> >You can see the patch here:
>> >http://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg-post-rc1&id=9b1425b1698cca01887ad154b631b59666882fb5
>>
>> What're the error messages look like? That'll help me root cause why
>> they are missed.
>>
>
>Error message because Kconfig select IIO_TRIGGERED_BUFFER is missing:
>
>  CC [M]  drivers/iio/humidity/am2315.o
>drivers/iio/humidity/am2315.c: In function ‘am2315_trigger_handler’:
>drivers/iio/humidity/am2315.c:186:2: error: implicit declaration of
>function ‘iio_push_to_buffers_with_timestamp’
>[-Werror=implicit-function-declaration]
>  iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  ^

It looks the robot does not catch that error, I cannot find
"iio_push_to_buffers_with_timestamp" in the logs.

Looking closer at the log files, I find they mostly fail at early
"make prepare" stage.

: /*
:  *  lkp-hsx03-rand iio/fixes-togreg-post-rc1 [67/67] 9b1425b1698c (29 minutes ago)  2016-07-24 22:05
:  */
: git checkout -q 9b1425b1698cca01887ad154b631b59666882fb5
: [6 days ago, Alison Schofield] iio: add Kconfig selects needed for triggered buffer compiles
:  drivers/iio/accel/Kconfig       | 5 ++++-
:  drivers/iio/humidity/Kconfig    | 2 ++
:  drivers/iio/light/Kconfig       | 2 ++
:  drivers/iio/temperature/Kconfig | 2 ++
: 2016-07-24 22:05:43 i386-randconfig-s1-201630: make prepare failed
: 2016-07-24 22:05:48 i386-randconfig-s0-201630: make prepare failed
: E: relocs_common.c:(.text.startup+0x0): multiple definition of `main'

That may be a new regression introduced when we enable
multiple-compiler support recently, I'll try to fix it.

Thanks,
Fengguang

>cc1: some warnings being treated as errors
>scripts/Makefile.build:295: recipe for target
>'drivers/iio/humidity/am2315.o' failed
>make[2]: *** [drivers/iio/humidity/am2315.o] Error 1
>scripts/Makefile.build:440: recipe for target 'drivers/iio/humidity'
>failed
>make[1]: *** [drivers/iio/humidity] Error 2
>Makefile:1622: recipe for target 'drivers/iio/' failed
>make: *** [drivers/iio/] Error 2
>
>
>> >I'd like to get a general understanding of the build testing the robot
>> >provides the iio subsystem, and then specifically see if these types of test
>> >cases can be added.
>>
>> In general for build tests, 100% coverage is our goal. If any error
>> is missed, it'd be appreciated to inform us and get the gap closed.
>>
>> - build error/warnings in all kind of kconfigs
>> - sparse/coccinelle/smatch static checks
>> - testing patches posted to mailing lists
>>
>> You may also opt-in to email notifications triggered by git push, so
>> that you are aware whether the robot is making good progress for each
>> pushed branch.
>>
>> >I'm up for digging into this if you'll point me in the right direction.
>> >
>> >First off, I hope this is the correct email list - lkp@list.01.org
>> >I didn't want to get lost in all the robo messages in kbuild-all.
>>
>> Yeah actually either account will reach us. Yet another one is
>> lkp@intel.com which has internal forward rules to all 0day team
>> members. Since I do content based filtering, emails not look like
>> automated reports will be directed to my main mail box.
>>
>> Thanks,
>> Fengguang
