Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35736 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161008AbcGZXyI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 19:54:08 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so2668487ywg.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2016 16:54:08 -0700 (PDT)
Date: Tue, 26 Jul 2016 16:54:05 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: lkp@lists.01.org, linux-iio@vger.kernel.org
Subject: Re: [LKP] drivers/iio & kbuild test robot
Message-ID: <20160726235358.GA30527@d830.WORKGROUP>
References: <20160726224911.GA16097@d830.WORKGROUP>
 <20160726233503.GA15811@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160726233503.GA15811@wfg-t540p.sh.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 27, 2016 at 07:35:03AM +0800, Fengguang Wu wrote:
> Hi Alison,
> 
> On Tue, Jul 26, 2016 at 03:49:19PM -0700, Alison Schofield wrote:
> >Hi Fengguang,
> >
> >I recently submitted a patch that adds Kconfig options required
> >to build a few drivers in IIO.  The kbuild robot did not find
> >these.
> >
> >You can see the patch here:
> >http://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg-post-rc1&id=9b1425b1698cca01887ad154b631b59666882fb5
> 
> What're the error messages look like? That'll help me root cause why
> they are missed.
> 

Error message because Kconfig select IIO_TRIGGERED_BUFFER is missing:

  CC [M]  drivers/iio/humidity/am2315.o
drivers/iio/humidity/am2315.c: In function ‘am2315_trigger_handler’:
drivers/iio/humidity/am2315.c:186:2: error: implicit declaration of
function ‘iio_push_to_buffers_with_timestamp’
[-Werror=implicit-function-declaration]
  iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
  ^
cc1: some warnings being treated as errors
scripts/Makefile.build:295: recipe for target
'drivers/iio/humidity/am2315.o' failed
make[2]: *** [drivers/iio/humidity/am2315.o] Error 1
scripts/Makefile.build:440: recipe for target 'drivers/iio/humidity'
failed
make[1]: *** [drivers/iio/humidity] Error 2
Makefile:1622: recipe for target 'drivers/iio/' failed
make: *** [drivers/iio/] Error 2


> >I'd like to get a general understanding of the build testing the robot
> >provides the iio subsystem, and then specifically see if these types of test
> >cases can be added.
> 
> In general for build tests, 100% coverage is our goal. If any error
> is missed, it'd be appreciated to inform us and get the gap closed.
> 
> - build error/warnings in all kind of kconfigs
> - sparse/coccinelle/smatch static checks
> - testing patches posted to mailing lists
> 
> You may also opt-in to email notifications triggered by git push, so
> that you are aware whether the robot is making good progress for each
> pushed branch.
> 
> >I'm up for digging into this if you'll point me in the right direction.
> >
> >First off, I hope this is the correct email list - lkp@list.01.org
> >I didn't want to get lost in all the robo messages in kbuild-all.
> 
> Yeah actually either account will reach us. Yet another one is
> lkp@intel.com which has internal forward rules to all 0day team
> members. Since I do content based filtering, emails not look like
> automated reports will be directed to my main mail box.
> 
> Thanks,
> Fengguang
