Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36817 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbcHWXXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 19:23:53 -0400
Date: Tue, 23 Aug 2016 16:23:46 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ltc2485: add support for Linear Technology
 LTC2485 ADC
Message-ID: <20160823232344.GA6071@d830.WORKGROUP>
References: <20160823032521.GA27711@d830.WORKGROUP>
 <201608231846.LrkmPoJu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201608231846.LrkmPoJu%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 23, 2016 at 06:27:58PM +0800, kbuild test robot wrote:
> Hi Alison,
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.8-rc3 next-20160823]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Alison-Schofield/iio-adc-ltc2485-add-support-for-Linear-Technology-LTC2485-ADC/20160823-112916
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `ltc2485_read_raw':
> >> ltc2485.c:(.text+0x2795c3b): undefined reference to `__divdi3'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

This is in the timestamp comparison code.  I guess I could use a
do_div macro to perform the task.  However, now that I've stared
the code a bit more, it doesn't need to be real time and in fact
it would be better/safer to use monotonic time.  So, I'll change
to monotonic time and use the ktime_t macros to manipulate.

Thanks kbuild robot for finding this immediately!!
alisons


